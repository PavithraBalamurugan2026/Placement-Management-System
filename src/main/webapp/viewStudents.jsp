<%@ page import="java.sql.*" %>
<%@ page import="com.placement.db.DBConnection" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Student Applications Analytics</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>

body{
    font-family:'Poppins',sans-serif;
    background:#f4f7fb;
    margin:0;
    padding:20px;
}

h2{
    text-align:center;
    color:#1565c0;
    margin-bottom:25px;
}

.filter-bar{
    background:white;
    padding:20px;
    border-radius:15px;
    display:flex;
    flex-wrap:wrap;
    gap:20px;
    justify-content:center;
    align-items:end;
    margin-bottom:25px;
    box-shadow:0 4px 12px rgba(0,0,0,0.08);
}

.filter-group{
    display:flex;
    flex-direction:column;
}

.filter-group label{
    margin-bottom:5px;
    font-size:13px;
    font-weight:600;
    color:#555;
}

.filter-group input,
.filter-group select{
    padding:10px;
    border:1px solid #ccc;
    border-radius:8px;
    min-width:180px;
    outline:none;
    font-size:14px;
}

.reset-btn{
    padding:10px 18px;
    background:#ef5350;
    color:white;
    border:none;
    border-radius:8px;
    cursor:pointer;
    font-weight:600;
}

.reset-btn:hover{
    background:#d32f2f;
}

.table-container{
    background:white;
    border-radius:15px;
    overflow:hidden;
    box-shadow:0 6px 18px rgba(0,0,0,0.08);
    max-width:1400px;
    margin:auto;
}

table{
    width:100%;
    border-collapse:collapse;
}

th{
    background:#1565c0;
    color:white;
    padding:15px;
    font-size:14px;
}

td{
    padding:14px;
    text-align:center;
    border-bottom:1px solid #eee;
    font-size:14px;
}

tr:hover{
    background:#f9fbff;
}

.status{
    padding:6px 12px;
    border-radius:20px;
    color:white;
    font-size:12px;
    font-weight:600;
}

.pending{
    background:#ff9800;
}

.shortlisted{
    background:#5e35b1;
}

.selected{
    background:#43a047;
}

.rejected{
    background:#e53935;
}

.update-btn{
    padding:8px 14px;
    background:#1565c0;
    color:white;
    border:none;
    border-radius:6px;
    cursor:pointer;
    font-size:13px;
}

.update-btn:hover{
    background:#0d47a1;
}

.resume-btn{
    background:#43a047;
    color:white;
    padding:8px 14px;
    border-radius:6px;
    text-decoration:none;
    font-size:13px;
    font-weight:600;
}

.resume-btn:hover{
    background:#2e7d32;
}

.back-container{
    text-align:center;
    margin-top:35px;
}

.back-btn{
    display:inline-block;
    background:#1565c0;
    color:white;
    text-decoration:none;
    padding:12px 35px;
    border-radius:10px;
    font-weight:600;
}

.back-btn:hover{
    background:#0d47a1;
}

</style>
</head>

<body>

<h2>Student Applications Analytics</h2>

<div class="filter-bar">

    <div class="filter-group">
        <label>Search Student</label>

        <input type="text"
               id="nameSearch"
               placeholder="Enter student name"
               onkeyup="filterTable()">
    </div>

    <div class="filter-group">
        <label>Department</label>

        <select id="deptFilter" onchange="filterTable()">

            <option value="">All Departments</option>
            <option value="MCA">MCA</option>
            <option value="CSE">CSE</option>
            <option value="IT">IT</option>
            <option value="ECE">ECE</option>
            <option value="EEE">EEE</option>
            <option value="MECH">MECH</option>
            <option value="CIVIL">CIVIL</option>
            <option value="BioTech">BioTech</option>
            <option value="Biomedical">Biomedical</option>
            <option value="AI & DS">AI & DS</option>

        </select>
    </div>

    <div class="filter-group">
        <label>Company</label>

        <select id="companyFilter" onchange="filterTable()">

            <option value="">All Companies</option>

            <%
            try{

                Connection con = DBConnection.getConnection();

                ResultSet rsComp =
                con.prepareStatement(
                "SELECT DISTINCT company_name FROM applications")
                .executeQuery();

                while(rsComp.next()){
            %>

            <option value="<%= rsComp.getString("company_name") %>">
                <%= rsComp.getString("company_name") %>
            </option>

            <%
                }
            %>

        </select>

    </div>

    <button class="reset-btn"
            onclick="resetFilters()">

        Reset

    </button>

</div>

<div class="table-container">

<table id="studentTable">

<thead>

<tr>

<th>Student Name</th>
<th>Department</th>
<th>Company</th>
<th>Role</th>
<th>Status</th>
<th>Applied Date</th>
<th>Resume</th>
<th>Update Status</th>

</tr>

</thead>

<tbody>

<%

String sql =
"SELECT a.*, s.name, s.department, s.resume " +
"FROM applications a " +
"JOIN students s ON a.student_email=s.email " +
"ORDER BY a.applied_date DESC";

ResultSet rs = con.prepareStatement(sql).executeQuery();

while(rs.next()){

String status = rs.getString("status");

String statusClass = "";

if(status.equalsIgnoreCase("Pending")){
    statusClass = "pending";
}
else if(status.equalsIgnoreCase("Shortlisted")){
    statusClass = "shortlisted";
}
else if(status.equalsIgnoreCase("Selected")){
    statusClass = "selected";
}
else{
    statusClass = "rejected";
}

%>

<tr>

<td>
<b><%= rs.getString("name") %></b>
</td>

<td>
<%= rs.getString("department") %>
</td>

<td>
<%= rs.getString("company_name") %>
</td>

<td>
<%= rs.getString("role") %>
</td>

<td>

<span class="status <%= statusClass %>">

<%= status %>

</span>

</td>

<td>
<%= rs.getString("applied_date") %>
</td>

<td>

<%

String resume =
rs.getString("resume");

if(resume != null &&
   !resume.trim().equals("")){

%>

<a href="resumes/<%= rs.getString("resume") %>" target="_blank">
    View Resume
</a>

<%

}else{

%>

<span style="color:gray;">
No Resume
</span>

<%

}

%>

</td>

<td>

<form action="UpdateApplicationStatusServlet"
      method="post">

<input type="hidden"
       name="id"
       value="<%= rs.getInt("id") %>">

<select name="status">

<option value="Pending"
<%= status.equals("Pending") ? "selected" : "" %>>
Pending
</option>

<option value="Shortlisted"
<%= status.equals("Shortlisted") ? "selected" : "" %>>
Shortlisted
</option>

<option value="Selected"
<%= status.equals("Selected") ? "selected" : "" %>>
Selected
</option>

<option value="Rejected"
<%= status.equals("Rejected") ? "selected" : "" %>>
Rejected
</option>

</select>

<br><br>

<button class="update-btn"
        type="submit">

Update

</button>

</form>

</td>

</tr>

<%
}

con.close();

}catch(Exception e){
e.printStackTrace();
}
%>

</tbody>

</table>

</div>

<div class="back-container">

<a class="back-btn"
   href="adminDashboard.jsp">

Back to Dashboard

</a>

</div>

<script>

function filterTable(){

    let nameInp =
    document.getElementById("nameSearch")
    .value.toUpperCase();

    let deptInp =
    document.getElementById("deptFilter")
    .value.toUpperCase();

    let compInp =
    document.getElementById("companyFilter")
    .value.toUpperCase();

    let table =
    document.getElementById("studentTable");

    let tr =
    table.getElementsByTagName("tr");

    for(let i=1; i<tr.length; i++){

        let tdName =
        tr[i].getElementsByTagName("td")[0]
        .textContent.toUpperCase();

        let tdDept =
        tr[i].getElementsByTagName("td")[1]
        .textContent.toUpperCase();

        let tdComp =
        tr[i].getElementsByTagName("td")[2]
        .textContent.toUpperCase();

        if(
            tdName.indexOf(nameInp) > -1 &&
            (deptInp === "" || tdDept.indexOf(deptInp) > -1) &&
            (compInp === "" || tdComp.indexOf(compInp) > -1)
        ){

            tr[i].style.display = "";

        }else{

            tr[i].style.display = "none";
        }
    }
}

function resetFilters(){

    document.getElementById("nameSearch").value = "";
    document.getElementById("deptFilter").value = "";
    document.getElementById("companyFilter").value = "";

    filterTable();
}

</script>

</body>
</html>