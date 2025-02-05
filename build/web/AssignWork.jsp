<%@ page contentType="text/html; charset=UTF-8" import="java.sql.*,java.io.*" session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Your Details</title>
    <link rel="stylesheet" href="main1.css">
</head>
<body>
<%
    String issue_id = request.getParameter("id");
    String tech = request.getParameter("tech");
    
    // Validate inputs
    if (issue_id != null && !issue_id.isEmpty() && tech != null && !tech.isEmpty()) {
        try {
            // Establish connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/MMSUser", "root", "password")) {
                // Prepare and execute query to get technician_id
                String selectTechnicianIdQuery = "SELECT technician_id FROM technician WHERE technician_registerId = ?";
                try (PreparedStatement ps = conn.prepareStatement(selectTechnicianIdQuery)) {
                    ps.setString(1, tech);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            String technician_id = rs.getString("technician_id");
                            
                            // Prepare and execute update query
                            String updateIssueQuery = "UPDATE issue SET technician_id = ?,issue_status='In Progress' WHERE issue_id = ?";
                            try (PreparedStatement psUpdate = conn.prepareStatement(updateIssueQuery)) {
                                psUpdate.setString(1, technician_id);
                                psUpdate.setString(2, issue_id);
                                int rowsAffected = psUpdate.executeUpdate();
                                if (rowsAffected > 0) {
                                    response.sendRedirect("inchargehome.html");
                                } else {
                                    out.println("Failed to update issue.");
                                }
                            }
                        } else {
                            out.println("Technician not found.");
                        }
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("An error occurred. Please try again later.");
        }
    } else {
        out.println("Invalid input parameters.");
    }
%>
</body>
</html>
