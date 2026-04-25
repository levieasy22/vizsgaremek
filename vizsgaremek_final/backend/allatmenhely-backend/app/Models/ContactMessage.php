<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ContactMessage extends Model
{
    use HasFactory;

    /**
     * Ezek a mezők tölthetők ki tömegesen
     */
    protected $fillable = [
        'name',
        'email',
        'subject',
        'message',
        'is_read',
    ];

    /**
     * Automatikus típuskonverzió
     */
    protected $casts = [
        'is_read' => 'boolean',
    ];

    // Ennek a modellnek nincsenek kapcsolatai más táblákkal,
    // mert a kapcsolatfelvételi üzenet független rekord.
}
