<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<html>
<head>
    <title>Delete Account</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .navbar {
            overflow: hidden;
            background-color: rgba(0, 123, 255, 0.7); /* Sky blue background color */
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 20px;
        }
        .navbar .logo img {
            height: 30px;
            width: auto; /* Adjusted for responsiveness */
        }
        .navbar .logout {
            display: block;
            background-color: black; /* Blue logout button */
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 3px;
        }
        .navbar .logout:hover {
            background-color: #0056b3; /* Darker blue hover effect */
        }
        .container {
            max-width: 500px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }
        h2 {
            text-align: center;
        }
        .message {
            padding: 10px;
            margin-bottom: 20px;
            font-weight: bold;
            text-align: center;
        }
        .success {
            color: green;
        }
        .error {
            color: red;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
        }
        .form-group button {
            background-color: #007bff;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            width: 100%;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="navbar">
    <a href="customerDashboard.jsp" class="logo"><img src="logo1.png" alt="Logo"></a>
    <a href="logoutcust.jsp" class="logout">Logout</a>
</div>

<div class="container">
    <h2>Delete Account</h2>
    
    <% 
        String message = (String) request.getAttribute("message");
        String messageColor = (String) request.getAttribute("messageColor");
        
        if (message != null && !message.trim().isEmpty()) {
            if ("green".equals(messageColor)) {
    %>
                <div class="message success"><%= message %></div>
    <% 
            } else if ("red".equals(messageColor)) {
    %>
                <div class="message error"><%= message %></div>
    <% 
            }
        }
    %>

    <form action="DeleteAccountServlet" method="post">
        <div class="form-group">
            <label for="accountNo">Account Number:</label>
            <input type="text" id="accountNo" name="accountNo" required>
        </div>
        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <button type="submit">Confirm Deletion</button>
        </div>
    </form>
</div>
</body>
</html>
