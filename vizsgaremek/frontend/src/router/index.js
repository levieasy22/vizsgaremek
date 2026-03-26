import {createRouter, createWebHistory} from 'vue-router'

const PublicLayout = () => import('@/layouts/PublicLayout.vue');
const AuthLayout = () => import('@/layouts/AuthLayout.vue');
const MenuLayout = () => import('@/layouts/MenuLayout.vue');

const routes = [
    {
        path: '/',
        component: PublicLayout,
        children: [
            {
                path: '',
                name: 'home',
                component: () => import('@/views/public/HomeView.vue'),
                meta: {title: 'Home'}
            },
            {
                path: 'animals',
                children: [
                    {
                        path: '',
                        name: 'animals',
                        component: () => import('@/views/public/AnimalListView.vue'),
                        meta: {title: 'Animals'}
                    },
                    {
                        path: ':id',
                        name: 'animal-details',
                        component: () => import('@/views/public/AnimalDetailsView.vue'),
                        meta: {title: 'Animal Details'},
                        /* KELLENI FOG
                        beforeEnter: async (to) => {
                            if (!isNumeric(to.params.id)) return {name: 'not-found'};
                            const product = await fetchProductById(to.params.id);
                            if (!product) return {name: 'not-found'};
                            to.meta.prefetched = {product};
                            return true;
                        }
                        */
                    }
                ]
            },
            {
                path: 'adoptions',
                children: [
                    {
                        path: '',
                        name: 'adoptions',
                        component: () => import('@/views/public/AdoptionView.vue'),
                        meta: {title: 'Adoptions'}
                    },
                    {
                        path: ':id',
                        name: 'adoption-details',
                        component: () => import('@/views/public/AdoptionDetailsView.vue'),
                        meta: {title: 'Adoption Details'},
                        /* KELLENI FOG
                        beforeEnter: async (to) => {
                            if (!isNumeric(to.params.id)) return {name: 'not-found'};
                            const product = await fetchProductById(to.params.id);
                            if (!product) return {name: 'not-found'};
                            to.meta.prefetched = {product};
                            return true;
                        }
                        */
                    }
                ]
            },
        ],
    },
    {
        path: '/auth',
        component: AuthLayout,
        children: [
            {
                path: 'login',
                name: 'login',
                component: () => import('@/views/auth/LoginView.vue'),
                meta: {title: 'Login'},
            },
            {
                path: 'register',
                name: 'register',
                component: () => import('@/views/auth/RegisterView.vue'),
                meta: {title: 'Register'}
            }
        ]
    },
    {
        path: '/app',
        component: MenuLayout,
        meta: {requiresAuth: true},
        children: [
            {
                path: '',
                redirect: {name: 'overview'},
            },
            {
                path: 'overview',
                name: 'overview',
                component: () => import('@/views/app/admin/OverviewView.vue'),
                meta: {title: 'Overview', requiresAuth: true},
            },
            {
                path: 'profile',
                name: 'profile',
                component: () => import('@/views/app/admin/ProfileView.vue'),
                meta: {title: 'Profile', requiresAuth: true},
            },
            {
                path: 'settings',
                name: 'settings',
                component: () => import('@/views/app/admin/SettingsView.vue'),
                meta: {title: 'Settings', requiresAuth: true},
            },
            {
                path: 'appointments',
                name: 'appointments',
                component: () => import('@/views/app/admin/AppointmentsView.vue'),
                meta: {title: 'Appointments', requiresAuth: true},
            },
            {
                path: 'adoptions',
                name: 'adoptions',
                component: () => import('@/views/app/admin/AdoptionsView.vue'),
                meta: {title: 'Adoptions', requiresAuth: true},
                /* KELLENI FOG
                beforeEnter: (to) => {
                    if (!isOrderId(to.params.orderId)) return {name: 'not-found'};
                    return true;
                }
                */
            },
            {
                path: 'admin',
                meta: {requiresAuth: true, roles: ['admin']},
                children: [
                    {
                        path: '',
                        redirect: {name: 'admin-users'},
                    },
                    {
                        path: 'users',
                        name: 'admin-users',
                        component: () => import('@/views/app/admin/AdminUsersView.vue'),
                        meta: {title: 'Admin - Users', requiresAuth: true, roles: ['admin']},
                    },
                    {
                        path: 'users/:userId',
                        name: 'admin-user-details',
                        component: () => import('@/views/app/admin/AdminUserDetailsView.vue'),
                        meta: {title: 'Admin - User Details', requiresAuth: true, roles: ['admin']},
                        beforeEnter: async (to) => {
                            if (!isNumeric(to.params.userId)) return {name: 'not-found'};
                            const user = await fetchAdminUserById(to.params.userId);
                            if (!user) return {name: 'not-found'};
                            to.meta.prefetched = {user};
                            return true;
                        }
                    },
                    {
                        path: 'audit-log',
                        name: 'admin-audit',
                        component: () => import('@/views/app/admin/AdminAuditLogView.vue'),
                        meta: {title: 'Audit Log', requiresAuth: true, roles: ['admin']},
                    }
                ]
            }
        ]
    },
    {
        path: '/403',
        name: 'not-authorized',
        component: () => import('@/views/errors/NotAuthorizedView.vue'),
        meta: {title: 'Not Authorized'},
    },
    {
        path: '/:pathMatch(.*)*',
        name: 'not-found',
        component: () => import('@/views/errors/NotFoundView.vue'),
        meta: {title: 'Not Found'},
    }
]


const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes,
    scrollBehavior(to, from, savedPosition) {
        if (savedPosition) return savedPosition;
        if(to.hash) return {el: to.hash, behavior: 'smooth'};
        return {top: 0};
    }
})

router.beforeEach(to =>{
    const {isAuthenticated, user} = useAuth();
    document.title = to.meta?.title ? `${to.meta.title} - RouterApp` : 'RouterApp';
    if(to.name === 'login' && isAuthenticated.value){ return {name: 'overview'}}
    if(to.meta?.requiresAuth && !isAuthenticated.value){
        return {name: 'login', query: {redirect: to.fullPath}}
    }
    const roles = to.meta?.roles;
    if(roles?.length){
        const role = user.value?.role;
        if(!role || !roles.includes(role)) return {name: 'not-authorized'};
    }
    return true;
})

export default router