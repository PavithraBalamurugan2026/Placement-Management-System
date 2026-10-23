<%@ page import="java.sql.*" %>
<%@ page import="com.placement.db.DBConnection" %>
<%
int studentCount = 0;
int companyCount = 0;
int applicationCount = 0;

try{

    Connection con = DBConnection.getConnection();

    // STUDENT COUNT

    PreparedStatement ps1 =
    con.prepareStatement(
    "SELECT COUNT(*) FROM students");

    ResultSet rs1 = ps1.executeQuery();

    if(rs1.next()){
        studentCount = rs1.getInt(1);
    }

    // COMPANY COUNT

    PreparedStatement ps2 =
    con.prepareStatement(
    "SELECT COUNT(DISTINCT company_name) FROM notifications");

    ResultSet rs2 = ps2.executeQuery();

    if(rs2.next()){
        companyCount = rs2.getInt(1);
    }
    

    

    // APPLICATION COUNT

    PreparedStatement ps3 =
    con.prepareStatement(
    "SELECT COUNT(*) FROM applications");

    ResultSet rs3 = ps3.executeQuery();

    if(rs3.next()){
        applicationCount = rs3.getInt(1);
    }

    con.close();

}
catch(Exception e){
    e.printStackTrace();
}
%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Admin Dashboard</title>

<style>
body {
    font-family: Cambria;
    background: linear-gradient(to right, #4e73df, #1cc88a);
    text-align: center;
    padding-top: 100px;
}

h2 {
    color: white;
    margin-bottom: 40px;
}

.btn {
    width: 250px;
    padding: 15px;
    margin: 15px;
    font-size: 18px;
    border: none;
    border-radius: 12px;
    cursor: pointer;
    background-color: #f1f1f1;
    transition: 0.3s;
}

.btn:hover {
    background-color: #ffffff;
    transform: scale(1.05);
}

.logout {
    background-color: red;
    color: white;
}
.stats-container{
    display:flex;
    justify-content:center;
    gap:25px;
    margin-top:30px;
    flex-wrap:wrap;
}

.card{
    background:white;
    width:220px;
    padding:25px;
    border-radius:15px;
    text-align:center;
    box-shadow:0 5px 15px rgba(0,0,0,0.1);
}

.card h2{
    color:#1565c0;
    font-size:40px;
    margin:0;
}

.card p{
    font-size:18px;
    color:#555;
}
</style>
</head>

<body>

<h2>Welcome Admin</h2>
<div class="stats-container">

    <div class="card">
        <h2><%= studentCount %></h2>
        <p>Students</p>
    </div>

    <div class="card">
        <h2><%= companyCount %></h2>
        <p>Companies</p>
    </div>

    <div class="card">
        <h2><%= applicationCount %></h2>
        <p>Applications</p>
    </div>

</div>

<a href="addCompany.jsp">
    <button class="btn">Add Company</button>
</a><br>

<a href="viewStudents.jsp">
    <button class="btn">View Students</button>
</a><br>

<!-- 🔥 IMPORTANT FIX -->
<a href="ViewCompaniesServlet">
    <button class="btn">View Companies</button>
</a><br>


<a href="<%=request.getContextPath()%>/AdminLogoutServlet">
    <button class="btn logout">Logout</button>
</a>

</body>
</html>