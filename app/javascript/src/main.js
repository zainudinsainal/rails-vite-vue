import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

export default () => {
  document.addEventListener('DOMContentLoaded', () => {
    const app = createApp(App);
    app.use(store)
    app.use(router)
    app.mount('#app')
  })
}
