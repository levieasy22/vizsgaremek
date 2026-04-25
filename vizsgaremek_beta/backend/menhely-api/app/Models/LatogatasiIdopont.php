<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LatogatasiIdopont extends Model
{
    protected $table = 'latogatasi_idopontok';

    protected $fillable = ['felhasznalo_id', 'allat_id', 'idopont', 'statusz'];
}
