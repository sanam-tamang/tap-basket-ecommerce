<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product - TapBasket</title>
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/tapbasket.css">
    
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        .add-product-container {
            max-width: 800px;
            margin: 30px auto 50px;
            padding: 0;
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
        
        .add-product-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
            padding: 25px 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .add-product-header::before {
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
        
        .add-product-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 5px;
            position: relative;
            z-index: 1;
        }
        
        .add-product-subtitle {
            font-size: 1rem;
            opacity: 0.9;
            margin-bottom: 0;
            position: relative;
            z-index: 1;
        }
        
        .add-product-body {
            padding: 30px;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }
        
        .form-group {
            flex: 1;
            margin-bottom: 20px;
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
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.2);
            outline: none;
        }
        
        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }
        
        .file-upload {
            position: relative;
            overflow: hidden;
            margin-top: 10px;
            text-align: center;
        }
        
        .file-upload-label {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 30px;
            border: 2px dashed #ddd;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .file-upload-label:hover {
            border-color: #007bff;
            background-color: rgba(0, 123, 255, 0.05);
        }
        
        .file-upload-icon {
            font-size: 2.5rem;
            color: #007bff;
            margin-bottom: 10px;
        }
        
        .file-upload-text {
            color: #666;
        }
        
        .file-upload input[type="file"] {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }
        
        .file-name {
            margin-top: 10px;
            font-size: 0.9rem;
            color: #007bff;
            display: none;
        }
        
        .form-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        
        .btn-reset {
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
        }
        
        .btn-reset:hover {
            background: linear-gradient(135deg, #5a6268, #343a40);
            transform: translateY(-2px);
        }
        
        .btn-submit {
            background: linear-gradient(135deg, #28a745, #218838);
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
        
        .btn-submit:hover {
            background: linear-gradient(135deg, #218838, #1e7e34);
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
        
        .currency-symbol {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
            font-weight: bold;
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
        <div class="add-product-container">
            <div class="add-product-header">
                <h1 class="add-product-title">Add New Product</h1>
                <p class="add-product-subtitle">Fill in the details to add a new product to your inventory</p>
            </div>
            
            <div class="add-product-body">
                <% if (message != null) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> <%= message %>
                    </div>
                <% } %>
                
                <form action="./AddProductSrv" method="post" enctype="multipart/form-data">
                    <div class="form-row">
                        <div class="form-group">
                            <label for="productName" class="form-label">Product Name</label>
                            <div class="input-group">
                           
                                <input type="text" id="productName" name="name" class="form-control input-with-icon" placeholder="Enter product name" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="productType" class="form-label">Product Type</label>
                            <div class="input-group">
                              
                                <select id="productType" name="type" class="form-control input-with-icon" required>
                                    <option value="mobile">Mobile</option>
                                    <option value="tv">TV</option>
                                    <option value="camera">Camera</option>
                                    <option value="laptop">Laptop</option>
                                    <option value="tablet">Tablet</option>
                                    <option value="speaker">Speaker</option>
                                    <option value="other">Other Appliances</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="productDescription" class="form-label">Product Description</label>
                        <textarea id="productDescription" name="info" class="form-control" placeholder="Enter detailed product description" required></textarea>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="productPrice" class="form-label">Unit Price (Rs)</label>
                            <div class="input-group">
                             
                                <input type="number" id="productPrice" name="price" class="form-control input-with-icon" placeholder="Enter unit price" required>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="productQuantity" class="form-label">Stock Quantity</label>
                            <div class="input-group">
                               
                                <input type="number" id="productQuantity" name="quantity" class="form-control input-with-icon" placeholder="Enter stock quantity" required>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="productImage" class="form-label">Product Image</label>
                        <div class="file-upload">
                            <label for="productImage" class="file-upload-label">
                                <i class="fas fa-cloud-upload-alt file-upload-icon"></i>
                                <span class="file-upload-text">Drag & drop an image or click to browse</span>
                            </label>
                            <input type="file" id="productImage" name="image" accept="image/*" required>
                            <div id="fileName" class="file-name"></div>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="reset" class="btn-reset">
                            <i class="fas fa-undo btn-icon"></i> Reset Form
                        </button>
                        <button type="submit" class="btn-submit">
                            <i class="fas fa-plus-circle btn-icon"></i> Add Product
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%@ include file="footer.html" %>

    <!-- JavaScript -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // File upload preview
            const fileInput = document.getElementById('productImage');
            const fileName = document.getElementById('fileName');
            
            fileInput.addEventListener('change', function() {
                if (this.files && this.files[0]) {
                    fileName.textContent = this.files[0].name;
                    fileName.style.display = 'block';
                    
                    // Change the upload icon to check mark
                    const uploadIcon = document.querySelector('.file-upload-icon');
                    uploadIcon.classList.remove('fa-cloud-upload-alt');
                    uploadIcon.classList.add('fa-check-circle');
                    uploadIcon.style.color = '#28a745';
                    
                    // Change the text
                    const uploadText = document.querySelector('.file-upload-text');
                    uploadText.textContent = 'Image selected successfully';
                }
            });
        });
    </script>
</body>

</html>
