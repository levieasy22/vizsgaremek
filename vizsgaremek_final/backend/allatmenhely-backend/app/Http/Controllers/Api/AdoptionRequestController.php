<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\AdoptionRequest\StoreAdoptionRequest;
use App\Models\AdoptionRequest;
use App\Models\Animal;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class AdoptionRequestController extends Controller
{
    // FELHASZNÁLÓI VÉGPONTOK

    /**
     * POST /api/adoption-requests
     *
     * Új örökbefogadási kérelem benyújtása.
     * Bejelentkezett user esetén automatikusan hozzárendeljük a user_id-t.
     */
    public function store(StoreAdoptionRequest $request): JsonResponse
    {
        // Ellenőrzés: az állat valóban elérhető-e?
        $animal = Animal::findOrFail($request->animal_id);

        if ($animal->status === 'orokbefogadva') {
            return response()->json([
                'message' => 'Ez az állat már örökbe lett fogadva.',
            ], 422);
        }

        // Ellenőrzés: nem nyújtott-e be már kérelmet ehhez az állathoz?
        if (auth()->check()) {
            $existingRequest = AdoptionRequest::where('animal_id', $request->animal_id)
                ->where('user_id', auth()->id())
                ->where('status', 'fuggoben')
                ->first();

            if ($existingRequest) {
                return response()->json([
                    'message' => 'Már van függőben lévő örökbefogadási kérelmed ehhez az állathoz.',
                ], 422);
            }
        }

        // Kérelem létrehozása
        $adoptionRequest = AdoptionRequest::create([
            'user_id'        => auth()->id(), // null ha vendég
            'animal_id'      => $request->animal_id,
            'first_name'     => $request->first_name,
            'last_name'      => $request->last_name,
            'email'          => $request->email,
            'phone'          => $request->phone,
            'address'        => $request->address,
            'motivation'     => $request->motivation,
            'has_garden'     => $request->boolean('has_garden'),
            'has_other_pets' => $request->boolean('has_other_pets'),
            'status'         => 'fuggoben',
        ]);

        // Állat státuszának frissítése: foglalás alatt
        $animal->update(['status' => 'foglalas_alatt']);

        // Betöltjük az állat adatait a válaszhoz
        $adoptionRequest->load('animal');

        return response()->json([
            'message'          => 'Örökbefogadási kérelmed sikeresen beérkezett! Hamarosan felvesszük veled a kapcsolatot.',
            'adoption_request' => $adoptionRequest,
        ], 201);
    }

    /**
     * GET /api/my-adoption-requests
     *
     * A bejelentkezett user saját kérelmeinek listája.
     */
    public function myRequests(Request $request): JsonResponse
    {
        $requests = AdoptionRequest::with('animal.primaryImage')
            ->where('user_id', $request->user()->id)
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json($requests);
    }

    // ADMIN VÉGPONTOK

    /**
     * GET /api/admin/adoption-requests
     *
     * Összes örökbefogadási kérelem listázása.
     * Szűrhető: ?status=fuggoben
     */
    public function index(Request $request): JsonResponse
    {
        $query = AdoptionRequest::with(['animal', 'user']);

        // Szűrés státusz szerint
        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        // Szűrés állat típusa szerint
        if ($request->filled('type')) {
            $query->whereHas('animal', function ($q) use ($request) {
                $q->where('type', $request->type);
            });
        }

        $query->orderBy('created_at', 'desc');

        $requests = $query->paginate(15);

        return response()->json($requests);
    }

    /**
     * PUT /api/admin/adoption-requests/{adoptionRequest}
     *
     * Kérelem státuszának módosítása (elfogad / elutasít).
     *
     * Kérés példa:
     * { "status": "elfogadva" }
     */
    public function updateStatus(Request $request, AdoptionRequest $adoptionRequest): JsonResponse
    {
        $request->validate([
            'status' => ['required', 'in:fuggoben,elfogadva,elutasitva'],
        ], [
            'status.required' => 'A státusz megadása kötelező.',
            'status.in'       => 'Érvénytelen státusz.',
        ]);

        $oldStatus = $adoptionRequest->status;
        $newStatus = $request->status;

        $adoptionRequest->update(['status' => $newStatus]);

        // Állat státuszának frissítése a kérelem státusza alapján
        $animal = $adoptionRequest->animal;

        if ($newStatus === 'elfogadva') {
            // Kérelem elfogadva → állat örökbefogadva
            $animal->update(['status' => 'orokbefogadva']);

            // Többi függőben lévő kérelmet elutasítjuk ehhez az állathoz
            AdoptionRequest::where('animal_id', $animal->id)
                ->where('id', '!=', $adoptionRequest->id)
                ->where('status', 'fuggoben')
                ->update(['status' => 'elutasitva']);

        } elseif ($newStatus === 'elutasitva') {
            // Ha elutasítottuk és nincs más függőben lévő kérelem,
            // az állat visszakerül elérhető státuszba
            $pendingCount = AdoptionRequest::where('animal_id', $animal->id)
                ->where('id', '!=', $adoptionRequest->id)
                ->where('status', 'fuggoben')
                ->count();

            if ($pendingCount === 0) {
                $animal->update(['status' => 'elerheto']);
            }
        }

        $adoptionRequest->load(['animal', 'user']);

        return response()->json([
            'message'          => 'A kérelem státusza sikeresen frissítve!',
            'adoption_request' => $adoptionRequest,
        ]);
    }
}
