<!DOCTYPE html>
<html>
<head>
<title>Placement Management System</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body {
    margin: 0;
    height: 100vh;
    font-family: 'Poppins', sans-serif;
    background: #f4f7fb;
    display: flex;
    justify-content: center;
    align-items: center;
}

.container {
    text-align: center;
    background: white;
    padding: 50px 60px;
    border-radius: 10px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
}

h1 {
    margin-bottom: 10px;
    color: #333;
}

.subtitle {
    margin-bottom: 30px;
    color: #666;
    font-size: 14px;
}

.btn {
    display: inline-block;
    margin: 10px;
    padding: 12px 25px;
    background: #1a73e8;
    color: white;
    text-decoration: none;
    font-size: 14px;
    border-radius: 5px;
}

.btn:hover {
    background: #0d5bd3;
}
</style>
</head>

<body>

<div class="container">

    <h1>Placement Management System</h1>
    <p class="subtitle">Manage placements and check eligibility</p>

    <a href="studentLogin.jsp" class="btn">Student Login</a>
    <a href="adminLogin.jsp" class="btn">Admin Login</a>

</div>

</body>
</html>