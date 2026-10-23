package com.placement.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.LinkedHashMap;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/ViewStudentServlet")
public class ViewStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        List<String[]> studentList = new ArrayList<>();
        Map<String, Integer> deptCounts = new LinkedHashMap<>();

        try (Connection con = DBConnection.getConnection()) {
            // 1. Get Detailed List
            String sql = "SELECT a.*, s.name, s.department, s.resume FROM applications a " +
                         "JOIN students s ON a.student_email = s.email ORDER BY a.applied_date DESC";
            ResultSet rs = con.prepareStatement(sql).executeQuery();
            while (rs.next()) {
                studentList.add(new String[]{
                    rs.getString("name"), rs.getString("department"), rs.getString("company_name"),
                    rs.getString("role"), rs.getString("package"), rs.getString("status"),
                    rs.getString("applied_date"), rs.getString("resume")
                });
            }

            // 2. Get Counts
            String countSql = "SELECT s.department, COUNT(*) as total FROM applications a " +
                              "JOIN students s ON a.student_email = s.email GROUP BY s.department";
            ResultSet rsCount = con.prepareStatement(countSql).executeQuery();
            while (rsCount.next()) {
                deptCounts.put(rsCount.getString("department"), rsCount.getInt("total"));
            }

            request.setAttribute("appliedStudents", studentList);
            request.setAttribute("deptCounts", deptCounts);
            request.getRequestDispatcher("viewStudents.jsp").forward(request, response);
        } catch (Exception e) { e.printStackTrace(); }
    }
}