<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('appointments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')
                ->nullable()              // vendégként is lehet időpontot foglalni
                ->constrained()
                ->nullOnDelete();
            $table->foreignId('animal_id')
                ->nullable()              // konzultációhoz nem kell konkrét állat
                ->constrained()
                ->nullOnDelete();
            $table->enum('type', ['megtekintes', 'konzultacio', 'esemeny']);
            $table->string('first_name', 100);
            $table->string('last_name', 100);
            $table->string('email');
            $table->string('phone', 20);
            $table->date('appointment_date');
            $table->time('appointment_time');
            $table->text('notes')->nullable();
            $table->enum('status', ['fuggoben', 'megerositett', 'lemondott'])
                ->default('fuggoben');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('appointments');
    }
};
