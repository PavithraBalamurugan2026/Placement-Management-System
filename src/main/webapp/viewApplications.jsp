<%@ page import="java.sql.*" %>
<%@ page import="com.placement.db.DBConnection" %>

<%
String email = (String) session.getAttribute("studentEmail");
if(email == null){
    response.sendRedirect("studentLogin.jsp");
}
%>

<html>
<head>
<title>My Applications</title>
<style>
body { font-family: Cambria; text-align:center; padding:40px; }
table { width:90%; margin:auto; border-collapse:collapse; }
th { background:#1565c0; color:white; padding:10px; }
td { padding:10px; border-bottom:1px solid #ddd; }
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
Connection con = DBConnection.getConnection();
PreparedStatement ps = con.prepareStatement(
"SELECT * FROM applications WHERE student_email=? ORDER BY applied_date DESC"
);
ps.setString(1, email);

ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
<td><%= rs.getString("company_name") %></td>
<td><%= rs.getString("role") %></td>
<td><%= rs.getString("package") %></td>
<td><%= rs.getString("status") %></td>
<td><%= rs.getString("applied_date") %></td>
</tr>

<%
}
con.close();
%>

</table>

<br>
<a href="studentDashboard.jsp">Back</a>

</body>
</html>