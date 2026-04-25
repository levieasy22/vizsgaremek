<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\Appointment\StoreAppointmentRequest;
use App\Models\Appointment;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class AppointmentController extends Controller
{
    // FELHASZNÁLÓI VÉGPONTOK

    /**
     * POST /api/appointments
     *
     * Új időpontfoglalás létrehozása.
     */
    public function store(StoreAppointmentRequest $request): JsonResponse
    {
        // Ellenőrzés: az adott dátum + időpont még szabad-e?
        $conflict = Appointment::where('appointment_date', $request->appointment_date)
            ->where('appointment_time', $request->appointment_time . ':00')
            ->whereNotIn('status', ['lemondott'])
            ->exists();

        if ($conflict) {
            return response()->json([
                'message' => 'Ez az időpont már foglalt. Kérjük, válasszon másik időpontot.',
            ], 422);
        }

        $appointment = Appointment::create([
            'user_id'          => auth()->id(), // null ha vendég
            'animal_id'        => $request->animal_id,
            'type'             => $request->type,
            'first_name'       => $request->first_name,
            'last_name'        => $request->last_name,
            'email'            => $request->email,
            'phone'            => $request->phone,
            'appointment_date' => $request->appointment_date,
            'appointment_time' => $request->appointment_time,
            'notes'            => $request->notes,
            'status'           => 'fuggoben',
        ]);

        // Betöltjük az állat adatait a válaszhoz (ha van)
        $appointment->load('animal');

        return response()->json([
            'message'     => 'Időpontkérése sikeresen beérkezett! Hamarosan visszaigazoljuk.',
            'appointment' => $appointment,
        ], 201);
    }

    /**
     * GET /api/my-appointments
     *
     * A bejelentkezett user saját időpontjainak listája.
     */
    public function myAppointments(Request $request): JsonResponse
    {
        $appointments = Appointment::with('animal.primaryImage')
            ->where('user_id', $request->user()->id)
            ->orderBy('appointment_date', 'asc')
            ->orderBy('appointment_time', 'asc')
            ->get();

        return response()->json($appointments);
    }

    // ADMIN VÉGPONTOK

    /**
     * GET /api/admin/appointments
     *
     * Összes időpontfoglalás listázása.
     * Szűrhető: ?status=fuggoben, ?type=megtekintes, ?date=2025-06-01
     */
    public function index(Request $request): JsonResponse
    {
        $query = Appointment::with(['animal', 'user']);

        // Szűrés státusz szerint
        if ($request->filled('status')) {
            $query->where('status', $request->status);
        }

        // Szűrés típus szerint
        if ($request->filled('type')) {
            $query->where('type', $request->type);
        }

        // Szűrés dátum szerint
        if ($request->filled('date')) {
            $query->where('appointment_date', $request->date);
        }

        // Alapértelmezetten a jövőbeli időpontok jönnek először
        $query->orderBy('appointment_date', 'asc')
            ->orderBy('appointment_time', 'asc');

        $appointments = $query->paginate(15);

        return response()->json($appointments);
    }

    /**
     * PUT /api/admin/appointments/{appointment}
     *
     * Időpont státuszának módosítása (megerősít / lemond).
     *
     * Kérés példa:
     * { "status": "megerositett" }
     */
    public function updateStatus(Request $request, Appointment $appointment): JsonResponse
    {
        $request->validate([
            'status' => ['required', 'in:fuggoben,megerositett,lemondott'],
        ], [
            'status.required' => 'A státusz megadása kötelező.',
            'status.in'       => 'Érvénytelen státusz.',
        ]);

        $appointment->update(['status' => $request->status]);

        $appointment->load(['animal', 'user']);

        return response()->json([
            'message'     => 'Az időpont státusza sikeresen frissítve!',
            'appointment' => $appointment,
        ]);
    }
}
