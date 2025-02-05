<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*,java.sql.*,java.text.*,java.util.*" session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your Details</title>
    <link rel="stylesheet" href="main1.css">
</head>
<body>
    <%
String issue_id= request.getParameter("id");
String rbi = request.getParameter("remarksByIn");

if (rbi != null && issue_id != null ) {
                Connection conn = null;
                Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MMSUser", "root", "password");
            
        PreparedStatement ps1 = null;
        try {
            // Update logic to update remarks, feedback, and status
            String sql2 = "UPDATE issue SET remarksByIn=? WHERE issue_id=?";
            ps1 = conn.prepareStatement(sql2);
            ps1.setString(1, rbi);
            ps1.setString(2, issue_id);
            
            ps1.executeUpdate();
            response.sendRedirect("postedpenIssuesIn.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close resources
            try {
                if (ps1 != null) ps1.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

%>
</body>