package com.placement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/MyApplicationsServlet")
public class MyApplicationsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 🔐 Session check
        if (session == null || session.getAttribute("studentEmail") == null) {
            response.sendRedirect("studentLogin.jsp");
            return;
        }

        String studentEmail = (String) session.getAttribute("studentEmail");

        List<String[]> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT * FROM applications WHERE student_email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, studentEmail);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                String[] data = new String[5];

                data[0] = rs.getString("company_name");
                data[1] = rs.getString("role");
                data[2] = rs.getString("package");
                data[3] = rs.getString("status");
                data[4] = rs.getString("applied_date");

                list.add(data);
            }

            request.setAttribute("applications", list);

            RequestDispatcher rd =
                request.getRequestDispatcher("myApplications.jsp");
            rd.forward(request, response);

            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}