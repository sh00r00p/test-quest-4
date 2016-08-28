<?php

namespace App\Http\Controllers;

use Cartalyst\Sentinel\Checkpoints\NotActivatedException;
use Cartalyst\Sentinel\Checkpoints\ThrottlingException;

use Illuminate\Http\Request;
use App\User;
use App\Http\Requests;
use Redirect;
use Socialite;
use Sentinel;
use Activation;
use Reminder;
use Validator;
use Mail;
use Storage;
use CurlHttp;

class UsersController extends Controller
{
    public function signUp(Request $request) {
        
        //if($type == 'simple') {
            $this->validate($request, [
            'email' => 'required|email',
            'password' => 'required',
            'password_confirm' => 'required|same:password',
        ]);
        $input = $request->all();
        $credentials = [ 'email' => $request->email ];
        if($user = Sentinel::findByCredentials($credentials)) {
            return Redirect::to('register')
                ->withErrors('Такой Email уже зарегистрирован.');
        }
 
        if ($sentuser = Sentinel::register($input)) {
            $activation = Activation::create($sentuser);
            $code = $activation->code;
            $sent = Mail::send('mail.account_activate', compact('sentuser', 'code'), function($m) use ($sentuser) {
                $m->from('noreplqy@mysite.ru', 'LaravelSite');
                $m->to($sentuser->email)->subject('Активация аккаунта');
            });
            if ($sent === 0) {
                return Redirect::to('register')
                    ->withErrors('Ошибка отправки письма активации.');
            }
 
            $role = Sentinel::findRoleBySlug('user');
            $role->users()->attach($sentuser);
 
            return Redirect::to('login')
                ->withSuccess('Ваш аккаунт создан. Проверьте Email для активации.')
                ->with('userId', $sentuser->getUserId());
        }
        return Redirect::to('register')
            ->withInput()
            ->withErrors('Failed to register.');
        /*} else {
            switch($type) {
                case 'facebook':
                    $fb_user = Socialize::with('facebook')->user();

                    // OAuth Two Providers
                    $token = $fb_user->token;

                    // OAuth One Providers
                    $token = $fb_user->token;
                    $tokenSecret = $fb_user->tokenSecret;

                    // All Providers
                    $fb_user->getId();
                    $fb_user->getNickname();
                    $fb_user->getName();
                    $fb_user->getEmail();
                    $fb_user->getAvatar();
                    
                    $authUser = $this->findOrCreateUser($user);
                
            }
        }*/
    }
    
    public function signIn(Request $request) {
        
        //if($type === 'simple') {
            try {
                $this->validate($request, [
                    'email' => 'required|email',
                    'password' => 'required',
                ]);
                $remember = (bool) $request->remember;
                if (Sentinel::authenticate($request->all(), $remember)) {
                    return Redirect::intended('/');
                }
                $errors = 'Неправильный логин или пароль.';
                return Redirect::back()
                    ->withInput()
                    ->withErrors($errors);
                
            } catch (NotActivatedException $e) {
                $sentuser= $e->getUser();
                $activation = Activation::create($sentuser);
                $code = $activation->code;
                $sent = Mail::send('mail.account_activate', compact('sentuser', 'code'), function($m) use ($sentuser) {
                    $m->from('noreplay@mysite.ru', 'LaravelSite');
                    $m->to($sentuser->email)->subject('Активация аккаунта');
                });

                if ($sent === 0) {
                    return Redirect::to('login')
                        ->withErrors('Ошибка отправки письма активации.');
                }
                $errors = 'Ваш аккаунт не ативирован! Поищите в своем почтовом ящике письмо со ссылкой для активации (Вам отправлено повторное письмо). ';

                return view('auth.login')->withErrors($errors);


            } catch (ThrottlingException $e) {
                $delay = $e->getDelay();
                $errors = "Ваш аккаунт блокирован на {$delay} секунд.";
            }

            return Redirect::back()
                ->withInput()
                ->withErrors($errors);
        
        /*} else {
            switch($type) {
                case 'facebook':
                    $fb_user = Socialize::with('facebook')->user();

                    // OAuth Two Providers
                    $token = $fb_user->token;

                    // OAuth One Providers
                    $token = $fb_user->token;
                    $tokenSecret = $fb_user->tokenSecret;

                    $authUser = $this->findOrCreateUser($user);
            
            }
                
        }*/
    }
    
    public function redirectToProvider() {
        
        return Socialite::driver('facebook')->redirect();
    }
    
    public function handleProviderCallback() {
        
        $user = Socialite::driver('facebook')->user();

        $authUser = $this->findOrCreateUser($user);

        Auth::login($authUser, true);

        return redirect()->back();
    }
    
    private function findOrCreateUser($fbUser) {

        if ($authUser = User::where('facebook_id', $fbUser->id)->first()) {
            return $authUser;
        }

        return User::create([
            'name' => $fbUser->name,
            'email' => $fbUser->email,
            'facebook_id' => $fbUser->id,
            'avatar' => $fbUser->avatar
        ]);

    }
    
    public function logout() {
        Sentinel::logout();
        return Redirect::intended('/');
    }
    
    public function activate($id, $code) {
        $sentuser = Sentinel::findById($id);
 
        if ( ! Activation::complete($sentuser, $code))
        {
            return Redirect::to("login")
                ->withErrors('Неверный или просроченный код активации.');
        }
 
        return Redirect::to('login')
            ->withSuccess('Аккаунт активирован.');
    }
}
