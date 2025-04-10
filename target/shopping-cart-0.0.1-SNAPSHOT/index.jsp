<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
	<%@ page
		import="com.aaryan.service.impl.*, com.aaryan.service.*, com.aaryan.beans.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*"
		%>
		<!DOCTYPE html>
		<html lang="en">

		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>TapBasket - Your One-Stop Shopping Destination</title>

			<!-- Custom CSS -->
			<link rel="stylesheet" href="css/tapbasket.css">

			<!-- Font Awesome for icons -->
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

			<!-- Google Fonts -->
			<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
				rel="stylesheet">
		</head>

		<body>
			<% /* Checking the user credentials */ String userName=(String) session.getAttribute("username"); String
				password=(String) session.getAttribute("password"); String userType=(String)
				session.getAttribute("usertype"); boolean isValidUser=true; if (userType==null || userName==null ||
				password==null || !userType.equals("customer")) { isValidUser=false; } ProductServiceImpl prodDao=new
				ProductServiceImpl(); List<ProductBean> products = new ArrayList<ProductBean>();

					String search = request.getParameter("search");
					String type = request.getParameter("type");
					String message = "All Products";

					if (search != null) {
					products = prodDao.searchAllProducts(search);
					message = "Showing Results for '" + search + "'";
					} else if (type != null) {
					products = prodDao.getAllProductsByType(type);
					message = "Showing Results for '" + type + "'";
					} else {
					products = prodDao.getAllProducts();
					}

					if (products.isEmpty()) {
					message = "No items found for the search '" + (search != null ? search : type) + "'";
					products = prodDao.getAllProducts();
					}
					%>

					<jsp:include page="header.jsp" />

					<!-- Category Pills -->
					<div class="container">
						<div class="category-pills">
							<a href="index.jsp" class="category-pill <%= type == null ? " active" : "" %>">All</a>
							<a href="index.jsp?type=mobile" class="category-pill <%= " mobile".equals(type) ? "active"
								: "" %>">Mobiles</a>
							<a href="index.jsp?type=tv" class="category-pill <%= " tv".equals(type) ? "active" : ""
								%>">TVs</a>
							<a href="index.jsp?type=laptop" class="category-pill <%= " laptop".equals(type) ? "active"
								: "" %>">Laptops</a>
							<a href="index.jsp?type=camera" class="category-pill <%= " camera".equals(type) ? "active"
								: "" %>">Cameras</a>
							<a href="index.jsp?type=speaker" class="category-pill <%= " speaker".equals(type) ? "active"
								: "" %>">Speakers</a>
							<a href="index.jsp?type=tablet" class="category-pill <%= " tablet".equals(type) ? "active"
								: "" %>">Tablets</a>
						</div>
					</div>

					<!-- Products Section -->
					<section class="container">
						<div class="section-title">
							<h2>
								<%= message %>
							</h2>
						</div>  

						<% if (products.isEmpty()) { %>
							<div class="alert alert-info text-center">
								No products found. Please try a different search.
							</div>
							<% } else { %>
								<div class="product-grid">
									<% for (ProductBean product : products) { int cartQty=isValidUser ? new
										CartServiceImpl().getCartItemCount(userName, product.getProdId()) : 0; String
										description=product.getProdInfo(); description=description.substring(0,
										Math.min(description.length(), 100)); %>
										<div class="product-card fade-in">
											<img src="./ShowImage?pid=<%= product.getProdId() %>"
												alt="<%= product.getProdName() %>" class="product-image">
											<div class="product-info">
												<h3 class="product-name">
													<%= product.getProdName() %>
												</h3>
												<p class="product-description">
													<%= description %>...
												</p>
												<div class="product-price">
													<%=product.getProdPrice()%>
												</div>

												<div class="product-actions">
													<% if (!isValidUser) { %>
														<a href="login.jsp" class="btn btn-primary">
															<i class="fas fa-sign-in-alt"></i> Login to Buy
														</a>
														<% } else if (cartQty==0) { %>
															<form method="post" action="./AddtoCart">
																<input type="hidden" name="uid" value="<%= userName %>">
																<input type="hidden" name="pid"
																	value="<%= product.getProdId() %>">
																<input type="hidden" name="pqty" value="1">
																<button type="submit" class="btn btn-primary">
																	<i class="fas fa-cart-plus"></i> Add to Cart
																</button>
															</form>
															<% } else { %>
																<form method="post" action="./AddtoCart">
																	<input type="hidden" name="uid"
																		value="<%= userName %>">
																	<input type="hidden" name="pid"
																		value="<%= product.getProdId() %>">
																	<input type="hidden" name="pqty" value="0">
																	<button type="submit" class="btn btn-danger">
																		<i class="fas fa-trash"></i> Remove
																	</button>
																</form>
																<form method="post" action="cartDetails.jsp">
																	<button type="submit" class="btn btn-success">
																		<i class="fas fa-shopping-cart"></i> Checkout
																	</button>
																</form>
																<% } %>
												</div>
											</div>
										</div>
										<% } %>
								</div>
								<% } %>
					</section>

					<%@ include file="footer.html" %>

						<!-- JavaScript -->
						<script>
							// Make sure all products are visible
							document.addEventListener('DOMContentLoaded', function () {
								const productCards = document.querySelectorAll('.product-card');
								productCards.forEach(card => {
									card.classList.add('fade-in');
								});
							});
						</script>
		</body>

		</html>