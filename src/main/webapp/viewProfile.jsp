<%@ page contentType="text/html;charset=UTF-8" %>

<%
String name = (String) request.getAttribute("name");
String rollno = (String) request.getAttribute("rollno");
String email = (String) request.getAttribute("email");
String department = (String) request.getAttribute("department");
Object cgpa = request.getAttribute("cgpa");
Object arrear = request.getAttribute("arrear");
Object year = request.getAttribute("year");
String resume = (String) request.getAttribute("resume");

String success = request.getParameter("success");
String resumeMsg = request.getParameter("resume");
%>

<!DOCTYPE html>
<html>
<head>
<title>Student Profile</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body {
    margin: 0;
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #f5f7fa, #c3cfe2);
}

/* 🔷 Navbar */
.navbar {
    background: #1a73e8;
    padding: 15px 30px;
    color: white;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.navbar a {
    color: white;
    margin-left: 20px;
    text-decoration: none;
    font-weight: bold;
}

.navbar a:hover {
    text-decoration: underline;
}

/* 🔷 Profile Card */
.container {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 40px;
}

.profile-card {
    background: white;
    width: 750px;
    border-radius: 20px;
    box-shadow: 0 15px 35px rgba(0,0,0,0.2);
    display: flex;
    overflow: hidden;
}

/* Left */
.left {
    background: #667eea;
    width: 250px;
    color: white;
    text-align: center;
    padding: 30px;
}

.icon {
    width: 120px;
    height: 120px;
    background: white;
    border-radius: 50%;
    margin: auto;
    font-size: 60px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #667eea;
}

/* Right */
.right {
    flex: 1;
    padding: 30px;
}

.info {
    display: flex;
    justify-content: space-between;
    margin: 15px 0;
    border-bottom: 1px solid #eee;
    padding-bottom: 8px;
}

.label {
    font-weight: 600;
}

.value {
    color: #333;
}

/* Buttons */
.btn {
    display: inline-block;
    margin-top: 20px;
    padding: 10px 18px;
    border-radius: 25px;
    background: #1a73e8;
    color: white;
    text-decoration: none;
}

.btn:hover {
    background: #0d5bd3;
}

.message {
    text-align: center;
    font-weight: bold;
}

/* 🔷 Centered Back Button Styles */
.back-container {
    text-align: center;
    margin-top: 40px;
    margin-bottom: 40px;
    width: 100%;
}

.back-btn {
    display: inline-block;
    background-color: #1a73e8; /* Blue matching your established theme */
    color: white !important;
    padding: 12px 30px;
    border-radius: 12px; /* Rounded corners per established design */
    text-decoration: none !important;
    font-weight: 500;
    transition: background 0.3s ease;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
}

.back-btn:hover {
    background-color: #1557b0;
    text-decoration: none;
}
</style>

</head>

<body>

<div class="navbar">
    <h2>Placement Portal</h2>
    <div>
        <a href="studentDashboard.jsp">Home</a>
        <a href="ViewAvailableCompaniesServlet">Companies</a>
        <a href="MyApplicationsServlet">My Applications</a>
        <a href="LogoutServlet">Logout</a>
    </div>
</div>

<%
if("updated".equals(success)){
%>
<p class="message" style="color:green;">✅ Profile Updated Successfully</p>
<%
}
if("uploaded".equals(resumeMsg)){
%>
<p class="message" style="color:green;">✅ Resume Uploaded Successfully</p>
<%
}
%>

<div class="container">

<div class="profile-card">

    <div class="left">
        <div class="icon">👤</div>
        <h3><%= name %></h3>
    </div>

    <div class="right">

        <h2>Student Details</h2>
        <div class="info">
            <span class="label">Name</span>
            <span class="value"><%= name %></span>
        </div>
        

        <div class="info">
            <span class="label">Email</span>
            <span class="value"><%= email %></span>
        </div>
        
        <div class="info">
            <span class="label">Roll No</span>
            <span class="value"><%= rollno %></span>
        </div>

        <div class="info">
            <span class="label">Department</span>
            <span class="value"><%= department %></span>
        </div>

        <div class="info">
            <span class="label">CGPA</span>
            <span class="value"><%= cgpa %></span>
        </div>

        <div class="info">
            <span class="label">Year</span>
            <span class="value"><%= year %></span>
        </div>

        <div class="info">
            <span class="label">Arrear</span>
            <span class="value"><%= arrear %></span>
        </div>

        <div class="info">
            <span class="label">Resume</span>
            <span class="value">
                <%
                if(resume != null){
                %>
                    <a href="resumes/<%= resume %>" target="_blank">View Resume</a>
                <%
                } else {
                %>
                    Not Uploaded
                <%
                }
                %>
            </span>
        </div>

        <a href="EditProfileServlet" class="btn">✏ Edit Profile</a>
        <a href="uploadResume.jsp" class="btn">📄 Upload Resume</a>

    </div>

</div>

</div>

<div class="back-container">
    <a class="back-btn" href="studentDashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>