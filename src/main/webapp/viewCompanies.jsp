<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%

String admin = (String) session.getAttribute("admin");

if(admin == null){
    response.sendRedirect("adminLogin.jsp");
    return;
}

@SuppressWarnings("unchecked")
List<String[]> list =
(List<String[]>) request.getAttribute("companies");

String currentSearch =
request.getParameter("search") != null
? request.getParameter("search")
: "";

String currentDept =
request.getParameter("dept") != null
? request.getParameter("dept")
: "";

%>

<!DOCTYPE html>
<html>
<head>

<title>Manage Company Drives</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap"
      rel="stylesheet">

<style>

body{
    font-family:'Poppins',sans-serif;
    background:#f4f7fb;
    margin:0;
    padding:30px;
}

h2{
    text-align:center;
    color:#1565c0;
    margin-bottom:30px;
}

/* FILTER BOX */

.filter-container{
    background:white;
    padding:20px;
    border-radius:15px;
    width:95%;
    margin:auto auto 30px auto;
    box-shadow:0 4px 12px rgba(0,0,0,0.08);
}

.filter-form{
    display:flex;
    flex-wrap:wrap;
    justify-content:center;
    gap:15px;
}

.filter-form input,
.filter-form select{
    padding:12px;
    border:1px solid #ccc;
    border-radius:8px;
    min-width:220px;
    outline:none;
}

.filter-btn{
    background:#1565c0;
    color:white;
    border:none;
    padding:12px 20px;
    border-radius:8px;
    cursor:pointer;
    font-weight:600;
}

.filter-btn:hover{
    background:#0d47a1;
}

.reset-link{
    text-decoration:none;
    color:#666;
    display:flex;
    align-items:center;
    font-weight:500;
}

/* TABLE */

.table-container{
    width:100%;
    overflow-x:auto;
}

table{
    width:100%;
    border-collapse:collapse;
    background:white;
    border-radius:15px;
    overflow:hidden;
    box-shadow:0 5px 15px rgba(0,0,0,0.08);
}

th{
    background:#1565c0;
    color:white;
    padding:15px;
    font-size:13px;
    text-transform:uppercase;
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

/* TAGS */

.dept-tag{
    background:#e8f0fe;
    color:#1967d2;
    padding:5px 10px;
    border-radius:20px;
    font-size:12px;
    font-weight:600;
}

.status-active{
    background:#e8f5e9;
    color:#2e7d32;
    padding:5px 10px;
    border-radius:20px;
    font-size:12px;
    font-weight:600;
}

.status-closed{
    background:#ffebee;
    color:#c62828;
    padding:5px 10px;
    border-radius:20px;
    font-size:12px;
    font-weight:600;
}

/* ACTION BUTTONS */

.actions{
    display:flex;
    gap:8px;
    justify-content:center;
}

.edit-btn{
    background:#f39c12;
    color:white;
    padding:8px 14px;
    border-radius:6px;
    text-decoration:none;
    font-size:13px;
}

.edit-btn:hover{
    background:#d68910;
}

.delete-btn{
    background:#e53935;
    color:white;
    border:none;
    padding:8px 14px;
    border-radius:6px;
    cursor:pointer;
    font-size:13px;
}

.delete-btn:hover{
    background:#c62828;
}

/* FOOTER */

.footer-nav{
    text-align:center;
    margin-top:35px;
}

.back-link{
    text-decoration:none;
    background:#1565c0;
    color:white;
    padding:12px 30px;
    border-radius:10px;
    font-weight:600;
}

.back-link:hover{
    background:#0d47a1;
}

</style>

</head>

<body>

<h2>Manage Company Drives</h2>

<!-- FILTER SECTION -->

<div class="filter-container">

<form class="filter-form"
      method="get"
      action="ViewCompaniesServlet">

<input type="text"
       name="search"
       placeholder="Search Company..."
       value="<%= currentSearch %>">

<select name="dept">

<option value="">All Departments</option>

<option value="MCA"
<%= "MCA".equals(currentDept) ? "selected" : "" %>>
MCA
</option>

<option value="CSE"
<%= "CSE".equals(currentDept) ? "selected" : "" %>>
CSE
</option>

<option value="IT"
<%= "IT".equals(currentDept) ? "selected" : "" %>>
IT
</option>

<option value="EEE"
<%= "EE".equals(currentDept) ? "selected" : "" %>>
EEE

</option>

<option value="CSE"
<%= "CSE".equals(currentDept) ? "selected" : "" %>>
CSE

</option>

<option value="ECE"
<%= "ECE".equals(currentDept) ? "selected" : "" %>>
ECE

</option>

<option value="BioTech"
<%= "BioTech".equals(currentDept) ? "selected" : "" %>>
BioTech

</option>
<option value="Biomedical"
<%= "Biomedical".equals(currentDept) ? "selected" : "" %>>
Biomedical

</option>

</select>

<button type="submit"
        class="filter-btn">

Filter

</button>

<a href="ViewCompaniesServlet"
   class="reset-link">

Reset

</a>

</form>

</div>

<!-- TABLE -->

<div class="table-container">

<table>

<thead>

<tr>

<th>Company</th>
<th>Role</th>
<th>Package</th>
<th>Skills</th>
<th>Department</th>
<th>Min CGPA</th>
<th>Max Arrear</th>
<th>Drive Date</th>
<th>Status</th>
<th>Action</th>

</tr>

</thead>

<tbody>

<%

if(list != null && !list.isEmpty()){

    for(String[] c : list){

%>

<tr>


<td>
<b><%= c[1] %></b>
</td>

<td><%= c[5] %></td>

<td><%= c[6] %></td>

<td>
<%= c[8] != null ? c[8] : "N/A" %>
</td>

<td>
<span class="dept-tag">

<%= c[7] %>

</span>
</td>

<td><%= c[2] %></td>

<td><%= c[3] %></td>

<td><%= c[4] %></td>

<td>

<span class="status-active">

Active

</span>

</td>

<td>

<div class="actions">

<a href="EditCompanyServlet?id=<%= c[0] %>"
   class="edit-btn">

Edit

</a>

<form action="DeleteCompanyServlet"
      method="get"
      style="display:inline;"
      onsubmit="return confirm('Delete this company drive?')">

<input type="hidden"
       name="id"
       value="<%= c[0] %>">

<button type="submit"
        class="delete-btn">

Delete

</button>

</form>

</div>

</td>

</tr>

<%

    }

}else{

%>

<tr>

<td colspan="11"
    style="padding:30px; color:gray;">

No company drives found

</td>

</tr>

<%

}

%>

</tbody>

</table>

</div>

<!-- FOOTER -->

<div class="footer-nav">

<a href="adminDashboard.jsp"
   class="back-link">

⬅ Back to Dashboard

</a>

</div>

</body>
</html>