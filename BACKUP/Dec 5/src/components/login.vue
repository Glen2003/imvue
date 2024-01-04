<template>
<div class="home">
    <h1>Login</h1>
    Gmail: <input type="text" v-model="email">
    <br>
    Password: <input type="password" v-model="password">
    <br>
    <button type="button" @click="login">Login</button>
    
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
const router = useRouter();
const email = ref('');
const password = ref('');

const login = () => {
  const formData = new FormData();
  formData.append('email', email.value);
  formData.append('password', password.value);

  fetch('http://localhost/im2/api/handler/login.php', {
    method: 'POST',
    body: formData
  })
  .then(response => response.json())
  .then(data => {
   
    if (data.success) {
     
      router.push({ path: '/dashboard', query: { fname: data.fname } });
    } else {
      
      console.log('Login failed:', data.message);
    }
  })
  .catch(error => {
    console.error('Error:', error);
  });
};
</script>

<style >

</style>
