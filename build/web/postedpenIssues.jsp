
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
            <th>Issue Pending From (days)</th>
            <th>Issue Completed Date</th>
            <th>Issue Completed In(days)</th>
            <th> Update</th>
        </tr>
        <% 
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        
        try {
            // Establish database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MMSUser", "root", "password");
           int i=1; 
            // Fetch issues assigned to the current employee
String sql = "SELECT * FROM issue WHERE employee_id=? AND (issue_status<>'Completed' OR status_byempolyee<>'Completed');";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, (int)session.getAttribute("employeeId"));
            rs = ps.executeQuery();
            
            // Get the number of rows in the ResultSet
           
            // Iterate over the ResultSet to display issue details in the table
            while (rs.next()) {
        %>
        <tr>
            <td><%= i++ %></td>
            <td><%= rs.getString("issue_category") %></td>
            <td><%= rs.getString("issue_description") %></td>
            <% session.setAttribute("technicianAssginedId", rs.getInt("technician_id")); %>
<td><a href="techDetails.jsp">Technician Details</a></td>
            <td><%= rs.getString("issue_status") %></td>
            <td><form name="edit" method="get" action="insertInDB.jsp" onsubmit="return verify()"><input type="text" name="remarksByEmp" value="<%= rs.getString("remarksByEmp") %>"/></td>
            <td><input type="text" name="feedbackByEmp" value="<%= rs.getString("feedbackByEmp") %>"/></td>
            <td><input type="text" name="status_byempolyee" value="<%= rs.getString("status_byempolyee") %>"/></td>
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