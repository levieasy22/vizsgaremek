<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class ContactMessageFactory extends Factory
{
    private array $subjects = [
        'Önkéntes lehetőségek',
        'Talált állat bejelentése',
        'Adomány leadása',
        'Örökbefogadott állat visszahozatala',
        'Szponzoráció',
        'Általános érdeklődés',
        'Rendezvény szervezés',
        'Sajtómegkeresés',
    ];

    private array $messages = [
        'Üdvözlöm! Érdeklődnék az önkéntes lehetőségekről. Hétvégente szívesen segítenék az állatok gondozásában és sétáltatásában.',
        'Jó napot! Tegnap este egy kóbor kutyát találtam a lakótelep mellett. Körülbelül 2 éves, barna-fehér foltos. Jelenleg nálam van.',
        'Tisztelt Menhely! Száraztápot és játékokat szeretnék adományozni. Mikor és hogyan tudom leadni az adományokat?',
        'Sajnálattal értesítem Önöket, hogy körülményeim megváltozása miatt nem tudom tovább tartani az örökbefogadott állatom.',
        'Kis vállalkozásunk szeretné szponzorálni a menhely egyik állatát. Havonta tudnánk hozzájárulni az ellátási költségekhez.',
        'Érdeklődnék, hogy milyen feltételei vannak az örökbefogadásnak. Először tennék szert háziállatra, ezért sok kérdésem van.',
        'Szeretném megkérdezni, hogy mikor van nyitva a menhely látogatók számára. Szeretnék személyesen megnézni néhány állatot.',
    ];

    public function definition(): array
    {
        return [
            'name'       => fake()->name(),
            'email'      => fake()->safeEmail(),
            'subject'    => fake()->randomElement($this->subjects),
            'message'    => fake()->randomElement($this->messages),
            'is_read'    => fake()->boolean(40),  // 40% eséllyel már olvasott
        ];
    }

    /**
     * Olvasatlan üzenet létrehozásához.
     * Használat: ContactMessage::factory()->unread()->create()
     */
    public function unread(): static
    {
        return $this->state(fn (array $attributes) => [
            'is_read' => false,
        ]);
    }
}
