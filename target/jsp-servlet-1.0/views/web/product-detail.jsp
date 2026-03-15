<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm | IVY moda</title>

</head>
<body>
<!-- Product Detail -->
<div class="product-detail">
    <div class="container">
        <div class="box-breadcumb">
            <nav>
                <ul>
                    <li><a href="<c:url value='/trang-chu'/>">Trang chủ<i class="fa-solid fa-minus"></i></a></li>
                    <li><a href="#">${product.productCategory}<i class="fa-solid fa-minus"></i></a></li>
                    <li><a href="#">${product.productName}</a></li>
                </ul>
            </nav>
        </div>
        <c:if test="${not empty product}">

            <div class="row">
                <div class="col-md-6">
                    <div class="product-detail__gallery">
                        <div class="product-gallery__slide">
                            <div class="product-gallery__slide-big">
                                <!-- <img src="assets/images/detail1.webp" alt=""> -->
                                <div id="carouselExampleIndicators" class="carousel slide">
                                    <div class="carousel-indicators">
                                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
                                        <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="3" aria-label="Slide 4"></button>
                                    </div>
                                    <div class="carousel-inner">
                                        <div class="carousel-item active">
                                            <img src="<c:url value='${product.productImage}'/>" class="d-block w-100" alt="...">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="<c:url value='${product.productImage}'/>" class="d-block w-100" alt="...">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="<c:url value='${product.productImage}'/>" class="d-block w-100" alt="...">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="<c:url value='${product.productImage}'/>" class="d-block w-100" alt="...">
                                        </div>
                                    </div>
                                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>

                            </div>
                            <div class="product-gallery__slide-small">
                                <div class="swiper-wraper">
                                    <div class="swiper-slide">
                                        <img src="<c:url value='${product.productImage}'/>" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="<c:url value='${product.productImage}'/>" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="<c:url value='${product.productImage}'/>" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="<c:url value='${product.productImage}'/>" alt="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="product-detail__information">
                        <h1>${product.productName}</h1>
                        <div class="product-detail__sub-infor">
                            <span>${product.productCode}</span>
                            <div class="product-detail__rating">
                                <div class="product-detail__rating-star">
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                    <i class="fa-solid fa-star"></i>
                                </div>
                                <span>(0 đánh giá)</span>
                            </div>
                        </div>
                        <div class="product-detail__price">
                            <b>${product.productPrice}</b>
                        </div>
                        <div class="product-detail__color">
                            <p>Màu sắc:${product.productColor}</p>
                            <div class="product-detail__color-check">
                                <button class="check-empty"></button>
                                <button class="check"><i class="fa-solid fa-check"></i></button>
                            </div>


                        </div>
                        <div class="product-detail__size">
                            <div class="product-detail__size-input">
                                <p>S</p>
                                <p>M</p>
                                <p>L</p>
                                <p>XL</p>
                                <p>XXL</p>
                            </div>
                            <p class="check-size"><i class=" fa-solid fa-ruler"></i>Kiểm tra size của bạn</p>
                        </div>
                        <div class="product-detail__quanlity">
                            <h3>Số lượng</h3>
                            <div class="product-detail__num">
                                <div class="product-detail__num-decre"><i class="fa-solid fa-minus"></i></div>
                                <span>${product.productQuantity}</span>
                                <div class="product-detail__num-incre"><i class="fa-solid fa-plus"></i></div>
                            </div>
                        </div>
                        <div class="product-detail__action">
                            <button class="add">Thêm vào giỏ</button>
                            <button class="buy">Mua hàng</button>
                            <button class="heart"><i class="bi bi-heart"></i></button>
                        </div>
                        <div class="product-detail__find">
                            <a>Tìm tại cửa hàng</a>
                        </div>

                        <div class="product-detail__tab">
                            <nav class="tab-navs">
                                <ul>
                                    <li><a href="#tab1" class="active">Giới Thiệu</a></li>
                                    <li><a href="#tab2">Chi Tiết Sản Phẩm</a></li>
                                    <li><a href="#tab3">Bảo Quản</a></li>
                                </ul>
                            </nav>
                            <div class="tab-contents">
                                <div id="tab1">
                                    <div class="tab-content-inner">
                                        <p>Bliss Dress là sự kết hợp hoàn hảo giữa vẻ đẹp thanh lịch và nữ tính,
                                            phù hợp cho nhiều dịp khác nhau từ đi chơi, dự tiệc đến dạo phố. Đây là một lựa chọn tuyệt vời cho nàng
                                            muốn thể hiện nét dịu dàng qua phong cách thời trang của mình.
                                        </p>
                                        <h3>Thông tin mẫu:</h3>
                                        <h3>Chiều cao: <span>167cm</span></h3>
                                        <h3>Cân nặng: <span>50kg</span></h3>
                                        <h3>Số đo 3 vòng:  <span>83-67-99 cm</span></h3>
                                        <p>Lưu ý: Màu sắc sản phẩm thực tế sẽ có sự chênh lệch nhỏ so với ảnh do điều kiện ánh sáng khi chụp
                                            và màu sắc hiển thị qua màn hình máy tính/ điện thoại.</p>
                                    </div>
                                    <div class="show-more-btn">
                                        <i class="fa-solid fa-chevron-down"></i>
                                    </div>
                                </div>
                                <div id="tab2">
                                    <div class="tab-content-inner">
                                        <h3>Dòng sản phẩm: <span>you</span></h3>
                                        <h3>Nhóm sản phẩm:  <span>Đầm</span></h3>
                                        <h3>Cổ áo: <span>Cổ tròn</span></h3>
                                        <h3>Tay áo: <span>Không tay</span></h3>
                                        <h3>Kiểu dáng:  <span>Đầm xòe</span></h3>
                                        <h3>Độ dài:  <span>qua gối</span></h3>
                                        <h3>Họa tiết:  <span>Trơn</span></h3>
                                        <h3>Chất liệu: <span>Tynsi</span></h3>
                                    </div>
                                    <div class="show-more-btn">
                                        <i class="fa-solid fa-chevron-down"></i>
                                    </div>
                                </div>
                                <div id="tab3">
                                    <div class="tab-content-inner">
                                        <h3>
                                            Chi tiết bảo quản:
                                        </h3>
                                        <p>* Vải dệt kim: sau khi giặt sản phẩm phải được phơi ngang tránh bai giãn.</p>
                                        <p>* Vải voan, lụa, chiffon nên giặt bằng tay.</p>
                                        <p>* Vải thô, tuytsi, kaki không có phối hay trang trí đá cườm thì có thể giặt máy.</p>
                                        <p>* Vải thô, tuytsi, kaki có phối màu tương phản hay trang trí voan, lụa, đá cườm thì cần giặt tay.</p>
                                        <p>* Đồ Jeans nên hạn chế giặt bằng máy giặt vì sẽ làm phai màu jeans.
                                            Nếu giặt thì nên lộn trái sản phẩm khi giặt, đóng khuy,
                                            kéo khóa, không nên giặt chung cùng đồ sáng màu, tránh dính màu vào các sản phẩm khác. </p>
                                    </div>
                                    <div class="show-more-btn">
                                        <i class="fa-solid fa-chevron-down"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="product-detail__tab-body">

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </c:if>
        <c:if test="${empty product}">
            <div class="inner-wrap">
                <p>Sản phẩm không tồn tại hoặc đã bị xóa.</p>
            </div>
        </c:if>
        <!-- Các phần "MUA CÙNG VỚI" và "Sản phẩm đã xem" có thể giữ nguyên hoặc cập nhật tương tự -->
    </div>
</div>



<script>
    $(document).ready(function() {
        // Áp dụng cho các ảnh trong carousel
        $('.carousel-item').mousemove(function(e) {
            const fare = $(this).offset(); // Lấy vị trí của khung ảnh so với trình duyệt

            // Tính toán vị trí chuột tương đối bên trong khung ảnh (%)
            const x = ((e.pageX - fare.left) / $(this).width()) * 100;
            const y = ((e.pageY - fare.top) / $(this).height()) * 100;

            // Cập nhật tâm điểm zoom (transform-origin) theo tọa độ chuột
            $(this).find('img').css('transform-origin', x + '% ' + y + '%');
        });

        // Khi chuột rời khỏi ảnh, trả tâm điểm về chính giữa (tùy chọn)
        $('.carousel-item').mouseleave(function() {
            $(this).find('img').css('transform-origin', 'center center');
        });
    });

    $(() => {
        // 1. Logic chuyển tab của bạn (đã thêm dấu > để bảo vệ rèm che)
        $(".tab-navs a").click(function (e) {
            e.preventDefault();
            $(".tab-navs a").removeClass("active");
            $(this).addClass("active");

            let currentTab = $(this).attr("href");

            // Sửa ở đây: thêm dấu ">" để chỉ ẩn tab cha (#tab1, #tab2...)
            $(".tab-contents > div").hide();
            $(currentTab).show();
        });

        // 2. Logic cho rèm che (Nút mũi tên)
        $(".show-more-btn").click(function() {
            // Tìm cái khung nội dung ngay phía trước nút này
            $(this).prev(".tab-content-inner").toggleClass("expanded");
            // Xoay mũi tên
            $(this).toggleClass("active");
        });
    });


</script>

</body>
</html>

