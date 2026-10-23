package com.placement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/UpdateApplicationStatusServlet")
public class UpdateApplicationStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws IOException {

        // Get form values
        String id = request.getParameter("id");
        String status = request.getParameter("status");

        try {

            Connection con = DBConnection.getConnection();

            String sql =
            "UPDATE applications SET status=? WHERE id=?";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1, status);
            ps.setInt(2, Integer.parseInt(id));

            ps.executeUpdate();

            con.close();

            // Redirect back
            response.sendRedirect("viewStudents.jsp");

        } catch(Exception e) {

            e.printStackTrace();
        }
    }
}