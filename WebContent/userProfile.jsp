<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="com.aaryan.service.impl.*, com.aaryan.service.*,com.aaryan.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Details - TapBasket</title>

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/tapbasket.css">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        .profile-container {
            margin-top: 120px;
            margin-bottom: 50px;
        }

        .profile-title {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
            font-weight: 600;
            color: var(--primary-color);
        }

        .profile-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 25px;
            overflow: hidden;
        }

        .profile-header {
            padding: 20px;
            text-align: center;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        }

        .profile-body {
            padding: 20px;
        }

        .profile-image {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            margin: 0 auto 15px;
            border: 5px solid rgba(0, 123, 255, 0.1);
        }

        .profile-name {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .profile-row {
            display: flex;
            margin-bottom: 15px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            padding-bottom: 15px;
        }

        .profile-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .profile-label {
            flex: 0 0 30%;
            font-weight: 600;
            color: #333;
        }

        .profile-value {
            flex: 0 0 70%;
            color: #666;
        }

        .breadcrumb {
            display: flex;
            list-style: none;
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .breadcrumb-item {
            margin-right: 10px;
        }

        .breadcrumb-item:not(:last-child)::after {
            content: '/';
            margin-left: 10px;
            color: #ccc;
        }

        .breadcrumb-item a {
            color: var(--primary-color);
            text-decoration: none;
        }

        .breadcrumb-item a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <% /* Checking the user credentials */ 
    String userName=(String) session.getAttribute("username"); 
    String password=(String) session.getAttribute("password"); 
    if (userName==null || password==null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!"); 
    } 
    
    UserService dao=new UserServiceImpl(); 
    UserBean user=dao.getUserDetails(userName, password); 
    if (user==null) 
        user=new UserBean("Test User", 98765498765L, "test@gmail.com", "ABC colony, Patna, bihar", 87659, "lksdjf");
    %>

    <jsp:include page="header.jsp" />

    <div class="container profile-container">
        <div class="row">
            <div class="col-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="userHome.jsp">Home</a></li>
                        <li class="breadcrumb-item">User Profile</li>
                    </ol>
                </nav>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4">
                <div class="profile-card">
                    <div class="profile-header">
                        <img src="images/profile.jpg" class="profile-image">
                        <h5 class="profile-name">Hello <%=user.getName()%> here!</h5>
                    </div>
                </div>
                <div class="profile-card">
                    <div class="profile-header">
                        <h2 class="profile-title">My Profile</h2>
                    </div>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="profile-card">
                    <div class="profile-body">
                        <div class="profile-row">
                            <div class="profile-label">Full Name</div>
                            <div class="profile-value"><%=user.getName()%></div>
                        </div>
                        <div class="profile-row">
                            <div class="profile-label">Email</div>
                            <div class="profile-value"><%=user.getEmail()%></div>
                        </div>
                        <div class="profile-row">
                            <div class="profile-label">Phone</div>
                            <div class="profile-value"><%=user.getMobile()%></div>
                        </div>
                        <div class="profile-row">
                            <div class="profile-label">Address</div>
                            <div class="profile-value"><%=user.getAddress()%></div>
                        </div>
                        <div class="profile-row">
                            <div class="profile-label">PinCode</div>
                            <div class="profile-value"><%=user.getPinCode()%></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="footer.html" %>
</body>

</html>
