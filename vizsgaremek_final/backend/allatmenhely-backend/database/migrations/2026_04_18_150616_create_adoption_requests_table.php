<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('adoption_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')
                ->nullable()              // lehet vendégként is kérelmet benyújtani
                ->constrained()
                ->nullOnDelete();         // ha törlöd a usert, a kérelem marad, user_id = null lesz
            $table->foreignId('animal_id')
                ->constrained()
                ->onDelete('cascade');    // ha törlöd az állatot, a kérelmek is törlődnek
            $table->string('first_name', 100);
            $table->string('last_name', 100);
            $table->string('email');
            $table->string('phone', 20);
            $table->string('address');
            $table->text('motivation');
            $table->boolean('has_garden')->default(false);
            $table->boolean('has_other_pets')->default(false);
            $table->enum('status', ['fuggoben', 'elfogadva', 'elutasitva'])
                ->default('fuggoben');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('adoption_requests');
    }
};
