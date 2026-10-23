package com.placement.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.placement.db.DBConnection;

@WebServlet("/UploadResumeServlet")

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 2,
    maxRequestSize = 1024 * 1024 * 5
)

public class UploadResumeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
                          throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // SESSION CHECK

        if(session == null ||
           session.getAttribute("studentEmail") == null){

            response.sendRedirect("studentLogin.jsp");
            return;
        }

        String email =
            (String) session.getAttribute("studentEmail");

        // GET FILE

        Part filePart =
            request.getPart("resume");

        String fileName =
            filePart.getSubmittedFileName();

        // EMPTY FILE CHECK

        if(fileName == null ||
           fileName.trim().equals("")){

            response.sendRedirect(
            "uploadResume.jsp?msg=nofile");

            return;
        }

        // =========================
        // ONLY PDF ALLOWED
        // =========================

        String lowerFile =
            fileName.toLowerCase();

        if(!lowerFile.endsWith(".pdf")){

            response.sendRedirect(
            "uploadResume.jsp?msg=invalidtype");

            return;
        }

        // =========================
        // FILE SIZE VALIDATION
        // =========================

        long fileSize =
            filePart.getSize();

        if(fileSize > 2 * 1024 * 1024){

            response.sendRedirect(
            "uploadResume.jsp?msg=toolarge");

            return;
        }

        // =========================
        // CREATE FOLDER
        // =========================

        String uploadPath =
        		getServletContext().getRealPath("/resumes");

        File uploadDir =
            new File(uploadPath);

        if(!uploadDir.exists()){

            uploadDir.mkdirs();
        }

        // =========================
        // UNIQUE FILE NAME
        // =========================

        String uniqueFileName =
            System.currentTimeMillis()
            + "_" + fileName;

        // =========================
        // SAVE FILE
        // =========================

        filePart.write(
            uploadPath
            + File.separator
            + uniqueFileName
        );

        try{

            Connection con =
                DBConnection.getConnection();

            String sql =
                "UPDATE students SET resume=? WHERE email=?";

            PreparedStatement ps =
                con.prepareStatement(sql);

            ps.setString(1, uniqueFileName);
            ps.setString(2, email);

            ps.executeUpdate();

            ps.close();
            con.close();

            // SUCCESS

            response.sendRedirect(
            "ViewProfileServlet?resume=uploaded");
        }

        catch(Exception e){

            e.printStackTrace();

            response.sendRedirect(
            "uploadResume.jsp?msg=error");
        }
    }
}