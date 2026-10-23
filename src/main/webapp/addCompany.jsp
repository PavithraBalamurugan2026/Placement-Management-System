<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Add Company</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background: linear-gradient(to right, #4e73df, #1cc88a);
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        padding: 20px;
    }

    .container {
        background: #ffffff;
        padding: 30px;
        border-radius: 15px;
        width: 450px;
        box-shadow: 0px 10px 25px rgba(0,0,0,0.3);
    }

    h2 {
        text-align: center;
        margin-bottom: 20px;
        color: #333;
    }

    input {
        width: 100%;
        padding: 10px;
        margin: 8px 0;
        border-radius: 8px;
        border: 1px solid #ddd;
        box-sizing: border-box; /* Ensures padding doesn't affect width */
    }

    button {
        width: 100%;
        padding: 12px;
        background: #4e73df;
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        font-weight: 600;
        cursor: pointer;
        margin-top: 10px;
        transition: background 0.3s;
    }

    button:hover {
        background: #2e59d9;
    }

    /* --- Back to Dashboard Button Styles --- */
    .back-container {
        text-align: center;
        margin-top: 20px;
    }

    .back-btn {
        display: inline-block;
        background-color: #5a5c69; /* Professional gray-blue for admin navigation */
        color: white !important;
        padding: 10px 25px;
        border-radius: 8px;
        text-decoration: none !important;
        font-size: 14px;
        font-weight: 500;
        transition: background 0.3s ease;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    }

    .back-btn:hover {
        background-color: #3a3b45;
        text-decoration: none;
    }
</style>
</head>

<body>

<div class="container">

<h2>Add Company Drive</h2>

<%
String success = request.getParameter("success");
if(success != null){
%>
    <p style="color:green; text-align:center; font-weight:bold;">
        ✅ Company Added Successfully!
    </p>
<%
}
%>

<form action="AddCompanyServlet" method="post">
    <input type="text" name="company_name" placeholder="Company Name" required>
    <input type="text" name="role" placeholder="Job Role" required>
    <input type="text" name="package" placeholder="Package (e.g. 4 LPA)" required>
    
    <label style="font-size: 12px; color: #666; margin-left: 5px;">Minimum CGPA Required</label>
    <input type="number" step="0.1" name="min_cgpa" placeholder="65.0" required>

    <label style="font-size: 12px; color: #666; margin-left: 5px;">Max Arrears Allowed</label>
    <input type="number" name="max_arrear" placeholder="0" required>

    <input type="text" name="skills" placeholder="Java, SQL, React" required>
    
    <label style="font-size: 12px; color: #666; margin-left: 5px;">Drive Date</label>
    <input type="date" name="drive_date" required>
   
    <input type="text" name="department" placeholder="MCA, CSE, IT or ALL" required>

    <button type="submit">Add Drive</button>
</form>

<div class="back-container">
    <a href="adminDashboard.jsp" class="back-btn">Back to Dashboard</a>
</div>

</div>

</body>
</html>