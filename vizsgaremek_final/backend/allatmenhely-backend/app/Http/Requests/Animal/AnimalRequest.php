<?php

namespace App\Http\Requests\Animal;

use Illuminate\Foundation\Http\FormRequest;

class AnimalRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'name'          => ['required', 'string', 'min:1', 'max:100'],
            'type'          => ['required', 'in:kutya,macska'],
            'breed'         => ['nullable', 'string', 'max:100'],
            'gender'        => ['required', 'in:him,nosteny'],
            'age'           => ['required', 'integer', 'min:0', 'max:30'],
            'description'   => ['nullable', 'string', 'max:2000'],
            'status'        => ['required', 'in:elerheto,foglalas_alatt,orokbefogadva'],
            'is_vaccinated' => ['boolean'],
            'is_neutered'   => ['boolean'],
        ];
    }

    public function messages(): array
    {
        return [
            'name.required'    => 'Az állat nevének megadása kötelező.',
            'name.max'         => 'A név maximum 100 karakter lehet.',
            'type.required'    => 'Az állat típusának megadása kötelező.',
            'type.in'          => 'Az állat típusa csak kutya vagy macska lehet.',
            'gender.required'  => 'Az állat nemének megadása kötelező.',
            'gender.in'        => 'Az állat neme csak him vagy nosteny lehet.',
            'age.required'     => 'Az állat korának megadása kötelező.',
            'age.integer'      => 'A kor csak egész szám lehet.',
            'age.min'          => 'A kor nem lehet negatív.',
            'status.required'  => 'Az állat státuszának megadása kötelező.',
            'status.in'        => 'Érvénytelen státusz.',
        ];
    }
}
