<?php

namespace App\Http\Requests\AdoptionRequest;

use Illuminate\Foundation\Http\FormRequest;

class StoreAdoptionRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'animal_id'      => ['required', 'integer', 'exists:animals,id'],
            'first_name'     => ['required', 'string', 'max:100'],
            'last_name'      => ['required', 'string', 'max:100'],
            'email'          => ['required', 'email', 'max:255'],
            'phone'          => ['required', 'string', 'max:20'],
            'address'        => ['required', 'string', 'max:255'],
            'motivation'     => ['required', 'string', 'min:50', 'max:2000'],
            'has_garden'     => ['boolean'],
            'has_other_pets' => ['boolean'],
        ];
    }

    public function messages(): array
    {
        return [
            'animal_id.required'   => 'Az állat megadása kötelező.',
            'animal_id.exists'     => 'A megadott állat nem létezik.',
            'first_name.required'  => 'A keresztnév megadása kötelező.',
            'last_name.required'   => 'A vezetéknév megadása kötelező.',
            'email.required'       => 'Az email cím megadása kötelező.',
            'email.email'          => 'Érvényes email címet adj meg.',
            'phone.required'       => 'A telefonszám megadása kötelező.',
            'address.required'     => 'A lakcím megadása kötelező.',
            'motivation.required'  => 'A motiváció megadása kötelező.',
            'motivation.min'       => 'A motivációnak legalább 50 karakter hosszúnak kell lennie.',
        ];
    }
}
