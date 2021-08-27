import Product from './modules/product.js';

const modules = {
  'products': Product
}

export default {
  call: name => modules[name]
};
