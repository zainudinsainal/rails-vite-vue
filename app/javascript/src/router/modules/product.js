export default [
  {
    path: '/products',
    name: 'Products',
    component: () => import('../../pages/products/ProductIndex.vue')
  },
  {
    path: '/products/:id',
    name: 'ProductShow',
    component: () => import('../../pages/products/ProductShow.vue')
  },
  {
    path: '/products/create',
    name: 'Product Create',
    component: () => import('../../pages/products/ProductNew.vue')
  },
  {
    path: '/products/edit/:id',
    name: 'ProductEdit',
    component: () => import('../../pages/products/ProductEdit.vue')
  },
  {
    path: '/products/:id/upload',
    name: 'ProductUpload',
    component: () => import('../../pages/products/ProductUpload.vue')
  },
];
