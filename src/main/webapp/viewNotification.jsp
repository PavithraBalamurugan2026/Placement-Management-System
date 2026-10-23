<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>

<%
@SuppressWarnings("unchecked")
    List<String[]> notifications =
        (List<String[]>) request.getAttribute("notifications");
%>

<!DOCTYPE html>
<html>
<head>
<title>Placement Drives</title>

<style>
body {
    font-family: Arial, sans-serif;
    background-color: #f4f7fb;
    margin: 0;
    padding: 30px;
}

h2 {
    text-align: center;
    color: #2c3e50;
    margin-bottom: 40px;
}

.container {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 25px;
}

.card {
    background-color: #ffffff;
    width: 340px;
    border-radius: 12px;
    padding: 20px;
    box-shadow: 0px 5px 15px rgba(0,0,0,0.1);
    transition: 0.3s ease;
}

.card:hover {
    transform: translateY(-5px);
}

.company-name {
    font-size: 20px;
    font-weight: bold;
    color: #1a73e8;
}

.message {
    font-size: 14px;
    color: #555;
    margin-bottom: 10px;
}

.role {
    font-size: 15px;
    margin: 6px 0;
}

.package {
    background-color: #e8f5e9;
    color: #2e7d32;
    padding: 6px 12px;
    border-radius: 20px;
    font-size: 14px;
    display: inline-block;
    margin-top: 8px;
}

.details {
    margin-top: 12px;
    font-size: 14px;
    color: #444;
    line-height: 1.6;
}

.detail-box {
    background-color: #f1f3f6;
    padding: 8px;
    border-radius: 6px;
    margin-bottom: 6px;
}

.apply-btn {
    margin-top: 15px;
    width: 100%;
    padding: 10px;
    border: none;
    border-radius: 6px;
    background-color: #1a73e8;
    color: white;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
}

.apply-btn:hover {
    background-color: #1558b0;
}

.success {
    text-align: center;
    background-color: #d4edda;
    color: #155724;
    padding: 10px;
    border-radius: 5px;
    margin-bottom: 20px;
}
</style>
</head>

<body>

<h2>Available Placement Drives</h2>

<% if(request.getParameter("success") != null) { %>
<div class="success">
    Application Submitted Successfully
</div>
<% } %>

<div class="container">

<%
if(notifications != null) {
    for(String[] n : notifications) {
%>

<div class="card">

    <!-- Correct Order Mapping -->
    <div class="company-name"><%= n[2] %></div>
    <div class="message"><%= n[1] %></div>

    <div class="role">
        Role: <b><%= n[6] %></b>
    </div>

    <div class="package">
        Package: <%= n[7] %>
    </div>

    <div class="details">
        <div class="detail-box">
            Minimum CGPA: <%= n[3] %>
        </div>
        <div class="detail-box">
            Maximum Arrears: <%= n[4] %>
        </div>
        <div class="detail-box">
            Drive Date: <%= n[5] %>
        </div>
    </div>

    <form action="applyCompany" method="post">
        <input type="hidden" name="companyId" value="<%= n[0] %>">
        <input type="hidden" name="studentId"
               value="<%= session.getAttribute("studentId") %>">
        <button type="submit" class="apply-btn">
            Apply Now
        </button>
    </form>

</div>

<%
    }
}
%>

</div>

</body>
</html>