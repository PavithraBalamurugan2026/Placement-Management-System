package com.placement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/ViewProfileServlet")
public class ViewProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentEmail") == null) {
            response.sendRedirect("studentLogin.jsp");
            return;
        }

        String email = (String) session.getAttribute("studentEmail");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT name,rollno, email, department, cgpa, arrear, year, resume FROM students WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("rollno", rs.getString("rollno"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("department", rs.getString("department"));
                request.setAttribute("cgpa", rs.getDouble("cgpa"));
                request.setAttribute("arrear", rs.getInt("arrear"));
                request.setAttribute("year", rs.getInt("year"));

                // ✅ ADD THIS (IMPORTANT)
                request.setAttribute("resume", rs.getString("resume"));
            }

            con.close();

            request.getRequestDispatcher("viewProfile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}