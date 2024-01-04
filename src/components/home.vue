<template>
  <div class="home">
    <h1>Register</h1>
    <form class="form">
      <div class="form-group">
        <label for="fname">First Name:</label>
        <input type="text" v-model="fname" id="fname" class="form-control">
      </div>
      <div class="form-group">
        <label for="lname">Last Name:</label>
        <input type="text" v-model="lname" id="lname" class="form-control">
      </div>
      <div class="form-group">
        <label for="email">Gmail:</label>
        <input type="text" v-model="email" id="email" class="form-control">
      </div>
      <div class="form-group">
        <label for="password">Password:</label>
        <input type="password" v-model="password" id="password" class="form-control">
      </div>
       <div class="form-group">
      <label for="confirmPassword">Confirm Password:</label>
      <input type="password" v-model="confirmPassword" id="confirmPassword" class="form-control">
    </div>
      <div class="form-group">
        <label for="role">Role:</label>
        <select v-model="selectedRole" id="role" class="form-control">
          <option value="admin">Admin</option>
          <option value="user">User</option>
        </select>
      </div>
      <button type="button" @click="save" class="btn btn-primary">Submit</button>
      <button type="button" @click="login" class="btn btn-primary">LogIn</button>

    </form>
    <div v-if="showNotification" class="notification">{{ notificationMessage }}</div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router';

// Inside your setup function
const router = useRouter();

const login = () => {
  router.push({ path: '/login' });
};

import { ref, computed } from 'vue';

const fname = ref('');
const lname = ref('');
const email = ref('');
const password = ref('');
const confirmPassword = ref('');
const selectedRole = ref('');
const showNotification = ref(false);
const notificationMessage = ref('');
const fullName = computed(() => fname.value + ' ' + lname.value);

const save = () => {
  const formData = new FormData();
  formData.append('fname', fname.value);
  formData.append('lname', lname.value);
  formData.append('email', email.value);
  formData.append('password', password.value);
  formData.append('role', selectedRole.value);

  if (selectedRole.value !== 'admin' && selectedRole.value !== 'user') {
    // Show an error message to the user
    showNotification.value = true;
    notificationMessage.value = 'Please select a valid role (admin/user)';
    setTimeout(() => {
      showNotification.value = false;
    }, 3000);
    return;
  }

  if (password.value !== confirmPassword.value) {
    showNotification.value = true;
    notificationMessage.value = 'Passwords do not match';
    setTimeout(() => {
      showNotification.value = false;
    }, 3000);
    return;
  }

  fetch('http://localhost/im2/api/handler/adminregister.php', {
    method: 'POST',
    body: formData
  })
    .then(response => response.json())
    .then(data => {
      if (data.success === false && data.message === 'An admin account already exists') {
        // An admin account already exists, show an error message
        showNotification.value = true;
        notificationMessage.value = 'An admin account already exists';
      } else if (data.success === false && data.message === 'User with this email already exists') {
        // User with this email already exists, show an error message
        showNotification.value = true;
        notificationMessage.value = 'User with this email already exists';
      } else {
        console.log(data);
        fname.value = '';
        lname.value = '';
        email.value = '';
        password.value = '';
        confirmPassword.value = '';
        selectedRole.value = '';

        showNotification.value = true;
        notificationMessage.value = 'Successfully created!';
      }

      setTimeout(() => {
        showNotification.value = false;
      }, 3000);
    })
    .catch(error => {
      console.error('Error:', error);
      // Handle other errors here
    });
};
</script>


<style>

.home {

  margin: 0 auto;
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 3rem;
  background-color: #f9f9f9;
  display: flex; 
  justify-content: center; 
  align-items: center; 
  flex-direction: column; 
  margin-right: -25rem;
  width: 45rem;
}
.form-group {
  margin-bottom: 15px;
}


.form-control {
  width: 30rem;
  padding: 8px;
  font-size: 16px;
  border-radius: 3px;
  border: 1px solid #ccc;
}

.btn {
  padding: 8px 20px;
  font-size: 16px;
  border-radius: 3px;
  cursor: pointer;
  margin-bottom: 10px;
}

.btn-primary {
 background-color: #007bff;
  color: #fff;
  border: none;
  margin-right: 10px;

}

.notification {
  margin-top: 15px;
  padding: 10px;
  background-color: #dff0d8;
  border: 1px solid #c8e3b4;
  border-radius: 3px;
  color: #468847;
}

</style>
