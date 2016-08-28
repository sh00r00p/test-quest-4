<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/

Route::get('/', function(){
    return view('welcome');
});

Route::get('/home', 'HomeController@index');
Route::get('/redirect', 'SocialAuthController@redirect');
Route::get('/callback', 'SocialAuthController@callback');

Route::get('/auth/facebook', 'UsersController@redirectToProvider');
Route::get('/auth/facebook/callback', 'UsersController@handleProviderCallback');

Route::get('register', function(){
    return view('auth.register');
});
Route::get('login', function(){
    return view('auth.login');
});
Route::post('register', 'UsersController@signUp'); 
Route::get('activate/{id}/{code}', 'UsersController@activate');
Route::post('login', 'UsersController@signIn');
Route::get('logout', 'UsersController@logout');
/*Route::get('reset', 'UsersController@resetOrder');
Route::post('reset', 'UsersController@resetOrderProcess');
Route::get('reset/{id}/{code}', 'UsersController@resetComplete');
Route::post('reset/{id}/{code}', 'UsersController@resetCompleteProcess');
Route::get('wait', 'UsersController@wait');*/