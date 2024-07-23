<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.List, java.util.ArrayList, com.bank.customer.Transaction" %>
<html>
<head>
    <title>Transaction History</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 800px;
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
            background-color: #007bff;
            color: white;
        }
        .download-button {
            text-align: center;
            margin-top: 20px;
        }
        .download-button a {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .download-button a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Transaction History</h2>
    <div class="download-button">
        <a href="DownloadPDFServlet" target="_blank">Download PDF</a>
    </div>
    <table>
        <thead>
            <tr>
                <th>Date</th>
                <th>Type</th>
                <th>Amount</th>
                <th>Balance</th>
            </tr>
        </thead>
        <tbody>
            <% 
                String accountNo = (String) session.getAttribute("accountNo");
                if (accountNo != null) {
                    List<Transaction> transactions = new ArrayList<>();
                    String url = "jdbc:mysql://localhost:3306/bank__db";
                    String user = "root";
                    String password = "root";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection(url, user, password);

                        String query = "SELECT * FROM transaction WHERE account_no = ? ORDER BY date DESC LIMIT 30";
                        PreparedStatement ps = con.prepareStatement(query);
                        ps.setString(1, accountNo);
                        ResultSet rs = ps.executeQuery();

                        while (rs.next()) {
                            Transaction transaction = new Transaction();
                            transaction.setId(rs.getInt("id"));
                            transaction.setAccountNo(rs.getString("account_no"));
                            transaction.setDate(rs.getTimestamp("date"));
                            transaction.setType(rs.getString("type"));
                            transaction.setAmount(rs.getDouble("amount"));
                            transaction.setBalance(rs.getDouble("balance"));
                            transactions.add(transaction);
                        }

                        rs.close();
                        ps.close();
                        con.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    for (Transaction transaction : transactions) {
            %>
                        <tr>
                            <td><%= transaction.getDate() %></td>
                            <td><%= transaction.getType() %></td>
                            <td><%= transaction.getAmount() %></td>
                            <td><%= transaction.getBalance() %></td>
                        </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
</div>
</body>
</html>
