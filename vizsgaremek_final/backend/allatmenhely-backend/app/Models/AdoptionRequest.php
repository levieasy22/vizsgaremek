<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AdoptionRequest extends Model
{
    use HasFactory;

    /**
     * Ezek a mezők tölthetők ki tömegesen
     */
    protected $fillable = [
        'user_id',
        'animal_id',
        'first_name',
        'last_name',
        'email',
        'phone',
        'address',
        'motivation',
        'has_garden',
        'has_other_pets',
        'status',
    ];

    /**
     * Automatikus típuskonverzió
     */
    protected $casts = [
        'has_garden'     => 'boolean',
        'has_other_pets' => 'boolean',
    ];

    // KAPCSOLATOK (Relationships)

    /**
     * Ez a kérelem TARTOZIK egy userhez (aki benyújtotta).
     * Lehet null is, ha vendégként nyújtotta be.
     * Használat: $request->user
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Ez a kérelem TARTOZIK egy állathoz.
     * Használat: $request->animal
     */
    public function animal(): BelongsTo
    {
        return $this->belongsTo(Animal::class);
    }
}
