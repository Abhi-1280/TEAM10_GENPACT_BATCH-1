package com.bank.admin;

import jakarta.servlet.*;

import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

import com.bank.dao.DatabaseConnection;

public class DeleteCustomerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNo = request.getParameter("accountNo");

        try {
        	Connection con = DatabaseConnection.getConnection();

            // Check if the balance is zero
            String checkBalanceQuery = "SELECT initial_balance FROM customer WHERE account_no=?";
            PreparedStatement checkBalanceStmt = con.prepareStatement(checkBalanceQuery);
            checkBalanceStmt.setString(1, accountNo);
            ResultSet rs = checkBalanceStmt.executeQuery();

            if (rs.next()) {
                double balance = rs.getDouble("initial_balance");
                if (balance == 0) {
                    // Delete the customer
                    String deleteQuery = "DELETE FROM customer WHERE account_no=?";
                    PreparedStatement deleteStmt = con.prepareStatement(deleteQuery);
                    deleteStmt.setString(1, accountNo);
                    deleteStmt.executeUpdate();

                    response.sendRedirect("adminDashboard.jsp?success=1");
                } else {
                    response.sendRedirect("deleteCustomer.jsp?error=balance_not_zero");
                }
            } else {
                response.sendRedirect("deleteCustomer.jsp?error=account_not_found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("deleteCustomer.jsp?error=1");
        }
    }
}