package com.bank.customer;

import com.bank.dao.DatabaseConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

public class TransferMoneyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String recipientAccountNo = request.getParameter("recipientAccountNo");
        double amount = Double.parseDouble(request.getParameter("amount"));

        // Get current user's account number from session
        HttpSession session = request.getSession();
        String accountNo = (String) session.getAttribute("accountNo");

        // Perform database operations to transfer money
        try (Connection con = DatabaseConnection.getConnection()) {
            // Check if the recipient account exists
            if (!accountExists(con, recipientAccountNo)) {
                // Handle if recipient account doesn't exist
                response.sendRedirect("transferMoney.jsp?error=recipientNotFound");
                return; // Exit the method to avoid further execution
            }

            // Begin transaction
            con.setAutoCommit(false);

            // Update balance for current user (deduct amount)
            updateBalance(con, accountNo, -amount);

            // Update balance for recipient (add amount)
            updateBalance(con, recipientAccountNo, amount);

            // Insert into transaction table for sender (transfer out)
            insertTransaction(con, accountNo, "transfer", -amount);

            // Insert into transaction table for recipient (transfer in)
            insertTransaction(con, recipientAccountNo, "transfer", amount);

            // Commit transaction
            con.commit();

            // Set success attribute to true
            request.setAttribute("successMessage", "Transfer of ₹" + amount + " successful!");

        } catch (SQLException e) {
            e.printStackTrace();
            // Redirect to transferMoney.jsp with error parameter for database error
            response.sendRedirect("transferMoney.jsp?error=databaseError");
            return; // Exit the method to avoid further execution
        }

        // Forward request to transferMoney.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("transferMoney.jsp");
        dispatcher.forward(request, response);
    }

    // Helper method to check if an account exists
    private boolean accountExists(Connection con, String accountNo) throws SQLException {
        String query = "SELECT * FROM customer WHERE account_no=?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, accountNo);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // Helper method to update balance
    private void updateBalance(Connection con, String accountNo, double amount) throws SQLException {
        String query = "UPDATE customer SET initial_balance = initial_balance + ? WHERE account_no = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setDouble(1, amount);
            ps.setString(2, accountNo);
            ps.executeUpdate();
        }
    }

    // Helper method to insert transaction record
    private void insertTransaction(Connection con, String accountNo, String type, double amount) throws SQLException {
        String query = "INSERT INTO transaction (account_no, date, type, amount, balance) VALUES (?, NOW(), ?, ?, ?)";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, accountNo);
            ps.setString(2, type);
            ps.setDouble(3, amount);
            ps.setDouble(4, getBalance(con, accountNo));
            ps.executeUpdate();
        }
    }

    // Helper method to get current balance from database
    private double getBalance(Connection con, String accountNo) throws SQLException {
        String query = "SELECT initial_balance FROM customer WHERE account_no = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, accountNo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("initial_balance");
                }
            }
        }
        return 0; // Return 0 if balance retrieval fails
    }
}
