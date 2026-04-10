<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Egeszsegugy extends Model
{
    protected $table = 'egeszsegugy';

    protected $primaryKey = 'allat_id';
    public $incrementing = false;
    protected $fillable = ['allat_id', 'ivar', 'oltas', 'gyogyszer', 'hatranyok'];
}
