<template>
  <div class="product-new">
    <product-form :product="product" />
  </div>
</template>

<script>
import ProductForm from './../../components/products/ProductForm.vue';
import Repository from '../../repositories/index.js';
const ProductRepository = Repository.call('products');

export default {
  components: { ProductForm },
  data() {
    return {
      product: {}
    };
  },
  created() {
    this.loadProduct();
  },
  methods: {
    async loadProduct() {
      try {
        const data = await ProductRepository.new();
        this.product = data.data.product;
      } catch (err) {
        console.log('error', err);
      }
    },
  }
}
</script>
