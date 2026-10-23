package com.placement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("studentEmail");

        // Capturing form data
        String name = request.getParameter("name");
        String rollno = request.getParameter("rollno"); // This matches your VARCHAR(20)
        String department = request.getParameter("department");
        String cgpa = request.getParameter("cgpa");
        String arrear = request.getParameter("arrear");
        String year = request.getParameter("year");

        try (Connection con = DBConnection.getConnection()) {
            // Count the '?' marks: 1(name), 2(rollno), 3(dept), 4(cgpa), 5(arrear), 6(year), 7(email)
            String sql = "UPDATE students SET name=?, rollno=?, department=?, cgpa=?, arrear=?, year=? WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, rollno);        // Sets 25MCA024
            ps.setString(3, department);
            ps.setDouble(4, Double.parseDouble(cgpa));
            ps.setInt(5, Integer.parseInt(arrear));
            ps.setInt(6, Integer.parseInt(year));
            ps.setString(7, email);

            int result = ps.executeUpdate();
            
            if (result > 0) {
                session.setAttribute("studentName", name);
                // MUST redirect to ViewProfileServlet so it fetches the NEW rollno
                response.sendRedirect("ViewProfileServlet?success=updated");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}