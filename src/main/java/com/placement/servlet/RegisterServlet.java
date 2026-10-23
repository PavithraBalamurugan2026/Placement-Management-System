package com.placement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.placement.db.DBConnection;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rollno = request.getParameter("rollno");
        String department = request.getParameter("department");
        String year = request.getParameter("year");

        try {

            Connection con =
            DBConnection.getConnection();

            String sql =
            "INSERT INTO students(name,email,password,rollno,department,year,cgpa,arrear) VALUES(?,?,?,?,?,?,0.0,0)";

            PreparedStatement ps =
            con.prepareStatement(sql);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, rollno);
            ps.setString(5, department);
            ps.setInt(6, Integer.parseInt(year));

            ps.executeUpdate();

            con.close();

            response.sendRedirect(
            "studentLogin.jsp?msg=registered");

        }
        catch(Exception e){

            e.printStackTrace();

            response.sendRedirect(
            "register.jsp?error=exists");
        }
    }
}