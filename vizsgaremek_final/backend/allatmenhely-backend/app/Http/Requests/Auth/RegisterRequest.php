<?php

namespace App\Http\Requests\Auth;

use Illuminate\Foundation\Http\FormRequest;

class RegisterRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name'     => ['required', 'string', 'min:2', 'max:100'],
            'email'    => ['required', 'string', 'email', 'max:255', 'unique:users,email'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
            'phone'    => ['nullable', 'string', 'max:20'],
        ];
    }

    public function messages(): array
    {
        return [
            'name.required'      => 'A név megadása kötelező.',
            'name.min'           => 'A névnek legalább 2 karakter hosszúnak kell lennie.',
            'email.required'     => 'Az email cím megadása kötelező.',
            'email.email'        => 'Érvényes email címet adj meg.',
            'email.unique'       => 'Ez az email cím már foglalt.',
            'password.required'  => 'A jelszó megadása kötelező.',
            'password.min'       => 'A jelszónak legalább 8 karakter hosszúnak kell lennie.',
            'password.confirmed' => 'A két jelszó nem egyezik.',
        ];
    }
}
