import api from './api'

export const appointmentService = {
    // ── FELHASZNÁLÓI ──

    // Időpontfoglalás
    store: (data) => api.post('/appointments', data),

    // Saját foglalások listája
    myAppointments: () => api.get('/my-appointments'),

    // ── ADMIN ──

    // Összes időpont listázása
    adminGetAll: (params = {}) => api.get('/admin/appointments', { params }),

    // Időpont státusz módosítása
    updateStatus: (id, status) => api.put(
        `/admin/appointments/${id}`,
        { status }
    ),
}