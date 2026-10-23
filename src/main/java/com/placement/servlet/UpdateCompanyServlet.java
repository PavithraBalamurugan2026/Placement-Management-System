package com.placement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/UpdateCompanyServlet")
public class UpdateCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        // 📥 GET UPDATED DATA
        String id = request.getParameter("id");
        String companyName = request.getParameter("company_name");
        String role = request.getParameter("role");
        String pack = request.getParameter("package");
        String skills = request.getParameter("skills");
        String minCgpa = request.getParameter("min_cgpa");
        String maxArrear = request.getParameter("max_arrear");
        String driveDate = request.getParameter("drive_date");
        String department = request.getParameter("department"); // 🔥 NEW

        try {
            Connection con = DBConnection.getConnection();

            String sql = "UPDATE notifications SET company_name=?, role=?, package=?,skills=?, min_cgpa=?, max_arrear=?, drive_date=?, department=? WHERE id=?";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, companyName);
            ps.setString(2, role);
            ps.setString(3, pack);
            ps.setString(4, skills);
            ps.setDouble(5, Double.parseDouble(minCgpa));
            ps.setInt(6, Integer.parseInt(maxArrear));
            ps.setString(7, driveDate);
            ps.setString(8, department); // 🔥 SET DEPARTMENT
            ps.setInt(9, Integer.parseInt(id)); // 🔥 ID shifted

            ps.executeUpdate();

            con.close();

            response.sendRedirect("ViewCompaniesServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}