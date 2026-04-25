import { createRouter, createWebHistory } from 'vue-router'
import { useAuthStore } from '@/stores/auth.js'

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),

    // Minden navigációnál az oldal tetejére ugrik
    scrollBehavior() {
        return { top: 0 }
    },

    routes: [
        {
            path: '/',
            name: 'Home',
            component: () => import('@/views/HomeView.vue'),
        },
        {
            path: '/rolunk',
            name: 'About',
            component: () => import('@/views/AboutView.vue'),
        },
        {
            path: '/kapcsolat',
            name: 'Contact',
            component: () => import('@/views/ContactView.vue'),
        },

        // Örökbefogadás oldal – query parammal szűrhető
        // /orokbefogadas?type=kutya vagy /orokbefogadas?type=macska
        {
            path: '/orokbefogadas',
            name: 'Adoption',
            component: () => import('@/views/AdoptionView.vue'),
        },

        // Állat részletes oldala
        {
            path: '/allat/:id',
            name: 'AnimalDetail',
            component: () => import('@/views/AnimalDetailView.vue'),
        },

        // Örökbefogadási kérelem oldala
        {
            path: '/allat/:id/orokbefogadas',
            name: 'AdoptionForm',
            component: () => import('@/components/forms/AdoptionForm.vue'),
        },

        // AUTH OLDALAK
        // Bejelentkezett usereket visszairányítjuk a főoldalra

        {
            path: '/bejelentkezes',
            name: 'Login',
            component: () => import('@/views/LoginView.vue'),
            meta: { guestOnly: true }, // csak bejelentkezés nélkül érhető el
        },
        {
            path: '/regisztracio',
            name: 'Register',
            component: () => import('@/views/RegisterView.vue'),
            meta: { guestOnly: true },
        },

        // ADMIN OLDALAK
        // Csak admin role-lal érhető el

        {
            path: '/admin',
            component: () => import('@/views/admin/AdminLayout.vue'),
            meta: { requiresAdmin: true },
            children: [
                {
                    path: '',
                    name: 'AdminDashboard',
                    component: () => import('@/views/admin/AdminDashboard.vue'),
                },
                {
                    path: 'allatok',
                    name: 'AdminAnimals',
                    component: () => import('@/views/admin/AdminAnimals.vue'),
                },
                {
                    path: 'orokbefogadas',
                    name: 'AdminAdoptions',
                    component: () => import('@/views/admin/AdminAdoptions.vue'),
                },
                {
                    path: 'idopontok',
                    name: 'AdminAppointments',
                    component: () => import('@/views/admin/AdminAppointments.vue'),
                },
                {
                    path: 'fiok',
                    name: 'AdminAccount',
                    component: () => import('@/views/admin/AdminAccount.vue'),
                },
            ],
        },

        // 404 – nem létező oldalak visszairányítása

        {
            path: '/:pathMatch(.*)*',
            name: 'NotFound',
            redirect: '/',
        },
    ],
})

// Minden navigáció előtt lefut és ellenőrzi a jogosultságokat
router.beforeEach((to, from, next) => {
    const auth = useAuthStore()

    // Admin oldal védelme – csak admin role-lal érhető el
    if (to.meta.requiresAdmin) {
        if (!auth.isLoggedIn) {
            // Nem bejelentkezett → login oldalra
            return next({ name: 'Login' })
        }
        if (!auth.isAdmin) {
            // Bejelentkezett, de nem admin → főoldalra
            return next({ name: 'Home' })
        }
    }

    // Guest only oldalak – bejelentkezett usereket visszairányítja
    if (to.meta.guestOnly && auth.isLoggedIn) {
        if (auth.isAdmin) {
            return next({ name: 'AdminDashboard' })
        }
        return next({ name: 'Home' })
    }

    next()
})


export default router