<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
@SuppressWarnings("unchecked")
List<String[]> notifications =
(List<String[]>) request.getAttribute("notifications");

int newCount = 0;

if(notifications != null){
    for(String[] n : notifications){
        if("NEW".equals(n[8])){
            newCount++;
        }
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Available Companies</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>

body{
    font-family:'Poppins',sans-serif;
    background:#f5f7fa;
    margin:0;
    padding:20px;
}

/* Heading */

h2{
    text-align:center;
    color:#1a73e8;
    margin-bottom:15px;
}

/* Notification Box */

.notification-box{
    width:250px;
    margin:0 auto 25px auto;
    background:white;
    border-radius:15px;
    padding:20px;
    text-align:center;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

.notification-count{
    font-size:40px;
    color:red;
    font-weight:bold;
    margin-top:10px;
}

/* Message */

.message-container{
    text-align:center;
    margin-bottom:20px;
}

.msg-box{
    display:inline-block;
    padding:12px 25px;
    border-radius:8px;
    font-weight:600;
}

.success{
    background:#e8f5e9;
    color:#2e7d32;
    border:1px solid #c8e6c9;
}

.error{
    background:#ffebee;
    color:#c62828;
    border:1px solid #ffcdd2;
}

/* Company Card */

.company-card{
    background:white;
    margin:25px auto;
    padding:25px;
    border-radius:15px;
    width:85%;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

/* Header */

.company-header{
    border-bottom:2px solid #f1f1f1;
    padding-bottom:10px;
    margin-bottom:20px;
}

.company-name{
    font-size:28px;
    font-weight:600;
    color:#1a73e8;
}

/* Roles */

.roles{
    display:flex;
    flex-wrap:wrap;
    gap:20px;
}

/* Role Card */

.role-box{
    background:#f1f3f4;
    padding:18px;
    border-radius:12px;
    width:260px;
    flex-grow:1;
    position:relative;
    transition:0.3s;
}

.role-box:hover{
    transform:translateY(-5px);
}

.role-title{
    font-size:18px;
    font-weight:600;
    margin-bottom:10px;
    color:#333;
}

.role-box p{
    margin:8px 0;
    font-size:14px;
    color:#444;
}

/* Badge */

.badge{
    position:absolute;
    top:10px;
    right:10px;
    background:red;
    color:white;
    font-size:10px;
    padding:4px 8px;
    border-radius:5px;
    font-weight:bold;
}

/* Button */

button{
    width:100%;
    padding:10px;
    margin-top:12px;
    border:none;
    border-radius:8px;
    background:#1a73e8;
    color:white;
    font-size:15px;
    cursor:pointer;
    transition:0.3s;
}

button:hover{
    background:#0d5cc0;
}

button:disabled{
    background:gray;
    cursor:not-allowed;
}

/* Back Button */

.back-container{
    text-align:center;
    margin-top:40px;
}

.back-btn{
    display:inline-block;
    background:#1a73e8;
    color:white;
    padding:12px 30px;
    border-radius:10px;
    text-decoration:none;
    font-weight:600;
}

.back-btn:hover{
    background:#0d5cc0;
}

/* Mobile */

@media(max-width:768px){

    .company-card{
        width:95%;
    }

    .roles{
        flex-direction:column;
    }
}

</style>
</head>

<body>

<h2>Available Companies</h2>

<!-- Notification Count -->

<div class="notification-box">

    <h3>🔔 Notifications</h3>

    <div class="notification-count">
        <%= newCount %>
    </div>

    <p>New Companies Available</p>

</div>

<!-- MESSAGE -->

<div class="message-container">

<%
String msg = request.getParameter("msg");
String success = request.getParameter("success");

if("1".equals(success)){
%>

<div class="msg-box success">
✅ Applied Successfully
</div>

<%
}
else if("noteligible".equals(msg)){
%>

<div class="msg-box error">
❌ You are not eligible
</div>

<%
}
else if("already".equals(msg)){
%>

<div class="msg-box error">
⚠ Already Applied
</div>

<%
}
%>

</div>

<!-- COMPANY SECTION -->

<%

if(notifications != null && !notifications.isEmpty()){

    String lastCompany = "";

    for(int i=0; i<notifications.size(); i++){

        String[] n = notifications.get(i);

        String company = n[2];

        if(!company.equals(lastCompany)){

            if(i != 0){
%>

            </div>
        </div>

<%
            }
%>

<div class="company-card">

    <div class="company-header">

        <div class="company-name">
            <%= company %>
        </div>

    </div>

    <div class="roles">

<%
            lastCompany = company;
        }
%>

<!-- ROLE CARD -->

<div class="role-box">

    <% if("NEW".equals(n[8])) { %>
        <div class="badge">NEW</div>
    <% } %>

    <div class="role-title">
        <%= n[6] %>
    </div>

    <p><b>Package:</b> <%= n[7] %></p>

    <p>
        <b>Skills:</b>

        <%= (n[10] == null ||
             n[10].trim().equals("") ||
             n[10].equals("null"))

             ? "N/A"
             : n[10]
        %>
    </p>

    <p><b>CGPA:</b> <%= n[3] %></p>

    <p><b>Arrear:</b> <%= n[4] %></p>

    <p><b>Drive Date:</b> <%= n[5] %></p>

    <p><b>Department:</b> <%= n[9] %></p>

    <form action="ApplyCompanyServlet" method="post">

        <input type="hidden"
               name="companyName"
               value="<%= company %>">

        <input type="hidden"
               name="role"
               value="<%= n[6] %>">

        <input type="hidden"
               name="package"
               value="<%= n[7] %>">

        <% if("APPLIED".equals(n[8])) { %>

            <button type="button" disabled>
                Applied
            </button>

        <% } else { %>

            <button type="submit">
                Apply
            </button>

        <% } %>

    </form>

</div>

<%
    }
%>

    </div>
</div>

<%
}
else{
%>

<p style="text-align:center; font-size:18px;">
No companies available
</p>

<%
}
%>

<!-- BACK BUTTON -->

<div class="back-container">

<a class="back-btn"
   href="studentDashboard.jsp">

   Back to Dashboard

</a>

</div>

</body>
</html>