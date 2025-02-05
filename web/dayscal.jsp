<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*, java.time.LocalDate, day.DateUtils" session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your Details</title>
    <link rel="stylesheet" href="main1.css">
</head>
<body>
<%
    Connection conn = null;
    Statement ps = null;
    PreparedStatement ps1 = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MMSUser", "root", "password");

        String selectSql = "SELECT * FROM issue WHERE issue_status <> 'Completed' OR status_byempolyee <> 'Completed'";
        ps = conn.createStatement();
        ResultSet rs = ps.executeQuery(selectSql);
        while (rs.next()) {
            LocalDate fromDate = rs.getDate("issuedDate").toLocalDate(); // Assuming issuedDate is a date column in your database
            int days = DateUtils.daysUntilPresent(fromDate);

            String updateSql = "UPDATE issue SET pendingfrom = ? WHERE issuedDate = ?";
            ps1 = conn.prepareStatement(updateSql);
            ps1.setInt(1, days);
            ps1.setDate(2, java.sql.Date.valueOf(fromDate));
            ps1.executeUpdate();
        }
        response.sendRedirect("postedpenIssues.jsp"); // Redirect after processing
    } catch (SQLException | ClassNotFoundException ex) {
        ex.printStackTrace();
    } finally {
        try {
            if (ps1 != null) ps1.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
</body>
</html>
