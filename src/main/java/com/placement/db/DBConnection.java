package com.placement.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/placement_system",
                "root",
                "Project@2026"
            );

            System.out.println("✅ Connected to placement_system DB");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}