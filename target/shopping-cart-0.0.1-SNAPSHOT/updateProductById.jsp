<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Product to Update - TapBasket</title>
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/tapbasket.css">
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        .search-product-container {
            max-width: 500px;
            margin: 120px auto 50px;
            padding: 30px;
            background-color: var(--card-color);
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-lg);
        }
        
        .search-product-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .search-product-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 10px;
        }
        
        .search-product-subtitle {
            color: var(--text-secondary);
            margin-bottom: 20px;
        }
        
        .search-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        
        @media (max-width: 768px) {
            .search-actions {
                flex-direction: column;
                gap: 10px;
            }
            
            .search-actions .btn {
                width: 100%;
            }
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
        response.sendRedirect("login.jsp?message=Access Denied, Login As Admin!!");
        return;
    } else if (userName == null || password == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        return;
    }
    
    String message = request.getParameter("message");
    %>

    <jsp:include page="header.jsp" />

    <div class="search-product-container">
        <div class="search-product-header">
            <h1 class="search-product-title">Find Product to Update</h1>
            <p class="search-product-subtitle">Enter the product ID to update its details</p>
            
            <% if (message != null) { %>
                <div class="alert alert-info">
                    <%= message %>
                </div>
            <% } %>
        </div>
        
        <form action="updateProduct.jsp" method="get">
            <div class="form-group">
                <label for="prodid" class="form-label">Product ID</label>
                <div class="input-group">
                    <i class="fas fa-barcode input-icon"></i>
                    <input type="text" id="prodid" name="prodid" class="form-control" placeholder="Enter product ID" required>
                </div>
            </div>
            
            <div class="search-actions">
                <a href="adminViewProduct.jsp" class="btn btn-danger">
                    <i class="fas fa-times"></i> Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-search"></i> Find Product
                </button>
            </div>
        </form>
    </div>

    <%@ include file="footer.html" %>
</body>

</html>
