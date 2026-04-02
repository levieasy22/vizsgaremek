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
      <RouterLink class="navbar-brand" to="/">Kezdőlap</RouterLink>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
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