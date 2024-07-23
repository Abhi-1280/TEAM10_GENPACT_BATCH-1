package com.bank.customer;

import com.bank.dao.DatabaseConnection;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;

public class UpdateProfileServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String fullName = request.getParameter("fullName");
        String address = request.getParameter("address");
        String mobileNo = request.getParameter("mobileNo");
        String emailId = request.getParameter("emailId");

        // Get current user's account number from session
        HttpSession session = request.getSession();
        String accountNo = (String) session.getAttribute("accountNo");

        // Perform database operations to update profile
        try (Connection con = DatabaseConnection.getConnection()) {
            // Update customer details in database
            String updateQuery = "UPDATE customer SET full_name=?, address=?, mobile_no=?, email_id=? WHERE account_no=?";
            try (PreparedStatement psUpdate = con.prepareStatement(updateQuery)) {
                psUpdate.setString(1, fullName);
                psUpdate.setString(2, address);
                psUpdate.setString(3, mobileNo);
                psUpdate.setString(4, emailId);
                psUpdate.setString(5, accountNo);
                int updatedRows = psUpdate.executeUpdate();

                if (updatedRows > 0) {
                    // Update session with new details if successful
                    session.setAttribute("fullName", fullName);
                    session.setAttribute("email", emailId);

                    // Set success message in request attribute
                    request.setAttribute("message", "Profile updated successfully!");
                    request.setAttribute("messageColor", "green"); // Green color for success message
                } else {
                    // Handle update failure
                    request.setAttribute("message", "Failed to update profile. Please try again.");
                    request.setAttribute("messageColor", "red"); // Red color for error message
                }
            }

            // Forward to profile.jsp to display message
            RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            // Redirect to profile.jsp with error parameter for database error
            response.sendRedirect("profile.jsp?error=databaseError");
        }
    }
}
