<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Post an Issue</title>
	<link rel="stylesheet" href="main1.css">
        <script type="text/javascript">
            function verify(){
    var category = document.getElementById("category").value;
    var description = document.getElementById("description").value;
    if ( !category || !description  ) {
        alert("Please fill in all fields.");
        return false;
    }
    var confirmation = confirm("Are you sure you want to submit the issue?");
    if (confirmation) {
        document.getElementById("success-popup").style.display = "block";
        document.getElementById("issue-form").reset();
        setTimeout(function() {
            document.getElementById("success-popup").style.display = "none";
        }, 30000);
    }
    return true;
            }
</script>
</head>
<body>
    <header>
        <div class="profinr-icon">
                <a href="InuserDetails.jsp"><img src="/MMS/images/pro.png" alt="Profile Icon" width="120"></a> 
    </div>
    <h1>MAINTENANCE MANAGEMENT SYSTEM</h1>
        <center><p><em>Track your Maintenance Issues status with ease.</em></p></center>
        <nav style="text-align: center;">
            <ul>
                <li>Post An Issue</li>
                </ul>
        </nav>
        <button id="logoutButton" style="position: fixed; top: 10px; right: 10px; padding: 10px; background-color: #f5f5f5; color: #3b3c36; cursor: pointer;" onclick="window.location.href='logout.jsp';"><b>Logout</b></button>
    </header>
    <div class="container" style='margin: 5% 25% 10% 35%; width:500px; height: 400px;'>
        <center><h3 style='color: #fff' >POST ISSUE</h3></center>
    <form id="issue-form" method="get" onsubmit="return verify()" action="InsertIssuesIn.jsp">
        <center>
            <label for="Category">Select a Category:</label><br>
                <select name="Category" id="Category">
            <option value="Furniture">Furniture</option>
             <option value="Hardware">Hardware</option>
             <option value="Sanitation">Sanitation</option>
             <option value="Others">Others</option>
                </select><br><br>
                <label for="description">Description:</label><br>
        <textarea id="description" name="description" rows="4" required></textarea>
        <br><br>
        <input type="submit" value="Submit Issue"></center>
    </form>

    <!-- Popup window for successful submission -->
    <div id="success-popup" class="popup">
        <center><p style='color: #fff'>Issue submitted successfully!</p></center>
    </div>
</div>


<footer>
        <p>&copy; 2024 Maintenance Management System. All rights reserved.</p>
    </footer>

</body>
</html>