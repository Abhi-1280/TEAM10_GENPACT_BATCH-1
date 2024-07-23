package com.bank.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAO {
    public boolean isBalanceZero(Connection con, String accountNo) throws SQLException {
        String checkBalanceQuery = "SELECT initial_balance FROM customer WHERE account_no=?";
        try (PreparedStatement checkBalanceStmt = con.prepareStatement(checkBalanceQuery)) {
            checkBalanceStmt.setString(1, accountNo);
            ResultSet rs = checkBalanceStmt.executeQuery();
            if (rs.next()) {
                double balance = rs.getDouble("initial_balance");
                return balance == 0;
            }
            return false;
        }
    }

    public boolean deleteCustomer(Connection con, String accountNo) throws SQLException {
        String deleteQuery = "DELETE FROM customer WHERE account_no=?";
        try (PreparedStatement deleteStmt = con.prepareStatement(deleteQuery)) {
            deleteStmt.setString(1, accountNo);
            return deleteStmt.executeUpdate() > 0;
        }
    }

    public boolean accountExists(Connection con, String accountNo) throws SQLException {
        String checkAccountQuery = "SELECT account_no FROM customer WHERE account_no=?";
        try (PreparedStatement checkAccountStmt = con.prepareStatement(checkAccountQuery)) {
            checkAccountStmt.setString(1, accountNo);
            ResultSet rs = checkAccountStmt.executeQuery();
            return rs.next();
        }
    }
}
