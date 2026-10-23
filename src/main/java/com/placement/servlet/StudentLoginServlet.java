package com.placement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/StudentLoginServlet")
public class StudentLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            // 🔐 Check login
            String sql = "SELECT * FROM students WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();
                session.setAttribute("studentEmail", email);
                session.setAttribute("studentName", rs.getString("name"));
                session.setAttribute("studentDept", rs.getString("department"));

                // 🔔 COUNT AVAILABLE COMPANIES
                String countSql = "SELECT COUNT(*) FROM notifications";
                PreparedStatement cps = con.prepareStatement(countSql);
                ResultSet crs = cps.executeQuery();

                int count = 0;
                if (crs.next()) {
                    count = crs.getInt(1);
                }

                // ✅ store in session
                session.setAttribute("companyCount", count);

                // redirect
                response.sendRedirect("studentDashboard.jsp");

            } else {
                response.sendRedirect("studentLogin.jsp?error=invalid");
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}