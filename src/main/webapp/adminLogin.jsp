<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>

<style>
    body {
        font-family: Arial, sans-serif;
        
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        margin: 0;
    }

    .login-box {
        background-color: white;
        padding: 30px;
        border-radius: 8px;
        width: 320px;
        text-align: center;
        box-shadow: 0px 5px 15px rgba(0,0,0,0.2);
    }

    .login-box h2 {
        margin-bottom: 20px;
        color: #4e73df;
    }

    .input-group {
        margin-bottom: 15px;
        text-align: left;
    }

    .input-group label {
        font-size: 14px;
    }

    .input-group input {
        width: 100%;
        padding: 8px;
        margin-top: 5px;
        border-radius: 4px;
        border: 1px solid #ccc;
    }

    button {
        width: 100%;
        padding: 8px;
        background-color: #4e73df;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }

    button:hover {
        background-color: #2e59d9;
    }

    .error {
        color: red;
        margin-top: 10px;
        font-size: 14px;
    }
</style>
</head>

<body>

<div class="login-box">
    <h2>Placement Admin Login</h2>

    <form action="AdminLoginServlet" method="post">

        <div class="input-group">
            <label>Username</label>
            <input type="text" name="username" required>
        </div>

        <div class="input-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <button type="submit">Login</button>

        <!-- Error Message -->
        <div class="error">
            <%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>
        </div>

    </form>
</div>

</body>
</html>