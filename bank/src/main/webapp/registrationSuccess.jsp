<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*,java.io.*,java.sql.*" %>
<html>
<head>
    <title>Registration Success</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            justify-content: space-between;
            background-image: url('your-background.gif'); /* Replace with your GIF URL */
            background-size: cover; /* Adjusted to cover the entire body */
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
        }
        .navbar {
            background-color: #333;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 20px;
        }
        .navbar a {
            color: #f2f2f2;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
        }
        .navbar a:hover {
            background-color: #555;
        }
        .navbar .logo {
            font-size: 18px;
            font-weight: bold;
            color: #f2f2f2;
            text-decoration: none;
        }
        .navbar .logout {
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
        }
        .navbar .logout:hover {
            background-color: #da190b;
        }
        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8); /* Transparent white background */
            border: 1px solid #ccc;
            border-radius: 5px;
            max-width: 800px; /* Adjusted maximum width */
            margin: auto; /* Center the container horizontally */
            margin-top: 20px; /* Added top margin */
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        p {
            text-align: center;
            font-size: 18px;
        }
        .success-message {
            background-color: #dff0d8;
            color: #3c763d;
            border: 1px solid #d6e9c6;
            padding: 15px;
            border-radius: 5px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="#" class="logo">Bank Logo</a>
        <div>
            <a href="adminDashboard.jsp">Dashboard</a>
            <a href="registerCustomer.jsp">Register Customer</a>
            <a href="modifyCustomer.jsp">Modify Customer</a>
            <a href="deleteCustomer.jsp">Delete Customer</a>
            <a href="viewCustomers.jsp">View Customers</a>
            <a href="logout.jsp" class="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Registration Successful</h2>
        <div class="success-message">
            <p>Your account has been successfully registered.</p>
            <p>Account Number: <%= request.getAttribute("accountNo") %></p>
            <p>Password: <%= request.getAttribute("tempPassword") %></p>
        </div>
    </div>
</body>
</html>
