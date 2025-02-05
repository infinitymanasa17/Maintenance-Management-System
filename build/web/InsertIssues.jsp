<%@ page contentType="text/html; charset=UTF-8" import="java.io.*,java.sql.*,java.text.*,java.util.*" session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your Details</title>
    <link rel="stylesheet" href="main1.css">
</head>
<body>
    <%

    String category = request.getParameter("Category");
    String description = request.getParameter("description");
    Connection conn = null;
    PreparedStatement ps1 = null;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MMSUser", "root", "password");
        String sql = "INSERT INTO issue (issue_category, issue_description, employee_id, issuedDate, issue_status) VALUES (?, ?, ?, ?, 'To Be Assigned')";
        ps1 = conn.prepareStatement(sql);
        ps1.setString(1, category);
        ps1.setString(2, description);
        ps1.setString(3, session.getAttribute("employeeId").toString());
        ps1.setDate(4, new java.sql.Date(currentDate.getTime())); // Use setDate for SQL date
        ps1.executeUpdate();
        response.sendRedirect("postIssues.jsp");
    } catch (SQLException | ClassNotFoundException ex) {
        ex.printStackTrace();
    } finally {
        try {
            if (ps1 != null) ps1.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    %>
</body>
</html>
