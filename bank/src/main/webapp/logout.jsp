<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>

<%
if (session == null || session.getAttribute("username") == null) {
	session.invalidate(); 
    
}
    response.sendRedirect("adminLogin.jsp"); // Redirect to the admin login page
%>
