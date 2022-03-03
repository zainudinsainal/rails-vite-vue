<template>
  <div>
    <div v-bind="getRootProps()">
      <input v-bind="getInputProps()" />
      <p v-if="isDragActive">Drop the files here ...</p>
      <p v-else>Drag 'n' drop some files here, or click to select files</p>
    </div>
    <button @click="open">open</button>
  </div>
</template>

<script>
import { useRoute, useRouter } from 'vue-router'
import { useDropzone } from "vue3-dropzone";
import axios from "axios";

export default {
  name: "UseDropzoneDemo",
  setup() {
    const route = useRoute()
    const router = useRouter()
    const url = `/api/products/${route.params.id}/upload.json`; // Your url on the server side
    const token = document.querySelector('[name="csrf-token"]') || { content: 'no-csrf-token' }
    const saveFiles = (files) => {
      const formData = new FormData(); // pass data as a form
      for (var x = 0; x < files.length; x++) {
        // append files as array to the form, feel free to change the array name
        formData.append("images[]", files[x]);
      }

      // post the formData to your backend where storage is processed. In the backend, you will need to loop through the array and save each file through the loop.

      axios
        .patch(url, formData, {
          headers: {
            "Content-Type": "multipart/form-data",
            "X-CSRF-Token": `${token.content}`
          },
        })
        .then((response) => {
          console.info(response.data);
          router.push({ name: 'ProductShow', params: { id: route.params.id } })
        })
        .catch((err) => {
          console.error(err);
        });
    };

    function onDrop(acceptFiles, rejectReasons) {
      saveFiles(acceptFiles); // saveFiles as callback
      console.log(rejectReasons);
    }

    const { getRootProps, getInputProps, ...rest } = useDropzone({ onDrop });

    return {
      getRootProps,
      getInputProps,
      ...rest,
    };
  },
};
</script>
