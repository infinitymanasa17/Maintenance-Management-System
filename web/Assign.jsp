
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
        <a href="InuserDetails.jsp"><img src="/MMS/images/pro.png" alt="Profile Icon" width="120"></a> 
    </div>
    <h1>MAINTENANCE MANAGEMENT SYSTEM</h1>
    <center><p><em>Track your Maintenance Issues status with ease.</em></p></center>
    <nav style="text-align: center;">
        <ul>
            <li>Logged In As Incharge</li>
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
            <th>Issue Pending From (days)</th>
            <th>Issue Completed Date</th>
            <th>Issue Completed In(days)</th>
            <th> Update</th>
        </tr>
        <% 
        Connection conn = null;
        Statement ps = null;
        ResultSet rs = null, rs1=null;
        Statement stmt1=null;
        
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MMSUser", "root", "password");
           int i=1; 
            // Fetch issues assigned to the current employee
String sql = "SELECT * FROM issue WHERE issue_status='To Be Assigned'";
            ps = conn.createStatement();
            
            rs = ps.executeQuery(sql);
            
            // Get the number of rows in the ResultSet
           
            // Iterate over the ResultSet to display issue details in the table
            while (rs.next()) {
        %>
        <tr>
            <td><%= i++ %></td>
            <form name="edit" method="get" action="AssignWork.jsp" >
            <td><%= rs.getString("issue_category") %></td>
            <td><%= rs.getString("issue_description") %></td>
            <% session.setAttribute("technicianAssginId", rs.getInt("technician_id")); %>
            <td><select name="tech" id="tech"><%String sql1 = "SELECT technician_registerId FROM technician";
            stmt1 = conn.createStatement();
            rs1 = stmt1.executeQuery(sql1);
            while(rs1.next()){
            %><option value="<%=rs1.getString("technician_registerId")%>"><%=rs1.getString("technician_registerId")%></option>
              <%  }%>
</td>       
            <td><%= rs.getString("issue_status") %></td>
            <td><%= rs.getString("remarksByEmp") %></td>
            <td><%= rs.getString("feedbackByEmp") %></td>
            <td><%= rs.getString("status_byempolyee") %></td>
            <td><%= rs.getString("remarksByIn") %></td>
            <td><%= rs.getString("issuedDate") %></td>
            <td><%= rs.getString("assignedDate") %></td>
            <td><%= rs.getString("pendingfrom") %></td>
            <td><%= rs.getString("completedDate") %></td>
            <td><%= rs.getString("completedindays") %></td>
            <td><input type="submit" name="submit" value="update"/></td>
            <input type="hidden" name="id" value="<%=rs.getInt("issue_id")%>"/>
    </form>
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
<script type="text/javascript">
    function verify(){
        var a = edit.status_byempolyee.value;
        if (a.equals("In Progress") || a.equals("Completed") || a.equals("To Be Resolved") || a.equals("Incomplete")) {
            return true;
        } else {
            alert("Please enter correct status. Status By You takes only 'In Progress, Completed, To Be Resolved, Incomplete' values only!!!");
            return false; 
        }
    }
</script>

<footer>
    <p>&copy; 2024 Maintenance Management System. All rights reserved.</p>
</footer>
</body>
</html>