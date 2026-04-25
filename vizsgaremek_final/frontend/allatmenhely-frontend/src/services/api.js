import axios from 'axios'

// Axios instance létrehozása az alap beállításokkal
const api = axios.create({
    baseURL: import.meta.env.VITE_API_URL || 'http://localhost:8000/api',
    withCredentials: true,
    headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
    }
})

// Minden kérés elküldése előtt automatikusan hozzáfűzi a tokent
api.interceptors.request.use(
    config => {
        const token = localStorage.getItem('token')
        if (token) {
            config.headers.Authorization = `Bearer ${token}`
        }
        return config
    },
    error => {
        return Promise.reject(error)
    }
)

// Minden válasz megérkezésekor fut le
api.interceptors.response.use(
    // Sikeres válasz – simán visszaadja
    response => response,

    // Hibás válasz kezelése
    error => {
        // 401 = token lejárt vagy érvénytelen → kijelentkeztetés
        if (error.response?.status === 401) {
            localStorage.removeItem('token')
            localStorage.removeItem('user')
            // Átirányítás a login oldalra
            window.location.href = '/bejelentkezes'
        }

        return Promise.reject(error)
    }
)

export default api