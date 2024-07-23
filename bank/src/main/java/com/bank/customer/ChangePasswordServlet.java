package com.bank.customer;

import com.bank.dao.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/changePassword")
public class ChangePasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String accountNo = (String) session.getAttribute("accountNo");
            String newPassword = request.getParameter("newPassword");

            try {
                Connection connection = DatabaseConnection.getConnection(); // Use DatabaseConnection class

                String sql = "UPDATE customer SET password = ? WHERE account_no = ?";
                try (PreparedStatement statement = connection.prepareStatement(sql)) {
                    statement.setString(1, newPassword);
                    statement.setString(2, accountNo);
                    statement.executeUpdate();
                }

                connection.close();
                response.sendRedirect("customerDashboard.jsp");
            } catch (SQLException e) {
                e.printStackTrace();
                throw new ServletException("Database connection error", e);
            }
        } else {
            response.sendRedirect("customerLogin.jsp");
        }
    }
}
