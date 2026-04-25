<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('animals', function (Blueprint $table) {
            $table->id();
            $table->string('name', 100);
            $table->enum('type', ['kutya', 'macska']);
            $table->string('breed', 100)->nullable();
            $table->enum('gender', ['him', 'nosteny']);
            $table->integer('age');
            $table->text('description')->nullable();
            $table->enum('status', ['elerheto', 'foglalas_alatt', 'orokbefogadva'])
                ->default('elerheto');
            $table->boolean('is_vaccinated')->default(false);
            $table->boolean('is_neutered')->default(false);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('animals');
    }
};
