<template>
  <div class="container">
    <!-- Sidebar Section -->
    <aside>
      <div class="toggle">
        <div class="logo">
          <img src="../components/images/logo.png" />
          <h2>Ad<span class="danger">min</span></h2>
        </div>
        <div class="close" id="close-btn">
          <span class="material-icons-sharp"> close </span>
        </div>
      </div>

      <div class="sidebar">
        <a href="#" class="active">
          <span class="material-icons-sharp"> dashboard </span>
          <h3>Dashboard</h3>
        </a>
        <a href="#">
          <span class="material-icons-sharp"> insights </span>
          <h3>Analytics</h3>
        </a>
        <a href="#">
          <span class="material-icons-sharp"> receipt_long </span>
          <h3>History</h3>
        </a>
        <a href="#">
          <span class="material-icons-sharp"> person_outline </span>
          <h3>Users</h3>
        </a>
        <a href="#">
          <span class="material-icons-sharp"> mail_outline </span>
          <h3>Tickets</h3>
          <span class="message-count">27</span>
        </a>
        <a href="#">
          <span class="material-icons-sharp"> inventory </span>
          <h3>Sale List</h3>
        </a>
        <a href="#">
          <span class="material-icons-sharp"> report_gmailerrorred </span>
          <h3>Reports</h3>
        </a>
        <a href="#">
          <span class="material-icons-sharp"> settings </span>
          <h3>Settings</h3>
        </a>
        <a href="#">
          <span class="material-icons-sharp"> add </span>
          <h3>New Login</h3>
        </a>
        <a @click="logout">
          <span class="material-icons-sharp"> logout </span>
          <h3>Logout</h3>
        </a>
      </div>
    </aside>
    <!-- End of Sidebar Section -->

    <!-- Main Content -->
    <main>
      <h1>Admin <span class="danger">Dashboard</span></h1>
      <!-- Analyses -->
      <div class="analyse">
        <div class="sales">
          <div class="status">
            <div class="info">
              <!-- <h3>User</h3> -->
              <h1>Users</h1>
            </div>
            <div class="progresss">
              <svg>
                <circle cx="38" cy="38" r="36"></circle>
              </svg>
              <div class="percentage">
                <p>+{{ userCount }}%</p>
              </div>
            </div>
          </div>
        </div>
        <div class="visits">
          <div class="status">
            <div class="info">
              <!-- <h3>Admin</h3> -->
              <h1>Admins</h1>
            </div>
            <div class="progresss">
              <svg>
                <circle cx="38" cy="38" r="36"></circle>
              </svg>
              <div class="percentage">
                <p>+{{ adminCount }}%</p>
              </div>
            </div>
          </div>
        </div>
        <div class="searches">
          <div class="status">
            <div class="info">
              <!-- <h3>All Users</h3> -->
              <h1>AllUsers</h1>
            </div>
            <div class="progresss">
              <svg>
                <circle cx="38" cy="38" r="36"></circle>
              </svg>
              <div class="percentage">
                <p>+{{ allUsersCount }}%</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Recent Orders Table -->
      <div class="recent-orders">
        <h2>New Users</h2>
        <table>
          <thead>
            <tr class="bold-header">
              <th>FirstName</th>
              <th>LastName</th>
              <th>Email</th>
              <th>Role</th>
              <th>Action</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="user in users" :key="user.id">
              <td>{{ user.fname }}</td>
              <td>{{ user.lname }}</td>
              <td>{{ user.email }}</td>
              <td>{{ user.role }}</td>
              <td class="action-cell">
                <button
                  type="button"
                  @click="editRole(user.id, user.role)"
                  class="edit-button"
                >
                  Edit
                </button>
                <button
                  type="button"
                  @click="confirmDelete(user.id)"
                  class="delete-button"
                >
                  Delete
                </button>
              </td>
            </tr>
          </tbody>
        </table>
        <div></div>
        <a href="#">Show All</a>
      </div>
      <!-- End of Recent Orders -->
    </main>
    <!-- End of Main Content -->

    <!-- Right Section -->
    <div class="right-section">
      <div class="nav">
        <button id="menu-btn">
          <span class="material-icons-sharp"> menu </span>
        </button>
        <div class="dark-mode">
          <span class="material-icons-sharp active"> light_mode </span>
          <span class="material-icons-sharp"> dark_mode </span>
        </div>

        <div class="profile">
          <div class="info">
            <p>
              Wellcome, <b>{{ $route.query.fname }}</b>
            </p>
            <small class="text-muted">Admin</small>
          </div>
          <div class="profile-photo">
            <img src="../components/images/profile-1.jpg" />
          </div>
        </div>
      </div>
      <!-- End of Nav -->

      <div class="user-profile">
        <div class="logo">
          <img src="../components/images/logo.png" />
          <h2>Users Management</h2>
        </div>
      </div>

      <div class="reminders">
        <div class="header">
          <h2>Reminders</h2>
          <span class="material-icons-sharp"> notifications_none </span>
        </div>

        <div class="notification">
          <div class="icon">
            <span class="material-icons-sharp"> volume_up </span>
          </div>
          <div class="content">
            <div class="info">
              <h3>Workshop</h3>
              <small class="text_muted"> 08:00 AM - 12:00 PM </small>
            </div>
            <span class="material-icons-sharp"> more_vert </span>
          </div>
        </div>

        <div class="notification deactive">
          <div class="icon">
            <span class="material-icons-sharp"> edit </span>
          </div>
          <div class="content">
            <div class="info">
              <h3>Workshop</h3>
              <small class="text_muted"> 08:00 AM - 12:00 PM </small>
            </div>
            <span class="material-icons-sharp"> more_vert </span>
          </div>
        </div>

        <div class="notification add-reminder">
          <div>
            <span class="material-icons-sharp"> add </span>
            <h3>Add Reminder</h3>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
import axios from 'axios'

export default {
  data() {
    return {
      users: [],
      userCount: 0,
      adminCount: 0,
      allUsersCount: 0,
    }
  },
  mounted() {
    this.fetchUsers()
  },
  methods: {
    fetchUsers() {
      axios
        .get('http://localhost/im2/api/handler/getalluser.php')
        .then((response) => {
          this.users = response.data
          const allUsers = response.data

          let userCount = 0
          let adminCount = 0

          allUsers.forEach((user) => {
            if (user.role === 'user') {
              userCount++
            } else if (user.role === 'admin') {
              adminCount++
            }
          })

          this.userCount = userCount
          this.adminCount = adminCount
          this.allUsersCount = allUsers.length
        })
        .catch((error) => {
          console.error('Error fetching user data', error)
        })
    },
    confirmDelete(userId) {
      if (confirm('Are you sure you want to delete this user?')) {
        this.deleteUser(userId)
      }
    },
    deleteUser(userId) {
      axios
        .delete(`http://localhost/im2/api/handler/deleteUser.php?id=${userId}`)
        .then(() => {
          this.fetchUsers()
          console.log('User deleted successfully')
        })
        .catch((error) => {
          console.error('Error deleting user', error)
        })
    },

    editRole(userId, currentRole) {
      const validRoles = ['admin', 'user']
      const newRole = prompt('Enter the new role:', currentRole)

      function notifyUser(message) {
        alert(message)
      }

      if (newRole !== null) {
        if (validRoles.includes(newRole)) {
          axios
            .put(`http://localhost/im2/api/handler/updateRole.php`, {
              id: userId,
              role: newRole,
            })
            .then(() => {
              this.fetchUsers()
              console.log('Role updated successfully')
            })
            .catch((error) => {
              console.error('Error updating role', error)
            })
        } else {
          notifyUser('Invalid role. Please enter either "admin" or "user".')
        }
      }
    },

    logout() {
      localStorage.removeItem('token')

      axios
        .post('http://localhost/im2/api/handler/logout.php')
        .then(() => {
          this.$router.push({ path: '/login' })
          console.log('logout Success')
        })
        .catch((error) => {
          console.error('Logout failed:', error)
        })
    },
  },
}
</script>

<style>
@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');
@import url('https://fonts.googleapis.com/icon?family=Material+Icons+Sharp');
:root {
  --color-primary: #6c9bcf;
  --color-danger: #ff0060;
  --color-success: #1b9c85;
  --color-warning: #f7d060;
  --color-white: #fff;
  --color-info-dark: #7d8da1;
  --color-dark: #363949;
  --color-light: rgba(132, 139, 200, 0.18);
  --color-dark-variant: #677483;
  --color-background: #f6f6f9;

  --card-border-radius: 2rem;
  --border-radius-1: 0.4rem;
  --border-radius-2: 1.2rem;

  --card-padding: 1.8rem;
  --padding-1: 1.2rem;

  --box-shadow: 0 2rem 3rem var(--color-light);
}

.dark-mode-variables {
  --color-background: #181a1e;
  --color-white: #202528;
  --color-dark: #edeffd;
  --color-dark-variant: #a3bdcc;
  --color-light: rgba(0, 0, 0, 0.4);
  --box-shadow: 0 2rem 3rem var(--color-light);
}

* {
  margin: 0;
  padding: 0;
  outline: 0;
  appearance: 0;
  border: 0;
  text-decoration: none;
  box-sizing: border-box;
}

html {
  font-size: 14px;
}

body {
  width: 100vw;
  height: 100vh;
  font-family: 'Poppins', sans-serif;
  font-size: 0.88rem;
  user-select: none;
  overflow-x: hidden;
  color: var(--color-dark);
  background-color: var(--color-background);
}

a {
  color: var(--color-dark);
}

img {
  display: block;
  width: 100%;
  object-fit: cover;
}

h1 {
  font-weight: 800;
  font-size: 1.8rem;
}

h2 {
  font-weight: 600;
  font-size: 1.4rem;
}

h3 {
  font-weight: 500;
  font-size: 0.87rem;
}

small {
  font-size: 0.76rem;
}

p {
  color: var(--color-dark-variant);
}

b {
  color: var(--color-dark);
}

.text-muted {
  color: var(--color-info-dark);
}

.primary {
  color: var(--color-primary);
}

.danger {
  color: var(--color-danger);
}

.success {
  color: var(--color-success);
}

.warning {
  color: var(--color-warning);
}

.container {
  display: grid;
  width: 100%;
  margin: 0 auto;
  gap: 1.8rem;
  grid-template-columns: 12rem auto 23rem;
}

aside {
  height: 100vh;
}

aside .toggle {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-top: 1.4rem;
}

aside .toggle .logo {
  display: flex;
  gap: 0.5rem;
}

aside .toggle .logo img {
  width: 2rem;
  height: 2rem;
}

aside .toggle .close {
  padding-right: 1rem;
  display: none;
}

aside .sidebar {
  display: flex;
  flex-direction: column;
  background-color: var(--color-white);
  box-shadow: var(--box-shadow);
  border-radius: 15px;
  height: 88vh;
  position: relative;
  top: 1.5rem;
  transition: all 0.3s ease;
}

aside .sidebar:hover {
  box-shadow: none;
}

aside .sidebar a {
  display: flex;
  align-items: center;
  color: var(--color-info-dark);
  height: 3.7rem;
  gap: 1rem;
  position: relative;
  margin-left: 2rem;
  transition: all 0.3s ease;
}

aside .sidebar a span {
  font-size: 1.6rem;
  transition: all 0.3s ease;
}

aside .sidebar a:last-child {
  position: absolute;
  bottom: 2rem;
  width: 100%;
}

aside .sidebar a.active {
  width: 100%;
  color: var(--color-primary);
  background-color: var(--color-light);
  margin-left: 0;
}

aside .sidebar a.active::before {
  content: '';
  width: 6px;
  height: 18px;
  background-color: var(--color-primary);
}

aside .sidebar a.active span {
  color: var(--color-primary);
  margin-left: calc(1rem - 3px);
}

aside .sidebar a:hover {
  color: var(--color-primary);
}

aside .sidebar a:hover span {
  margin-left: 0.6rem;
}

aside .sidebar .message-count {
  background-color: var(--color-danger);
  padding: 2px 6px;
  color: var(--color-white);
  font-size: 11px;
  border-radius: var(--border-radius-1);
}

main {
  margin-top: 1.4rem;
}

main .analyse {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.6rem;
}

main .analyse > div {
  background-color: var(--color-white);
  padding: var(--card-padding);
  border-radius: var(--card-border-radius);
  margin-top: 1rem;
  box-shadow: var(--box-shadow);
  cursor: pointer;
  transition: all 0.3s ease;
}

main .analyse > div:hover {
  box-shadow: none;
}

main .analyse > div .status {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

main .analyse h3 {
  margin-left: 0.6rem;
  font-size: 1rem;
}

main .analyse .progresss {
  position: relative;
  width: 92px;
  height: 92px;
  border-radius: 50%;
}

main .analyse svg {
  width: 7rem;
  height: 7rem;
}

main .analyse svg circle {
  fill: none;
  stroke-width: 10;
  stroke-linecap: round;
  transform: translate(5px, 5px);
}

main .analyse .sales svg circle {
  stroke: var(--color-success);
  stroke-dashoffset: -30;
  stroke-dasharray: 200;
}

main .analyse .visits svg circle {
  stroke: var(--color-danger);
  stroke-dashoffset: -30;
  stroke-dasharray: 200;
}

main .analyse .searches svg circle {
  stroke: var(--color-primary);
  stroke-dashoffset: -30;
  stroke-dasharray: 200;
}

main .analyse .progresss .percentage {
  position: absolute;
  top: -3px;
  left: -1px;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100%;
  width: 100%;
}

main .new-users {
  margin-top: 1.3rem;
}

main .new-users .user-list {
  background-color: var(--color-white);
  padding: var(--card-padding);
  border-radius: var(--card-border-radius);
  margin-top: 1rem;
  box-shadow: var(--box-shadow);
  display: flex;
  justify-content: space-around;
  flex-wrap: wrap;
  gap: 1.4rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

main .new-users .user-list:hover {
  box-shadow: none;
}

main .new-users .user-list .user {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

main .new-users .user-list .user img {
  width: 5rem;
  height: 5rem;
  margin-bottom: 0.4rem;
  border-radius: 50%;
}

main .recent-orders {
  margin-top: 1.3rem;
}

main .recent-orders h2 {
  margin-bottom: 0.8rem;
}

main .recent-orders table {
  background-color: var(--color-white);
  width: 100%;
  padding: var(--card-padding);
  text-align: center;
  box-shadow: var(--box-shadow);
  border-radius: var(--card-border-radius);
  transition: all 0.3s ease;
}

main .recent-orders table:hover {
  box-shadow: none;
}

main table tbody td {
  height: 2.8rem;
  border-bottom: 1px solid var(--color-light);
  color: var(--color-dark-variant);
}

main table tbody tr:last-child td {
  border: none;
}

main .recent-orders a {
  text-align: center;
  display: block;
  margin: 1rem auto;
  color: var(--color-primary);
}

.right-section {
  margin-top: 1.4rem;
}

.right-section .nav {
  display: flex;
  justify-content: end;
  gap: 2rem;
}

.right-section .nav button {
  display: none;
}

.right-section .dark-mode {
  background-color: var(--color-light);
  display: flex;
  justify-content: space-between;
  align-items: center;
  height: 1.6rem;
  width: 4.2rem;
  cursor: pointer;
  border-radius: var(--border-radius-1);
}

.right-section .dark-mode span {
  font-size: 1.2rem;
  width: 50%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
}

.right-section .dark-mode span.active {
  background-color: var(--color-primary);
  color: white;
  border-radius: var(--border-radius-1);
}

.right-section .nav .profile {
  display: flex;
  gap: 2rem;
  text-align: right;
}

.right-section .nav .profile .profile-photo {
  width: 2.8rem;
  height: 2.8rem;
  border-radius: 50%;
  overflow: hidden;
}

.right-section .user-profile {
  display: flex;
  justify-content: center;
  text-align: center;
  margin-top: 1rem;
  background-color: var(--color-white);
  padding: var(--card-padding);
  border-radius: var(--card-border-radius);
  box-shadow: var(--box-shadow);
  cursor: pointer;
  transition: all 0.3s ease;
}

.right-section .user-profile:hover {
  box-shadow: none;
}

.right-section .user-profile img {
  width: 11rem;
  height: auto;
  margin-bottom: 0.8rem;
  border-radius: 50%;
}

.right-section .user-profile h2 {
  margin-bottom: 0.2rem;
}

.right-section .reminders {
  margin-top: 2rem;
}

.right-section .reminders .header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 0.8rem;
}

.right-section .reminders .header span {
  padding: 10px;
  box-shadow: var(--box-shadow);
  background-color: var(--color-white);
  border-radius: 50%;
}

.right-section .reminders .notification {
  background-color: var(--color-white);
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 0.7rem;
  padding: 1.4rem var(--card-padding);
  border-radius: var(--border-radius-2);
  box-shadow: var(--box-shadow);
  cursor: pointer;
  transition: all 0.3s ease;
}

.right-section .reminders .notification:hover {
  box-shadow: none;
}

.right-section .reminders .notification .content {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin: 0;
  width: 100%;
}

.right-section .reminders .notification .icon {
  padding: 0.6rem;
  color: var(--color-white);
  background-color: var(--color-success);
  border-radius: 20%;
  display: flex;
}

.right-section .reminders .notification.deactive .icon {
  background-color: var(--color-danger);
}

.right-section .reminders .add-reminder {
  background-color: var(--color-white);
  border: 2px dashed var(--color-primary);
  color: var(--color-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.right-section .reminders .add-reminder:hover {
  background-color: var(--color-primary);
  color: white;
}

.right-section .reminders .add-reminder div {
  display: flex;
  align-items: center;
  gap: 0.6rem;
}

@media screen and (max-width: 1200px) {
  .container {
    width: 95%;
    grid-template-columns: 7rem auto 23rem;
  }

  aside .logo h2 {
    display: none;
  }

  aside .sidebar h3 {
    display: none;
  }

  aside .sidebar a {
    width: 5.6rem;
  }

  aside .sidebar a:last-child {
    position: relative;
    margin-top: 1.8rem;
  }

  main .analyse {
    grid-template-columns: 1fr;
    gap: 0;
  }

  main .new-users .user-list .user {
    flex-basis: 40%;
  }

  main .recent-orders {
    width: 94%;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    margin: 2rem 0 0 0.8rem;
  }

  main .recent-orders table {
    width: 83vw;
  }

  main table thead tr th:last-child,
  main table thead tr th:first-child {
    display: none;
  }

  main table tbody tr td:last-child,
  main table tbody tr td:first-child {
    display: none;
  }
}

@media screen and (max-width: 768px) {
  .container {
    width: 100%;
    grid-template-columns: 1fr;
    padding: 0 var(--padding-1);
  }

  aside {
    position: fixed;
    background-color: var(--color-white);
    width: 15rem;
    z-index: 3;
    box-shadow: 1rem 3rem 4rem var(--color-light);
    height: 100vh;
    left: -100%;
    display: none;
    animation: showMenu 0.4s ease forwards;
  }

  @keyframes showMenu {
    to {
      left: 0;
    }
  }

  aside .logo {
    margin-left: 1rem;
  }

  aside .logo h2 {
    display: inline;
  }

  aside .sidebar h3 {
    display: inline;
  }

  aside .sidebar a {
    width: 100%;
    height: 3.4rem;
  }

  aside .sidebar a:last-child {
    position: absolute;
    bottom: 5rem;
  }

  aside .toggle .close {
    display: inline-block;
    cursor: pointer;
  }

  main {
    margin-top: 8rem;
    padding: 0 1rem;
  }

  main .new-users .user-list .user {
    flex-basis: 35%;
  }

  main .recent-orders {
    position: relative;
    margin: 3rem 0 0 0;
    width: 100%;
  }

  main .recent-orders table {
    width: 100%;
    margin: 0;
  }

  .right-section {
    width: 94%;
    margin: 0 auto 4rem;
  }

  .right-section .nav {
    position: fixed;
    top: 0;
    left: 0;
    align-items: center;
    background-color: var(--color-white);
    padding: 0 var(--padding-1);
    height: 4.6rem;
    width: 100%;
    z-index: 2;
    box-shadow: 0 1rem 1rem var(--color-light);
    margin: 0;
  }

  .right-section .nav .dark-mode {
    width: 4.4rem;
    position: absolute;
    left: 66%;
  }

  .right-section .profile .info {
    display: none;
  }

  .right-section .nav button {
    display: inline-block;
    background-color: transparent;
    cursor: pointer;
    color: var(--color-dark);
    position: absolute;
    left: 1rem;
  }

  .right-section .nav button span {
    font-size: 2rem;
  }
}
/* ----------------------- */
.recent-orders {
  margin: 20px;
  padding: 20px;
  border: 1px solid #ffff;
  border-radius: 3rem;
  background-color: #ffff;
}

.recent-orders h2 {
  font-size: 24px;
  margin-bottom: 15px;
}

.recent-orders table {
  width: 100%;
  border-collapse: collapse;
  margin-bottom: 15px;
}

.recent-orders th,
.recent-orders td {
  padding: 8px;
  border: 1px solid #ffff;
  text-align: left;
}

.recent-orders th {
  background-color: #ffff;
}

.recent-orders tbody tr:nth-child(even) {
  background-color: #ffff;
}

.recent-orders a {
  text-decoration: none;
  color: #007bff;
  display: block;
  text-align: right;
  font-weight: bold;
}

.recent-orders a:hover {
  text-decoration: underline;
}
.bold-header th {
  font-weight: bold;
}
.delete-button {
  font-weight: bold;
  background: transparent;
  /* background-color: red; */
  margin: 10px;
  color: red;
  /* border-radius: 1rem; */
}
.edit-button {
  font-weight: bold;
  background: transparent;
  /* background-color: red; */
  color: green;
  /* border-radius: 1rem; */
}
</style>
