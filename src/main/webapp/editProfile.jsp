<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Edit Profile</title>
<style>
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #eef2f7; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
    .box { background: white; padding: 30px; width: 400px; border-radius: 15px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); }
    h2 { text-align: center; color: #333; margin-bottom: 20px; }
    label { font-weight: bold; font-size: 14px; color: #555; display: block; margin-top: 10px; }
    input { width: 100%; padding: 10px; margin: 5px 0 15px 0; border: 1px solid #ddd; border-radius: 5px; box-sizing: border-box; }
    input:disabled { background: #f9f9f9; color: #888; }
    button { width: 100%; padding: 12px; background: #1a73e8; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; transition: background 0.3s; }
    button:hover { background: #1557b0; }
    .back-link { display: block; text-align: center; margin-top: 15px; text-decoration: none; color: #666; font-size: 14px; }
</style>
</head>
<body>

<div class="box">
    <h2>Edit Profile</h2>
    <form action="UpdateProfileServlet" method="post">
        
        <label>Full Name</label>
        <input type="text" name="name" value="<%= request.getAttribute("name") %>" required>

        <label>Roll Number (e.g., 25MCA024)</label>
        <input type="text" name="rollno" value="<%= request.getAttribute("rollno") %>" required>

        <label>Email (Cannot Change)</label>
        <input type="text" value="<%= request.getAttribute("email") %>" disabled>

        <label>Department</label>
        <input type="text" name="department" value="<%= request.getAttribute("department") %>" required>

        <label>CGPA</label>
        <input type="text" name="cgpa" value="<%= request.getAttribute("cgpa") %>" required>

        <label>Arrear Count</label>
        <input type="text" name="arrear" value="<%= request.getAttribute("arrear") %>" required>

        <label>Graduation Year</label>
        <input type="text" name="year" value="<%= request.getAttribute("year") %>" required>

        <button type="submit">Update Profile</button>
    </form>
    <a href="ViewProfileServlet" class="back-link">⬅ Back to Profile</a>
</div>

</body>
</html>