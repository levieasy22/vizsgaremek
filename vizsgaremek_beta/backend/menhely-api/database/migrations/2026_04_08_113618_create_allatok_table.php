<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('allatok', function (Blueprint $table) {
            $table->id();
            $table->string('faj'); // kutya, macska, etc
            $table->string('nev');
            $table->integer('eletkor');
            $table->string('nem'); // hím, nőstény
            $table->string('orokbefogadasi_statusz');
            $table->string('photo_path')->nullable(); // path to the image
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('allatok');
    }
};
