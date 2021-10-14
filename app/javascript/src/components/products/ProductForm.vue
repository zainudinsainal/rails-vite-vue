<template>
  <div class="container">
    <div class="card">
      <div class="card-header">
        <h6>{{ product.id ? 'Edit' : 'Add' }} Product</h6>
      </div>
      <div class="card-body">
        <form v-on:submit.prevent="saveProduct">
          <div class="form-group row">
            <div class="col-6" :class="{invalid: product.errors && product.errors.name}">
              <label>Product Name:</label>
              <input type="text" class="form-control" min="0" step=".01" v-model="product.name" />
              <span class='invalid' v-if="product.errors">{{product.errors.name}}</span>
            </div>
            <div class="col-6" :class="{invalid: product.errors && product.errors.price}">
              <label>Product Price:</label>
              <input type="number" class="form-control" v-model="product.price" />
              <span class='invalid' v-if="product.errors">{{product.errors.price}}</span>
            </div>
          </div>
          <div class="form-group row">
            <div class="col-12">
              <label>Product Details:</label>
              <textarea class="form-control" v-model="product.description" />
              <span class='error' v-if="product.errors">{{product.errors.description}}</span>
            </div>
          </div>
          <div class="form-group">
            <button @click="openUppyModal = true" class="btn btn-success" type="button">Open Image Upload</button>
            <dashboard-modal
              :uppy="uppy"
              :plugins="plugins"
              :open="openUppyModal"
              :props="dashboardProps" />
          </div>
          <div class="form-group">
            <router-link to="/products" class="btn btn-secondary mr-2"
              >Cancel</router-link
            >
            <input
              type="submit"
              class="btn btn-primary"
              value="Submit"
              v-if="!isSubmitting"
            />
            <button class="btn btn-primary" type="button" disabled v-if="isSubmitting">
              <span
                class="spinner-border spinner-border-sm"
                role="status"
                aria-hidden="true"
              ></span>
              Saving...
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script>
import { DashboardModal } from '@uppy/vue'
import '@uppy/core/dist/style.css'
import '@uppy/dashboard/dist/style.css'
import Uppy from '@uppy/core'
import Webcam from '@uppy/webcam'

import Service from '../../services/index.js';
const ProductService = Service.call('products');

export default {
  components: {
    DashboardModal
  },
  props: {
    product: {
      type: Object,
    },
  },
  data() {
    return {
      isSubmitting: false,
      plugins: ['Webcam'],
      openUppyModal: false,
      dashboardProps: {
        theme: 'light',
        onRequestCloseModal: this.handleClose
      }
    };
  },
  computed: {
    uppy: () => new Uppy().use(Webcam)
  },
  beforeDestroy () {
    this.uppy.close()
  },
  methods: {
    handleClose() { this.openUppyModal = false },
    async saveProduct() {
      this.isSubmitting = true
      try {
        this.product.id ? await ProductService.update(this.product.id, this.product) : await ProductService.create(this.product)
        this.$swal.fire({
          text: `Success, Product has been ${ this.product.id ? 'updated' : 'added' }.`,
          icon: "success",
          position: "top-end",
          timer: 1000,
        });
        this.$router.push({ name: "Products" });
        this.isSubmitting = false
      } catch (err) {
        if (err.response.status === 422) {
          const errors = err.response.data.product.errors;
          for (const key in errors) {
            errors[key] = errors[key].join(', ');
          }
          this.product.errors = errors;
        } else {
          window.alert(err.response.statusText)
        }
      }
      this.isSubmitting = false
    }
  },
};
</script>

<style scoped>
.invalid span {
  color: #d9534f;
}
.invalid input,
.invalid textarea {
  border: 1px solid #d9534f;
}
</style>
