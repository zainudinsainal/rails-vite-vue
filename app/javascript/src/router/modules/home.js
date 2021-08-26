export default [
  {
    path: '/',
    name: 'Home',
    component: '../../pages/Home.vue'
  },
  {
    path: '/help',
    name: 'Help',
    component: () => import('../../pages/Helper.vue')
  },
  {
    path: '/about',
    name: 'About',
    component: () => import('../../pages/About.vue')
  },
]
