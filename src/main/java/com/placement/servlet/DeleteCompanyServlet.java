package com.placement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.placement.db.DBConnection;

@WebServlet("/DeleteCompanyServlet")
public class DeleteCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws IOException {

        // 🔐 SESSION CHECK
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect("adminLogin.jsp");
            return;
        }

        // 📥 GET COMPANY ID
        String id = request.getParameter("id");

        try {
            Connection con = DBConnection.getConnection();

            String sql = "DELETE FROM notifications WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, Integer.parseInt(id));

            ps.executeUpdate();

            con.close();

            // ✅ REDIRECT BACK TO VIEW PAGE
            response.sendRedirect("ViewCompaniesServlet");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}