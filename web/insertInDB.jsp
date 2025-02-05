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
String rbe = request.getParameter("remarksByEmp");
String fbe = request.getParameter("feedbackByEmp");
String sbe = request.getParameter("status_byempolyee");

if (rbe != null && fbe != null && sbe != null && issue_id != null ) {
                Connection conn = null;
                Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MMSUser", "root", "password");
            
        PreparedStatement ps1 = null;
        try {
            // Update logic to update remarks, feedback, and status
            String sql2 = "UPDATE issue SET remarksByEmp=?, feedbackByEmp=?, status_byempolyee=? WHERE issue_id=?";
            ps1 = conn.prepareStatement(sql2);
            ps1.setString(1, rbe);
            ps1.setString(2, fbe);
            ps1.setString(3, sbe);
            ps1.setString(4, issue_id);
            ps1.executeUpdate();
            response.sendRedirect("postedpenIssues.jsp");
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