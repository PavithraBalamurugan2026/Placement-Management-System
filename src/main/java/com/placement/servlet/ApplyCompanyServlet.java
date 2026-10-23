package com.placement.servlet;

import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import com.placement.db.DBConnection;

@WebServlet("/ApplyCompanyServlet")
public class ApplyCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentEmail") == null) {
            response.sendRedirect("studentLogin.jsp");
            return;
        }

        String email = (String) session.getAttribute("studentEmail");
        String companyName = request.getParameter("companyName");
        String role = request.getParameter("role");
        String pack = request.getParameter("package");

        try (Connection con = DBConnection.getConnection()) {
            
            // 1. Fetch Student Data
            PreparedStatement psStud = con.prepareStatement("SELECT cgpa, arrear, department FROM students WHERE email=?");
            psStud.setString(1, email);
            ResultSet rsStud = psStud.executeQuery();

            if (rsStud.next()) {
                double sCgpa = rsStud.getDouble("cgpa"); // e.g., 8.5
                int sArrear = rsStud.getInt("arrear");   // e.g., 0
                String sDept = rsStud.getString("department").trim();

                // 2. Fetch Company Criteria
                PreparedStatement psComp = con.prepareStatement("SELECT min_cgpa, max_arrear, department FROM notifications WHERE company_name=? AND role=?");
                psComp.setString(1, companyName);
                psComp.setString(2, role);
                ResultSet rsComp = psComp.executeQuery();

                if (rsComp.next()) {
                    double minCgpaReq = rsComp.getDouble("min_cgpa"); // e.g., 65.0
                    int maxArrearAllowed = rsComp.getInt("max_arrear");
                    String compDept = rsComp.getString("department").trim();

                    // Logic: Convert student 8.5 to 85.0 to match admin's 65.0 scale
                    double studentCgpaAdjusted = sCgpa * 10; 

                    boolean isEligible = true;

                    // Check CGPA and Arrears
                    if (studentCgpaAdjusted < minCgpaReq || sArrear > maxArrearAllowed) {
                        isEligible = false;
                    }

                    // Check Department (Handles "ALL" or comma-separated lists)
                    if (isEligible && !compDept.equalsIgnoreCase("ALL")) {
                        boolean deptMatch = false;
                        String[] allowedDepts = compDept.split(",");
                        for (String d : allowedDepts) {
                            if (d.trim().equalsIgnoreCase(sDept)) {
                                deptMatch = true;
                                break;
                            }
                        }
                        if (!deptMatch) isEligible = false;
                    }

                    // Redirect if not eligible
                    if (!isEligible) {
                        response.sendRedirect("ViewAvailableCompaniesServlet?msg=noteligible");
                        return;
                    }

                    // 3. Duplicate Application Check
                    PreparedStatement psCheck = con.prepareStatement("SELECT id FROM applications WHERE student_email=? AND company_name=? AND role=?");
                    psCheck.setString(1, email);
                    psCheck.setString(2, companyName);
                    psCheck.setString(3, role);
                    if (psCheck.executeQuery().next()) {
                        response.sendRedirect("ViewAvailableCompaniesServlet?msg=already");
                        return;
                    }

                    // 4. Insert Application
                    PreparedStatement psIns = con.prepareStatement("INSERT INTO applications (student_email, company_name, role, package, status) VALUES (?, ?, ?, ?, ?)");
                    psIns.setString(1, email);
                    psIns.setString(2, companyName);
                    psIns.setString(3, role);
                    psIns.setString(4, pack);
                    psIns.setString(5, "Applied");
                    psIns.executeUpdate();

                    // Success redirect
                    response.sendRedirect("ViewAvailableCompaniesServlet?success=1");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ViewAvailableCompaniesServlet?msg=error");
        }
    }
}