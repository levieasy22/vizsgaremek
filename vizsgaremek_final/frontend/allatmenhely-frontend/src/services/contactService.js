import api from './api'

export const contactService = {
    // ── PUBLIKUS ──

    // Üzenet küldése
    send: (data) => api.post('/contact', data),

    // ── ADMIN ──

    // Összes üzenet listázása
    adminGetAll: (params = {}) => api.get('/admin/contact-messages', { params }),

    // Üzenet olvasottnak jelölése
    markRead: (id) => api.put(`/admin/contact-messages/${id}/read`),

    // Üzenet törlése
    delete: (id) => api.delete(`/admin/contact-messages/${id}`),
}