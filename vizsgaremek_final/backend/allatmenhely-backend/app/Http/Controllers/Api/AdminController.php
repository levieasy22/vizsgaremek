<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\AdoptionRequest;
use App\Models\Animal;
use App\Models\Appointment;
use App\Models\ContactMessage;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class AdminController extends Controller
{
    // DASHBOARD STATISZTIKÁK

    /**
     * GET /api/admin/stats
     *
     * Visszaadja az admin dashboard-on megjelenő összes statisztikát.
     * Az AdminDashboard.vue komponens ezt hívja be oldalbetöltéskor.
     */
    public function stats(): JsonResponse
    {
        // Állat statisztikák
        $totalAnimals     = Animal::count();
        $availableAnimals = Animal::where('status', 'elerheto')->count();
        $reservedAnimals  = Animal::where('status', 'foglalas_alatt')->count();
        $adoptedAnimals   = Animal::where('status', 'orokbefogadva')->count();
        $dogCount         = Animal::where('type', 'kutya')->count();
        $catCount         = Animal::where('type', 'macska')->count();

        // Örökbefogadási kérelem statisztikák
        $totalRequests   = AdoptionRequest::count();
        $pendingRequests = AdoptionRequest::where('status', 'fuggoben')->count();
        $acceptedRequests = AdoptionRequest::where('status', 'elfogadva')->count();
        $rejectedRequests = AdoptionRequest::where('status', 'elutasitva')->count();

        // Időpont statisztikák
        $totalAppointments    = Appointment::count();
        $upcomingAppointments = Appointment::where('appointment_date', '>=', now()->toDateString())
            ->whereNotIn('status', ['lemondott'])
            ->count();
        $todayAppointments = Appointment::where('appointment_date', now()->toDateString())
            ->whereNotIn('status', ['lemondott'])
            ->count();

        // Üzenet statisztikák
        $totalMessages  = ContactMessage::count();
        $unreadMessages = ContactMessage::where('is_read', false)->count();

        // Felhasználó statisztikák
        $totalUsers = User::where('role', 'user')->count();
        $newUsersThisMonth = User::where('role', 'user')
            ->whereMonth('created_at', now()->month)
            ->whereYear('created_at', now()->year)
            ->count();

        // Legutóbbi 5 örökbefogadási kérelem (dashboard táblázathoz)
        $recentAdoptionRequests = AdoptionRequest::with(['animal', 'user'])
            ->orderBy('created_at', 'desc')
            ->take(5)
            ->get()
            ->map(function ($req) {
                return [
                    'id'          => $req->id,
                    'name'        => $req->last_name . ' ' . $req->first_name,
                    'animal_name' => $req->animal?->name,
                    'animal_type' => $req->animal?->type,
                    'status'      => $req->status,
                    'created_at'  => $req->created_at,
                ];
            });

        // Következő 5 időpont (dashboard táblázathoz)
        $upcomingAppointmentsList = Appointment::with(['animal', 'user'])
            ->where('appointment_date', '>=', now()->toDateString())
            ->whereNotIn('status', ['lemondott'])
            ->orderBy('appointment_date', 'asc')
            ->orderBy('appointment_time', 'asc')
            ->take(5)
            ->get()
            ->map(function ($apt) {
                return [
                    'id'               => $apt->id,
                    'name'             => $apt->last_name . ' ' . $apt->first_name,
                    'type'             => $apt->type,
                    'animal_name'      => $apt->animal?->name,
                    'appointment_date' => $apt->appointment_date,
                    'appointment_time' => $apt->appointment_time,
                    'status'           => $apt->status,
                ];
            });

        return response()->json([
            // Állatok
            'animals' => [
                'total'     => $totalAnimals,
                'available' => $availableAnimals,
                'reserved'  => $reservedAnimals,
                'adopted'   => $adoptedAnimals,
                'dogs'      => $dogCount,
                'cats'      => $catCount,
            ],
            // Örökbefogadási kérelmek
            'adoption_requests' => [
                'total'    => $totalRequests,
                'pending'  => $pendingRequests,
                'accepted' => $acceptedRequests,
                'rejected' => $rejectedRequests,
            ],
            // Időpontok
            'appointments' => [
                'total'    => $totalAppointments,
                'upcoming' => $upcomingAppointments,
                'today'    => $todayAppointments,
            ],
            // Üzenetek
            'messages' => [
                'total'  => $totalMessages,
                'unread' => $unreadMessages,
            ],
            // Felhasználók
            'users' => [
                'total'           => $totalUsers,
                'new_this_month'  => $newUsersThisMonth,
            ],
            // Dashboard táblázatok
            'recent_adoption_requests'  => $recentAdoptionRequests,
            'upcoming_appointments'     => $upcomingAppointmentsList,
        ]);
    }

    // FELHASZNÁLÓK KEZELÉSE

    /**
     * GET /api/admin/users
     *
     * Összes felhasználó listázása (csak user role-ú).
     * Szűrhető: ?search=anna
     */
    public function users(Request $request): JsonResponse
    {
        $query = User::where('role', 'user')
            ->withCount([
                'adoptionRequests',
                'appointments',
            ]);

        // Keresés névre vagy emailre
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', '%' . $search . '%')
                    ->orWhere('email', 'like', '%' . $search . '%');
            });
        }

        $query->orderBy('created_at', 'desc');

        $users = $query->paginate(20);

        // Jelszót és remember_token-t nem küldjük ki
        $users->getCollection()->transform(function ($user) {
            return [
                'id'                       => $user->id,
                'name'                     => $user->name,
                'email'                    => $user->email,
                'phone'                    => $user->phone,
                'role'                     => $user->role,
                'adoption_requests_count'  => $user->adoption_requests_count,
                'appointments_count'       => $user->appointments_count,
                'created_at'               => $user->created_at,
            ];
        });

        return response()->json($users);
    }

    /**
     * DELETE /api/admin/users/{user}
     *
     * Felhasználó törlése.
     * Az admin saját magát nem törölheti!
     */
    public function deleteUser(Request $request, User $user): JsonResponse
    {
        // Admin saját magát nem törölheti
        if ($user->id === $request->user()->id) {
            return response()->json([
                'message' => 'Saját fiókodat nem törölheted.',
            ], 422);
        }

        // Admin felhasználót nem lehet törölni
        if ($user->isAdmin()) {
            return response()->json([
                'message' => 'Admin felhasználót nem lehet törölni.',
            ], 422);
        }

        $user->delete();

        return response()->json([
            'message' => 'A felhasználó sikeresen törölve!',
        ]);
    }
}
