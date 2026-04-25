<?php

use App\Http\Controllers\AllatController;
use App\Http\Controllers\EgeszsegugyController;
use App\Http\Controllers\LatogatasiIdopontController;
use App\Http\Controllers\OrokbefogadasiKerelmeController;
use App\Http\Controllers\UserController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::apiResource('allatok', AllatController::class);
Route::apiResource('egeszsegugy', EgeszsegugyController::class);
Route::apiResource('latogatasi-idopontok', LatogatasiIdopontController::class);
Route::apiResource('orokbefogadasi-kerelmek', OrokbefogadasiKerelmeController::class);
Route::apiResource('users', UserController::class);
