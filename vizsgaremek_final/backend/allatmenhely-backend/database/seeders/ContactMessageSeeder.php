<?php

namespace Database\Seeders;

use App\Models\ContactMessage;
use Illuminate\Database\Seeder;

class ContactMessageSeeder extends Seeder
{
    public function run(): void
    {
        // ── FIX ÜZENETEK (vegyes olvasott/olvasatlan állapottal) ──────

        $messages = [
            [
                'name'       => 'Horváth Judit',
                'email'      => 'horvath.judit@gmail.com',
                'subject'    => 'Önkéntes lehetőségek',
                'message'    => 'Üdvözlöm! Érdeklődnék, hogy van-e lehetőség önkéntesnek jelentkezni a menhelyre. Hétvégeken szívesen segítenék az állatok gondozásában és sétáltatásában. Várom megtisztelő válaszukat!',
                'is_read'    => false,
                'created_at' => now()->subDays(2),
                'updated_at' => now()->subDays(2),
            ],
            [
                'name'       => 'Kiss Gábor',
                'email'      => 'kiss.gabor@freemail.hu',
                'subject'    => 'Talált kutya bejelentése',
                'message'    => 'Jó napot! Tegnap este egy kóbor kutyát találtam a lakótelep mellett. Körülbelül 2 éves, barna-fehér foltos, nyakörv nélkül. Jelenleg nálam van. Kérem jelezzék, mit tegyek.',
                'is_read'    => true,
                'created_at' => now()->subDays(4),
                'updated_at' => now()->subDays(3),
            ],
            [
                'name'       => 'Varga Réka',
                'email'      => 'varga.reka@citromail.hu',
                'subject'    => 'Adomány leadása',
                'message'    => 'Tisztelt Menhely! Szeretnék adományozni száraztápot és néhány játékot az állatoknak. Mikor és hogyan tudom leadni? Nagyjából 10 kg száraztápot hoztam össze.',
                'is_read'    => false,
                'created_at' => now()->subDay(),
                'updated_at' => now()->subDay(),
            ],
            [
                'name'       => 'Balogh Tamás',
                'email'      => 'balogh.tamas@gmail.com',
                'subject'    => 'Örökbefogadott állat visszahozatala',
                'message'    => 'Sajnálattal értesítem Önöket, hogy körülményeim megváltozása miatt nem tudom tovább tartani a 2 hónapja örökbefogadott állatot. Kérem tájékoztassanak a visszahozatal menetéről.',
                'is_read'    => true,
                'created_at' => now()->subDays(6),
                'updated_at' => now()->subDays(5),
            ],
            [
                'name'       => 'Fekete Kata',
                'email'      => 'fekete.kata@outlook.com',
                'subject'    => 'Szponzoráció',
                'message'    => 'Kis vállalkozásunk szeretné szponzorálni a menhely egyik állatát. Havonta egy összegben tudnánk hozzájárulni az ellátási költségekhez. Kérlek vegyétek fel velünk a kapcsolatot!',
                'is_read'    => false,
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ];

        foreach ($messages as $message) {
            ContactMessage::create($message);
        }

        // ── VÉLETLENSZERŰ ÜZENETEK (Factory segítségével) ─────────────
        ContactMessage::factory(8)->create();
        ContactMessage::factory(4)->unread()->create();  // + 4 biztosan olvasatlan

        $this->command->info('✅ Kapcsolatfelvételi üzenetek sikeresen létrehozva.');
    }
}
