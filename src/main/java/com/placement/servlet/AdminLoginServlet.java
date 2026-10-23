package com.placement.servlet;

import javax.servlet.annotation.WebServlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM admin WHERE username=? AND password=?"
            );

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                // ✅ 🔥 CREATE SESSION (MOST IMPORTANT FIX)
                HttpSession session = request.getSession();
                session.setAttribute("admin", username);

                // Login Success
                response.sendRedirect("adminDashboard.jsp");

            } else {

                // Login Failed
                request.setAttribute("error", "Invalid Username or Password!");
                RequestDispatcher rd = request.getRequestDispatcher("adminLogin.jsp");
                rd.forward(request, response);
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}