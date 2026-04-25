<?php

namespace Database\Factories;

use App\Models\Animal;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

class AdoptionRequestFactory extends Factory
{
    private array $motivations = [
        'Mindig is szerettem volna kutyát tartani. Nagy kertünk van, ahol az állat szabadon mozoghatna. Gyermekeimnek is nagyon hiányzik egy háziállat.',
        'Egyedül élek és szeretnék társat magam mellé. Home office-ban dolgozom, így egész nap otthon vagyok és rengeteg időt tudnék szánni az állatra.',
        'Korábban már tartottunk kutyát, tudom mivel jár a felelősség. Aktív életmódot élek, naponta sétálok és kirándulok, tökéletes gazdija lennék.',
        'A macskák iránti szeretetem régóta megvan. Tágas lakásban élek, kaparófával és rengeteg játékkal tudnám biztosítani a megfelelő körülményeket.',
        'Egész életemben álmom volt egy ilyen fajta állat. Stabil anyagi háttérrel rendelkezem, az állatorvosi költségek nem jelentenének gondot.',
        'A gyerekeink nagyon szeretnének állatot. Felelős gazdik lennénk, a gyerekek is részt vennének a gondozásban. Van kertünk és nagy udvarunk.',
        'Nemrég vesztettem el a régi kutyámat és nagyon hiányzik az állat a házból. Tapasztalt kutyatartó vagyok, tudom mi a felelőssége.',
    ];

    public function definition(): array
    {
        return [
            'user_id'        => fake()->boolean(70)
                ? User::where('role', 'user')->inRandomOrder()->first()?->id
                : null,  // 30% eséllyel vendég kérelem
            'animal_id'      => Animal::inRandomOrder()->first()?->id,
            'first_name'     => fake()->firstName(),
            'last_name'      => fake()->lastName(),
            'email'          => fake()->safeEmail(),
            'phone'          => '+36 ' . fake()->numerify('## ### ####'),
            'address'        => fake()->numerify('#### ') . fake()->city() . ', ' . fake()->streetAddress(),
            'motivation'     => fake()->randomElement($this->motivations),
            'has_garden'     => fake()->boolean(50),
            'has_other_pets' => fake()->boolean(30),
            'status'         => fake()->randomElement([
                'fuggoben', 'fuggoben', 'fuggoben',  // 3x = nagyobb eséllyel függőben
                'elfogadva',
                'elutasitva',
            ]),
        ];
    }
}
