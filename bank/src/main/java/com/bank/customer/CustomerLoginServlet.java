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
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet("/customerLogin")
public class CustomerLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo");
        String password = request.getParameter("password");

        try {
            Connection connection = DatabaseConnection.getConnection(); // Use DatabaseConnection class

            boolean isValidUser = checkCredentials(connection, accountNo, password);

            if (isValidUser) {
                HttpSession session = request.getSession();
                session.setAttribute("accountNo", accountNo);
                if (password.startsWith("TEMP_")) { // Check if it's a temporary password
                    response.sendRedirect("ChangePassword.jsp");
                } else {
                    response.sendRedirect("customerDashboard.jsp");
                }
            } else {
                request.setAttribute("errorMessage", "Invalid account number or password.");
                request.getRequestDispatcher("customerLogin.jsp").forward(request, response);
            }

            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new ServletException("Database connection error", e);
        }
    }

    private boolean checkCredentials(Connection connection, String accountNo, String password) throws SQLException {
        String sql = "SELECT password FROM customer WHERE account_no = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, accountNo);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    String dbPassword = resultSet.getString("password");
                    return password.equals(dbPassword);
                } else {
                    return false;
                }
            }
        }
    }
}
