<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Animal\AnimalRequest;
use App\Models\Animal;
use App\Models\AnimalImage;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class AnimalController extends Controller
{
    // PUBLIKUS VÉGPONTOK

    /**
     * GET /api/animals
     *
     * Visszaadja az elérhető állatok listáját.
     * Szűrhető: ?type=kutya vagy ?type=macska
     *
     * A Vue örökbefogadás oldala és főoldala használja.
     */
    public function index(Request $request): JsonResponse
    {
        $query = Animal::with('primaryImage');

        // Szűrés típus szerint (kutya / macska)
        if ($request->filled('type')) {
            $query->where('type', $request->type);
        }

        // Publikus oldalon csak az elérhető és foglalás alatt lévőket mutatjuk
        $query->whereIn('status', ['elerheto', 'foglalas_alatt']);

        // Legújabbak elöl
        $query->orderBy('created_at', 'desc');

        $animals = $query->get();

        // Minden állathoz hozzáadjuk a kép teljes URL-jét
        $storageUrl = rtrim(Storage::disk('public')->url(''), '/');
        $animals->transform(function ($animal) use ($storageUrl) {
            $animal->primary_image_url = $animal->primaryImage
                ? $storageUrl . '/' . $animal->primaryImage->image_path
                : null;
            return $animal;
        });

        return response()->json($animals);
    }

    /**
     * GET /api/animals/stats
     *
     * Publikus statisztikák a főoldalhoz.
     * Visszaadja az örökbefogadott és elérhető állatok számát.
     */
    public function stats(): JsonResponse
    {
        $adopted = Animal::where('status', 'orokbefogadva')->count();
        $available = Animal::whereIn('status', ['elerheto', 'foglalas_alatt'])->count();

        return response()->json([
            'adopted'   => $adopted,
            'available' => $available,
        ]);
    }

    /**
     * GET /api/animals/{animal}
     *
     * Visszaadja egy állat összes adatát a képeivel együtt.
     * A Vue állatdetail oldala használja.
     */
    public function show(Animal $animal): JsonResponse
    {
        // Betöltjük az összes képet
        $animal->load('images');

        // Minden képhez hozzáadjuk a teljes URL-t
        $storageUrl = rtrim(Storage::disk('public')->url(''), '/');
        $animal->images->transform(function ($image) use ($storageUrl) {
            $image->url = $storageUrl . '/' . $image->image_path;
            return $image;
        });

        return response()->json($animal);
    }

    // ----------------------------------------------------------------
    // ADMIN VÉGPONTOK
    // ----------------------------------------------------------------

    /**
     * GET /api/admin/animals
     *
     * Admin nézetben az ÖSSZES állatot visszaadja státusztól függetlenül.
     * Szűrhető: ?type=kutya, ?status=elerheto, ?search=Bodri
     */
    public function adminIndex(Request $request): JsonResponse
    {
        $query = Animal::with('primaryImage');

        // Szűrés típus szerint
        if ($request->filled('type')) {
            $query->where('type', $request->type);
        }

        // Szűrés státusz szerint
        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        // Keresés névre
        if ($request->filled('search')) {
            $query->where('name', 'like', '%' . $request->search . '%');
        }

        $query->orderBy('created_at', 'desc');

        $animals = $query->get();

        $storageUrl = rtrim(Storage::disk('public')->url(''), '/');
        $animals->transform(function ($animal) use ($storageUrl) {
            $animal->primary_image_url = $animal->primaryImage
                ? $storageUrl . '/' . $animal->primaryImage->image_path
                : null;
            return $animal;
        });

        return response()->json($animals);
    }

    /**
     * POST /api/admin/animals
     *
     * Új állat létrehozása.
     * A Form Request elvégzi a validációt.
     */
    public function store(AnimalRequest $request): JsonResponse
    {
        $animal = Animal::create($request->validated());

        return response()->json([
            'message' => 'Az állat sikeresen hozzáadva!',
            'animal'  => $animal,
        ], 201);
    }

    /**
     * PUT /api/admin/animals/{animal}
     *
     * Állat adatainak módosítása.
     */
    public function update(AnimalRequest $request, Animal $animal): JsonResponse
    {
        $animal->update($request->validated());

        // Frissített adatok visszaküldése a képekkel együtt
        $animal->load('images');
        $storageUrl = rtrim(Storage::disk('public')->url(''), '/');
        $animal->images->transform(function ($image) use ($storageUrl) {
            $image->url = $storageUrl . '/' . $image->image_path;
            return $image;
        });

        return response()->json([
            'message' => 'Az állat adatai sikeresen frissítve!',
            'animal'  => $animal,
        ]);
    }

    /**
     * DELETE /api/admin/animals/{animal}
     *
     * Állat törlése. A CASCADE miatt a képfájlok és kérelmek is törlődnek az adatbázisból,
     * de a fizikai képfájlokat külön töröljük a storage-ból.
     */
    public function destroy(Animal $animal): JsonResponse
    {
        // Fizikai képfájlok törlése a storage-ból
        foreach ($animal->images as $image) {
            Storage::delete($image->image_path);
        }

        $animal->delete();

        return response()->json([
            'message' => 'Az állat sikeresen törölve!',
        ]);
    }

    /**
     * POST /api/admin/animals/{animal}/images
     *
     * Kép feltöltése egy állathoz.
     * A kép a storage/app/public/animals mappába kerül.
     */
    public function uploadImage(Request $request, Animal $animal): JsonResponse
    {
        $request->validate([
            'image'      => ['required', 'image', 'mimes:jpeg,png,jpg,webp', 'max:2048'],
            'is_primary' => ['boolean'],
        ], [
            'image.required' => 'Kép megadása kötelező.',
            'image.image'    => 'A fájlnak képnek kell lennie.',
            'image.mimes'    => 'A kép formátuma csak jpeg, png, jpg vagy webp lehet.',
            'image.max'      => 'A kép mérete maximum 2MB lehet.',
        ]);

        // Ha ez lesz az elsődleges kép, a többieket átállítjuk
        if ($request->boolean('is_primary', false)) {
            $animal->images()->update(['is_primary' => false]);
        }

        // Ha még nincs képe az állatnak, automatikusan primary lesz
        $isPrimary = $request->boolean('is_primary', false) || $animal->images()->count() === 0;

        // Kép mentése: storage/app/public/animals/
        $path = $request->file('image')->store('animals', 'public');

        $image = $animal->images()->create([
            'image_path' => $path,
            'is_primary' => $isPrimary,
        ]);

        $storageUrl = rtrim(Storage::disk('public')->url(''), '/');
        $image->url = $storageUrl . '/' . $path;

        return response()->json([
            'message' => 'Kép sikeresen feltöltve!',
            'image'   => $image,
        ], 201);
    }

    /**
     * DELETE /api/admin/animals/{animal}/images/{image}
     *
     * Egy kép törlése az állathoz tartozó képek közül.
     */
    public function deleteImage(Animal $animal, AnimalImage $image): JsonResponse
    {
        // Ellenőrzés: ez a kép valóban ehhez az állathoz tartozik-e?
        if ($image->animal_id !== $animal->id) {
            return response()->json([
                'message' => 'Ez a kép nem tartozik ehhez az állathoz.',
            ], 403);
        }

        // Fizikai fájl törlése
        Storage::delete($image->image_path);

        $wasPrimary = $image->is_primary;
        $image->delete();

        // Ha az elsődleges képet töröltük, a következő képet tesszük primary-vá
        if ($wasPrimary) {
            $nextImage = $animal->images()->first();
            if ($nextImage) {
                $nextImage->update(['is_primary' => true]);
            }
        }

        return response()->json([
            'message' => 'Kép sikeresen törölve!',
        ]);
    }
}
