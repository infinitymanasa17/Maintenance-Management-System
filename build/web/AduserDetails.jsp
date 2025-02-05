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
            <div class="profinr-icon">
                <a href="userDetails.jsp"><img src="/MMS/images/pro.png" alt="Profile Icon" width="120"></a> 
    </div>
        <h1>MAINTENANCE MANAGEMENT SYSTEM</h1>
        <center><p><em>Track your Maintenance Issues status with ease.</em></p></center>
        <nav style="text-align: center;">
            <ul>
                <li>Logged In As Admin</li>
                </ul>
        </nav>
        <button id="logoutButton" style="position: fixed; top: 10px; right: 10px; padding: 10px; background-color: #f5f5f5; color: #3b3c36; cursor: pointer;" onclick="window.location.href='logout.jsp';"><b>Logout</b></button>
    </header>
        <%
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                // Establish connection 
                Class.forName("com.mysql.cj.jdbc.Driver");
                
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MMSUser", "root", "password");

                // Creating the SQL statement
                String sql = "SELECT * FROM Admins WHERE Admins_id="+ session.getAttribute("AdminsId");
                ps = conn.prepareStatement(sql);
                //out.println(rs);
                // Executing the query
                rs = ps.executeQuery();
                while(rs.next()){
            %>
                <section class="hero"><div class="container" style=" margin: 1% 35% 5% 35%; width: 400px;">
                        <form name="user">
                        <label for="Name">Your Name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;</label><input type="text" name="Name" value="<%=rs.getString("Admins_name")%>" readonly/><br>
                        <label for="Password">Your Password:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;</label><input type="text" name="Password" value="<%=rs.getString("Admins_password")%>" readonly/><br>
                        <label for="Registration Id">Your Registration Id:&nbsp;&nbsp; </label><input type="text" name="Registration Id" value="<%=rs.getString("Admins_registerId")%>" readonly/><br>
                        <label for="Designation">Your Designation:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label><input type="text" name="Designation" value="<%=rs.getString("Admins_designation")%>" readonly/><br>
                        <label for="Email">Your Email:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label><input type="text" name="Email" value="<%=rs.getString("Admins_emailId")%>" readonly/><br>
                        <label for="Phone Number">Your Phone Number:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </label><input type="text" name="Phone Number" value="<%=rs.getString("Admins_phno")%>" readonly/><br>
                        </form></div></section>
            <%
                }
}
catch (SQLException e) {
                e.printStackTrace();
            } finally {
                // Closing resources
                try {
                    if (ps != null) ps.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            %>
        <br>
<footer>
        <p>&copy; 2024 Maintenance Management System. All rights reserved.</p>
    </footer>
         </body>
</html>
