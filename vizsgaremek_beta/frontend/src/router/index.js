import {createRouter, createWebHistory} from 'vue-router'

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        {
            path: '/',
            name: 'home',
            component: () => import('@/views/public/HomeView.vue'),
            meta: {title: 'Kezdőlap'}
        },
        {
            path: '/about',
            name: 'about',
            component: () => import('@/views/public/AboutView.vue'),
            meta:{
                title: "Rólunk"
            }
        },
        {
            path: '/adoption',
            name: 'adoption',
            component: () => import('@/views/public/AdoptionView.vue'),
            meta:{
                title: "Örökbefogadás"
            }
        },
        {
            path: '/dogs',
            name: 'dogs',
            component: () => import('@/views/public/DogListView.vue'),
            meta:{
                title: "Kutyák"
            },
        },
        {
            path: '/dogs/:id',
            name: 'dog-details',
            component: () => import('@/views/public/DogDetailsView.vue'),
            meta:{
                title: "Kutya részletei"
            },
        },
        {
            path: '/cats',
            name: 'cats',
            component: () => import('@/views/public/CatListView.vue'),
            meta:{
                title: "Macskák"
            },
        },
        {
            path: '/cats/:id',
            name: 'cat-details',
            component: () => import('@/views/public/CatDetailsView.vue'),
            meta:{
                title: "Macska részletei"
            },
        },
        {
            path: '/contact',
            name: 'contact',
            component: () => import('@/views/public/ContactView.vue'),
            meta:{
                title: "Kapcsolat"
            }
        },
        {
            path: '/auth/login',
            name: 'login',
            component: () => import('@/views/auth/LoginView.vue'),
            meta: {title: 'Bejelentkezés'},
        },
        {
            path: '/auth/register',
            name: 'register',
            component: () => import('@/views/auth/RegisterView.vue'),
            meta:{
                title: "Regisztráció",
            }
        },
        {
            path: '/not-authorized',
            name: 'not-authorized',
            component: () => import('@/views/errors/NotAuthorizedView.vue'),
            meta: {
                title: 'Nem jogosult'
            }
        },
        {
            path: '/:pathMatch(.*)*',
            name: 'not-found',
            component: () => import('@/views/errors/NotFoundView.vue'),
            meta: {
                title: 'Nem található'
            }
        },
        {
            path: '/admin',
            name: 'admin',
            component: () => import('@/views/app/admin/OverviewView.vue'),
            meta: {
                title: 'Adminisztráció',
                requiresAuth: true,
                roles: ['admin']
            },
            children: [
                {
                    path: '',
                    name: 'admin-overview',
                    component: () => import('@/views/app/admin/OverviewView.vue'),
                    meta: {
                        title: 'Áttekintés'
                    }
                },
                {
                    path: 'adoptions',
                    name: 'admin-adoptions',
                    component: () => import('@/views/app/admin/AdoptionsView.vue'),
                    meta: {
                        title: 'Örökbefogadások'
                    }
                },
                {
                    path: 'appointments',
                    name: 'admin-appointments',
                    component: () => import('@/views/app/admin/AppointmentsView.vue'),
                    meta: {
                        title: 'Időpontfoglalások'
                    }
                },
                {
                    path: 'profile',
                    name: 'admin-profile',
                    component: () => import('@/views/app/admin/ProfileView.vue'),
                    meta: {
                        title: 'Profil'
                    }
                },
                {
                    path: 'settings',
                    name: 'admin-settings',
                    component: () => import('@/views/app/admin/SettingsView.vue'),
                    meta: {
                        title: 'Beállítások'
                    }
                },
                {
                    path: 'manage',
                    name: 'admin-manage',
                    component: () => import('@/views/app/admin/AdminPanelView/AdoptionManageView.vue'), // Assuming a main manage view, adjust if needed
                    meta: {
                        title: 'Kezelés'
                    },
                    children: [
                        {
                            path: 'adoptions',
                            name: 'manage-adoptions',
                            component: () => import('@/views/app/admin/AdminPanelView/AdoptionManageView.vue'),
                            meta: {
                                title: 'Örökbefogadások Kezelése'
                            }
                        },
                        {
                            path: 'animals',
                            name: 'manage-animals',
                            component: () => import('@/views/app/admin/AdminPanelView/AnimalManageView.vue'),
                            meta: {
                                title: 'Állatok Kezelése'
                            }
                        },
                        {
                            path: 'appointments',
                            name: 'manage-appointments',
                            component: () => import('@/views/app/admin/AdminPanelView/AppointmentsManageView.vue'),
                            meta: {
                                title: 'Időpontfoglalások Kezelése'
                            }
                        },
                        {
                            path: 'users',
                            name: 'manage-users',
                            component: () => import('@/views/app/admin/AdminPanelView/UserManageView.vue'),
                            meta: {
                                title: 'Felhasználók Kezelése'
                            }
                        }
                    ]
                }
            ]
        },
        {
            path: '/policies/privacy',
            name: 'privacy policy',
            component: () => import('@/policies/PrivacyPolicy.vue'),
            meta: {
                title: 'Adatvédelmi irányelvek'
            }
        },
        {
            path: '/policies/aszf',
            name: 'aszf policy',
            component: () => import('@/policies/AszfPolicy.vue'),
            meta: {
                title: 'Általános Szerződési Feltételek'
            }
        },
        {
            path: '/policies/cookie',
            name: 'cookie policy',
            component: () => import('@/policies/CookiePolicy.vue'),
            meta: {
                title: 'Cookie irányelvek'
            }
        },
        {
            path: '/policies/impressum',
            name: 'impressum',
            component: () => import('@/policies/ImpressumPolicy.vue'),
            meta: {
                title: 'Impresszum'
            }
        },
    ],
})

/*
const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes,
    scrollBehavior(to, from, savedPosition) {
        if (savedPosition) return savedPosition;
        if(to.hash) return {el: to.hash, behavior: 'smooth'};
        return {top: 0};
    }
})
*/

/*
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
*/
export default router