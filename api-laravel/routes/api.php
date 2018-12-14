<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::prefix('/v1/users')
    ->namespace('Api\V1')
    ->group(function () {
        Route::get('/', 'UsersController@index');
        Route::get('/create', 'UsersController@create');
        Route::get('/update', 'UsersController@update');
    });
