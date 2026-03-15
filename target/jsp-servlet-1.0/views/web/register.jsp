<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang đăng ký | IVY moda</title>
</head>
<body>
	<main>
		<div class="container">

			<section
				class="section register min-vh-100 d-flex flex-column align-items-center justify-content-center py-4">
				<div class="container">
					<div class="row justify-content-center">
						<div
							class="col-lg-4 col-md-6 d-flex flex-column align-items-center justify-content-center">

							<div class="d-flex justify-content-center py-4">
								<a href="index.html"
									class="logo d-flex align-items-center w-auto"> <img
									src="assets/img/logo-icon.ico" alt=""> <span
									class="d-none d-lg-block">IVY Moda</span>
								</a>
							</div>
							<!-- End Logo -->

							<div class="card mb-3">

								<div class="card-body">

									<div class="pt-4 pb-2">
										<h5 class="card-title text-center pb-0 fs-4">Tạo tài
											khoản</h5>
										<p class="text-center small">Nhập thông tin cá nhân của
											bạn để tạo tài khoản</p>
									</div>

									<form class="row g-3 needs-validation form-register" novalidate>
										<div class="col-12">
											<label for="yourName" class="form-label">Họ và tên</label> <input
												type="text" name="name" class="form-control inner-name"
												id="yourName" required>
											<div class="feedback feedback-name"></div>
										</div>

										<div class="col-12">
											<label for="yourEmail" class="form-label">Email</label> <input
												type="email" name="email" class="form-control inner-email"
												id="yourEmail" required>
											<div class="feedback feedback-email"></div>
										</div>

										<div class="col-12">
											<label for="yourUsername" class="form-label">Tên đăng
												nhập</label> <input type="text" name="username"
												class="form-control inner-name-login" id="yourUsername"
												required>
											<div class="feedback feedback-name-login"></div>
										</div>

										<div class="col-12">
											<label for="yourPassword" class="form-label">Mật khẩu</label>
											<input type="password" name="password"
												class="form-control inner-password" id="yourPassword"
												required>
											<div class="feedback feedback-password"></div>
										</div>

										<div class="col-12">
											<div class="form-check">
												<input class="form-check-input inner-check" name="terms"
													type="checkbox" value="" id="acceptTerms" required>
												<label class="form-check-label" for="acceptTerms">Tôi
													đồng ý và chấp nhận <a href="#">điều khoản và điều kiện</a>
												</label>
												<div class="feedback feedback-check"></div>
											</div>
										</div>
										<div class="col-12">
											<button class="btn btn-secondary w-100 button-register"
												type="submit">Đăng ký</button>
										</div>
										<div class="col-12">
											<p class="small mb-0">
												Đã có tài khoản? <a href="pages-login.html">Đăng nhập</a>
											</p>
										</div>
									</form>

								</div>
							</div>

							<!-- <div class="credits"> -->
							<!-- All the links in the footer should remain intact. -->
							<!-- You can delete the links only if you purchased the pro version. -->
							<!-- Licensing information: https://bootstrapmade.com/license/ -->
							<!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/nice-admin-bootstrap-admin-html-template/ -->
							<!-- Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a> -->
							<!-- </div> -->

						</div>
					</div>
				</div>

			</section>

		</div>
	</main>
	<!-- End #main -->
</body>
</html>