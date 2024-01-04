

// import { createRouter, createWebHistory } from 'vue-router';
// import Home from '../components/home.vue';
// import Login from '../components/login.vue';
// import Dashboard from '../components/dashboard.vue';
// import Dashboard1 from '../components/dashboard1.vue';
// import AuthService from './AuthService'; // Import your AuthService

// const routes = [
//   { path: '/home', component: Home },
//   { path: '/login', component: Login },
//   { path: '/dashboard', component: Dashboard, meta: { requiresAuth: true } }, 
//   { path: '/dashboard1', component: Dashboard1, meta: { requiresAuth: true } },
// ];

// const router = createRouter({
//   history: createWebHistory(),
//   routes,
// });

// router.beforeEach((to, from, next) => {
//   const isLoggedIn = AuthService.isLoggedIn();
//   const isTryingToAccessProtectedRoute = to.meta.requiresAuth;

//   if (isTryingToAccessProtectedRoute && !isLoggedIn) {
//     // If trying to access a protected route without authentication, redirect to login
//     next('/login');
//   } else if (to.path === '/login' && isLoggedIn) {
//     // If trying to access the login page while authenticated, redirect to dashboard
//     next('/dashboard');
//   } else if (isLoggedIn && (to.path === '/dashboard' || to.path === '/dashboard1')) {
//     // If authenticated and trying to access dashboard, proceed if logged in
//     next();
//   } else {
//     // For other cases, proceed as usual
//     next();
//   }
// });


// export default router;





import { createRouter, createWebHistory } from 'vue-router';
import Home from '../components/home.vue';
import Login from '../components/login.vue';
import Dashboard from '../components/dashboard.vue';
import Dashboard1 from '../components/dashboard1.vue';
import Resetpass from '../components/resetpass.vue';

const routes = [
  { path: '/home', component: Home },
  { path: '/login', component: Login },
  { path: '/dashboard', component: Dashboard, meta: { requiresAuth: true } }, 
  { path: '/dashboard1', component: Dashboard1, meta: { requiresAuth: true } },
  { path: '/resetpass', component: Resetpass },

];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;








// import { createRouter, createWebHistory } from 'vue-router';
// import Home from '../components/home.vue';
// import Login from '../components/login.vue';
// import Dashboard from '../components/dashboard.vue';
// import Dashboard1 from '../components/dashboard1.vue';



// const routes = [
//   { path: '/home', component: Home },
//   { path: '/login', component: Login },
//   { path: '/dashboard', component: Dashboard, meta: { requiresAuth: true } }, // Protected route
//   { path: '/dashboard1', component: Dashboard1, meta: { requiresAuth: true } },
// ];

// const router = createRouter({
//   history: createWebHistory(),
//   routes,
// });

// export default router;






// // Simulated authentication variable (replace this with your actual authentication logic)
// let isAuthenticated = false;

// // Function to simulate login and set isAuthenticated to true
// export function login() {
//   isAuthenticated = true;
// }

// // Navigation guard to check authentication status before accessing protected routes
// router.beforeEach((to, from, next) => {
//   const isTryingToAccessProtectedRoute = to.meta.requiresAuth;
  
//   if (isTryingToAccessProtectedRoute && !isAuthenticated) {
//     // If accessing a protected route and not authenticated, redirect to login
//     next('/login');
//   } else if (to.path === '/login' && isAuthenticated) {
//     // If trying to access login page while authenticated, redirect to dashboard
//     next('/dashboard');
//   } else {
//     // If accessing a public route or authenticated, proceed
//     next();
//   }
// });

// export default router;