<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="com.aaryan.service.impl.CartServiceImpl" %>
<%@ page import="com.aaryan.service.impl.ProductServiceImpl" %>
<%@ page import="com.aaryan.service.*" %>
<%@ page import="com.aaryan.beans.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TapBasket</title>

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/tapbasket.css">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Google Fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">

    <style>
        /* Enhanced header styles */
        .header {
            background: linear-gradient(135deg, #0056b3, #007bff);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            transition: all 0.3s ease;
            height: 70px;
            display: flex;
            align-items: center;
        }

        .header-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 1.8rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
            transition: all 0.3s ease;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            letter-spacing: 0.5px;
        }

        .logo:hover {
            transform: scale(1.05);
            text-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .logo i {
            margin-right: 10px;
            font-size: 1.5em;
            color: #ffcc00;
        }

        .nav {
            display: flex;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-item {
            margin-left: 25px;
            position: relative;
        }

        .nav-link {
            color: white;
            font-weight: 500;
            padding: 8px 0;
            display: inline-block;
            position: relative;
            text-decoration: none;
            transition: all 0.3s ease;
            letter-spacing: 0.5px;
        }

        .nav-link:after {
            content: '';
            position: absolute;
            width: 0;
            height: 3px;
            bottom: 0;
            left: 0;
            background-color: #ffcc00;
            transition: width 0.3s ease;
            border-radius: 3px;
        }

        .nav-link:hover {
            color: white;
            transform: translateY(-2px);
        }

        .nav-link:hover:after {
            width: 100%;
        }

        .nav-link.active {
            font-weight: 700;
            color: white;
            position: relative;
        }

        .nav-link.active:after {
            width: 100%;
            height: 3px;
            background-color: #ffcc00;
        }

        .nav-link.active:before {
            content: '';
            position: absolute;
            top: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-left: 6px solid transparent;
            border-right: 6px solid transparent;
            border-top: 6px solid #ffcc00;
        }

        .cart-icon {
            position: relative;
        }

        .cart-badge {
            position: absolute;
            top: -8px;
            right: -8px;
            background-color: #ffcc00;
            color: #0056b3;
            font-size: 0.7rem;
            font-weight: 700;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .mobile-menu-toggle {
            display: none;
            background: none;
            border: none;
            color: white;
            font-size: 1.5rem;
            cursor: pointer;
        }

        /* Admin quick actions */
        .admin-quick-actions {
            position: relative;
        }

        .admin-quick-actions .nav-link {
            display: flex;
            align-items: center;
        }

        .admin-quick-actions .nav-link i {
            margin-right: 5px;
        }

        .admin-actions-menu {
            position: absolute;
            top: 100%;
            right: 0;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
            width: 200px;
            padding: 10px 0;
            display: none;
            z-index: 1000;
            transform: translateY(10px);
            opacity: 0;
            transition: all 0.3s ease;
        }

        .admin-quick-actions:hover .admin-actions-menu {
            display: block;
            transform: translateY(0);
            opacity: 1;
        }

        .admin-action-item {
            display: flex;
            align-items: center;
            padding: 10px 15px;
            color: #333;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .admin-action-item:hover {
            background-color: #f5f5f5;
            color: #007bff;
        }

        .admin-action-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        /* Brand header styles */
        .brand-header {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 15px 0;
            margin-top: 70px;
            color: #333;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .brand-title {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 5px;
            color: #0056b3;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }

        .brand-subtitle {
            font-size: 1rem;
            opacity: 0.9;
            margin-bottom: 15px;
            color: #555;
        }

        .search-container {
            max-width: 600px;
            margin: 0 auto;
        }

        .search-input-group {
            display: flex;
            position: relative;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 50px;
            overflow: hidden;
        }

        .search-input {
            flex: 1;
            padding: 15px 20px;
            border: none;
            border-radius: 50px 0 0 50px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            box-shadow: inset 0 0 0 2px #007bff;
        }

        .search-button {
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 0 50px 50px 0;
            padding: 0 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
            display: flex;
            align-items: center;
        }

        .search-button:hover {
            background-color: #0056b3;
            transform: translateX(2px);
        }

        .search-button i {
            margin-right: 8px;
        }

        /* Responsive styles */
        @media (max-width: 992px) {
            .mobile-menu-toggle {
                display: block;
            }

            .nav {
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                background-color: #0056b3;
                flex-direction: column;
                padding: 20px;
                display: none;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
            }

            .nav.active {
                display: flex;
            }

            .nav-item {
                margin: 10px 0;
            }

            .admin-actions-menu {
                position: static;
                box-shadow: none;
                width: 100%;
                margin-top: 10px;
                padding: 0;
                background-color: transparent;
            }

            .admin-action-item {
                color: white;
            }

            .admin-action-item:hover {
                background-color: rgba(255, 255, 255, 0.1);
                color: white;
            }
        }
    </style>
</head>

<body>
    <% /* Checking the user credentials */ 
    String userType=(String)session.getAttribute("usertype"); 
    String username=(String)session.getAttribute("username"); 
    int notf=0; 
    if (username !=null) {
        CartServiceImpl cartService=new CartServiceImpl();
        notf=cartService.getCartCount(username); 
    } 
    String currentPage=request.getRequestURI();
    currentPage=currentPage.substring(currentPage.lastIndexOf("/") + 1); 
    %>

    <!-- Main Navigation -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <% if (userType==null) { %>
                    <a href="index.jsp" class="logo">
                        <i class="fas fa-shopping-basket"></i>
                        <span>TapBasket</span>
                    </a>
                <% } else if ("customer".equalsIgnoreCase(userType)) { %>
                    <a href="userHome.jsp" class="logo">
                        <i class="fas fa-shopping-basket"></i>
                        <span>TapBasket</span>
                    </a>
                <% } else { %>
                    <a href="adminViewProduct.jsp" class="logo">
                        <i class="fas fa-shopping-basket"></i>
                        <span>TapBasket Admin</span>
                    </a>
                <% } %>

                <button class="mobile-menu-toggle" id="mobileMenuToggle">
                    <i class="fas fa-bars"></i>
                </button>

                <ul class="nav" id="mainNav">
                    <% if (userType==null) { %>
                        <!-- Logged Out Navigation -->
                        <li class="nav-item">
                            <a href="index.jsp" class="nav-link <%= "index.jsp".equals(currentPage) ? "active" : "" %>">Home</a>
                        </li>
                        <li class="nav-item">
                            <a href="login.jsp" class="nav-link <%= "login.jsp".equals(currentPage) ? "active" : "" %>">Login</a>
                        </li>
                        <li class="nav-item">
                            <a href="register.jsp" class="nav-link <%= "register.jsp".equals(currentPage) ? "active" : "" %>">Register</a>
                        </li>
                    <% } else if ("customer".equalsIgnoreCase(userType)) { %>
                        <!-- Customer Navigation -->
                        <li class="nav-item">
                            <a href="userHome.jsp" class="nav-link <%= "userHome.jsp".equals(currentPage) ? "active" : "" %>">Home</a>
                        </li>
                        <li class="nav-item">
                            <a href="cartDetails.jsp" class="nav-link cart-icon <%= "cartDetails.jsp".equals(currentPage) ? "active" : "" %>">
                                <i class="fas fa-shopping-cart"></i>
                                <% if (notf> 0) { %>
                                    <span class="cart-badge"><%= notf %></span>
                                <% } %>
                                Cart
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="orderDetails.jsp" class="nav-link <%= "orderDetails.jsp".equals(currentPage) ? "active" : "" %>">Orders</a>
                        </li>
                        <li class="nav-item">
                            <a href="userProfile.jsp" class="nav-link <%= "userProfile.jsp".equals(currentPage) ? "active" : "" %>">Profile</a>
                        </li>
                        <li class="nav-item">
                            <a href="./LogoutSrv" class="nav-link">Logout</a>
                        </li>
                    <% } else { %>
                        <!-- Admin Navigation -->
                        <li class="nav-item">
                            <a href="adminViewProduct.jsp" class="nav-link <%= "adminViewProduct.jsp".equals(currentPage) ? "active" : "" %>">Products</a>
                        </li>
                        <li class="nav-item">
                            <a href="adminStock.jsp" class="nav-link <%= "adminStock.jsp".equals(currentPage) ? "active" : "" %>">Stock</a>
                        </li>
                        <li class="nav-item">
                            <a href="unshippedItems.jsp" class="nav-link <%= "unshippedItems.jsp".equals(currentPage) ? "active" : "" %>">Orders</a>
                        </li>
                        <li class="nav-item">
                            <a href="shippedItems.jsp" class="nav-link <%= "shippedItems.jsp".equals(currentPage) ? "active" : "" %>">Shipped</a>
                        </li>
                        <li class="nav-item admin-quick-actions">
                            <a href="#" class="nav-link <%= "addProduct.jsp".equals(currentPage) || "removeProduct.jsp".equals(currentPage) || "updateProductById.jsp".equals(currentPage) ? "active" : "" %>">
                                <i class="fas fa-cog"></i> Manage Products
                            </a>
                            <div class="admin-actions-menu">
                                <a href="addProduct.jsp" class="admin-action-item <%= "addProduct.jsp".equals(currentPage) ? "active" : "" %>">
                                    <i class="fas fa-plus-circle"></i> Add Product
                                </a>
                                <a href="removeProduct.jsp" class="admin-action-item <%= "removeProduct.jsp".equals(currentPage) ? "active" : "" %>">
                                    <i class="fas fa-trash-alt"></i> Remove Product
                                </a>
                                <a href="updateProductById.jsp" class="admin-action-item <%= "updateProductById.jsp".equals(currentPage) ? "active" : "" %>">
                                    <i class="fas fa-edit"></i> Update Product
                                </a>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a href="./LogoutSrv" class="nav-link">Logout</a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </header>

    <!-- Brand Header with Search -->
    <div class="brand-header">
        <div class="container">
            <h1 class="brand-title">TapBasket</h1>
            <p class="brand-subtitle">Your one-stop destination for all electronic needs</p>

            <div class="search-container">
                <form action="<%= userType == null ? "index.jsp" : (userType.equals("customer") ? "userHome.jsp" : "adminViewProduct.jsp" ) %>" method="get">
                    <div class="search-input-group">
                        <input type="text" name="search" class="search-input" placeholder="Search for products..." required>
                        <button type="submit" class="search-button">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- JavaScript for Mobile Menu -->
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Mobile menu toggle
            const mobileMenuToggle = document.getElementById('mobileMenuToggle');
            if (mobileMenuToggle) {
                mobileMenuToggle.addEventListener('click', function () {
                    document.getElementById('mainNav').classList.toggle('active');
                });
            }

            // Make header visible on scroll
            const header = document.querySelector('.header');
            window.addEventListener('scroll', function () {
                if (window.scrollY > 100) {
                    header.style.background = 'linear-gradient(135deg, #004494, #0066cc)';
                } else {
                    header.style.background = 'linear-gradient(135deg, #0056b3, #007bff)';
                }
            });
        });
    </script>
</body>

</html>
