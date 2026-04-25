import api from './api'

export const adoptionService = {
    // ── FELHASZNÁLÓI ──

    // Örökbefogadási kérelem benyújtása
    store: (data) => api.post('/adoption-requests', data),

    // Saját kérelmek listája
    myRequests: () => api.get('/my-adoption-requests'),

    // ── ADMIN ──

    // Összes kérelem listázása (szűrhető: { status: 'fuggoben' })
    adminGetAll: (params = {}) => api.get('/admin/adoption-requests', { params }),

    // Kérelem státusz módosítása
    updateStatus: (id, status) => api.put(
        `/admin/adoption-requests/${id}`,
        { status }
    ),
}