<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*,java.sql.*" %>

<%
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("adminLogin.jsp");
    }
%>

<html>
<head>
    <title>Modify Customer</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f2f2f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .navbar {
            overflow: hidden;
            background-color: #333;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 20px;
            width: 100%;
            position: fixed;
            top: 0;
            z-index: 1000;
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
            margin-top: 500px;/* Adjust to leave space for the navbar */
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            width: 100%;
        }
        .form-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 500px;
            text-align: center;
            margin: 20px;
        }
        h2 {
            color: #333;
            margin-top: 0;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        label {
            margin: 10px 0;
            font-weight: bold;
        }
        input[type="text"],
        input[type="email"],
        input[type="date"],
        select {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            width: 100%;
            background-color: #4CAF50;
            color: white;
            padding: 12px 20px;
            margin: 10px 0;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
        .success {
            color: green;
        }
    </style>
    <script>
        function showSuccessMessage() {
            alert("Customer details have been successfully modified.");
        }
    </script>
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
        <div class="form-container">
            <h2>Modify Customer</h2>
            <%
                String error = request.getParameter("error");
                String success = request.getParameter("success");
                if (error != null) {
                    out.println("<p class='error'>An error occurred. Please try again.</p>");
                }
                if (success != null) {
            %>
                <script>
                    showSuccessMessage();
                </script>
            <%
                }
            %>
            <form action="ModifyCustomerServlet" method="post">
                <label for="accountNo">Account No:</label>
                <input type="text" id="accountNo" name="accountNo" required>

                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required>

                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>

                <label for="mobileNo">Mobile No:</label>
                <input type="text" id="mobileNo" name="mobileNo" required>

                <label for="emailId">Email ID:</label>
                <input type="email" id="emailId" name="emailId" required>

                <label for="accountType">Account Type:</label>
                <select id="accountType" name="accountType" required>
                    <option value="Saving">Saving</option>
                    <option value="Current">Current</option>
                </select>

                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" required>

                <label for="idProof">ID Proof:</label>
                <input type="text" id="idProof" name="idProof" required>

                <input type="submit" value="Modify">
            </form>
        </div>
    </div>
</body>
</html>
