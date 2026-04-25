<?php

namespace App\Http\Requests\Auth;

use Illuminate\Foundation\Http\FormRequest;

class LoginRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'email'    => ['required', 'string', 'email'],
            'password' => ['required', 'string'],
        ];
    }

    public function messages(): array
    {
        return [
            'email.required'    => 'Az email cím megadása kötelező.',
            'email.email'       => 'Érvényes email címet adj meg.',
            'password.required' => 'A jelszó megadása kötelező.',
        ];
    }
}
