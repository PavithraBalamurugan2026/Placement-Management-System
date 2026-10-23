<%@ page import="java.sql.*" %>
<%@ page import="com.placement.db.DBConnection" %>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String name = (String) session.getAttribute("studentName");
String email = (String) session.getAttribute("studentEmail");

if(email == null){
    response.sendRedirect("studentLogin.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Student Dashboard</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body {
    margin: 0;
    font-family: 'Poppins', sans-serif;
    background: #f4f7fb;
}

/* 🔷 Navbar */
.navbar {
    background: #1a73e8;
    color: white;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.navbar h2 {
    margin: 0;
}

.navbar a {
    color: white;
    text-decoration: none;
    margin-left: 20px;
    font-weight: 500;
}

.navbar a:hover {
    text-decoration: underline;
}

/* 🔷 Main Container */
.container {
    display: flex;
    justify-content: center;
    margin-top: 60px;
}

/* 🔷 Dashboard Card */
.dashboard-box {
    background: white;
    width: 420px;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    text-align: center;
}

/* 🔷 Welcome */
.welcome {
    margin-bottom: 25px;
    color: #333;
}

/* 🔷 Buttons */
.btn {
    display: block;
    width: 100%;
    padding: 12px;
    margin: 10px 0;
    background: #1a73e8;
    color: white;
    text-decoration: none;
    border-radius: 6px;
    transition: 0.2s;
}

.btn:hover {
    background: #0d5bd3;
}
</style>

</head>

<body>

<!-- 🔷 Navbar -->
<div class="navbar">
    <h2>Placement Portal</h2>
    <div>
        <a href="ViewProfileServlet">Profile</a>
        <a href="ViewAvailableCompaniesServlet">Companies</a>
        <a href="MyApplicationsServlet">Applications</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<!-- 🔷 Dashboard -->
<div class="container">
    <div class="dashboard-box">

        <h2 class="welcome">Welcome, <%= name %></h2>
        

        <a class="btn" href="ViewProfileServlet">👤 My Profile</a>

        <a class="btn" href="ViewAvailableCompaniesServlet">
            🏢 View Available Companies
        </a>

        <a class="btn" href="MyApplicationsServlet">
            📄 My Applications
        </a>

        

        <a class="btn" href="LogoutServlet">
            🚪 Logout
        </a>

    </div>
</div>

</body>
</html>