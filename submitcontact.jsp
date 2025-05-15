<%@ page import="java.sql.*, java.util.*, jakarta.mail.*, jakarta.mail.internet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.sql.*" %>
<%
  String fullname = request.getParameter("fullname");
  String email = request.getParameter("email");
  String message = request.getParameter("message");

  String jdbcURL = "jdbc:mysql://localhost:3306/contact";
  String dbUser  = "root";
  String dbPass  = "";

  Connection conn = null;
  PreparedStatement stmt = null;
  String result = "error";

  try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection(jdbcURL, dbUser, dbPass);

    String sql = "INSERT INTO contact_messages (fullname, email, message) VALUES (?, ?, ?)";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, fullname);
    stmt.setString(2, email);
    stmt.setString(3, message);

    int rowsInserted = stmt.executeUpdate();
    if (rowsInserted > 0) {
      result = "success";
    }
  } catch (Exception e) {
    result = "Database error: " + e.getMessage();
  } finally {
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
  }

  out.print(result);
%>


