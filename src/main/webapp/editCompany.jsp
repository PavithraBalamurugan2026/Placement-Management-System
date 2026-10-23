<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Edit Company</title>

<style>
body {
    font-family: Cambria;
    background: #eef2f7;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.box {
    background: white;
    padding: 25px;
    border-radius: 10px;
    width: 400px;
}

input {
    width: 100%;
    padding: 8px;
    margin: 8px 0;
}

button {
    width: 100%;
    padding: 10px;
    background: orange;
    color: white;
    border: none;
}
</style>
</head>

<body>

<div class="box">

<h2>Edit Company</h2>

<form action="UpdateCompanyServlet" method="post">

    <input type="hidden" name="id" value="<%= request.getAttribute("id") %>">

<input type="text" name="company_name" value="<%= request.getAttribute("company_name") %>">

<input type="text" name="role" value="<%= request.getAttribute("role") %>">

<input type="text" name="package" value="<%= request.getAttribute("package") %>">

<input type="text" name="department" value="<%= request.getAttribute("department") %>">

<input type="text" name="skills" value="<%= request.getAttribute("skills") %>">

<input type="number" step="0.1" name="min_cgpa" value="<%= request.getAttribute("min_cgpa") %>">

<input type="number" name="max_arrear" value="<%= request.getAttribute("max_arrear") %>">

<input type="date" name="drive_date" value="<%= request.getAttribute("drive_date") %>">
<button type="submit">Update</button>
</form>

</div>

</body>
</html>