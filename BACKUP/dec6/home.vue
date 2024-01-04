<template>
  <div class="home">
    <h1>Register</h1>
    First Name: <input type="text" v-model="fname">
    <br>
    Last Name: <input type="text" v-model="lname">
    <br>
    Gmail: <input type="text" v-model="email">
    <br>
    Password: <input type="password" v-model="password">
    <br>
    <button type="button" @click="save">Submit</button>
    <span v-for="name in names" :key="name">{{ name }}</span>
    <div v-if="showNotification">{{ notificationMessage }}</div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

const fname = ref('');
const lname = ref('');
const email = ref('');
const password = ref('');
const names = ref([]);
const showNotification = ref(false);
const notificationMessage = ref('');
const fullName = computed(() => fname.value + ' ' + lname.value);

const save = () => {
  // Example: sending data to a PHP script using fetch
  const formData = new FormData();
  formData.append('fname', fname.value);
  formData.append('lname', lname.value);
  formData.append('email', email.value);
  formData.append('password', password.value);

  fetch('http://localhost/im2/api/handler/adminregister.php', {
    method: 'POST',
    body: formData
  })
  .then(response => response.json())
  .then(data => {

    console.log(data);

    fname.value = '';
    lname.value = '';
    email.value = '';
    password.value = '';

    // Set notification message
    showNotification.value = true;
    notificationMessage.value = 'Successfully created!';
    // Hide the notification after a few seconds
    setTimeout(() => {
      showNotification.value = false;
    }, 3000); // Adjust the time for how long you want the notification to be displayed
  })
  .catch(error => {
    console.error('Error:', error);
  });
};
</script>

<style >

</style>
