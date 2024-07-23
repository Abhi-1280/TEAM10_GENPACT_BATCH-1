<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*, java.io.*, java.sql.*" %>
<html>
<head>
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }
        h2 {
            text-align: center;
        }
        .message {
            color: red;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>User Profile</h2>

    <% if (request.getParameter("error") != null && request.getParameter("error").equals("databaseError")) { %>
        <p class="message">Database error occurred. Please try again later.</p>
    <% } %>

    <!-- Your profile display logic here -->
    <p>Full Name: <%= session.getAttribute("fullName") %></p>
    <p>Email: <%= session.getAttribute("email") %></p>
</div>
</body>
</html>
