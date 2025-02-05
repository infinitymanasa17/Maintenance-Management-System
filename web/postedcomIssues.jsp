
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.io.*,java.sql.*,java.text.*,java.util.*" session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your Details</title>
    <link rel="stylesheet" href="main1.css">
    
</head>
<body>
<header>
    <!-- Header content -->
    <div class="profinr-icon">
        <a href="userDetails.jsp"><img src="/MMS/images/pro.png" alt="Profile Icon" width="120"></a> 
    </div>
    <h1>MAINTENANCE MANAGEMENT SYSTEM</h1>
    <center><p><em>Track your Maintenance Issues status with ease.</em></p></center>
    <nav style="text-align: center;">
        <ul>
            <li>Logged In As Employee</li>
        </ul>
    </nav>
    <button id="logoutButton" style="position: fixed; top: 10px; right: 10px; padding: 10px; background-color: #f5f5f5; color: #3b3c36; cursor: pointer;" onclick="window.location.href='logout.jsp';"><b>Logout</b></button>
</header>
<section class='hero'>
    <table align='center' border='1' id='tab'>
        <tr>
            <th>Issue Id</th>
            <th>Issue Category</th>
            <th>Issue Description</th>
            <th>Technician Assigned</th>
            <th>Issue Status</th>
            <th>Remarks By You</th>
            <th>Feedback By You</th>
            <th>Status given by You</th>
            <th>Remarks By Incharge</th>
            <th>Issue Posted Date</th>
            <th>Issue Assigned Date</th>
            <th>Issue Completed Date</th>
            <th>Issue Completed In(days)</th>
            
        </tr>
        <% 
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    // Establish database connection
    Class.forName("com.mysql.cj.jdbc.Driver");
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MMSUser", "root", "password");
    int i = 1; 
    // Fetch issues assigned to the current employee
String sql = "SELECT * FROM issue WHERE employee_id=" +session.getAttribute("employeeId")+" AND issue_status='Completed' AND status_byempolyee='Completed';";
ps = conn.prepareStatement(sql);

    // Assuming employeeId is stored as a String, change to setString
   
    rs = ps.executeQuery();
    // Iterate over the ResultSet to display issue details in the table
    while (rs.next()) {
%>
<tr>
    <td><%= rs.getInt("issue_id") %></td>
    <td><%= rs.getString("issue_category") %></td>
    <td><%= rs.getString("issue_description") %></td>
<% session.setAttribute("technicianAssginId", rs.getInt("technician_id")); %>

    <td><a href="techDetails.jsp">Technician Details</a></td>
    <td><%= rs.getString("issue_status") %></td>
    <td><%= rs.getString("remarksByEmp") %></td>
        <td><%= rs.getString("feedbackByEmp") %></td>
    <td><%= rs.getString("status_byempolyee") %></td> 
    <td><%= rs.getString("remarksByIn") %></td>
    <td><%= rs.getString("issuedDate") %></td>
    <td><%= rs.getString("assignedDate") %></td>
    <td><%= rs.getString("completedDate") %></td>
    <td><%= rs.getString("completedindays") %></td>
</tr>

<% 
    // Store issue ID in the id array
}
} catch (SQLException | ClassNotFoundException e) {
    e.printStackTrace();
} finally {
    // Close resources
    try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}
%>

        </table>
</section>


<footer>
    <p>&copy; 2024 Maintenance Management System. All rights reserved.</p>
</footer>
</body>
</html>