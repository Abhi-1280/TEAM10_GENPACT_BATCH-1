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

        // Example: Aggregate spending by category (simplified)
        PreparedStatement ps = con.prepareStatement("SELECT type, SUM(amount) AS total FROM transaction WHERE account_no=? GROUP BY type");
        ps.setString(1, accountNo);
        ResultSet rs = ps.executeQuery();
%>
<html>
<head>
    <title>Spend Analyzer</title>
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #007bff; /* Sky blue header */
            color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Spend Analyzer</h2>
    <table>
        <thead>
            <tr>
                <th>Category</th>
                <th>Total Amount</th>
            </tr>
        </thead>
        <tbody>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getString("type") %></td>
                <td><%= rs.getDouble("total") %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
</body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
