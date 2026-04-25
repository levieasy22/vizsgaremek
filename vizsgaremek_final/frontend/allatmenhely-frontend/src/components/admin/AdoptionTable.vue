<script>
export default {
  name: 'AdoptionTable',
  props: {
    requests: { type: Array, default: () => [] },
  },
  emits: ['view', 'accept', 'reject'],
  data() {
    return {
      statusLabels: {
        fuggoben:   'Függőben',
        elfogadva:  'Elfogadva',
        elutasitva: 'Elutasítva',
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
            <th class="px-4 py-3">#</th>
            <th>Kérelmező</th>
            <th>Állat</th>
            <th>Kert</th>
            <th>Más állat</th>
            <th>Beérkezett</th>
            <th>Státusz</th>
            <th class="text-end px-4">Műveletek</th>
          </tr>
          </thead>

          <tbody>
          <tr v-for="req in requests" :key="req.id">

            <td class="px-4 text-muted small">#{{ req.id }}</td>

            <td>
              <div class="fw-semibold small">
                {{ req.last_name }} {{ req.first_name }}
              </div>
              <div class="text-muted" style="font-size: 11px;">{{ req.email }}</div>
            </td>

            <td class="small">{{ req.animal?.name ?? '–' }}</td>

            <td>
              <i :class="req.has_garden
                  ? 'bi bi-check-circle-fill text-success'
                  : 'bi bi-x-circle-fill text-danger'">
              </i>
            </td>

            <td>
              <i :class="req.has_other_pets
                  ? 'bi bi-check-circle-fill text-success'
                  : 'bi bi-x-circle-fill text-danger'">
              </i>
            </td>

            <td class="small text-muted">
              {{ formatDate(req.created_at) }}
            </td>

            <td>
                <span :class="`badge badge-${req.status}`">
                  {{ statusLabels[req.status] }}
                </span>
            </td>

            <td class="text-end px-4">
              <div class="d-flex gap-1 justify-content-end">
                <!-- Motiváció megtekintése -->
                <button
                    class="btn btn-sm btn-outline-secondary"
                    @click="$emit('view', req)"
                    title="Motiváció"
                >
                  <i class="bi bi-eye"></i>
                </button>
                <!-- Elfogadás -->
                <button
                    v-if="req.status === 'fuggoben'"
                    class="btn btn-sm btn-success"
                    @click="$emit('accept', req)"
                    title="Elfogadás"
                >
                  <i class="bi bi-check-lg"></i>
                </button>
                <!-- Elutasítás -->
                <button
                    v-if="req.status === 'fuggoben'"
                    class="btn btn-sm btn-danger"
                    @click="$emit('reject', req)"
                    title="Elutasítás"
                >
                  <i class="bi bi-x-lg"></i>
                </button>
              </div>
            </td>

          </tr>

          <tr v-if="requests.length === 0">
            <td colspan="8" class="text-center text-muted py-5">
              Nincs megjeleníthető kérelem.
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