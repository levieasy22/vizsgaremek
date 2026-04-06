<script>
import { RouterLink } from 'vue-router'

export default {
  name: "MenuLayout",
  components: {
    RouterLink
  }
}
</script>

<template>
  <nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <img src="../../imgs/mancs_allatmenhely_logo.png" class="card-img-top object-fit-cover" style="height: 220px; object-fit: cover;" />
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <RouterLink class="nav-link" to="/">Kezdőlap</RouterLink>
          </li>
          <li class="nav-item dropdown">
            <RouterLink class="nav-link dropdown-toggle" :to="{name: 'adoption'}" role="button" aria-expanded="false">
              Örökbefogadás
            </RouterLink>
            <ul class="dropdown-menu">
              <li><RouterLink class="dropdown-item" :to="{name: 'dogs'}">Kutyák</RouterLink></li>
              <li><RouterLink class="dropdown-item" :to="{name: 'cats'}">Macskák</RouterLink></li>
            </ul>
          </li>
          <li class="nav-item">
            <RouterLink class="nav-link" to="/about">Rólunk</RouterLink>
          </li>
          <li class="nav-item">
            <RouterLink class="nav-link" to="/contact">Kapcsolat</RouterLink>
          </li>
          <li class="nav-item">
            <RouterLink class="nav-link" to="/auth/login">Bejelentkezés</RouterLink>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<style scoped>
.dropdown:hover .dropdown-menu {
  display: block;
}
</style>