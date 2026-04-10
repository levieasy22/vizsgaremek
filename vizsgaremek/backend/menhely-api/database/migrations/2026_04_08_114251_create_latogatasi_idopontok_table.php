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
        Schema::create('latogatasi_idopontok', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('felhasznalo_id');
            $table->unsignedBigInteger('allat_id');
            $table->datetime('idopont');
            $table->enum('statusz', ['foglalt', 'lemondva', 'teljesitve'])->default('foglalt');
            $table->timestamps();
            $table->foreign('felhasznalo_id')->references('id')->on('felhasznalok')->onDelete('cascade');
            $table->foreign('allat_id')->references('id')->on('allatok')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('latogatasi_idopontok');
    }
};
