import { defineStore } from 'pinia'
import { computed, ref } from 'vue'
import { authService } from '@/services/authService'

export const useAuthStore = defineStore('auth', () => {
    // ── STATE ──
    // Betöltéskor kiolvassuk a localStorage-ból (hogy ne vesszen el frissítéskor)
    const user  = ref(JSON.parse(localStorage.getItem('user') || 'null'))
    const token = ref(localStorage.getItem('token') || null)
    const loading = ref(false)
    const error   = ref(null)

    // ── GETTERS (computed) ──
    const isLoggedIn = computed(() => !!token.value)
    const isAdmin    = computed(() => user.value?.role === 'admin')
    const userName   = computed(() => user.value?.name || '')
    const userEmail  = computed(() => user.value?.email || '')

    // ── ACTIONS ──

    /**
     * Bejelentkezés
     * Használat: await authStore.login({ email, password })
     */
    async function login(credentials) {
        loading.value = true
        error.value   = null

        try {
            const { data } = await authService.login(credentials)

            // Token és user mentése
            token.value = data.token
            user.value  = data.user

            // LocalStorage-ba mentés (oldal frissítés után is megmarad)
            localStorage.setItem('token', data.token)
            localStorage.setItem('user', JSON.stringify(data.user))

            return data
        } catch (err) {
            error.value = err.response?.data?.message || 'Bejelentkezési hiba.'
            throw err
        } finally {
            loading.value = false
        }
    }

    /**
     * Regisztráció
     * Használat: await authStore.register({ name, email, password, ... })
     */
    async function register(userData) {
        loading.value = true
        error.value   = null

        try {
            const { data } = await authService.register(userData)

            token.value = data.token
            user.value  = data.user

            localStorage.setItem('token', data.token)
            localStorage.setItem('user', JSON.stringify(data.user))

            return data
        } catch (err) {
            error.value = err.response?.data?.message || 'Regisztrációs hiba.'
            throw err
        } finally {
            loading.value = false
        }
    }

    /**
     * Kijelentkezés
     * Használat: await authStore.logout()
     */
    async function logout() {
        loading.value = true

        try {
            await authService.logout()
        } catch (err) {
            // Ha a token már lejárt, a logout API hívás hibát dob
            // de ettől még ki kell jelentkeztetni a usert
            console.warn('Logout API hiba:', err.message)
        } finally {
            // Mindenképp töröljük a lokális adatokat
            token.value = null
            user.value  = null
            localStorage.removeItem('token')
            localStorage.removeItem('user')
            loading.value = false
        }
    }

    /**
     * Profil frissítése
     */
    async function updateProfile(data) {
        loading.value = true
        error.value   = null

        try {
            const { data: responseData } = await authService.updateProfile(data)

            // Frissítjük a store-ban és localStorage-ban is
            user.value = responseData.user
            localStorage.setItem('user', JSON.stringify(responseData.user))

            return responseData
        } catch (err) {
            error.value = err.response?.data?.message || 'Profil frissítési hiba.'
            throw err
        } finally {
            loading.value = false
        }
    }

    /**
     * Jelszó módosítása
     */
    async function changePassword(data) {
        loading.value = true
        error.value   = null

        try {
            const { data: responseData } = await authService.changePassword(data)

            // Új tokent kapunk vissza, frissítjük
            if (responseData.token) {
                token.value = responseData.token
                localStorage.setItem('token', responseData.token)
            }

            return responseData
        } catch (err) {
            error.value = err.response?.data?.message || 'Jelszó módosítási hiba.'
            throw err
        } finally {
            loading.value = false
        }
    }

    /**
     * Store visszaállítása (pl. logout után)
     */
    function reset() {
        user.value    = null
        token.value   = null
        loading.value = false
        error.value   = null
        localStorage.removeItem('token')
        localStorage.removeItem('user')
    }

    return {
        // State
        user,
        token,
        loading,
        error,
        // Getters
        isLoggedIn,
        isAdmin,
        userName,
        userEmail,
        // Actions
        login,
        register,
        logout,
        updateProfile,
        changePassword,
        reset,
    }
})