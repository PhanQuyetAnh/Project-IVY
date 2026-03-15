<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang admin | IVY moda</title>
</head>
<body>
	<main id="main" class="main">
		<div
			class="pagetitle d-flex align-items-center justify-content-between">
			<h1>Tổng quan</h1>
			<nav>
				<ol class="breadcrumb mb-0">
					<li class="breadcrumb-item"><a href="index.html"><i
							class="bi bi-house-door"></i></a></li>
					<li class="breadcrumb-item active">Tổng quan</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section dashboard">
			<div class="row">
				<!-- Left side columns -->
				<div class="col-lg-8">
					<div class="row">
						<!-- Sales Card -->
						<div class="col-xxl-6 col-md-6">
							<div class="card info-card sales-card">
								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Bộ lọc</h6>
										</li>

										<li><a class="dropdown-item" href="#">Hôm nay</a></li>
										<li><a class="dropdown-item" href="#">Tháng này</a></li>
										<li><a class="dropdown-item" href="#">Năm này</a></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Doanh số <span>| Hôm nay</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-cart"></i>
										</div>
										<div class="ps-3">
											<h6>145</h6>
											<span class="text-muted small pt-2 ps-1">tăng</span> <span
												class="text-success small pt-1 fw-bold">12%</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End Sales Card -->

						<!-- Revenue Card -->
						<div class="col-xxl-6 col-md-6">
							<div class="card info-card revenue-card">
								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Bộ lọc</h6>
										</li>

										<li><a class="dropdown-item" href="#">Hôm nay</a></li>
										<li><a class="dropdown-item" href="#">Tháng này</a></li>
										<li><a class="dropdown-item" href="#">Năm này</a></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Doanh thu <span>| Tháng này</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-currency-dollar"></i>
										</div>
										<div class="ps-3">
											<h6>3.000.000.000đ</h6>
											<span class="text-muted small pt-2 ps-1">tăng</span> <span
												class="text-success small pt-1 fw-bold">8%</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End Revenue Card -->

						<!-- Customers Card -->
						<div class="col-xxl-6 col-xl-12">
							<div class="card info-card customers-card">
								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Bộ lọc</h6>
										</li>

										<li><a class="dropdown-item" href="#">Hôm nay</a></li>
										<li><a class="dropdown-item" href="#">Tháng này</a></li>
										<li><a class="dropdown-item" href="#">Năm này</a></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Khách hàng <span>| Năm này </span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-people"></i>
										</div>
										<div class="ps-3">
											<h6>1244</h6>
											<span class="text-muted small pt-2 ps-1"> giảm</span> <span
												class="text-danger small pt-1 fw-bold">12%</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End Customers Card -->

						<!-- Review customers -->
						<div class="col-xxl-6 col-md-6">
							<div class="card info-card review-card">
								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Bộ lọc</h6>
										</li>

										<li><a class="dropdown-item" href="#">Hôm nay</a></li>
										<li><a class="dropdown-item" href="#">Tháng này</a></li>
										<li><a class="dropdown-item" href="#">Năm này</a></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Đánh giá <span>| Tháng này</span>
									</h5>

									<div class="d-flex align-items-center">
										<div
											class="card-icon rounded-circle d-flex align-items-center justify-content-center">
											<i class="bi bi-star-fill text-warning"></i>
										</div>
										<div class="ps-3">
											<h6>200 lượt</h6>
											<span class="text-muted small pt-2 ps-1">tăng</span> <span
												class="text-success small pt-1 fw-bold">8%</span>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- End review customers -->

						<!-- Reports -->
						<div class="col-12">
							<div class="card">
								<div class="filter">
									<a class="icon" href="#" data-bs-toggle="dropdown"><i
										class="bi bi-three-dots"></i></a>
									<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
										<li class="dropdown-header text-start">
											<h6>Bộ lọc</h6>
										</li>

										<li><a class="dropdown-item" href="#">Hôm nay</a></li>
										<li><a class="dropdown-item" href="#">Tháng này</a></li>
										<li><a class="dropdown-item" href="#">Năm này</a></li>
									</ul>
								</div>

								<div class="card-body">
									<h5 class="card-title">
										Thống kê <span>/Hôm nay</span>
									</h5>

									<!-- Line Chart -->
									<div id="reportsChart"></div>

									<script>
                    document.addEventListener("DOMContentLoaded", () => {
                      new ApexCharts(
                        document.querySelector("#reportsChart"),
                        {
                          series: [
                            {
                              name: "Doanh số",
                              data: [31, 40, 28, 51, 42, 82, 56],
                            },
                            {
                              name: "Doanh thu",
                              data: [11, 32, 45, 32, 34, 52, 41],
                            },
                            {
                              name: "Khách hàng",
                              data: [15, 11, 32, 18, 9, 24, 11],
                            },
                          ],
                          chart: {
                            height: 350,
                            type: "area",
                            toolbar: {
                              show: false,
                            },
                          },
                          markers: {
                            size: 4,
                          },
                          colors: ["#4154f1", "#2eca6a", "#ff771d"],
                          fill: {
                            type: "gradient",
                            gradient: {
                              shadeIntensity: 1,
                              opacityFrom: 0.3,
                              opacityTo: 0.4,
                              stops: [0, 90, 100],
                            },
                          },
                          dataLabels: {
                            enabled: false,
                          },
                          stroke: {
                            curve: "smooth",
                            width: 2,
                          },
                          xaxis: {
                            type: "datetime",
                            categories: [
                              "2018-09-19T00:00:00.000Z",
                              "2018-09-19T01:30:00.000Z",
                              "2018-09-19T02:30:00.000Z",
                              "2018-09-19T03:30:00.000Z",
                              "2018-09-19T04:30:00.000Z",
                              "2018-09-19T05:30:00.000Z",
                              "2018-09-19T06:30:00.000Z",
                            ],
                          },
                          tooltip: {
                            x: {
                              format: "dd/MM/yy HH:mm",
                            },
                          },
                        }
                      ).render();
                    });
                  </script>
									<!-- End Line Chart -->
								</div>
							</div>
						</div>
						<!-- End Reports -->

						

						<!-- Top Selling -->

						<!-- End Top Selling -->
					</div>
				</div>
				<!-- End Left side columns -->

				<!-- Right side columns -->
				<div class="col-lg-4">
					<!-- Recent Activity -->
					<div class="card">
						<div class="filter">
							<a class="icon" href="#" data-bs-toggle="dropdown"><i
								class="bi bi-three-dots"></i></a>
							<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
								<li class="dropdown-header text-start">
									<h6>Bộ lọc</h6>
								</li>

								<li><a class="dropdown-item" href="#">Hôm nay </a></li>
								<li><a class="dropdown-item" href="#">Tháng này</a></li>
								<li><a class="dropdown-item" href="#">Năm này </a></li>
							</ul>
						</div>

						<div class="card-body">
							<h5 class="card-title">
								Hoạt động gần đây <span>| Hôm nay</span>
							</h5>

							<div class="activity overflow-auto" style="max-height: 265px">
								<div class="activity-item d-flex">
									<div class="activite-label">5 phút</div>
									<i
										class="bi bi-circle-fill activity-badge text-success align-self-start"></i>
									<div class="activity-content">
										Nguyễn Văn A đã đánh giá Áo hoodie unisex <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i>
									</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">10 phút</div>
									<i
										class="bi bi-circle-fill activity-badge text-danger align-self-start"></i>
									<div class="activity-content">Trần Văn Quang đã đặt 1 Áo
										thun Daily Metagent - Màu đen</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">12 phút</div>
									<i
										class="bi bi-circle-fill activity-badge text-primary align-self-start"></i>
									<div class="activity-content">Đơn hàng #10231 đã được
										giao thành công.</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">20 phút</div>
									<i
										class="bi bi-circle-fill activity-badge text-info align-self-start"></i>
									<div class="activity-content">
										Ngô Quang Hà đã đánh giá Áo hoodie unisex <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i>
									</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">21 phút</div>
									<i
										class="bi bi-circle-fill activity-badge text-warning align-self-start"></i>
									<div class="activity-content">
										Phan Quyết Anh đã đánh giá Áo hoodie unisex <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i> <i
											class="bi bi-star-fill text-warning"></i>
									</div>
								</div>
								<!-- End activity item-->

								<div class="activity-item d-flex">
									<div class="activite-label">2 ngày</div>
									<i
										class="bi bi-circle-fill activity-badge text-muted align-self-start"></i>
									<div class="activity-content">Đơn hàng #10220 đã bị hủy.
									</div>
								</div>
								<!-- End activity item-->
							</div>
						</div>
					</div>
					<!-- End Recent Activity -->

					<!-- Budget Report -->
					<div class="card">
						<div class="filter">
							<a class="icon" href="#" data-bs-toggle="dropdown"><i
								class="bi bi-three-dots"></i></a>
							<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
								<li class="dropdown-header text-start">
									<h6>Bộ lọc</h6>
								</li>

								<li><a class="dropdown-item" href="#">Hôm nay</a></li>
								<li><a class="dropdown-item" href="#">Tháng này</a></li>
								<li><a class="dropdown-item" href="#">Năm này</a></li>
							</ul>
						</div>

						<div class="card-body pb-0" style="max-height: 452px">
							<h5 class="card-title">
								Báo cáo ngân sách <span>| Tháng này</span>
							</h5>

							<div id="budgetChart" style="min-height: 400px" class="echart"></div>

							<script>
                document.addEventListener("DOMContentLoaded", () => {
                  var budgetChart = echarts
                    .init(document.querySelector("#budgetChart"))
                    .setOption({
                      legend: {
                        data: ["Ngân sách dự kiến", "Chi tiêu thực tế"],
                      },
                      radar: {
                        // shape: 'circle',
                        indicator: [
                          {
                            name: "Bán hàng",
                            max: 6500,
                          },
                          {
                            name: "Quản lý",
                            max: 16000,
                          },
                          {
                            name: "Công nghệ",
                            max: 30000,
                          },
                          {
                            name: "Hỗ trợ khách hàng",
                            max: 38000,
                          },
                          {
                            name: "Phát triển",
                            max: 52000,
                          },
                          {
                            name: "Tiếp thị",
                            max: 25000,
                          },
                        ],
                      },
                      series: [
                        {
                          name: "Budget vs spending",
                          type: "radar",
                          data: [
                            {
                              value: [4200, 3000, 20000, 35000, 50000, 18000],
                              name: "Ngân sách dự kiến",
                            },
                            {
                              value: [
                                5000, 14000, 28000, 26000, 42000, 21000,
                              ],
                              name: "Chi tiêu thực tế",
                            },
                          ],
                        },
                      ],
                    });
                });
              </script>
						</div>
					</div>
					<!-- End Budget Report -->

					
				</div>
				<!-- End Right side columns -->
				
				<!-- Recent Sales -->

						<div class="col-lg-12">
							<div class="card">
								<div class="card-body">
									<h5 class="card-title">Doanh số gần đây</h5>
									<c:if test="${not empty error}">
										<div class="alert alert-danger">${error}</div>
									</c:if>
									<table class="table datatable">
										<thead>
											<tr>
												<th>Khách hàng</th>
												<th>Sản phẩm</th>
												<th>Giá</th>
												<th>Trạng thái</th>
												<th>Ngày đặt hàng</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="order" items="${orderList}">
												<tr>
													<td>${order.customerName}</td>
													<td>${order.productName}</td>
													<td><fmt:formatNumber value="${order.price}"
															type="number" pattern="#,##0.00" /> VNĐ</td>
													<td><c:choose>
															<c:when test="${order.orderStatus == 'pending'}">
																<span class="badge bg-warning">${order.orderStatus}</span>
															</c:when>
															<c:when test="${order.orderStatus == 'approved'}">
																<span class="badge bg-success">${order.orderStatus}</span>
															</c:when>
															<c:when test="${order.orderStatus == 'cancelled'}">
																<span class="badge bg-danger">${order.orderStatus}</span>
															</c:when>
															<c:otherwise>
																<span class="badge bg-secondary">${order.orderStatus}</span>
															</c:otherwise>
														</c:choose></td>
													<td>${order.orderDate}</td>
												</tr>
											</c:forEach>
											<c:if test="${empty orderList}">
												<tr>
													<td colspan="5" class="text-center">Không có đơn hàng
														nào.</td>
												</tr>
											</c:if>
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<!-- End Recent Sales -->

				<!-- Top Selling -->
				<div class="col-12">
					<div class="card top-selling overflow-auto">
						<div class="filter">
							<a class="icon" href="#" data-bs-toggle="dropdown"><i
								class="bi bi-three-dots"></i></a>
							<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
								<li class="dropdown-header text-start">
									<h6>Bộ lọc</h6>
								</li>

								<li><a class="dropdown-item" href="#">Hôm nay</a></li>
								<li><a class="dropdown-item" href="#">Tháng này</a></li>
								<li><a class="dropdown-item" href="#">Năm này</a></li>
							</ul>
						</div>

						<div class="card-body pb-0" id="banchay">
							<h5 class="card-title">
								Bán chạy nhất <span>| Hôm nay </span>
							</h5>

							<table class="table table-borderless">
								<thead>
									<tr>
										<th scope="col">Hình ảnh</th>
										<th scope="col">Sản phẩm</th>
										<th scope="col">Giá</th>
										<th scope="col">Đã bán</th>
										<th scope="col">Doanh thu</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th scope="row"><a href="#"><img
												src="<c:url value='/templates/admin/img/product-1.jpg'/>"
												alt="" /></a></th>
										<td><a href="#" class="text-primary fw-bold">Crepe
												Dress - Đầm ôm tạo kiểu</a></td>
										<td>795.000đ</td>
										<td class="fw-bold">124</td>
										<td>98.580.000đ</td>
									</tr>
									<tr>
										<th scope="row"><a href="#"><img
												src="<c:url value='/templates/admin/img/product-2.jpg'/>"
												alt="" /></a></th>
										<td><a href="#" class="text-primary fw-bold">Forge
												Pants - Quần dài Tuysi ống đứng</a></td>
										<td>1.290.000đ</td>
										<td class="fw-bold">98</td>
										<td>126.420.000đ</td>
									</tr>
									<tr>
										<th scope="row"><a href="#"><img
												src="<c:url value='/templates/admin/img/product-3.jpg'/>"
												alt="" /></a></th>
										<td><a href="#" class="text-primary fw-bold">Elegant
												Silk Blouse - Áo sơ mi lụa</a></td>
										<td>850.000đ</td>
										<td class="fw-bold">74</td>
										<td>62.900.000đ</td>
									</tr>
									<tr>
										<th scope="row"><a href="#"><img
												src="<c:url value='/templates/admin/img/product-4.jpg'/>"
												alt="" /></a></th>
										<td><a href="#" class="text-primary fw-bold">Áo sơ mi
												lụa đính hoa</a></td>
										<td>1.150.000đ</td>
										<td class="fw-bold">63</td>
										<td>72.450.000đ</td>
									</tr>
									<tr>
										<th scope="row"><a href="#"><img
												src="<c:url value='/templates/admin/img/product-5.jpg'/>"
												alt="" /></a></th>
										<td><a href="#" class="text-primary fw-bold">Elegant
												Silk Blouse - Áo sơ mi lụa</a></td>
										<td>850.000đ</td>
										<td class="fw-bold">41</td>
										<td>34.850.000đ</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- End Top Selling -->

				<!-- News & Updates Traffic -->
				<div class="col-12">
					<div class="card">
						<div class="filter">
							<a class="icon" href="#" data-bs-toggle="dropdown"><i
								class="bi bi-three-dots"></i></a>
							<ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow">
								<li class="dropdown-header text-start">
									<h6>Bộ lọc</h6>
								</li>

								<li><a class="dropdown-item" href="#">Hôm nay</a></li>
								<li><a class="dropdown-item" href="#">Tháng này</a></li>
								<li><a class="dropdown-item" href="#">Năm này</a></li>
							</ul>
						</div>

						<div class="card-body pb-0" id="tintuc">
							<h5 class="card-title">
								Tin tức &amp; Cập nhật <span>| Hôm nay</span>
							</h5>

							<div class="news pb-4">
								<div class="post-item clearfix">
									<img src="<c:url value='/templates/admin/img/news-1.jpg'/>"
										alt="" />
									<h4>
										<a href="#">Giảm giá sốc 50% toàn bộ sản phẩm nhân dịp
											sinh nhật cửa hàng!</a>
									</h4>
									<p>Sinh nhật vui – Quà tặng khủng! Chỉ trong 3 ngày duy
										nhất,...</p>
								</div>

								<div class="post-item clearfix">
									<img src="<c:url value='/templates/admin/img/news-2.jpg'/>"
										alt="" />
									<h4>
										<a href="#">Ra mắt BST Xuân Hè 2025 – Xu hướng thời trang
											bạn không thể bỏ lỡ!</a>
									</h4>
									<p>Đã đến lúc F5 tủ đồ của bạn với BST Xuân Hè 2025!</p>
								</div>

								<div class="post-item clearfix">
									<img src="<c:url value='/templates/admin/img/news-3.jpg'/>"
										alt="" />
									<h4>
										<a href="#">5 cách mix & match áo sơ mi giúp bạn luôn thời
											thượng</a>
									</h4>
									<p>Bạn nghĩ áo sơ mi chỉ dành cho môi trường công sở? Sai
										rồi! Hãy khám phá ngay 5 cách phối áo sơ mi cực chất..</p>
								</div>

								<div class="post-item clearfix">
									<img src="<c:url value='/templates/admin/img/news-4.jpg'/>"
										alt="" />
									<h4>
										<a href="#">Cảnh báo hàng giả – Chỉ mua hàng chính hãng
											tại website của chúng tôi</a>
									</h4>
									<p>Gần đây, có nhiều sản phẩm giả mạo thương hiệu của chúng
										tôi xuất hiện trên thị trường...</p>
								</div>

								<div class="post-item clearfix">
									<img src="<c:url value='/templates/admin/img/news-5.jpg'/>"
										alt="" />
									<h4>
										<a href="#">Hơn 5000 khách hàng đã đặt hàng trong tháng
											qua – Còn bạn thì sao?</a>
									</h4>
									<p>Hơn 5000 tín đồ thời trang đã chọn chúng tôi trong tháng
										qua để nâng cấp phong cách của họ!...</p>
								</div>
							</div>
							<!-- End sidebar recent posts-->
						</div>
					</div>
				</div>
				<!-- End News & Updates -->
			</div>
		</section>
	</main>
	<!-- End #main -->
</body>
</html>