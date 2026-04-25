<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrokbefogadasiKerelme extends Model
{
    protected $table = 'orokbefogadasi_kerelmek';

    protected $fillable = ['felhasznalo_id', 'allat_id', 'statusz', 'indoklas'];
}
