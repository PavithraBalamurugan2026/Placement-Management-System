<%@ page contentType="text/html;charset=UTF-8" %>

<%
String name = (String) session.getAttribute("studentName");
String email = (String) session.getAttribute("studentEmail");
String role = request.getParameter("role");
String company = request.getParameter("companyName");
%>

<!DOCTYPE html>
<html>
<head>
<title>Apply Job</title>

<style>
body {
    font-family: Arial;
    background: #f5f7fb;
    text-align: center;
}

.form-box {
    background: white;
    width: 350px;
    margin: 50px auto;
    padding: 25px;
    border-radius: 10px;
}

input, textarea {
    width: 100%;
    padding: 8px;
    margin: 8px 0;
}

button {
    background: #1a73e8;
    color: white;
    padding: 10px;
    border: none;
}
</style>
</head>

<body>

<div class="form-box">
<h3>Apply for <%= company %></h3>

<form action="ApplyCompanyServlet" method="post">

Name:
<input type="text" name="name" value="<%= name %>" readonly>

Email:
<input type="text" name="email" value="<%= email %>" readonly>

Role:
<input type="text" name="role" value="<%= role %>" readonly>

Skills:
<textarea name="skills" placeholder="Enter your skills"></textarea>

<input type="hidden" name="companyName" value="<%= company %>">

<button type="submit">Submit Application</button>

</form>

</div>

</body>
</html>