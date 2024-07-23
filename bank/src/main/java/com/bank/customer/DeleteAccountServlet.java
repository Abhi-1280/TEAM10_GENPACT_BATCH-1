package com.bank.customer;

import com.bank.dao.DatabaseConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class DeleteAccountServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String accountNo = request.getParameter("accountNo");
        String password = request.getParameter("password");

        if (accountNo == null || password == null) {
            request.setAttribute("message", "Account number and password are required.");
            request.setAttribute("messageColor", "red");
            RequestDispatcher dispatcher = request.getRequestDispatcher("deleteAccount.jsp");
            dispatcher.forward(request, response);
            return;
        }

        try (Connection con = DatabaseConnection.getConnection()) {
            // Check account details
            String query = "SELECT initial_balance, password FROM customer WHERE account_no = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, accountNo);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                double balance = rs.getDouble("initial_balance");
                String dbPassword = rs.getString("password");

                if (!dbPassword.equals(password)) {
                    request.setAttribute("message", "Incorrect password.");
                    request.setAttribute("messageColor", "red");
                } else if (balance != 0) {
                    request.setAttribute("message", "Account balance is not zero. Cannot delete account.");
                    request.setAttribute("messageColor", "red");
                } else {
                    // Delete related transaction records
                    String deleteTransactionsQuery = "DELETE FROM transaction WHERE account_no = ?";
                    try (PreparedStatement psDeleteTransactions = con.prepareStatement(deleteTransactionsQuery)) {
                        psDeleteTransactions.setString(1, accountNo);
                        psDeleteTransactions.executeUpdate();
                    }

                    // Now delete the customer record
                    String deleteCustomerQuery = "DELETE FROM customer WHERE account_no = ?";
                    try (PreparedStatement psDeleteCustomer = con.prepareStatement(deleteCustomerQuery)) {
                        psDeleteCustomer.setString(1, accountNo);
                        psDeleteCustomer.executeUpdate();
                    }

                    session.invalidate(); // Invalidate session after deletion
                    request.setAttribute("message", "Account deleted successfully.");
                    request.setAttribute("messageColor", "green");
                }
            } else {
                request.setAttribute("message", "Account not found.");
                request.setAttribute("messageColor", "red");
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("deleteAccount.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message", "Database error occurred.");
            request.setAttribute("messageColor", "red");
            RequestDispatcher dispatcher = request.getRequestDispatcher("deleteAccount.jsp");
            dispatcher.forward(request, response);
        }
    }
}
