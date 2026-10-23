package com.placement.servlet;

import java.io.IOException;
import java.sql.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/EditProfileServlet")
public class EditProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentEmail") == null) {
            response.sendRedirect("studentLogin.jsp");
            return;
        }

        String email = (String) session.getAttribute("studentEmail");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM students WHERE email=?"
            );
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("name", rs.getString("name"));
                request.setAttribute("rollno", rs.getString("rollno"));
                request.setAttribute("email", rs.getString("email"));
                request.setAttribute("department", rs.getString("department"));
                request.setAttribute("cgpa", rs.getString("cgpa"));
                request.setAttribute("arrear", rs.getString("arrear"));
                request.setAttribute("year", rs.getString("year"));
            }

            con.close();

            request.getRequestDispatcher("editProfile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}