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
import jakarta.servlet.RequestDispatcher;

@WebServlet("/customerTransaction")
public class CustomerTransactionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String transactionType = request.getParameter("type");
        double amount = Double.parseDouble(request.getParameter("amount"));

        // Get current user's account number from session
        HttpSession session = request.getSession();
        String accountNo = (String) session.getAttribute("accountNo");

        // Log transaction details for debugging
        System.out.println("Transaction Type: " + transactionType);
        System.out.println("Amount: " + amount);
        System.out.println("Account No: " + accountNo);

        Connection con = null;
        try {
            con = DatabaseConnection.getConnection(); // Use DatabaseConnection class

            // Retrieve current balance
            double currentBalance = getCurrentBalance(con, accountNo);
            System.out.println("Current Balance: " + currentBalance);

            if ("Deposit".equals(transactionType)) {
                double newBalance = currentBalance + amount;
                updateBalance(con, accountNo, newBalance);

                // Insert transaction record
                insertTransaction(con, accountNo, "Deposit", amount, newBalance);

                // Set success message
                request.setAttribute("successMessage", "Deposit of ₹" + amount + " successful!");

            } else if ("Withdraw".equals(transactionType)) {
                if (currentBalance >= amount) {
                    double newBalance = currentBalance - amount;
                    updateBalance(con, accountNo, newBalance);

                    // Insert transaction record
                    insertTransaction(con, accountNo, "Withdraw", amount, newBalance);

                    // Set success message
                    request.setAttribute("successMessage", "Withdrawal of ₹" + amount + " successful!");
                } else {
                    // Insufficient balance error handling
                    request.setAttribute("errorMessage", "Insufficient balance for withdrawal.");
                }
            }

            // Forward to Transaction.jsp to display message
            RequestDispatcher dispatcher = request.getRequestDispatcher("transaction.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQL exceptions here
            request.setAttribute("errorMessage", "Database error occurred. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("transaction.jsp");
            dispatcher.forward(request, response);

        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private double getCurrentBalance(Connection con, String accountNo) throws SQLException {
        PreparedStatement ps = con.prepareStatement("SELECT current_balance FROM customer WHERE account_no=?");
        ps.setString(1, accountNo);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getDouble("current_balance");
        }
        return 0.0; // Default to 0 if no balance found (should not happen in normal scenarios)
    }

    private void updateBalance(Connection con, String accountNo, double newBalance) throws SQLException {
        PreparedStatement ps = con.prepareStatement("UPDATE customer SET current_balance=? WHERE account_no=?");
        ps.setDouble(1, newBalance);
        ps.setString(2, accountNo);
        ps.executeUpdate();
    }

    private void insertTransaction(Connection con, String accountNo, String type, double amount, double balanceAfterTransaction) throws SQLException {
        PreparedStatement ps = con.prepareStatement("INSERT INTO transaction (account_no, type, amount, balance) VALUES (?, ?, ?, ?)");
        ps.setString(1, accountNo);
        ps.setString(2, type);
        ps.setDouble(3, amount);
        ps.setDouble(4, balanceAfterTransaction);
        ps.executeUpdate();
    }
}
