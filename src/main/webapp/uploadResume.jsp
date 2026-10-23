<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>

<title>Upload Resume</title>

<style>

body{
    font-family:Arial;
    background:#eef2f7;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.box{
    background:white;
    padding:35px;
    border-radius:15px;
    width:350px;
    text-align:center;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

h2{
    color:#1565c0;
    margin-bottom:20px;
}

input[type=file]{
    margin-top:15px;
    width:100%;
}

button{
    margin-top:20px;
    width:100%;
    padding:10px;
    border:none;
    border-radius:8px;
    background:#1565c0;
    color:white;
    font-size:15px;
    cursor:pointer;
}

button:hover{
    background:#0d47a1;
}

.msg{
    margin-top:15px;
    font-size:14px;
    font-weight:bold;
}

.error{
    color:red;
}

.success{
    color:green;
}

.back{
    display:inline-block;
    margin-top:20px;
    text-decoration:none;
    color:#1565c0;
    font-weight:bold;
}

.note{
    font-size:12px;
    color:#666;
    margin-top:10px;
}

</style>

</head>

<body>

<div class="box">

<h2>Upload Resume</h2>

<form action="UploadResumeServlet"
      method="post"
      enctype="multipart/form-data">

    <input type="file"
           name="resume"
           required>

    <div class="note">
        Allowed: PDF <br>
        Max Size: 2MB
    </div>

    <button type="submit">
        Upload Resume
    </button>

</form>

<%

String msg = request.getParameter("msg");

if("invalidtype".equals(msg)){
%>

<div class="msg error">
 Only PDF file allowed
</div>

<%
}
else if("toolarge".equals(msg)){
%>

<div class="msg error">
File size must be less than 2MB
</div>

<%
}
else if("nofile".equals(msg)){
%>

<div class="msg error">
Please select a file
</div>

<%
}
else if("error".equals(msg)){
%>

<div class="msg error">
Upload Failed
</div>

<%
}
%>

<a class="back"
   href="studentDashboard.jsp">

⬅ Back to Dashboard

</a>

</div>

</body>
</html>