package com.placement.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/ViewAvailableCompaniesServlet")
public class ViewAvailableCompaniesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
                         throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("studentEmail") == null) {
            response.sendRedirect("studentLogin.jsp");
            return;
        }

        List<String[]> list = new ArrayList<>();

        String email = (String) session.getAttribute("studentEmail");

        try {

            Connection con = DBConnection.getConnection();

            // ==============================
            // 1. GET STUDENT DEPARTMENT
            // ==============================

            String studentDept = "";

            String deptSql =
                "SELECT department FROM students WHERE email=?";

            PreparedStatement deptPs =
                con.prepareStatement(deptSql);

            deptPs.setString(1, email);

            ResultSet deptRs = deptPs.executeQuery();

            if (deptRs.next()) {
                studentDept = deptRs.getString("department");
            }

            // ==============================
            // 2. GET SEEN COOKIE
            // ==============================

            Cookie[] cookies = request.getCookies();

            String seenIds = "";

            if (cookies != null) {

                for (Cookie ck : cookies) {

                    if (ck.getName().equals("seen_notifs")) {
                        seenIds = ck.getValue();
                    }
                }
            }

            String newSeenIds = seenIds;

            // ==============================
            // 3. FETCH ONLY ELIGIBLE COMPANIES
            // ==============================

            String sql =
                "SELECT * FROM notifications " +
                "WHERE department='ALL' " +
                "OR department LIKE ? " +
                "ORDER BY company_name, id DESC";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setString(1, "%" + studentDept + "%");

            ResultSet rs = ps.executeQuery();

            // ==============================
            // 4. LOOP COMPANIES
            // ==============================

            while (rs.next()) {

                String[] data = new String[11];

                String notifId = rs.getString("id");

                String companyName =
                    rs.getString("company_name");

                String compDept =
                    rs.getString("department");

                String role =
                    rs.getString("role");

                // ==============================
                // STORE DATA
                // ==============================

                data[0] = notifId;
                data[1] = rs.getString("message");
                data[2] = companyName;
                data[3] = rs.getString("min_cgpa");
                data[4] = rs.getString("max_arrear");
                data[5] = rs.getString("drive_date");
                data[6] = role;
                data[7] = rs.getString("package");
                data[9] = compDept;
                data[10] = rs.getString("skills");

                // ==============================
                // 5. CHECK APPLIED
                // ==============================

                String checkSql =
                    "SELECT * FROM applications " +
                    "WHERE student_email=? " +
                    "AND company_name=? " +
                    "AND role=?";

                PreparedStatement cps =
                    con.prepareStatement(checkSql);

                cps.setString(1, email);
                cps.setString(2, companyName);
                cps.setString(3, role);

                ResultSet crs = cps.executeQuery();

                boolean isApplied = crs.next();

                // ==============================
                // 6. STATUS LOGIC
                // ==============================

                if (isApplied) {

                    data[8] = "APPLIED";

                } else {

                    boolean alreadySeen =
                        seenIds.contains("[" + notifId + "]");

                    if (!alreadySeen) {

                        data[8] = "NEW";

                        newSeenIds += "[" + notifId + "]";
                    }
                    else {

                        data[8] = "";
                    }
                }

                list.add(data);
            }

            // ==============================
            // 7. UPDATE COOKIE
            // ==============================

            Cookie cookie =
                new Cookie("seen_notifs", newSeenIds);

            cookie.setMaxAge(60 * 60 * 24 * 30);

            response.addCookie(cookie);

            // ==============================
            // 8. FORWARD
            // ==============================

            request.setAttribute("notifications", list);

            RequestDispatcher rd =
                request.getRequestDispatcher(
                    "viewAvailableCompanies.jsp");

            rd.forward(request, response);

            con.close();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}