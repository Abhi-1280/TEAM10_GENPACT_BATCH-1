<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
            background: url('login.gif') no-repeat center center fixed;
            background-size: 700px;
            position: relative;
             background-position: center top ;
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
            width: auto;
        }
        .navbar .logout {
            float: right;
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
            padding: 20px;
            margin: auto;
            max-width: 400px;
            background-color: #333;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            margin-top: 100px;
            color: white;
        }
        h2 {
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
            background-color: #333;
            color: white;
        }
        form input[type="text"],
        form input[type="password"] {
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        form input[type="submit"] {
            padding: 10px;
            background-color: #007bff; /* Blue submit button */
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }
        form input[type="submit"]:hover {
            background-color: #0056b3; /* Darker blue hover effect */
        }
        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<div class="navbar">
    <a href="#" class="logo"><img src="logo1.png" alt="Logo"></a>
    <div>
        <a href="logoutcust.jsp" class="logout">Logout</a>
    </div>
</div>

<div class="container">
    <h2>Customer Login</h2>

    <% String errorMessage = (String) request.getAttribute("errorMessage");
       if (errorMessage != null && !errorMessage.isEmpty()) { %>
        <p class="error"><%= errorMessage %></p>
    <% } %>

    <form action="CustomerLoginServlet" method="post">
        Account No: <input type="text" name="accountNo" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Login">
    </form>
</div>
</body>
</html>
