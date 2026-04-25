<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('animal_images', function (Blueprint $table) {
            $table->id();
            $table->foreignId('animal_id')
                ->constrained()           // automatikusan az animals táblára mutat
                ->onDelete('cascade');     // ha törlöd az állatot, a képei is törlődnek
            $table->string('image_path');
            $table->boolean('is_primary')->default(false);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('animal_images');
    }
};
