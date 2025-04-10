<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="com.aaryan.service.impl.*" %>
<%@ page import="com.aaryan.service.*" %>
<%@ page import="com.aaryan.beans.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.ServletOutputStream" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart Details - TapBasket</title>

    <!-- Custom CSS -->
    <link rel="stylesheet" href="css/tapbasket.css">

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        .cart-container {
            margin-top: 120px;
            margin-bottom: 50px;
        }

        .cart-title {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2rem;
            font-weight: 600;
            color: var(--primary-color);
        }

        .product-image {
            width: 80px;
            height: 80px;
            object-fit: contain;
            border-radius: var(--border-radius-sm);
            background-color: #f5f5f5;
            padding: 5px;
        }

        .quantity-input {
            width: 70px;
            padding: 8px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: var(--border-radius-sm);
            text-align: center;
        }

        .update-btn {
            padding: 8px 12px;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: var(--border-radius-sm);
            cursor: pointer;
            margin-left: 5px;
            transition: background-color 0.3s ease;
        }

        .update-btn:hover {
            background-color: var(--primary-dark);
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: var(--background-color);
            color: var(--text-primary);
            transition: all 0.3s ease;
        }

        .action-btn:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .action-btn.add:hover {
            background-color: var(--success-color);
        }

        .action-btn.remove:hover {
            background-color: var(--danger-color);
        }

        .total-row {
            background-color: var(--primary-color);
            color: white;
            font-weight: 600;
        }

        .action-buttons {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .btn-cancel,
        .btn-checkout {
            padding: 12px 25px;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .btn-cancel {
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white;
        }

        .btn-cancel:hover {
            background: linear-gradient(135deg, #5a6268, #343a40);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        .btn-checkout {
            background: linear-gradient(135deg, #4CAF50, #2E7D32);
            color: white;
        }

        .btn-checkout:hover {
            background: linear-gradient(135deg, #43A047, #2E7D32);
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(46, 125, 50, 0.3);
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
    
    String addS=request.getParameter("add"); 
    if (addS !=null) { 
        int add=Integer.parseInt(addS);
        String uid=request.getParameter("uid"); 
        String pid=request.getParameter("pid"); 
        int avail=Integer.parseInt(request.getParameter("avail")); 
        int cartQty=Integer.parseInt(request.getParameter("qty")); 
        CartServiceImpl cartService=new CartServiceImpl(); 
        
        if (add==1) { 
            // Add Product into the cart
            cartQty += 1; 
            if (cartQty <= avail) { 
                cartService.addProductToCart(uid, pid, 1); 
            } else { 
                response.sendRedirect("./AddtoCart?pid=" + pid + " &pqty=" + cartQty);
            }
        } else if (add == 0) {
            // Remove Product from the cart
            cartService.removeProductFromCart(uid, pid);
        }
    }
    %>

    <jsp:include page="header.jsp" />

    <div class="container cart-container">
        <h2 class="cart-title">Cart Items</h2>

        <table class="table">
            <thead style="background-color: #186188; color: white; font-size: 16px; font-weight: bold;">
                <tr>
                    <th>Picture</th>
                    <th>Products</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Add</th>
                    <th>Remove</th>
                    <th>Amount</th>
                </tr>
            </thead>
            <tbody style="background-color: white; font-size: 15px; font-weight: 500;">
                <% 
                CartServiceImpl cart=new CartServiceImpl(); 
                List<CartBean> cartItems = new ArrayList<CartBean>();
                cartItems = cart.getAllCartItems(userName);
                double totAmount = 0;

                for (CartBean item : cartItems) {
                    String prodId = item.getProdId();
                    int prodQuantity = item.getQuantity();
                    ProductBean product = new ProductServiceImpl().getProductDetails(prodId);
                    double currAmount = product.getProdPrice() * prodQuantity;
                    totAmount += currAmount;

                    if (prodQuantity > 0) {
                %>
                <tr>
                    <td><img src="./ShowImage?pid=<%=product.getProdId()%>" class="product-image"></td>
                    <td><%=product.getProdName()%></td>
                    <td><%=product.getProdPrice()%></td>
                    <td>
                        <form method="post" action="./UpdateToCart">
                            <input type="number" name="pqty" value="<%=prodQuantity%>" class="quantity-input" min="0">
                            <input type="hidden" name="pid" value="<%=product.getProdId()%>">
                            <input type="submit" name="Update" value="Update" class="update-btn">
                        </form>
                    </td>
                    <td>
                        <a href="cartDetails.jsp?add=1&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>" class="action-btn add">
                            <i class="fa fa-plus"></i>
                        </a>
                    </td>
                    <td>
                        <a href="cartDetails.jsp?add=0&uid=<%=userName%>&pid=<%=product.getProdId()%>&avail=<%=product.getProdQuantity()%>&qty=<%=prodQuantity%>" class="action-btn remove">
                            <i class="fa fa-minus"></i>
                        </a>
                    </td>
                    <td><%=currAmount%></td>
                </tr>
                <% } } %>
                <tr class="total-row">
                    <td colspan="6" style="text-align: center;">Total Amount to Pay (in Rupees)</td>
                    <td><%=totAmount%></td>
                </tr>
                <% if (totAmount !=0) { %>
                <tr style="background-color: transparent;">
                    <td colspan="7" style="padding: 20px;">
                        <div style="display: flex; justify-content: space-between; gap: 20px;">
                            <a href="userHome.jsp" class="btn-cancel">
                                <i class="fas fa-arrow-left"></i> Continue Shopping
                            </a>
                            <a href="payment.jsp?amount=<%=totAmount%>" class="btn-checkout">
                                <i class="fas fa-lock"></i> Proceed to Checkout
                            </a>
                        </div>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <%@ include file="footer.html" %>

</body>

</html>
