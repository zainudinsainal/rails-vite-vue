// wrapper around axios to include Rails CSRF token
import axios from 'axios';
import router from '../router/index.js';

const token = document.querySelector('[name="csrf-token"]') || { content: 'no-csrf-token' };
const instance = axios.create({
  headers: {
    Accept: "application/json",
    "Content-Type": "application/json",
    common: {
      'X-CSRF-Token': token.content
    }
  }
});

instance.interceptors.response.use(null, error => {
  if (error.response.status === 401) {
    return window.location.href = 'users/sign_in'
  } else if (error.response.status === 422) {
     return true;
  } else {
    router.push('app/500');
    return Promise.reject(error);
  }
});

export default instance;
