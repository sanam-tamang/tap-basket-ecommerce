<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - TapBasket</title>

        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/tapbasket.css">

        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
            rel="stylesheet">

        <style>
            .register-container {
                max-width: 600px;
                margin: 30px auto 50px;
                padding: 30px;
                background-color: var(--card-color);
                border-radius: var(--border-radius-lg);
                box-shadow: var(--shadow-lg);
            }

            .register-header {
                text-align: center;
                margin-bottom: 30px;
            }

            .register-header .logo {
                font-size: 2rem;
                margin-bottom: 10px;
                display: inline-block;
            }

            .register-title {
                font-size: 1.5rem;
                font-weight: 600;
                color: var(--text-primary);
                margin-bottom: 5px;
            }

            .register-subtitle {
                color: var(--text-secondary);
                margin-bottom: 20px;
            }

            .register-form .form-group {
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

            .register-form .form-control {
                padding-left: 45px;
            }

            .form-row {
                display: flex;
                gap: 15px;
            }

            .form-row .form-group {
                flex: 1;
            }

            .register-footer {
                text-align: center;
                margin-top: 20px;
                color: var(--text-secondary);
            }

            .register-footer a {
                color: var(--primary-color);
                font-weight: 500;
            }

            .password-requirements {
                font-size: 0.85rem;
                color: var(--text-secondary);
                margin-top: 5px;
            }

            .password-requirements ul {
                padding-left: 20px;
                margin-top: 5px;
            }

            .password-requirements li {
                margin-bottom: 3px;
            }

            .password-strength {
                height: 5px;
                background-color: #e9ecef;
                border-radius: 3px;
                margin-top: 8px;
                overflow: hidden;
            }

            .password-strength-meter {
                height: 100%;
                width: 0;
                transition: width 0.3s ease;
            }

            .strength-weak {
                background-color: var(--danger-color);
                width: 25%;
            }

            .strength-medium {
                background-color: var(--warning-color);
                width: 50%;
            }

            .strength-good {
                background-color: var(--info-color);
                width: 75%;
            }

            .strength-strong {
                background-color: var(--success-color);
                width: 100%;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <!-- Register Form -->
        <div class="container">
            <div class="register-container">
                <div class="register-header">
                    <a href="index.jsp" class="logo">
                        <i class="fas fa-shopping-basket"></i>
                        TapBasket
                    </a>
                    <h1 class="register-title">Create an Account</h1>
                    <p class="register-subtitle">Join TapBasket to start shopping</p>

                    <% String message=request.getParameter("message"); if (message !=null) { %>
                        <div class="alert alert-info">
                            <%= message %>
                        </div>
                        <% } %>
                </div>

                <form action="./RegisterSrv" method="post" class="register-form" id="registerForm">
                    <div class="form-group">
                        <label for="username" class="form-label">Full Name</label>
                        <div class="input-group">
                            <i class="fas fa-user input-icon"></i>
                            <input type="text" id="username" name="username" class="form-control"
                                placeholder="Enter your full name" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="email" class="form-label">Email Address</label>
                            <div class="input-group">
                                <i class="fas fa-envelope input-icon"></i>
                                <input type="email" id="email" name="email" class="form-control"
                                    placeholder="Enter your email" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="mobile" class="form-label">Mobile Number</label>
                            <div class="input-group">
                                <i class="fas fa-phone input-icon"></i>
                                <input type="tel" id="mobile" name="mobile" class="form-control"
                                    placeholder="Enter your mobile number" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="address" class="form-label">Address</label>
                        <div class="input-group">
                            <i class="fas fa-map-marker-alt input-icon"></i>
                            <input type="text" id="address" name="address" class="form-control"
                                placeholder="Enter your address" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="pincode" class="form-label">Pincode</label>
                        <div class="input-group">
                            <i class="fas fa-map-pin input-icon"></i>
                            <input type="text" id="pincode" name="pincode" class="form-control"
                                placeholder="Enter your pincode" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="password" class="form-label">Password</label>
                            <div class="input-group">
                                <i class="fas fa-lock input-icon"></i>
                                <input type="password" id="password" name="password" class="form-control"
                                    placeholder="Create a password" required>
                            </div>
                            <div class="password-strength">
                                <div class="password-strength-meter" id="passwordStrengthMeter"></div>
                            </div>
                            <div class="password-requirements">
                                <small>Password should contain:</small>
                                <ul>
                                    <li>At least 8 characters</li>
                                    <li>At least one uppercase letter</li>
                                    <li>At least one number</li>
                                    <li>At least one special character</li>
                                </ul>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <div class="input-group">
                                <i class="fas fa-lock input-icon"></i>
                                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control"
                                    placeholder="Confirm your password" required>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="remember-me">
                            <input type="checkbox" name="terms" required> I agree to the <a href="#">Terms of
                                Service</a> and <a href="#">Privacy Policy</a>
                        </label>
                    </div>

                    <button type="submit" class="btn btn-primary btn-block">Create Account</button>
                </form>

                <div class="register-footer">
                    <p>Already have an account? <a href="login.jsp">Sign In</a></p>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="footer-content">
                    <div class="footer-section">
                        <h3 class="footer-title">TapBasket</h3>
                        <p>Your one-stop destination for all electronic needs. We provide high-quality products at
                            competitive prices.</p>
                    </div>

                    <div class="footer-section">
                        <h3 class="footer-title">Quick Links</h3>
                        <ul class="footer-links">
                            <li class="footer-link"><a href="index.jsp">Home</a></li>
                            <li class="footer-link"><a href="login.jsp">Login</a></li>
                            <li class="footer-link"><a href="register.jsp">Register</a></li>
                        </ul>
                    </div>

                    <div class="footer-section">
                        <h3 class="footer-title">Categories</h3>
                        <ul class="footer-links">
                            <li class="footer-link"><a href="index.jsp?type=mobile">Mobiles</a></li>
                            <li class="footer-link"><a href="index.jsp?type=laptop">Laptops</a></li>
                            <li class="footer-link"><a href="index.jsp?type=tv">TVs</a></li>
                            <li class="footer-link"><a href="index.jsp?type=camera">Cameras</a></li>
                        </ul>
                    </div>

                    <div class="footer-section">
                        <h3 class="footer-title">Contact Us</h3>
                        <ul class="footer-links">
                            <li class="footer-link"><i class="fas fa-map-marker-alt"></i> 123 Electronics Street, Tech
                                City</li>
                            <li class="footer-link"><i class="fas fa-phone"></i> +1 234 567 8900</li>
                            <li class="footer-link"><i class="fas fa-envelope"></i> info@tapbasket.com</li>
                        </ul>
                    </div>
                </div>

                <div class="footer-bottom">
                    <p>&copy; 2025 TapBasket. All Rights Reserved.</p>
                </div>
            </div>
        </footer>

        <!-- JavaScript -->
        <script>
            // Mobile Menu Toggle
            document.getElementById('mobileMenuToggle').addEventListener('click', function () {
                document.getElementById('mainNav').classList.toggle('active');
            });

            // Password Strength Meter
            const passwordInput = document.getElementById('password');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const passwordStrengthMeter = document.getElementById('passwordStrengthMeter');
            const registerForm = document.getElementById('registerForm');

            passwordInput.addEventListener('input', function () {
                const password = this.value;
                let strength = 0;

                // Check length
                if (password.length >= 8) {
                    strength += 1;
                }

                // Check for uppercase letters
                if (/[A-Z]/.test(password)) {
                    strength += 1;
                }

                // Check for numbers
                if (/[0-9]/.test(password)) {
                    strength += 1;
                }

                // Check for special characters
                if (/[^A-Za-z0-9]/.test(password)) {
                    strength += 1;
                }

                // Update strength meter
                passwordStrengthMeter.className = 'password-strength-meter';

                if (strength === 0) {
                    passwordStrengthMeter.classList.add('');
                } else if (strength === 1) {
                    passwordStrengthMeter.classList.add('strength-weak');
                } else if (strength === 2) {
                    passwordStrengthMeter.classList.add('strength-medium');
                } else if (strength === 3) {
                    passwordStrengthMeter.classList.add('strength-good');
                } else {
                    passwordStrengthMeter.classList.add('strength-strong');
                }
            });

            // Form Validation
            registerForm.addEventListener('submit', function (e) {
                const password = passwordInput.value;
                const confirmPassword = confirmPasswordInput.value;

                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('Passwords do not match!');
                    return false;
                }

                if (password.length < 8) {
                    e.preventDefault();
                    alert('Password must be at least 8 characters long!');
                    return false;
                }

                return true;
            });
        </script>
    </body>

    </html>