<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Appointment extends Model
{
    use HasFactory;

    /**
     * Ezek a mezők tölthetők ki tömegesen
     */
    protected $fillable = [
        'user_id',
        'animal_id',
        'type',
        'first_name',
        'last_name',
        'email',
        'phone',
        'appointment_date',
        'appointment_time',
        'notes',
        'status',
    ];

    /**
     * Automatikus típuskonverzió
     */
    protected $casts = [
        'appointment_date' => 'date',
    ];

    // KAPCSOLATOK (Relationships)

    /**
     * Ez az időpont TARTOZIK egy userhez (aki foglalta).
     * Lehet null is, ha vendégként foglalta.
     * Használat: $appointment->user
     */
    public function user(): BelongsTo
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Ez az időpont TARTOZIK egy állathoz.
     * Lehet null is, ha pl. konzultációs időpont.
     * Használat: $appointment->animal
     */
    public function animal(): BelongsTo
    {
        return $this->belongsTo(Animal::class);
    }
}
