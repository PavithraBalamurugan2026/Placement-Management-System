package com.placement.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/viewNotificationServlet")
public class ViewNotificationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html>");
        out.println("<head>");
        out.println("<title>Company Drive Notifications</title>");

        // ===== CSS START =====
        out.println("<style>");

        out.println("body {");
        out.println("    font-family: Cambria, serif;");
        out.println("    background: linear-gradient(to right, #e3f2fd, #f8fbff);");
        out.println("    margin: 0;");
        out.println("    padding: 40px;");
        out.println("}");

        out.println("h2 {");
        out.println("    text-align: center;");
        out.println("    color: #0d47a1;");
        out.println("    margin-bottom: 40px;");
        out.println("    font-size: 32px;");
        out.println("    animation: glowTitle 2s infinite alternate;");
        out.println("}");

        out.println("@keyframes glowTitle {");
        out.println("    from { text-shadow: 0 0 5px #90caf9; }");
        out.println("    to { text-shadow: 0 0 15px #42a5f5; }");
        out.println("}");

        out.println(".card {");
        out.println("    background: white;");
        out.println("    width: 60%;");
        out.println("    margin: 0 auto 30px auto;");
        out.println("    padding: 25px;");
        out.println("    border-radius: 15px;");
        out.println("    box-shadow: 0 8px 20px rgba(0,0,0,0.1);");
        out.println("    position: relative;");
        out.println("    border: 2px solid #bbdefb;");
        out.println("    animation: blinkBorder 2s infinite;");
        out.println("    transition: 0.3s ease;");
        out.println("}");

        out.println("@keyframes blinkBorder {");
        out.println("    0% { border-color: #bbdefb; }");
        out.println("    50% { border-color: #42a5f5; }");
        out.println("    100% { border-color: #bbdefb; }");
        out.println("}");

        out.println(".card:hover {");
        out.println("    transform: scale(1.03);");
        out.println("}");

        out.println(".company-header {");
        out.println("    display: flex;");
        out.println("    align-items: center;");
        out.println("    gap: 15px;");
        out.println("}");

        out.println(".company-logo {");
        out.println("    width: 55px;");
        out.println("    height: 55px;");
        out.println("    object-fit: contain;");
        out.println("}");

        out.println(".company-name {");
        out.println("    font-size: 24px;");
        out.println("    color: #1565c0;");
        out.println("    margin: 0;");
        out.println("}");

        out.println(".card p {");
        out.println("    margin: 8px 0;");
        out.println("    font-size: 16px;");
        out.println("    color: #333;");
        out.println("}");

        out.println(".label {");
        out.println("    font-weight: bold;");
        out.println("    color: #1a237e;");
        out.println("}");

        out.println(".badge {");
        out.println("    position: absolute;");
        out.println("    top: -10px;");
        out.println("    right: -10px;");
        out.println("    background-color: #ff5252;");
        out.println("    color: white;");
        out.println("    padding: 6px 12px;");
        out.println("    border-radius: 20px;");
        out.println("    font-size: 13px;");
        out.println("    animation: blinkText 1s infinite;");
        out.println("}");

        out.println("@keyframes blinkText {");
        out.println("    0% { opacity: 1; }");
        out.println("    50% { opacity: 0.4; }");
        out.println("    100% { opacity: 1; }");
        out.println("}");

        out.println("</style>");
        // ===== CSS END =====

        out.println("</head>");
        out.println("<body>");
        out.println("<h2>Company Drive Notifications</h2>");

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/placement_system",
                    "root",
                    "Project@2026"  // 🔴 Put your MySQL password here
            );

            Statement stmt = con.createStatement();

            ResultSet rs = stmt.executeQuery(
                    "SELECT id, message, company_name, min_cgpa, max_arrear, drive_date, role, package FROM notifications");

            while (rs.next()) {

                String company = rs.getString("company_name");
                String logoURL = "";

                if (company.equalsIgnoreCase("TCS")) {
                    logoURL = "images/tcs.png";
                } 
                else if (company.equalsIgnoreCase("Infosys")) {
                    logoURL = "images/infosys.png";
                } 
                else if (company.equalsIgnoreCase("Wipro")) {
                    logoURL = "images/wipro.png";
                }

                out.println("<img class='company-logo' src='" 
                    + request.getContextPath() + "/" + logoURL + "' alt='logo'>");

                out.println("<div class='card'>");
                out.println("<div class='badge'>New Drive</div>");

                out.println("<div class='company-header'>");
                out.println("<img class='company-logo' src='" + logoURL + "' alt='logo'>");
                out.println("<h3 class='company-name'>" + company + "</h3>");
                out.println("</div>");

                out.println("<p><span class='label'>Drive Message:</span> "
                        + rs.getString("message") + "</p>");

                out.println("<p><span class='label'>Role:</span> "
                        + rs.getString("role") + "</p>");

                out.println("<p><span class='label'>Package:</span> "
                        + rs.getString("package") + "</p>");

                out.println("<p><span class='label'>Minimum CGPA:</span> "
                        + rs.getDouble("min_cgpa") + "</p>");

                out.println("<p><span class='label'>Maximum Arrear:</span> "
                        + rs.getInt("max_arrear") + "</p>");

                out.println("<p><span class='label'>Drive Date:</span> "
                        + rs.getDate("drive_date") + "</p>");

                out.println("</div>");
            }

            con.close();

        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }

        out.println("</body>");
        out.println("</html>");
    }
}