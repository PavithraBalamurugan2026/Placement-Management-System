<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
<title>Create Account</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:#f4f7fb;
    display:flex;
    justify-content:center;
    align-items:center;
    min-height:100vh;
}

.container{
    width:650px;
    background:#fff;
    padding:40px;
    border-radius:20px;
    box-shadow:0 8px 20px rgba(0,0,0,0.08);
}

h1{
    text-align:center;
    margin-bottom:35px;
    color:#222;
}

.form-group{
    margin-bottom:22px;
}

label{
    display:block;
    margin-bottom:8px;
    font-weight:600;
    color:#444;
}

input,select{
    width:100%;
    padding:14px;
    border:1px solid #ccc;
    border-radius:10px;
    font-size:16px;
    outline:none;
}

input:focus,
select:focus{
    border-color:#2d74da;
}

button{
    width:100%;
    padding:15px;
    background:#2d74da;
    color:white;
    border:none;
    border-radius:10px;
    font-size:20px;
    font-weight:600;
    cursor:pointer;
    margin-top:10px;
}

button:hover{
    background:#1f5fb8;
}

.bottom-text{
    text-align:center;
    margin-top:25px;
    font-size:18px;
}

.bottom-text a{
    color:#2d74da;
    text-decoration:none;
    font-weight:600;
}

.error{
    color:red;
    text-align:center;
    margin-bottom:20px;
}

</style>
</head>

<body>

<div class="container">

<h1>Create Account</h1>

<%
String error = request.getParameter("error");

if("exists".equals(error)){
%>

<p class="error">
Email already exists!
</p>

<%
}
%>

<form action="RegisterServlet" method="post">

<div class="form-group">
<label>Full Name (Include Initials)</label>

<input type="text"
       name="name"
       required>
</div>

<div class="form-group">
<label>College Email</label>

<input type="email"
       name="email"
       required>
</div>

<div class="form-group">
<label>Create Password</label>

<input type="password"
       name="password"
       required>
</div>

<div class="form-group">
<label>Roll Number</label>

<input type="text"
       name="rollno"
       required>
</div>

<div class="form-group">
<label>Department</label>

<select name="department" required>

<option value="">Select Department</option>

<option value="IT">IT</option>
<option value="CSE">CSE</option>
<option value="MCA">MCA</option>
<option value="ECE">ECE</option>
<option value="EEE">EEE</option>
<option value="MECH">MECH</option>
<option value="CIVIL">CIVIL</option>
<option value="BioTech">BioTech</option>
<option value="Biomedical">Biomedical</option>
<option value="AI&DS">AI DS</option>
</select>

</div>

<div class="form-group">
<label>Year of Graduation</label>

<input type="number"
       name="year"
       required>
</div>

<button type="submit">

Sign Up

</button>

</form>

<div class="bottom-text">

Already have an account?

<a href="studentLogin.jsp">

Login

</a>

</div>

</div>

</body>
</html>