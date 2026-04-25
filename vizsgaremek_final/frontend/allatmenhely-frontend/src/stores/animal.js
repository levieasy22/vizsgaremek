import { defineStore } from 'pinia'
import { ref } from 'vue'
import { animalService } from '@/services/animalService'

export const useAnimalsStore = defineStore('animals', () => {
    // ── STATE ──
    const animals        = ref([])
    const currentAnimal  = ref(null)
    const loading        = ref(false)
    const error          = ref(null)

    // ── ACTIONS ──

    /**
     * Állatok lekérése (szűrhető típus szerint)
     * Használat: await animalsStore.fetchAnimals({ type: 'kutya' })
     */
    async function fetchAnimals(params = {}) {
        loading.value = true
        error.value   = null

        try {
            const { data } = await animalService.getAll(params)
            animals.value  = data
            return data
        } catch (err) {
            error.value = 'Az állatok betöltése sikertelen.'
            throw err
        } finally {
            loading.value = false
        }
    }

    /**
     * Egy állat részletes adatainak lekérése
     * Használat: await animalsStore.fetchAnimal(1)
     */
    async function fetchAnimal(id) {
        loading.value       = true
        error.value         = null
        currentAnimal.value = null

        try {
            const { data }      = await animalService.getById(id)
            currentAnimal.value = data
            return data
        } catch (err) {
            error.value = 'Az állat adatainak betöltése sikertelen.'
            throw err
        } finally {
            loading.value = false
        }
    }

    /**
     * Store törlése
     */
    function reset() {
        animals.value       = []
        currentAnimal.value = null
        loading.value       = false
        error.value         = null
    }

    return {
        animals,
        currentAnimal,
        loading,
        error,
        fetchAnimals,
        fetchAnimal,
        reset,
    }
})