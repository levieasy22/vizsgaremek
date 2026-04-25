<?php

namespace Database\Seeders;

use App\Models\Animal;
use App\Models\AnimalImage;
use Illuminate\Database\Seeder;

class AnimalSeeder extends Seeder
{
    public function run(): void
    {
        // ── FIX ÁLLATOK (valódi adatokkal, bemutatkozáshoz jók) ───────

        $fixAnimals = [
            [
                'name'          => 'Bodri',
                'type'          => 'kutya',
                'breed'         => 'Labrador Retriever',
                'gender'        => 'him',
                'age'           => 3,
                'description'   => 'Bodri egy barátságos és energikus labrador, aki imád emberek közelében lenni. Nagyon jól kijön gyerekekkel és más állatokkal egyaránt. Alapkiképzést elvégezte, ismeri az ül, le és maradj parancsokat.',
                'status'        => 'elerheto',
                'is_vaccinated' => true,
                'is_neutered'   => true,
            ],
            [
                'name'          => 'Hópehely',
                'type'          => 'macska',
                'breed'         => 'Perzsa',
                'gender'        => 'nosteny',
                'age'           => 4,
                'description'   => 'Hópehely egy gyönyörű fehér perzsa macska, aki nagyon szereti a kényelmet. Csendes természetű, ideális lakásmacska. Rendszeres ápolást igényel hosszú szőre miatt.',
                'status'        => 'elerheto',
                'is_vaccinated' => true,
                'is_neutered'   => true,
            ],
            [
                'name'          => 'Rex',
                'type'          => 'kutya',
                'breed'         => 'Dobermann',
                'gender'        => 'him',
                'age'           => 1,
                'description'   => 'Rex még fiatal, mindössze egyéves dobermann kölyök. Tele van energiával és szeret tanulni. Megfelelő szocializációval és edzéssel kiváló társ lesz.',
                'status'        => 'elerheto',
                'is_vaccinated' => true,
                'is_neutered'   => false,
            ],
            [
                'name'          => 'Tigris',
                'type'          => 'macska',
                'breed'         => 'Bengáli',
                'gender'        => 'him',
                'age'           => 2,
                'description'   => 'Tigris egy aktív és játékos bengáli macska, lenyűgöző mintás bundával. Okos és tanulékony, még apróbb trükköket is megtaníthatók neki.',
                'status'        => 'elerheto',
                'is_vaccinated' => true,
                'is_neutered'   => false,
            ],
            [
                'name'          => 'Lola',
                'type'          => 'kutya',
                'breed'         => 'Golden Retriever',
                'gender'        => 'nosteny',
                'age'           => 6,
                'description'   => 'Lola egy szeretetteljes golden retriever. Imádja a vízet és a labdát. Gyerekekkel nagyon türelmes, kiváló családi kutya.',
                'status'        => 'foglalas_alatt',
                'is_vaccinated' => true,
                'is_neutered'   => true,
            ],
            [
                'name'          => 'Cirmos',
                'type'          => 'macska',
                'breed'         => 'Európai rövidszőrű',
                'gender'        => 'him',
                'age'           => 3,
                'description'   => 'Cirmos egy vidám és kíváncsi macska, aki minden zugot felderít a lakásban. Szereti az emberek társaságát, de önállóan is jól elvan.',
                'status'        => 'elerheto',
                'is_vaccinated' => true,
                'is_neutered'   => true,
            ],
            [
                'name'          => 'Bundás',
                'type'          => 'kutya',
                'breed'         => 'Bernáthegyi',
                'gender'        => 'him',
                'age'           => 5,
                'description'   => 'Bundás egy hatalmas szívű bernáthegyi. Nagyon barátságos és türelmes, imádja a gyerekeket. Kerttel rendelkező otthonba ajánljuk mérete miatt.',
                'status'        => 'orokbefogadva',
                'is_vaccinated' => true,
                'is_neutered'   => false,
            ],
            [
                'name'          => 'Zsemlye',
                'type'          => 'macska',
                'breed'         => 'Ragdoll',
                'gender'        => 'nosteny',
                'age'           => 3,
                'description'   => 'Zsemlye egy tipikus ragdoll: lágy, ölbe simuló, türelmes macska. Soha nem karmolja meg az embert, nagyon gyerekbarát.',
                'status'        => 'elerheto',
                'is_vaccinated' => true,
                'is_neutered'   => true,
            ],
        ];

        foreach ($fixAnimals as $animalData) {
            $animal = Animal::create($animalData);

            // Minden fix állathoz létrehozunk egy placeholder képbejegyzést
            AnimalImage::create([
                'animal_id'  => $animal->id,
                'image_path' => 'animals/placeholder.jpg',
                'is_primary' => true,
            ]);
        }

        // ── VÉLETLENSZERŰ ÁLLATOK (Factory segítségével) ─────────────
        // Létrehoz még 12 db véletlenszerű állatot (6 kutya + 6 macska)
        Animal::factory(6)->dog()->create()->each(function ($animal) {
            AnimalImage::create([
                'animal_id'  => $animal->id,
                'image_path' => 'animals/placeholder.jpg',
                'is_primary' => true,
            ]);
        });

        Animal::factory(6)->cat()->create()->each(function ($animal) {
            AnimalImage::create([
                'animal_id'  => $animal->id,
                'image_path' => 'animals/placeholder.jpg',
                'is_primary' => true,
            ]);
        });

        $this->command->info('✅ Állatok sikeresen létrehozva (8 fix + 12 véletlenszerű).');
    }
}
