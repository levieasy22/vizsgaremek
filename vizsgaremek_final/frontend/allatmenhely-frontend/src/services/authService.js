import api from './api'

export const authService = {
    // Regisztráció
    register: (data) => api.post('/register', data),

    // Bejelentkezés
    login: (data) => api.post('/login', data),

    // Kijelentkezés
    logout: () => api.post('/logout'),

    // Bejelentkezett user adatai
    me: () => api.get('/me'),

    // Profil frissítése
    updateProfile: (data) => api.put('/profile', data),

    // Jelszó módosítása
    changePassword: (data) => api.post('/change-password', data),
}