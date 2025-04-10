<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - TapBasket</title>
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/tapbasket.css">
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        .login-container {
            max-width: 450px;
            margin: 30px auto 50px;
            padding: 30px;
            background-color: var(--card-color);
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-lg);
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .login-header .logo {
            font-size: 2rem;
            margin-bottom: 15px;
            display: inline-block;
        }
        
        .login-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 10px;
        }
        
        .login-subtitle {
            color: var(--text-secondary);
            margin-bottom: 20px;
        }
        
        .login-form .form-group {
            margin-bottom: 20px;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
        }
        
        .login-form .form-control {
            padding-left: 45px;
        }
        
        .user-type-selector {
            display: flex;
            margin-bottom: 25px;
            border-radius: var(--border-radius-md);
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        
        .user-type-option {
            flex: 1;
            padding: 12px;
            text-align: center;
            cursor: pointer;
            background-color: #f8f9fa;
            transition: all 0.3s ease;
            font-weight: 500;
            color: var(--text-secondary);
            border: none;
        }
        
        .user-type-option.active {
            background-color: var(--primary-color);
            color: white;
        }
        
        .user-type-option:first-child {
            border-radius: var(--border-radius-md) 0 0 var(--border-radius-md);
        }
        
        .user-type-option:last-child {
            border-radius: 0 var(--border-radius-md) var(--border-radius-md) 0;
        }
        
        .login-footer {
            text-align: center;
            margin-top: 25px;
            color: var(--text-secondary);
        }
        
        .login-footer a {
            color: var(--primary-color);
            font-weight: 500;
            text-decoration: none;
        }
        
        .login-footer a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />

    <!-- Login Form -->
    <div class="container">
        <div class="login-container">
            <div class="login-header">
                <h1 class="login-title">Welcome Back</h1>
                <p class="login-subtitle">Sign in to continue to TapBasket</p>
                
                <% 
                String message = request.getParameter("message");
                if (message != null) {
                %>
                    <div class="alert alert-info">
                        <%= message %>
                    </div>
                <% } %>
            </div>
            
            <form action="./LoginSrv" method="post" class="login-form">
                <div class="form-group">
                    <label for="username" class="form-label">Email Address</label>
                    <div class="input-group">
                        <i class="fas fa-envelope input-icon"></i>
                        <input type="email" id="username" name="username" class="form-control" placeholder="Enter your email" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password" class="form-label">Password</label>
                    <div class="input-group">
                        <i class="fas fa-lock input-icon"></i>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label">Login As</label>
                    <div class="user-type-selector">
                        <input type="radio" name="usertype" id="customer" value="customer" checked style="display: none;">
                        <label for="customer" class="user-type-option active" id="customerLabel">
                            <i class="fas fa-user"></i> Customer
                        </label>
                        
                        <input type="radio" name="usertype" id="admin" value="admin" style="display: none;">
                        <label for="admin" class="user-type-option" id="adminLabel">
                            <i class="fas fa-user-shield"></i> Admin
                        </label>
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary btn-block">Sign In</button>
            </form>
            
            <div class="login-footer">
                <p>Don't have an account? <a href="register.jsp">Sign Up</a></p>
            </div>
        </div>
    </div>

    <%@ include file="footer.html" %>

    <!-- JavaScript -->
    <script>
        // User type selector
        document.addEventListener('DOMContentLoaded', function() {
            const customerLabel = document.getElementById('customerLabel');
            const adminLabel = document.getElementById('adminLabel');
            const customerRadio = document.getElementById('customer');
            const adminRadio = document.getElementById('admin');
            
            customerLabel.addEventListener('click', function() {
                customerRadio.checked = true;
                customerLabel.classList.add('active');
                adminLabel.classList.remove('active');
            });
            
            adminLabel.addEventListener('click', function() {
                adminRadio.checked = true;
                adminLabel.classList.add('active');
                customerLabel.classList.remove('active');
            });
        });
    </script>
</body>

</html>
