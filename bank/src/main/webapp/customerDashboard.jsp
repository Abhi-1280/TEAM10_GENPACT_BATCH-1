<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*, java.io.*, java.sql.*" %>

<%
    // Check if user is logged in
    if (session == null || session.getAttribute("accountNo") == null) {
        response.sendRedirect("customerLogin.jsp");
    }

    String accountNo = (String) session.getAttribute("accountNo");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/bank__db", "root", "root");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM customer WHERE account_no=?");
        ps.setString(1, accountNo);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            String fullName = rs.getString("full_name");
            double balance = rs.getDouble("current_balance");
%>
<html>
<head>
    <title>Customer Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
            
            background-size: cover;
            position: relative;
        }
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(255, 255, 255, 0.8);
            display: flex;
            flex-direction: column;
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
            max-width: 900px;
            margin: 20px auto;
            padding: 20px;
             background: url('main.gif') no-repeat center center fixed 0.9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            animation: slideIn 2s; /* Animation added */
             animation: slideIn 2s; /* Animation added */
            
        }
        
        h2 {
            text-align: center;
        }
        .info {
            margin-bottom: 20px;
        }
        .buttons {
            margin-top: 50px;
            text-align: center;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }
        .buttons .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 250px; /* Adjusted width for better alignment */
            margin: 10px;
            animation: slideIn 2s;
            background-color: rgba(252, 249, 251, 0.92);
        }
        .buttons .button-container img {
            height: 150px; /* Fixed height for consistency */
            width: 200px; /* Fixed width for consistency */
            margin-bottom: 15px; /* Space between image and text */
        }
        .buttons .button-container a {
            background-color: #007bff; /* Sky blue buttons */
            color: #fff;
            padding: 15px 20px;
            text-decoration: none;
            border-radius: 5px;
            text-align: center;
            width: 100%; /* Button width matches container width */
            font-size: 16px;
            margin:10px;
        }
        .buttons .button-container a:hover {
            background-color: #0056b3; /* Darker blue hover effect */
            transform: scale(1.1);
            transition: transform 0.3s;
        }
    </style>
    <script>
    window.history.pushState(null, "", window.location.href);
    window.onpopstate = function() {
        window.history.pushState(null, "", window.location.href);
    };
    </script>
</head>
<body>
<div class="navbar">
    <a href="#" class="logo"><img src="logo1.png" alt="Logo"></a>
    <a href="logoutcust.jsp" class="logout">Logout</a>
</div>

<div class="container">
    <h2>Welcome, <%= fullName %></h2>
    <div class="info">
        <p><strong>Account Number:</strong> <%= accountNo %></p>
        <p><strong>Balance:</strong> <%= balance %></p>
    </div>
    <div class="buttons">
        <div class="button-container">
            <img src="dep.gif" alt="Deposit" height="150" width="200">
            <a href="transaction.jsp">Deposit/Withdraw</a>
        </div>
        <div class="button-container">
            <img src="up.gif" alt="Update Profile" height="150" width="200">
            <a href="profile.jsp">Update Profile Preference</a>
        </div>
        <div class="button-container">
            <img src="transach.gif" alt="Transaction History" height="150" width="200">
            <a href="transactionHistory.jsp">Transaction History</a>
        </div>
        <div class="button-container">
            <img src="trans.gif" alt="Transfer Money" height="150" width="200">
            <a href="transferMoney.jsp">Transfer Money</a>
        </div>
        <div class="button-container">
            <img src="spen.gif" alt="Spend Analyzer" height="150" width="200">
            <a href="spendAnalyzer.jsp">Spend Analyzer</a>
        </div>
        <div class="button-container">
            <img src="del.gif" alt="Delete Account" height="150" width="150">
            <a href="deleteAccount.jsp">Delete Account</a>
        </div>
    </div>
</div>

</body>
</html>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
