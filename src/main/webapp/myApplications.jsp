<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
@SuppressWarnings("unchecked")
List<String[]> apps = (List<String[]>) request.getAttribute("applications");
%>

<!DOCTYPE html>
<html>
<head>
<title>My Applications</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: #eef2f7;
        padding: 30px;
        margin: 0;
    }

    h2 {
        text-align: center;
        margin-bottom: 30px;
    }

    table {
        width: 80%;
        margin: auto;
        border-collapse: collapse;
        background: white;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        border-radius: 8px;
        overflow: hidden;
    }

    th {
        background: #1a73e8;
        color: white;
        padding: 12px;
        font-weight: 600;
    }

    td {
        padding: 12px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    /* --- BACK TO DASHBOARD BUTTON STYLES --- */
    .back-container {
        text-align: center;
        margin-top: 40px;
        margin-bottom: 40px;
        width: 100%;
    }

    .back-btn {
        display: inline-block;
        background-color: #1a73e8; /* Blue color matching Cognizant headers and your image */
        color: white !important;
        padding: 12px 30px;
        border-radius: 12px; /* Rounded corners as per image_3d24b0.png */
        text-decoration: none !important; /* Removes the underline */
        font-weight: 500;
        transition: background 0.3s ease, transform 0.2s ease;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        border: none;
    }

    .back-btn:hover {
        background-color: #1557b0;
        transform: translateY(-2px);
        text-decoration: none;
    }
</style>
</head>

<body>

<h2>My Applications</h2>

<table>
<tr>
    <th>Company</th>
    <th>Role</th>
    <th>Package</th>
    <th>Status</th>
    <th>Applied Date</th>
</tr>

<%
if(apps != null && !apps.isEmpty()){
    for(String[] a : apps){
%>

<tr>
    <td><%= a[0] %></td>
    <td><%= a[1] %></td>
    <td><%= a[2] %></td>
    <td><%= a[3] %></td>
    <td><%= a[4] %></td>
</tr>

<%
    }
} else {
%>

<tr>
    <td colspan="5" style="color:red; padding: 20px;">
        No Applications Found
    </td>
</tr>

<%
}
%>
</table>

<div class="back-container">
    <a class="back-btn" href="studentDashboard.jsp">Back to Dashboard</a>
</div>

</body>
</html>