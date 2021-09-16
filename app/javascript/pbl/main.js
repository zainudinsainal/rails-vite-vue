import { createApp } from 'vue';
import router from './router';
import store from './store';
import App from './App.vue';
import { initQuasar } from './plugins/quasar';

export default () => {
  document.addEventListener('DOMContentLoaded', () => {
    const app = createApp(App);
    initQuasar(app);
    app.use(store);
    app.use(router);
    app.mount('#app');
  })
}
