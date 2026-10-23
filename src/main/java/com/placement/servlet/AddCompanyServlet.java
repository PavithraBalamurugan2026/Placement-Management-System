package com.placement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/AddCompanyServlet")
public class AddCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                         HttpServletResponse response)
                         throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String companyName = request.getParameter("company_name");
        String role = request.getParameter("role");
        String pack = request.getParameter("package");
        String message = request.getParameter("message");
        String minCgpa = request.getParameter("min_cgpa");
        String maxArrear = request.getParameter("max_arrear");
        String driveDate = request.getParameter("drive_date");
        String department = request.getParameter("department");
        String skills = request.getParameter("skills");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "INSERT INTO notifications (company_name, role, package, message, min_cgpa, max_arrear, drive_date, department, skills) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, companyName);
            ps.setString(2, role);
            ps.setString(3, pack);
            ps.setString(4, message);
            ps.setDouble(5, Double.parseDouble(minCgpa));
            ps.setInt(6, Integer.parseInt(maxArrear));
            ps.setString(7, driveDate);
            ps.setString(8, department);
            ps.setString(9, skills);

            ps.executeUpdate();

            con.close();

            response.sendRedirect("addCompany.jsp?success=1");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}