<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\User;
use App\Http\Requests;
use App\Http\Controllers\Controller;
use Auth;
use Socialite;

class UsersController extends Controller
{
    public function signUp($type, $data) {
        
        if($type == 'simple') {
            // Проверка входных данных
            $rules = User::$validation;
            $validation = Validator::make(Input::all(), $rules);
            if ($validation->fails()) {
                // В случае провала, редиректим обратно с ошибками и самими введенными данными
                return Redirect::to('users/register')->withErrors($validation)->withInput();
            }

            // Сама регистрация с уже проверенными данными
            $user = new User();
            $user->fill(Input::all());
            $id = $user->register();

            // Вывод информационного сообщения об успешности регистрации
            return $this->getMessage("Регистрация почти завершена. Вам необходимо подтвердить e-mail, указанный при регистрации, перейдя по ссылке в письме.");
        } else {
            switch($type) {
                case 'facebook':
                    $fb_user = Socialize::with('facebook')->user();

                    // OAuth Two Providers
                    $token = $fb_user->token;

                    // OAuth One Providers
                    $token = $fb_user->token;
                    $tokenSecret = $fb_user->tokenSecret;

                    /* All Providers
                    $fb_user->getId();
                    $fb_user->getNickname();
                    $fb_user->getName();
                    $fb_user->getEmail();
                    $fb_user->getAvatar();*/
                    
                    $authUser = $this->findOrCreateUser($user);
                
            }
        }
    }
    
    public function sighIn($type, $data) {
        
        if($type === 'simple') {
        // Формируем базовый набор данных для авторизации
        // (isActive => 1 нужно для того, чтобы аторизоваться могли только
        // активированные пользователи)
        $creds = array(
            'password' => Input::get('password'),
            'isActive'  => 1,
        );

        // В зависимости от того, что пользователь указал в поле username,
        // дополняем авторизационные данные
        $username = Input::get('username');
        if (strpos($username, '@')) {
            $creds['email'] = $username;
        } else {
            $creds['username'] = $username;
        }

        // Пытаемся авторизовать пользователя
        if (Auth::attempt($creds, Input::has('remember'))) {
            Log::info("User [{$username}] successfully logged in.");
            return Redirect::intended();
        } else {
            Log::info("User [{$username}] failed to login.");
        }

        $alert = "Неверная комбинация имени (email) и пароля, либо учетная запись еще не активирована.";

        // Возвращаем пользователя назад на форму входа с временной сессионной
        // переменной alert (withAlert)
        return Redirect::back()->withAlert($alert);
        
        } else {
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
                
        }
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
    
}
