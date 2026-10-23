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

@WebServlet("/ViewCompaniesServlet")
public class ViewCompaniesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<String[]> list = new ArrayList<>();
        String search = request.getParameter("search");
        String dept = request.getParameter("dept"); // New parameter

        try (Connection con = DBConnection.getConnection()) {
            StringBuilder sql = new StringBuilder("SELECT * FROM notifications WHERE 1=1");
            
            // Dynamically build the query
            if (search != null && !search.trim().isEmpty()) {
                sql.append(" AND company_name LIKE ?");
            }
            if (dept != null && !dept.trim().isEmpty()) {
                // This SQL checks if the column matches the Dept OR if the column contains "All"
                sql.append(" AND (department LIKE ? OR department LIKE '%All%')");
            }

            PreparedStatement ps = con.prepareStatement(sql.toString());
            int paramIndex = 1;

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + search + "%");
            }
            if (dept != null && !dept.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + dept + "%");
                // You only need to set one parameter because 'All' is hardcoded in the SQL above
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String[] data = new String[9];
                data[0] = rs.getString("id");
                data[1] = rs.getString("company_name");
                data[2] = rs.getString("min_cgpa");
                data[3] = rs.getString("max_arrear");
                data[4] = rs.getString("drive_date");
                data[5] = rs.getString("role");
                data[6] = rs.getString("package");
                data[7] = rs.getString("department");
                data[8] = rs.getString("skills");
                list.add(data);
            }

            request.setAttribute("companies", list);
            request.getRequestDispatcher("viewCompanies.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}