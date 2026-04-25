<?php

namespace App\Http\Requests\Appointment;

use Illuminate\Foundation\Http\FormRequest;

class StoreAppointmentRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'animal_id'        => ['nullable', 'integer', 'exists:animals,id'],
            'type'             => ['required', 'in:megtekintes,konzultacio,esemeny'],
            'first_name'       => ['required', 'string', 'max:100'],
            'last_name'        => ['required', 'string', 'max:100'],
            'email'            => ['required', 'email', 'max:255'],
            'phone'            => ['required', 'string', 'max:20'],
            'appointment_date' => ['required', 'date', 'after:today'],
            'appointment_time' => ['required', 'date_format:H:i'],
            'notes'            => ['nullable', 'string', 'max:500'],
        ];
    }

    public function messages(): array
    {
        return [
            'animal_id.exists'           => 'A megadott állat nem létezik.',
            'type.required'              => 'Az időpont típusának megadása kötelező.',
            'type.in'                    => 'Érvénytelen időpont típus.',
            'first_name.required'        => 'A keresztnév megadása kötelező.',
            'last_name.required'         => 'A vezetéknév megadása kötelező.',
            'email.required'             => 'Az email cím megadása kötelező.',
            'email.email'                => 'Érvényes email címet adj meg.',
            'phone.required'             => 'A telefonszám megadása kötelező.',
            'appointment_date.required'  => 'A dátum megadása kötelező.',
            'appointment_date.date'      => 'Érvényes dátumot adj meg.',
            'appointment_date.after'     => 'A foglalás dátuma csak jövőbeli lehet.',
            'appointment_time.required'  => 'Az időpont megadása kötelező.',
            'appointment_time.date_format' => 'Az időpontot ÓÓ:PP formátumban add meg.',
        ];
    }
}
