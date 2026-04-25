import { defineStore } from 'pinia'
import { ref } from 'vue'
import { adminService } from '@/services/adminService'
import { animalService } from '@/services/animalService'
import { adoptionService } from '@/services/adoptionService'
import { appointmentService } from '@/services/appointmentService'
import { contactService } from '@/services/contactService'

export const useAdminStore = defineStore('admin', () => {
    // ── STATE ───────────────────────────────────────────────────────
    const stats        = ref(null)
    const animals      = ref([])
    const adoptions    = ref([])
    const appointments = ref([])
    const messages     = ref([])
    const users        = ref([])
    const loading      = ref(false)
    const error        = ref(null)

    // ── ACTIONS ─────────────────────────────────────────────────────

    async function fetchStats() {
        loading.value = true
        try {
            const { data } = await adminService.getStats()
            stats.value = data
        } catch (err) {
            error.value = 'Statisztikák betöltése sikertelen.'
        } finally {
            loading.value = false
        }
    }

    async function fetchAnimals(params = {}) {
        loading.value = true
        try {
            const { data } = await animalService.adminGetAll(params)
            animals.value = data
        } catch (err) {
            error.value = 'Állatok betöltése sikertelen.'
        } finally {
            loading.value = false
        }
    }

    async function fetchAdoptions(params = {}) {
        loading.value = true
        try {
            const { data } = await adoptionService.adminGetAll(params)
            adoptions.value = data.data ?? data
        } catch (err) {
            error.value = 'Kérelmek betöltése sikertelen.'
        } finally {
            loading.value = false
        }
    }

    async function fetchAppointments(params = {}) {
        loading.value = true
        try {
            const { data } = await appointmentService.adminGetAll(params)
            appointments.value = data.data ?? data
        } catch (err) {
            error.value = 'Időpontok betöltése sikertelen.'
        } finally {
            loading.value = false
        }
    }

    async function fetchMessages(params = {}) {
        loading.value = true
        try {
            const { data } = await contactService.adminGetAll(params)
            messages.value = data.data ?? data
        } catch (err) {
            error.value = 'Üzenetek betöltése sikertelen.'
        } finally {
            loading.value = false
        }
    }

    async function fetchUsers(params = {}) {
        loading.value = true
        try {
            const { data } = await adminService.getUsers(params)
            users.value = data.data ?? data
        } catch (err) {
            error.value = 'Felhasználók betöltése sikertelen.'
        } finally {
            loading.value = false
        }
    }

    function reset() {
        stats.value        = null
        animals.value      = []
        adoptions.value    = []
        appointments.value = []
        messages.value     = []
        users.value        = []
        loading.value      = false
        error.value        = null
    }

    return {
        // State
        stats,
        animals,
        adoptions,
        appointments,
        messages,
        users,
        loading,
        error,
        // Actions
        fetchStats,
        fetchAnimals,
        fetchAdoptions,
        fetchAppointments,
        fetchMessages,
        fetchUsers,
        reset,
    }
})