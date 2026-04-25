<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Allat extends Model
{
    protected $table = 'allatok';

    protected $fillable = ['faj', 'nev', 'eletkor', 'nem', 'orokbefogadasi_statusz', 'photo_path'];
}
