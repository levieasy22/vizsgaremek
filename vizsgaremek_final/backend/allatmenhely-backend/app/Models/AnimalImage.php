<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AnimalImage extends Model
{
    use HasFactory;

    /**
     * Ezek a mezők tölthetők ki tömegesen
     */
    protected $fillable = [
        'animal_id',
        'image_path',
        'is_primary',
    ];

    /**
     * Automatikus típuskonverzió
     */
    protected $casts = [
        'is_primary' => 'boolean',
    ];

    // KAPCSOLATOK (Relationships)

    /**
     * Ez a kép TARTOZIK egy állathoz.
     * Használat: $image->animal
     */
    public function animal(): BelongsTo
    {
        return $this->belongsTo(Animal::class);
    }
}
