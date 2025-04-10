<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="com.aaryan.service.impl.*, com.aaryan.service.*, com.aaryan.beans.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product - TapBasket</title>
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/tapbasket.css">
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        .update-form-container {
            max-width: 800px;
            margin: 120px auto 50px;
            padding: 30px;
            background-color: var(--card-color);
            border-radius: var(--border-radius-lg);
            box-shadow: var(--shadow-lg);
        }
        
        .update-form-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .update-form-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 10px;
        }
        
        .product-preview {
            width: 120px;
            height: 120px;
            object-fit: contain;
            border-radius: var(--border-radius-md);
            background-color: #f5f5f5;
            padding: 10px;
            margin: 0 auto 20px;
            display: block;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-group {
            flex: 1;
        }
        
        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }
        
        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: var(--border-radius-md);
            font-size: 1rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(58, 134, 255, 0.2);
        }
        
        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }
        
        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        
        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
                gap: 10px;
            }
            
            .form-actions {
                flex-direction: column;
                gap: 10px;
            }
            
            .form-actions .btn {
                width: 100%;
            }
        }
    </style>
</head>

<body>
    <% 
    /* Checking the user credentials */ 
    String utype = (String) session.getAttribute("usertype");
    String uname = (String) session.getAttribute("username");
    String pwd = (String) session.getAttribute("password");
    String prodid = request.getParameter("prodid");
    
    ProductBean product = new ProductServiceImpl().getProductDetails(prodid);
    
    if (prodid == null || product == null) {
        response.sendRedirect("updateProductById.jsp?message=Please Enter a valid product Id");
        return;
    } else if (utype == null || !utype.equals("admin")) {
        response.sendRedirect("login.jsp?message=Access Denied, Login as admin!!");
        return;
    } else if (uname == null || pwd == null) {
        response.sendRedirect("login.jsp?message=Session Expired, Login Again!!");
        return;
    }
    
    String message = request.getParameter("message");
    %>

    <jsp:include page="header.jsp" />

    <div class="update-form-container">
        <div class="update-form-header">
            <img src="./ShowImage?pid=<%=product.getProdId()%>" alt="Product Image" class="product-preview">
            <h1 class="update-form-title">Update Product</h1>
            
            <% if (message != null) { %>
                <div class="alert alert-info">
                    <%= message %>
                </div>
            <% } %>
        </div>
        
        <form action="./UpdateProductSrv" method="post">
            <input type="hidden" name="pid" value="<%=product.getProdId()%>">
            
            <div class="form-row">
                <div class="form-group">
                    <label for="name" class="form-label">Product Name</label>
                    <input type="text" id="name" name="name" class="form-control" value="<%=product.getProdName()%>" placeholder="Enter Product Name" required>
                </div>
                
                <div class="form-group">
                    <label for="producttype" class="form-label">Product Type</label>
                    <select name="type" id="producttype" class="form-control" required>
                        <% String ptype = product.getProdType(); %>
                        <option value="mobile" <%="mobile".equalsIgnoreCase(ptype) ? "selected" : ""%>>Mobile</option>
                        <option value="tv" <%="tv".equalsIgnoreCase(ptype) ? "selected" : ""%>>TV</option>
                        <option value="camera" <%="camera".equalsIgnoreCase(ptype) ? "selected" : ""%>>Camera</option>
                        <option value="laptop" <%="laptop".equalsIgnoreCase(ptype) ? "selected" : ""%>>Laptop</option>
                        <option value="tablet" <%="tablet".equalsIgnoreCase(ptype) ? "selected" : ""%>>Tablet</option>
                        <option value="speaker" <%="speaker".equalsIgnoreCase(ptype) ? "selected" : ""%>>Speaker</option>
                        <option value="other" <%="other".equalsIgnoreCase(ptype) ? "selected" : ""%>>Other Appliances</option>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label for="info" class="form-label">Product Description</label>
                <textarea id="info" name="info" class="form-control" placeholder="Enter Product Description" required><%=product.getProdInfo()%></textarea>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="price" class="form-label">Unit Price (Rs)</label>
                    <input type="number" id="price" name="price" class="form-control" value="<%=product.getProdPrice()%>" placeholder="Enter Unit Price" required>
                </div>
                
                <div class="form-group">
                    <label for="quantity" class="form-label">Stock Quantity</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" value="<%=product.getProdQuantity()%>" placeholder="Enter Stock Quantity" required>
                </div>
            </div>
            
            <div class="form-actions">
                <a href="adminViewProduct.jsp" class="btn btn-danger">
                    <i class="fas fa-times"></i> Cancel
                </a>
                <button type="submit" class="btn btn-success">
                    <i class="fas fa-save"></i> Update Product
                </button>
            </div>
        </form>
    </div>

    <%@ include file="footer.html" %>
</body>

</html>
