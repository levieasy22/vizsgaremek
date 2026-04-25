import api from './api'

export const adminService = {
    // Dashboard statisztikák
    getStats: () => api.get('/admin/stats'),

    // Felhasználók listázása
    getUsers: (params = {}) => api.get('/admin/users', { params }),

    // Felhasználó törlése
    deleteUser: (id) => api.delete(`/admin/users/${id}`),
}