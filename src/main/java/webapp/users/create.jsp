<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
  <style>
      * {
          margin: 0;
          padding: 0;
          box-sizing: border-box;
          font-family: Arial, sans-serif;
      }

      body {
          background-color: #f4f4f4;
          display: flex;
          justify-content: center;
          align-items: center;
          height: 100vh;
      }

      .form-container {
          background-color: #fff;
          padding: 20px;
          box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
          border-radius: 8px;
          width: 100%;
          max-width: 400px;
      }

      h2 {
          text-align: center;
          margin-bottom: 20px;
          color: #333;
      }

      .form-group {
          margin-bottom: 15px;
      }

      .form-group label {
          display: block;
          margin-bottom: 5px;
          color: #555;
      }

      .form-group input,
      .form-group select {
          width: 100%;
          padding: 10px;
          border: 1px solid #ccc;
          border-radius: 4px;
      }

      .submit-btn {
          background-color: #007bff;
          color: #fff;
          padding: 10px 15px;
          border: none;
          border-radius: 4px;
          width: 100%;
          cursor: pointer;
          transition: background-color 0.3s ease;
      }

      .submit-btn:hover {
          background-color: #0056b3;
      }

  </style>
</head>
<body>


<div class="form-container">
    <h2>Register User</h2>
    <form action="/dev/users" method="POST">
        <div class="form-group">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>
        </div>

        <div class="form-group">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
        </div>

        <div class="form-group">
            <label for="prenom">Prenom:</label>
            <input type="text" id="prenom" name="prenom" required>
        </div>


        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>

        <div class="form-group">
            <label for="userType">User Type:</label>
            <select id="userType" name="userType" required>
                <option value="MANAGER">MANAGER</option>
                <option value="USER">User</option>
            </select>
        </div>

        <button type="submit" class="submit-btn">Create</button>
    </form>
</div>
</body>
</html>
