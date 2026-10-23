<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { margin: 0; font-family: 'Poppins', sans-serif; background: #f4f7fb; display: flex; justify-content: center; align-items: center; height: 100vh; }
        .login-box { background: white; padding: 35px; width: 340px; border-radius: 10px; box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
        h2 { text-align: center; margin-bottom: 25px; color: #333; }
        input { width: 100%; padding: 10px; margin: 10px 0; border-radius: 5px; border: 1px solid #ccc; font-size: 14px; box-sizing: border-box; }
        button { width: 100%; padding: 10px; background: #1a73e8; color: white; border: none; border-radius: 5px; font-size: 15px; cursor: pointer; margin-top: 10px; }
        button:hover { background: #0d5bd3; }
        .error { text-align: center; color: red; font-size: 14px; }
        .success { text-align: center; color: green; font-size: 14px; }
        .register-link { text-align: center; margin-top: 20px; font-size: 13px; color: #666; }
        .register-link a { color: #1a73e8; text-decoration: none; font-weight: 600; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Student Login</h2>

        <%
        String error = request.getParameter("error");
        if("invalid".equals(error)){
        %>
            <p class="error">Invalid Email or Password</p>
        <%
        }
        String msg = request.getParameter("msg");
        if("registered".equals(msg)){
        %>
            <p class="success">Registration Successful! Please Login.</p>
        <%
        }
        %>

        <form action="<%=request.getContextPath()%>/StudentLoginServlet" method="post">
            <input type="text" name="email" placeholder="Enter Email" required>
            <input type="password" name="password" placeholder="Enter Password" required>
            <button type="submit">Login</button>
        </form>

        <div class="register-link">
            New Student? <a href="register.jsp">Register Here</a>
        </div>
    </div>
</body>
</html>