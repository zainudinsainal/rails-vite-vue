<template>
  <div class="product-edit">
    <product-form :product="product" />
  </div>
</template>

<script>
import ProductForm from './../../components/products/ProductForm.vue';
export default {
  components: { ProductForm },
  inject: ['$axios'],
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
        const data = await this.$axios.get(`/api/products/${this.$route.params.id}/edit.json`);
        this.product = data.data.product;
      } catch (err) {
        console.log('error', err);
      }
      this.isLoading = false
    },
  }
}
</script>
