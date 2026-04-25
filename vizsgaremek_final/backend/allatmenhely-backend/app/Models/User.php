<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * Ezek a mezők tölthetők ki tömegesen (pl. User::create([...]))
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'role',
        'phone',
    ];

    /**
     * Ezek a mezők NEM jelennek meg JSON válaszban (pl. API híváskor)
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * Automatikus típuskonverzió
     */
    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password'          => 'hashed',
        ];
    }

    // SEGÉDFÜGGVÉNYEK

    /**
     * Admin-e ez a felhasználó?
     * Használat: if ($user->isAdmin()) { ... }
     */
    public function isAdmin(): bool
    {
        return $this->role === 'admin';
    }

    // KAPCSOLATOK (Relationships)

    /**
     * Egy usernek TÖBB örökbefogadási kérelme lehet.
     * Használat: $user->adoptionRequests
     */
    public function adoptionRequests(): HasMany
    {
        return $this->hasMany(AdoptionRequest::class);
    }

    /**
     * Egy usernek TÖBB időpontfoglalása lehet.
     * Használat: $user->appointments
     */
    public function appointments(): HasMany
    {
        return $this->hasMany(Appointment::class);
    }
}
