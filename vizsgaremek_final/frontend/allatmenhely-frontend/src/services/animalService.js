import api from './api'

export const animalService = {
    // ── PUBLIKUS ───────────────────────────────────────────────────

    // Összes állat lekérése (szűrhető: { type: 'kutya' })
    getAll: (params = {}) => api.get('/animals', { params }),

    // Egy állat részletei
    getById: (id) => api.get(`/animals/${id}`),

    // ── ADMIN ──────────────────────────────────────────────────────

    // Összes állat lekérése admin nézetben
    adminGetAll: (params = {}) => api.get('/admin/animals', { params }),

    // Új állat létrehozása
    create: (data) => api.post('/admin/animals', data),

    // Állat módosítása
    update: (id, data) => api.put(`/admin/animals/${id}`, data),

    // Állat törlése
    delete: (id) => api.delete(`/admin/animals/${id}`),

    // Kép feltöltése (multipart/form-data!)
    uploadImage: (id, formData) => api.post(
        `/admin/animals/${id}/images`,
        formData,
        { headers: { 'Content-Type': 'multipart/form-data' } }
    ),

    // Kép törlése
    deleteImage: (animalId, imageId) => api.delete(
        `/admin/animals/${animalId}/images/${imageId}`
    ),
}