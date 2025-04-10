<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
	<%@ page
		import="com.aaryan.service.impl.*, com.aaryan.service.*, com.aaryan.beans.*, java.util.*, javax.servlet.ServletOutputStream, java.io.*"
		%>
		<!DOCTYPE html>
		<html lang="en">

		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>Payment - TapBasket</title>

			<!-- Custom CSS -->
			<link rel="stylesheet" href="css/tapbasket.css">

			<!-- Font Awesome for icons -->
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

			<!-- Google Fonts -->
			<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
				rel="stylesheet">

			<style>
				body {
					background: linear-gradient(135deg, #f5f7fa, #e4e8f0);
					min-height: 100vh;
				}

				.payment-container {
					max-width: 600px;
					margin: 30px auto 50px;
					background: white;
					border-radius: 20px;
					box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
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

				.payment-header {
					background: linear-gradient(135deg, #4CAF50, #2E7D32);
					color: white;
					padding: 30px;
					text-align: center;
					position: relative;
					overflow: hidden;
				}

				.payment-header::before {
					content: '';
					position: absolute;
					top: -50%;
					left: -50%;
					width: 200%;
					height: 200%;
					background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 0%, rgba(255, 255, 255, 0) 60%);
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

				.payment-title {
					font-size: 2rem;
					font-weight: 700;
					margin-bottom: 5px;
					position: relative;
					z-index: 1;
				}

				.payment-subtitle {
					font-size: 1.1rem;
					opacity: 0.9;
					margin-bottom: 0;
					position: relative;
					z-index: 1;
				}

				.payment-icon {
					font-size: 3.5rem;
					margin-bottom: 15px;
					color: rgba(255, 255, 255, 0.9);
					position: relative;
					z-index: 1;
					animation: float 3s ease-in-out infinite;
				}

				@keyframes float {

					0%,
					100% {
						transform: translateY(0);
					}

					50% {
						transform: translateY(-10px);
					}
				}

				.payment-amount {
					font-size: 3rem;
					font-weight: 700;
					margin: 15px 0;
					position: relative;
					z-index: 1;
					text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
				}

				.payment-amount::before {
					content: 'Rs. ';
					font-size: 2.2rem;
					margin-right: 5px;
					vertical-align: top;
				}

				.payment-body {
					padding: 30px;
				}

				.form-group {
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
					border-color: #4CAF50;
					box-shadow: 0 0 0 3px rgba(76, 175, 80, 0.2);
					outline: none;
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
					z-index: 1;
					pointer-events: none;
				}

				.input-with-icon {
					padding-left: 45px;
				}

				.form-row {
					display: flex;
					gap: 20px;
					margin-bottom: 20px;
				}

				.btn-pay {
					background: linear-gradient(135deg, #4CAF50, #2E7D32);
					color: white;
					border: none;
					padding: 15px 25px;
					border-radius: 50px;
					cursor: pointer;
					font-weight: 600;
					font-size: 1.1rem;
					width: 100%;
					transition: all 0.3s ease;
					display: flex;
					align-items: center;
					justify-content: center;
					gap: 10px;
					box-shadow: 0 4px 15px rgba(46, 125, 50, 0.3);
					position: relative;
					overflow: hidden;
				}

				.btn-pay::before {
					content: '';
					position: absolute;
					top: 0;
					left: -100%;
					width: 100%;
					height: 100%;
					background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
					transition: all 0.6s ease;
				}

				.btn-pay:hover {
					background: linear-gradient(135deg, #43A047, #2E7D32);
					transform: translateY(-2px);
					box-shadow: 0 6px 20px rgba(46, 125, 50, 0.4);
				}

				.btn-pay:hover::before {
					left: 100%;
				}

				.btn-pay:active {
					transform: translateY(0);
					box-shadow: 0 2px 10px rgba(46, 125, 50, 0.3);
				}

				.secure-badge {
					display: flex;
					align-items: center;
					justify-content: center;
					margin-top: 20px;
					color: #6c757d;
					font-size: 0.9rem;
					gap: 5px;
				}

				.secure-badge i {
					color: #4CAF50;
				}

				.order-summary {
					background-color: #f8f9fa;
					border-radius: 10px;
					padding: 20px;
					margin-bottom: 30px;
				}

				.order-summary-title {
					font-size: 1.2rem;
					font-weight: 600;
					margin-bottom: 15px;
					color: #333;
				}

				.order-summary-item {
					display: flex;
					justify-content: space-between;
					margin-bottom: 10px;
				}

				.order-summary-total {
					display: flex;
					justify-content: space-between;
					margin-top: 15px;
					padding-top: 15px;
					border-top: 1px solid #e0e0e0;
					font-weight: 600;
					color: #333;
				}

				.input-group {
					position: relative;
					width: 100%;
				}

				.input-group {
					position: relative;
					width: 100%;
					margin-bottom: 20px;
				}

				.input-icon {
					position: absolute;
					top: 50%;
					left: 15px;
					transform: translateY(-50%);
					color: #999;
					font-size: 16px;
					z-index: 1;
					pointer-events: none;
				}

				.input-with-icon {
					padding-left: 45px;
					/* space for the icon */
					height: 45px;
					width: 100%;
					box-sizing: border-box;
					border: 1px solid
			</style>
		</head>

		<body>
			<% /* Checking the user credentials */ String userName=(String) session.getAttribute("username"); String
				password=(String) session.getAttribute("password"); if (userName==null || password==null) {
				response.sendRedirect("login.jsp?message=Session Expired, Login Again!!"); } String
				sAmount=request.getParameter("amount"); double amount=0; if (sAmount !=null) {
				amount=Double.parseDouble(sAmount); } %>

				<jsp:include page="header.jsp" />

				<div class="container">
					<div class="payment-container">
						<div class="payment-header">
							<div class="payment-icon">
								<i class="fas fa-credit-card"></i>
							</div>
							<h1 class="payment-title">Secure Payment</h1>
							<p class="payment-subtitle">Complete your purchase securely</p>
							<div class="payment-amount">
								<%= amount %>
							</div>
						</div>

						<div class="payment-body">
							<div class="order-summary">
								<div class="order-summary-title">Order Summary</div>
								<div class="order-summary-item">
									<span>Subtotal</span>
									<span>Rs. <%= String.format("%.2f", amount * 0.9) %></span>
								</div>
								<div class="order-summary-item">
									<span>Tax (10%)</span>
									<span>Rs. <%= String.format("%.2f", amount * 0.1) %></span>
								</div>
								<div class="order-summary-total">
									<span>Total</span>
									<span>Rs. <%= String.format("%.2f", amount) %></span>
								</div>
							</div>

							<form action="./OrderServlet" method="post">
								<div class="form-group">
									<label for="cardHolder" class="form-label">Card Holder Name</label>
									<div class="input-group">

										<input type="text" id="cardHolder" name="cardholder"
											class="form-control input-with-icon" placeholder="Enter card holder name"
											required>
									</div>
								</div>

								<div class="form-group">
									<label for="cardNumber" class="form-label">Card Number</label>
									<div class="input-group">

										<input type="text" id="cardNumber" name="cardnumber"
											class="form-control input-with-icon" placeholder="4242 4242 4242 4242"
											maxlength="19" required>
									</div>
								</div>

								<div class="form-row">

									<div class="form-group" style="flex: 1;">
										<label for="expMonth" class="form-label">Expiry Month</label>
										<select id="expMonth" name="expmonth" class="form-control" required>
											<option value="" disabled selected>MM</option>
											<option value="01">01</option>
											<option value="02">02</option>
											<option value="03">03</option>
											<option value="04">04</option>
											<option value="05">05</option>
											<option value="06">06</option>
											<option value="07">07</option>
											<option value="08">08</option>
											<option value="09">09</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>
										</select>
									</div>

									<div class="form-group" style="flex: 1;">
										<label for="expYear" class="form-label">Expiry Year</label>
										<select id="expYear" name="expyear" class="form-control" required>
											<option value="" disabled selected>YYYY</option>
											<option value="2025">2025</option>
											<option value="2026">2026</option>
											<option value="2027">2027</option>
											<option value="2028">2028</option>
											<option value="2029">2029</option>
											<option value="2030">2030</option>
										</select>
									</div>

									<div class="form-group" style="flex: 0.8;">
										<label for="cvv" class="form-label">CVV</label>
										<div class="input-group">

											<input type="password" id="cvv" name="cvv"
												class="form-control input-with-icon" placeholder="123" maxlength="4"
												required>
										</div>
									</div>
								</div>

								<input type="hidden" name="amount" value="<%= amount %>">

								<button type="submit" class="btn-pay">
									<i class="fas fa-lock"></i> Pay Securely Rs. <%= String.format("%.2f", amount) %>
								</button>

								<div class="secure-badge">
									<i class="fas fa-shield-alt"></i> Your payment information is secure and encrypted
								</div>
							</form>
						</div>
					</div>
				</div>

				<%@ include file="footer.html" %>

		</body>

		</html>