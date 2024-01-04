// let isAuthenticated = false; // Assuming initially the user is not authenticated

// const AuthService = {
//   login(username, password) {
//     return new Promise((resolve, reject) => {
//       fetch('http://localhost/im2s/api/handler/login.php/login.php', {
//         method: 'POST',
//         headers: {
//           'Content-Type': 'application/json',
//         },
//         body: JSON.stringify({ email: username, password: password }),
//       })
//         .then(response => response.json())
//         .then(data => {
//           if (data.success) {
//             const token = data.token;
//             console.log('this is the token!', token);
//             isAuthenticated = true;
//             localStorage.setItem('token', token);
//             resolve(); // Resolve the promise upon successful login
//           } else {
//             console.error(data.message);
//             reject(data.message); // Reject the promise with an error message
//           }
//         })
//         .catch(error => {
//           // Handle any errors during the login process
//           console.error('Login error:', error);
//           reject('Login error: Please try again'); // Reject the promise with a generic error message
//         });
//     });
//   },

//   // Other methods like logout and isLoggedIn remain unchanged
//   // ...

//   logout() {
//     // Simulated logout logic
//     isAuthenticated = false;
//     localStorage.removeItem('token'); // Remove token from localStorage
//   },

//   isLoggedIn() {
//     // Check if the user is authenticated (replace with your actual check)
//     return isAuthenticated;
//   },
// };

// export default AuthService;
