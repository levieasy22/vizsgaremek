<?php

use App\Http\Controllers\Api\AdminController;
use App\Http\Controllers\Api\AnimalController;
use App\Http\Controllers\Api\AdoptionRequestController;
use App\Http\Controllers\Api\AppointmentController;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\ContactController;
use Illuminate\Support\Facades\Route;

// ════════════════════════════════════════════════════════════════════
// PUBLIKUS ROUTE-OK
// Ezek bejelentkezés nélkül is elérhetők
// ════════════════════════════════════════════════════════════════════

// ── Autentikáció ─────────────────────────────────────────────────
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login',    [AuthController::class, 'login']);

// ── Állatok (publikus lista – a főoldalhoz és örökbefogadás oldalhoz) ──
Route::get('/animals',       [AnimalController::class, 'index']);
Route::get('/animals/stats', [AnimalController::class, 'stats']);
Route::get('/animals/{animal}', [AnimalController::class, 'show']);

// ── Kapcsolatfelvétel ─────────────────────────────────────────────
Route::post('/contact', [ContactController::class, 'store']);


// ════════════════════════════════════════════════════════════════════
// BEJELENTKEZETT FELHASZNÁLÓK ROUTE-JAI
// Sanctum token szükséges az Authorization headerben
// ════════════════════════════════════════════════════════════════════

Route::middleware('auth:sanctum')->group(function () {

    // ── Autentikáció ─────────────────────────────────────────────
    Route::post('/logout',          [AuthController::class, 'logout']);
    Route::get('/me',               [AuthController::class, 'me']);
    Route::put('/profile',          [AuthController::class, 'updateProfile']);
    Route::post('/change-password', [AuthController::class, 'changePassword']);

    // ── Örökbefogadási kérelmek ───────────────────────────────────
    // Kérelem benyújtása
    Route::post('/adoption-requests',    [AdoptionRequestController::class, 'store']);
    // Saját kérelmek megtekintése
    Route::get('/my-adoption-requests',  [AdoptionRequestController::class, 'myRequests']);

    // ── Időpontfoglalások ─────────────────────────────────────────
    // Időpont foglalása
    Route::post('/appointments',    [AppointmentController::class, 'store']);
    // Saját foglalások megtekintése
    Route::get('/my-appointments',  [AppointmentController::class, 'myAppointments']);

});


// ════════════════════════════════════════════════════════════════════
// ADMIN ROUTE-OK
// Sanctum token + admin role szükséges
// ════════════════════════════════════════════════════════════════════

Route::middleware(['auth:sanctum', 'admin'])->prefix('admin')->group(function () {

    // ── Dashboard statisztikák ────────────────────────────────────
    Route::get('/stats', [AdminController::class, 'stats']);

    // ── Állatok kezelése (CRUD) ───────────────────────────────────
    // Összes állat listázása (admin nézetben státusz szűrés nélkül)
    Route::get('/animals',               [AnimalController::class, 'adminIndex']);
    // Új állat hozzáadása
    Route::post('/animals',              [AnimalController::class, 'store']);
    // Állat szerkesztése
    Route::put('/animals/{animal}',      [AnimalController::class, 'update']);
    // Állat törlése
    Route::delete('/animals/{animal}',   [AnimalController::class, 'destroy']);
    // Kép feltöltése állathoz
    Route::post('/animals/{animal}/images',                    [AnimalController::class, 'uploadImage']);
    // Kép törlése
    Route::delete('/animals/{animal}/images/{image}',          [AnimalController::class, 'deleteImage']);

    // ── Örökbefogadási kérelmek kezelése ─────────────────────────
    // Összes kérelem listázása
    Route::get('/adoption-requests',          [AdoptionRequestController::class, 'index']);
    // Kérelem státuszának módosítása (elfogad / elutasít)
    Route::put('/adoption-requests/{adoptionRequest}', [AdoptionRequestController::class, 'updateStatus']);

    // ── Időpontfoglalások kezelése ────────────────────────────────
    // Összes időpont listázása
    Route::get('/appointments',               [AppointmentController::class, 'index']);
    // Időpont státuszának módosítása (megerősít / lemond)
    Route::put('/appointments/{appointment}', [AppointmentController::class, 'updateStatus']);

    // ── Kapcsolatfelvételi üzenetek kezelése ──────────────────────
    // Összes üzenet listázása
    Route::get('/contact-messages',                    [ContactController::class, 'index']);
    // Üzenet olvasottnak jelölése
    Route::put('/contact-messages/{contactMessage}/read', [ContactController::class, 'markRead']);
    // Üzenet törlése
    Route::delete('/contact-messages/{contactMessage}',   [ContactController::class, 'destroy']);

    // ── Felhasználók kezelése ─────────────────────────────────────
    // Összes felhasználó listázása
    Route::get('/users',          [AdminController::class, 'users']);
    // Felhasználó törlése
    Route::delete('/users/{user}', [AdminController::class, 'deleteUser']);

});
