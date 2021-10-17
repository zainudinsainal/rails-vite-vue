<template>
  <div class="container">
    <div class="card">
      <div class="card-header">
        <slot name="header"></slot>
      </div>
      <div class="card-body">
        <form @submit.prevent="submit">
          <slot name="body"></slot>
          <div class="form-group">
            <router-link :to="redirectBack" class="btn btn-secondary mr-2"
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
import Service from '../../services/index.js';

export default {
  props: {
    resourceType: {
      type: String,
      required: true
    },
    resource: {
      type: Object,
      required: true
    },
    successMsg: {
      type: String,
      required: true
    },
    redirectTo: {
      type: String,
      required: true
    },
    redirectBack: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      isSubmitting: false,
    };
  },
  methods: {
    submit() {
      this.isSubmitting = true
      this.$nextTick(() => this.submitResource())
    },
    async submitResource() {
      const ResourceService = Service.call(this.resourceType)

      this.isSubmitting = true
      try {
        this.resource.id ? await ResourceService.update(this.resource.id, this.resource) : await ResourceService.create(this.resource)
        this.$swal.fire({
          text: this.message,
          icon: "success",
          position: "top-end",
          timer: 1000,
        });
        this.$router.push({ name: this.redirectTo });
        this.isSubmitting = false
      } catch (err) {
        if (err.response.status === 422) {
          const errors = err.response.data[this.resourceType].errors;
          for (const key in errors) {
            errors[key] = errors[key].join(', ');
          }
          this.resource.errors = errors;
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
