<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*,java.sql.*" %>

<%
    
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("adminLogin.jsp");
    }
%>

<html>
<head>
    <title>Delete Customer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .navbar {
            overflow: hidden;
            background-color: #333;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 20px;
        }
        .navbar a {
            float: left;
            display: block;
            color: #f2f2f2;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }
        .navbar a:hover {
            background-color: #ddd;
            color: black;
        }
        .navbar .logo img {
            height: 30px;
            width: auto; /* Adjusted for responsiveness */
        }
           .navbar .logo:hover {
            background-color: transparent; /* Removed hover effect */
        }
        .navbar .logout {
            float: right;
            display: block;
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
        }
        .navbar .logout:hover {
            background-color: #da190b;
        }
        .container {
            padding: 20px;
            margin-top: 30px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
            margin-left: auto;
            margin-right: auto;
        }
        .container h2 {
            margin-bottom: 20px;
            text-align: center;
            color: #333;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        input[type="text"] {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
             background-color: #f44336;
            color: white;
            padding: 12px 20px;
            margin: 10px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #da190b;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="#" class="logo"><img src="logo1.png" alt="Logo"></a>
        <div>
            <a href="adminDashboard.jsp">Dashboard</a>
            <a href="registerCustomer.jsp">Register Customer</a>
            <a href="viewCustomers.jsp">View Customers</a>
            <a href="modifyCustomer.jsp">Modify Customer</a>
            <a href="logout.jsp" class="logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h2>Delete Customer</h2>
        <%
            String error = request.getParameter("error");
            if (error != null) {
                if (error.equals("balance_not_zero")) {
                    out.println("<p class='error'>Cannot delete customer: Balance is not zero.</p>");
                } else if (error.equals("account_not_found")) {
                    out.println("<p class='error'>Cannot delete customer: Account not found.</p>");
                } else {
                    out.println("<p class='error'>An error occurred. Please try again.</p>");
                }
            }
        %>
        <form action="DeleteCustomerServlet" method="post">
            Account No: <input type="text" name="accountNo" required><br>
            <input type="submit" value="Delete">
        </form>
    </div>
</body>
</html>
