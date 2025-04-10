<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Remove Product - TapBasket</title>
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/tapbasket.css">
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        .remove-product-container {
            max-width: 500px;
            margin: 30px auto 50px;
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
        }
        
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .remove-product-header {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            padding: 25px 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .remove-product-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.2) 0%, rgba(255,255,255,0) 60%);
            animation: pulse 8s linear infinite;
        }
        
        @keyframes pulse {
            0% {
                transform: scale(1);
                opacity: 0.3;
            }
            50% {
                transform: scale(1.1);
                opacity: 0.5;
            }
            100% {
                transform: scale(1);
                opacity: 0.3;
            }
        }
        
        .remove-product-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
            position: relative;
            z-index: 1;
        }
        
        .remove-product-subtitle {
            font-size: 1rem;
            opacity: 0.9;
            margin-bottom: 0;
            position: relative;
            z-index: 1;
        }
        
        .remove-product-icon {
            font-size: 3rem;
            margin-bottom: 15px;
            animation: shake 5s ease-in-out infinite;
            display: inline-block;
        }
        
        @keyframes shake {
            0%, 100% {
                transform: rotate(0deg);
            }
            1%, 5% {
                transform: rotate(-5deg);
            }
            2%, 4% {
                transform: rotate(5deg);
            }
            3% {
                transform: rotate(-5deg);
            }
            50% {
                transform: rotate(0deg);
            }
        }
        
        .remove-product-body {
            padding: 30px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }
        
        .form-control:focus {
            border-color: #dc3545;
            box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.2);
            outline: none;
        }
        
        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        
        .btn-cancel {
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            text-decoration: none;
        }
        
        .btn-cancel:hover {
            background: linear-gradient(135deg, #5a6268, #343a40);
            transform: translateY(-2px);
        }
        
        .btn-remove {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 50px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
        }
        
        .btn-remove:hover {
            background: linear-gradient(135deg, #c82333, #bd2130);
            transform: translateY(-2px);
        }
        
        .btn-icon {
            margin-right: 8px;
        }
        
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 8px;
            animation: fadeIn 0.5s ease;
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }
        
        .alert-success {
            background-color: rgba(40, 167, 69, 0.1);
            border: 1px solid rgba(40, 167, 69, 0.2);
            color: #28a745;
        }
        
        .alert-danger {
            background-color: rgba(220, 53, 69, 0.1);
            border: 1px solid rgba(220, 53, 69, 0.2);
            color: #dc3545;
        }
        
        .input-group {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        
        .input-with-icon {
            padding-left: 45px;
        }
        
        .warning-text {
            color: #dc3545;
            font-size: 0.9rem;
            margin-top: 5px;
            display: flex;
            align-items: center;
        }
        
        .warning-text i {
            margin-right: 5px;
        }
    </style>
</head>

<body>
    <% 
    /* Checking the user credentials */
    String userType = (String) session.getAttribute("usertype");
    String userName = (String) session.getAttribute("username");
    String password = (String) session.getAttribute("password");
    
    if (userType == null || !userType.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
        return;
    } else if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        return;
    }
    
    String message = request.getParameter("message");
    %>

    <jsp:include page="header.jsp" />

    <div class="container">
        <div class="remove-product-container">
            <div class="remove-product-header">
                <i class="fas fa-trash-alt remove-product-icon"></i>
                <h1 class="remove-product-title">Remove Product</h1>
                <p class="remove-product-subtitle">Enter the product ID to remove it from inventory</p>
            </div>
            
            <div class="remove-product-body">
                <% if (message != null) { %>
                    <div class="alert <%= message.contains("Successfully") ? "alert-success" : "alert-danger" %>">
                        <i class="<%= message.contains("Successfully") ? "fas fa-check-circle" : "fas fa-exclamation-circle" %>"></i> <%= message %>
                    </div>
                <% } %>
                
                <form action="./RemoveProductSrv" method="post">
                    <div class="form-group">
                        <label for="productId" class="form-label">Product ID</label>
                        <div class="input-group">
                         
                            <input type="text" id="productId" name="prodid" class="form-control input-with-icon" placeholder="Enter product ID" required>
                        </div>
                        <p class="warning-text">
                            <i class="fas fa-exclamation-triangle"></i>
                            This action cannot be undone. The product will be permanently removed.
                        </p>
                    </div>
                    
                    <div class="form-actions">
                        <a href="adminViewProduct.jsp" class="btn-cancel">
                            <i class="fas fa-times btn-icon"></i> Cancel
                        </a>
                        <button type="submit" class="btn-remove">
                            <i class="fas fa-trash-alt btn-icon"></i> Remove Product
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="footer.html" %>
</body>

</html>
