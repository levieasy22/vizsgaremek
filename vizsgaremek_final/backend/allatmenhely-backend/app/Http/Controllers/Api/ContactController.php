<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ContactMessage;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

class ContactController extends Controller
{
    // PUBLIKUS VÉGPONT

    /**
     * POST /api/contact
     *
     * Kapcsolatfelvételi üzenet küldése.
     * Bejelentkezés nélkül is elérhető.
     */
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'name'    => ['required', 'string', 'min:2', 'max:100'],
            'email'   => ['required', 'email', 'max:255'],
            'subject' => ['required', 'string', 'min:3', 'max:255'],
            'message' => ['required', 'string', 'min:10', 'max:2000'],
        ], [
            'name.required'    => 'A név megadása kötelező.',
            'name.min'         => 'A névnek legalább 2 karakter hosszúnak kell lennie.',
            'email.required'   => 'Az email cím megadása kötelező.',
            'email.email'      => 'Érvényes email címet adj meg.',
            'subject.required' => 'A tárgy megadása kötelező.',
            'subject.min'      => 'A tárgynak legalább 3 karakter hosszúnak kell lennie.',
            'message.required' => 'Az üzenet megadása kötelező.',
            'message.min'      => 'Az üzenetnek legalább 10 karakter hosszúnak kell lennie.',
        ]);

        $contactMessage = ContactMessage::create([
            'name'    => $request->name,
            'email'   => $request->email,
            'subject' => $request->subject,
            'message' => $request->message,
            'is_read' => false,
        ]);

        return response()->json([
            'message' => 'Üzeneted sikeresen elküldve! Hamarosan felvesszük veled a kapcsolatot.',
        ], 201);
    }

    // ----------------------------------------------------------------
    // ADMIN VÉGPONTOK
    // ----------------------------------------------------------------

    /**
     * GET /api/admin/contact-messages
     *
     * Összes kapcsolatfelvételi üzenet listázása.
     * Szűrhető: ?is_read=0 (olvasatlanok) vagy ?is_read=1 (olvasottak)
     */
    public function index(Request $request): JsonResponse
    {
        $query = ContactMessage::query();

        // Szűrés olvasott/olvasatlan szerint
        if ($request->filled('is_read')) {
            $query->where('is_read', (bool) $request->is_read);
        }

        // Legújabbak elöl
        $query->orderBy('created_at', 'desc');

        $messages = $query->paginate(15);

        return response()->json($messages);
    }

    /**
     * PUT /api/admin/contact-messages/{contactMessage}/read
     *
     * Üzenet olvasottnak jelölése.
     */
    public function markRead(ContactMessage $contactMessage): JsonResponse
    {
        $contactMessage->update(['is_read' => true]);

        return response()->json([
            'message'         => 'Az üzenet olvasottnak jelölve.',
            'contact_message' => $contactMessage,
        ]);
    }

    /**
     * DELETE /api/admin/contact-messages/{contactMessage}
     *
     * Üzenet törlése.
     */
    public function destroy(ContactMessage $contactMessage): JsonResponse
    {
        $contactMessage->delete();

        return response()->json([
            'message' => 'Az üzenet sikeresen törölve!',
        ]);
    }
}
