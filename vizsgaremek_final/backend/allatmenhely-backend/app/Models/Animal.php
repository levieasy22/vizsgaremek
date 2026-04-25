<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\HasOne;

class Animal extends Model
{
    use HasFactory;

    /**
     * Ezek a mezők tölthetők ki tömegesen
     */
    protected $fillable = [
        'name',
        'type',
        'breed',
        'gender',
        'age',
        'description',
        'status',
        'is_vaccinated',
        'is_neutered',
    ];

    /**
     * Automatikus típuskonverzió
     */
    protected $casts = [
        'is_vaccinated' => 'boolean',
        'is_neutered'   => 'boolean',
        'age'           => 'integer',
    ];

    // KAPCSOLATOK (Relationships)

    /**
     * Egy állatnak TÖBB képe lehet.
     * Használat: $animal->images
     */
    public function images(): HasMany
    {
        return $this->hasMany(AnimalImage::class);
    }

    /**
     * Egy állatnak egy FŐ képe van (ahol is_primary = true).
     * Használat: $animal->primaryImage
     */
    public function primaryImage(): HasOne
    {
        return $this->hasOne(AnimalImage::class)->where('is_primary', true);
    }

    /**
     * Egy állathoz TÖBB örökbefogadási kérelem tartozhat.
     * Használat: $animal->adoptionRequests
     */
    public function adoptionRequests(): HasMany
    {
        return $this->hasMany(AdoptionRequest::class);
    }

    /**
     * Egy állathoz TÖBB időpontfoglalás tartozhat.
     * Használat: $animal->appointments
     */
    public function appointments(): HasMany
    {
        return $this->hasMany(Appointment::class);
    }
}
