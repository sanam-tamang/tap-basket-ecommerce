<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
	<%@ page
		import="com.aaryan.service.impl.*, com.aaryan.service.*,com.aaryan.beans.*,java.util.*,javax.servlet.ServletOutputStream,java.io.*"
		%>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>Order Details - TapBasket</title>

			<!-- Custom CSS -->
			<link rel="stylesheet" href="css/tapbasket.css">

			<!-- Font Awesome for icons -->
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

			<!-- Google Fonts -->
			<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
				rel="stylesheet">

			<style>
				.order-container {
					margin-top: 120px;
					margin-bottom: 50px;
				}

				.order-title {
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
			</style>
		</head>

		<body>

			<% /* Checking the user credentials */ String userName=(String) session.getAttribute("username"); String
				password=(String) session.getAttribute("password"); if (userName==null || password==null) {
				response.sendRedirect("login.jsp?message=Session Expired, Login Again!!"); } OrderService dao=new
				OrderServiceImpl(); List<OrderDetails> orders = dao.getAllOrderDetails(userName);
				%>



				<jsp:include page="header.jsp" />

				<!-- <script>document.getElementById('mycart').innerHTML='<i data-count="20" class="fa fa-shopping-cart fa-3x icon-white badge" style="background-color:#333;margin:0px;padding:0px; margin-top:5px;"></i>'</script>
 -->
				<div class="container order-container">
					<h2 class="order-title">Order Details</h2>
					<!-- Start of Product Items List -->
					<div class="table-responsive">
						<table class="table">
							<thead style="background-color: #186188; color: white; font-size: 16px; font-weight: bold;">
								<tr>
									<th>Picture</th>
									<th>ProductName</th>
									<th>OrderId</th>
									<th>Quantity</th>
									<th>Price</th>
									<th>Time</th>
									<th>Status</th>
								</tr>
							</thead>
							<tbody style="background-color: white; font-size: 15px; font-weight: 500;">
								<% for (OrderDetails order : orders) { %>

									<tr>
										<td><img src="./ShowImage?pid=<%=order.getProductId()%>" class="product-image">
										</td>
										<td>
											<%=order.getProdName()%>
										</td>
										<td>
											<%=order.getOrderId()%>
										</td>
										<td>
											<%=order.getQty()%>
										</td>
										<td>
											<%=order.getAmount()%>
										</td>
										<td>
											<%=order.getTime()%>
										</td>
										<td style="color: var(--success-color); font-weight: 600;">
											<%=order.getShipped()==0 ? "ORDER_PLACED" : "ORDER_SHIPPED" %>
										</td>
									</tr>

									<% } %>

							</tbody>
						</table>
					</div>
				</div>
				<!-- ENd of Product Items List -->


				<%@ include file="footer.html" %>
		</body>

		</html>