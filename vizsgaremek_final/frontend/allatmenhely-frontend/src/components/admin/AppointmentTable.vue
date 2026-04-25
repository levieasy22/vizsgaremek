<script>
export default {
  name: 'AppointmentTable',
  props: {
    appointments: { type: Array, default: () => [] },
  },
  emits: ['confirm', 'cancel'],
  data() {
    return {
      statusLabels: {
        fuggoben: 'Függőben',
        megerositett: 'Megerősített',
        lemondott: 'Lemondott',
      },
      typeLabels: {
        megtekintes: 'Megtekintés',
        konzultacio: 'Konzultáció',
        esemeny: 'Esemény',
      },
    }
  },
  methods: {
    formatDate(dateStr) {
      return new Date(dateStr).toLocaleDateString('hu-HU')
    },
  },
}
</script>

<template>
  <div class="card border-0 shadow-sm">
    <div class="card-body p-0">
      <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">

          <thead class="bg-light">
          <tr>
            <th class="px-4 py-3">Foglalóval</th>
            <th>Típus</th>
            <th>Állat</th>
            <th>Dátum</th>
            <th>Időpont</th>
            <th>Státusz</th>
            <th class="text-end px-4">Műveletek</th>
          </tr>
          </thead>

          <tbody>
          <tr v-for="apt in appointments" :key="apt.id">

            <td class="px-4">
              <div class="fw-semibold small">
                {{ apt.last_name }} {{ apt.first_name }}
              </div>
              <div class="text-muted" style="font-size: 11px;">{{ apt.email }}</div>
            </td>

            <td>
                <span class="badge bg-light text-dark border small">
                  {{ typeLabels[apt.type] }}
                </span>
            </td>

            <td class="small">{{ apt.animal?.name ?? '–' }}</td>

            <td class="small">{{ formatDate(apt.appointment_date) }}</td>

            <td class="small fw-semibold">
              {{ apt.appointment_time?.slice(0, 5) }}
            </td>

            <td>
                <span :class="`badge badge-${apt.status}`">
                  {{ statusLabels[apt.status] }}
                </span>
            </td>

            <td class="text-end px-4">
              <div class="d-flex gap-1 justify-content-end">
                <!-- Megerősítés -->
                <button
                    v-if="apt.status === 'fuggoben'"
                    class="btn btn-sm btn-success"
                    @click="$emit('confirm', apt)"
                    title="Megerősítés"
                >
                  <i class="bi bi-check-lg"></i>
                </button>
                <!-- Lemondás -->
                <button
                    v-if="apt.status !== 'lemondott'"
                    class="btn btn-sm btn-outline-danger"
                    @click="$emit('cancel', apt)"
                    title="Lemondás"
                >
                  <i class="bi bi-x-lg"></i>
                </button>
              </div>
            </td>

          </tr>

          <tr v-if="appointments.length === 0">
            <td colspan="7" class="text-center text-muted py-5">
              Nincs megjeleníthető időpont.
            </td>
          </tr>
          </tbody>

        </table>
      </div>
    </div>
  </div>
</template>

<style scoped>

</style>