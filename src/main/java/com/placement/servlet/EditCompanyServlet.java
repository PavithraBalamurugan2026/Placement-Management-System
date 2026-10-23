package com.placement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/EditCompanyServlet")
public class EditCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        String id = request.getParameter("id");

        System.out.println("Edit clicked for ID: " + id); // 🔥 debug

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM notifications WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                request.setAttribute("id", rs.getString("id"));
                request.setAttribute("company_name", rs.getString("company_name"));
                request.setAttribute("role", rs.getString("role"));
                request.setAttribute("package", rs.getString("package"));
                request.setAttribute("department", rs.getString("department"));
                request.setAttribute("skills", rs.getString("skills"));
                request.setAttribute("message", rs.getString("message"));
                request.setAttribute("min_cgpa", rs.getString("min_cgpa"));
                request.setAttribute("max_arrear", rs.getString("max_arrear"));
                request.setAttribute("drive_date", rs.getString("drive_date"));

                RequestDispatcher rd = request.getRequestDispatcher("editCompany.jsp");
                rd.forward(request, response);

            } else {
                response.getWriter().println("No data found!");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error occurred: " + e.getMessage());
        }
    }
}