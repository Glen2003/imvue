<template>
  <div class="login">
    <h1>Login</h1>
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="text" id="email" v-model="email" placeholder="Enter your email">
    </div>
    <div class="form-group">
      <label for="password">Password:</label>
      <input type="password" id="password" v-model="password" placeholder="Enter your password">
    </div>
    <button type="button" @click="login" class="btn-login">Login</button>
    <button type="button" @click="Register" class="btn-login">Register</button><br>
     <a href="#" @click="forgotPassword" class="forgot-password">Forgot Password?</a>

    
    <div v-if="errorNotification">{{ errorNotification }}</div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const email = ref('');
const password = ref('');
const errorNotification = ref('');

const Register = () => {
  router.push({ path: '/Home' });
};

const forgotPassword = () => {
  router.push({ path: '/resetpass' });
};

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
      console.log('Login response:', data);
      
      if (data.success) {
        if (data.role === 'admin') {
          router.push({ path: '/dashboard', query: { fname: data.fname } });
        } else if (data.role === 'user'){
          router.push({ path: '/dashboard1', query: { fname: data.fname } });
        }
      } else {
        
        errorNotification.value = data.message;
        console.log('Login failed:', data.message);
      }
    })
    .catch(error => {
      console.error('Error:', error);
    
      errorNotification.value = 'An error occurred while logging in';
    });
};



</script>

<style>
.login {
 
  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 2rem;
  background-color: #f9f9f9;
  text-align: center;
  margin-right: -18rem;
  width: 30rem;
}

.form-group {
  margin-bottom: 15px;
}

label {
  display: block;
  margin-bottom: 5px;
}

input[type="text"],
input[type="password"] {
  width: 100%;
  padding: 8px;
  font-size: 14px;
  border-radius: 3px;
  border: 1px solid #ccc;
}

.btn-login {
  padding: 8px 20px;
  font-size: 16px;
  border-radius: 3px;
  cursor: pointer;
  background-color: #007bff;
  color: #fff;
  border: none;
  margin-right: 10px;
  
}
.forgot-password {
  margin-top: 10px;
  display: block;
  text-align: center;
  color: #007bff;
  text-decoration: none;
}
</style>


