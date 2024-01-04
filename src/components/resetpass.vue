<template>
  <div class="login">
    <h1>Password Reset</h1>
    <div class="form-group" v-if="showForm">
      <label>Email:</label>
      <input type="text" v-model="email" placeholder="Enter your email">
    </div>
    <div class="form-group" v-if="showForm">
      <label>First Name:</label>
      <input type="text" v-model="fname" placeholder="Enter your first name">
    </div>
    <div class="form-group" v-if="showForm">
      <label>Last Name:</label>
      <input type="text" v-model="lname" placeholder="Enter your last name">
    </div>
    <div class="form-group" v-if="showForm">
      <label>New Password:</label>
      <input type="password" v-model="newPassword" placeholder="Enter new password">
    </div>
    <button @click="resetPassword" class="btn-login" v-if="showForm">Save</button>
      <button type="button" @click="login" class="btn btn-primary">LogIn</button>
    
    <p v-if="message">{{ message }}</p>
    <p v-else>{{ loadingMessage }}</p>
  </div>
</template>

<script >



export default {
  data() {
    return {
      email: '',
      fname: '',
      lname: '',
      newPassword: '',
      showForm: true,
      message: '',
      loadingMessage: ''
    };
  },
  methods: {
    resetPassword() {
      fetch('http://localhost/im2/api/handler/resetpassword.php', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({
          email: this.email,
          fname: this.fname,
          lname: this.lname,
          newPassword: this.newPassword
        })
      })
      .then(response => response.json())
      .then(data => {
        console.log(data); 
        if (data.success) {
          this.message = data.message; 
          this.showForm = false; 
        } else {
          this.message = data.message; 
        }
      })
      .catch(error => {
        console.error('Error:', error);
        this.message = 'An error occurred while resetting the password.';
      });
    },
    login() {
      this.$router.push({ path: '/login' })
        .catch(err => {
          console.error('Error navigating to login page:', err);
        });
    }
  }
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
    max-width: 40rem; 
    width: 500%; 
    box-sizing: border-box; 
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
    box-sizing: border-box; 
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

 
  @media screen and (max-width: 768px) {
    .login {
      width: 100%;
      border-radius: 1rem; 
    }
  }



</style>