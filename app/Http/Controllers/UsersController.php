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
use Response;

class UsersController extends Controller {
    
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
            /*return Redirect::to('register')
                ->withErrors('Такой Email уже зарегистрирован.');*/
            return $this->response(400, 'this email already exist');
        }
 
        if ($sentuser = Sentinel::register($input)) {
            $activation = Activation::create($sentuser);
            $code = $activation->code;
            $sent = Mail::send('mail.account_activate', compact('sentuser', 'code'), function($m) use ($sentuser) {
                $m->from('noreplqy@mysite.ru', 'LaravelSite');
                $m->to($sentuser->email)->subject('Активация аккаунта');
            });
            if ($sent === 0) {
                /*return Redirect::to('register')
                    ->withErrors('Ошибка отправки письма активации.');*/
                return $this->response(400, 'error send activation mail');
            }
 
            $role = Sentinel::findRoleBySlug('user');
            $role->users()->attach($sentuser);
 
            return Redirect::to('login', 200)
                ->withSuccess('Ваш аккаунт создан. Проверьте Email для активации.')
                ->with('userId', $sentuser->getUserId());
        }
        /*return Redirect::to('register')
            ->withInput()
            ->withErrors('Failed to register.');*/
        return $this->response(400, 'failed to register');
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
                    return Redirect::intended('/', 200);
                }
                $errors = 'Неправильный логин или пароль.';
                /*return Redirect::back()
                    ->withInput()
                    ->withErrors($errors);*/
                return $this->response(400, 'login or password is not correct');
                
            } catch (NotActivatedException $e) {
                $sentuser= $e->getUser();
                $activation = Activation::create($sentuser);
                $code = $activation->code;
                $sent = Mail::send('mail.account_activate', compact('sentuser', 'code'), function($m) use ($sentuser) {
                    $m->from('noreplay@mysite.ru', 'LaravelSite');
                    $m->to($sentuser->email)->subject('Активация аккаунта');
                });

                if ($sent === 0) {
                    /*return Redirect::to('login')
                        ->withErrors('Ошибка отправки письма активации.');*/
                    return $this->response(400, 'error send activation mail');
                }
                $errors = 'Ваш аккаунт не ативирован! Поищите в своем почтовом ящике письмо со ссылкой для активации (Вам отправлено повторное письмо). ';

                //return view('auth.login')->withErrors($errors);
                return $this->response(400, 'your account is not activated');


            } catch (ThrottlingException $e) {
                $delay = $e->getDelay();
                $errors = "Ваш аккаунт блокирован на {$delay} секунд.";
            }

            /*return Redirect::back()
                ->withInput()
                ->withErrors($errors);*/
            return $this->response(400, 'your account is blocked');
        
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

        Sentinel::authenticate($authUser, true);

        return redirect()->back();
    }
    
    private function findOrCreateUser($fbUser) {

        if ($authUser = Sentinel::findByCredentials('facebook_id', $fbUser->id)->first()) {
            return $authUser;
        }

        return Sentinel::register([
            'name' => $fbUser->name,
            'email' => $fbUser->email,
            'facebook_id' => $fbUser->id
        ]);

    }
    
    public function logout() {
        Sentinel::logout();
        
        return Redirect::intended('/');
    }
    
    public function activate($id, $code) {
        $sentuser = Sentinel::findById($id);
 
        if (!Activation::complete($sentuser, $code)){
            /*return Redirect::to("login")
                ->withErrors('Неверный или просроченный код активации.');*/
            return $this->response(400, 'incorrect activation key');
        }
 
        return Redirect::to('login', 200)
            ->withSuccess('Аккаунт активирован.');
    }
    
    public static function response($code, $message = null) {
    
        if (is_object($message)) { $message = $message->toArray(); }

        $data = array(
                'code' => $code,
                'data' => $message
            );

        return Response::json($data, $code);
    }
}
