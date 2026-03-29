$(document).ready(function() {
    // ==========================================
    // 1. XỬ LÝ VOUCHER (MÃ GIẢM GIÁ)
    // ==========================================
    $(".btn-apply").click(function(e) {
        e.preventDefault();

        // Lấy mã từ ô input (Dùng ID đã thêm ở JSP)
        var voucherInput = $("#voucher-input");

        // Kiểm tra nếu không tìm thấy ô input thì báo lỗi nhẹ để debug
        if (voucherInput.length === 0) {
            console.error("Không tìm thấy ô nhập mã giảm giá (#voucher-input)");
            return;
        }

        var voucherCode = voucherInput.val().trim();

        if (voucherCode === "") {
            alert("Vui lòng nhập mã giảm giá!");
            return;
        }

        $.ajax({
            // Đảm bảo đường dẫn này đúng với Context Path của bạn
            url: window.location.origin + "/jsp_servlet_war_exploded/api/check-voucher",
            type: "GET",
            data: { code: voucherCode },
            success: function(response) {
                if (response.success) {
                    var discount = response.discount;

                    // 1. Hiển thị dòng Giảm giá và số tiền giảm
                    $("#discount-row").show();
                    $("#discount-display").text("-" + discount.toLocaleString() + "đ");

                    // 2. Tính lại tổng tiền thanh toán
                    var totalOriginal = parseInt($("#final-total-display").attr("data-original-sum"));
                    var totalAfter = totalOriginal - discount;
                    if(totalAfter < 0) totalAfter = 0;

                    // 3. Cập nhật số tiền cuối cùng
                    $("#final-total-display").text(totalAfter.toLocaleString() + "đ");

                    alert("Áp dụng mã " + voucherCode + " thành công!");
                } else {
                    alert(response.message);
                }
            },
            error: function() {
                alert("Không thể kết nối với máy chủ để kiểm tra mã!");
            }
        });
    });

    // ==========================================
    // 2. XỬ LÝ ĐỊA CHỈ (Giữ nguyên vì đã chuẩn)
    // ==========================================
    const addressData = {
        "Hà Nội": {
            "Quận Cầu Giấy": ["Phường Dịch Vọng", "Phường Mai Dịch", "Phường Quan Hoa"],
            "Quận Hoàn Kiếm": ["Phường Hàng Bạc", "Phường Hàng Đào", "Phường Tràng Tiền"],
            "Quận Đống Đa": ["Phường Láng Hạ", "Phường Quang Trung", "Phường Ô Chợ Dừa"],
            "Quận Nam Từ Liêm": ["Phường Mỹ Đình 1", "Phường Mỹ Đình 2", "Phường Mễ Trì", "Phường Tây Mỗ", "Phường Đại Mỗ"]
        },
        "TP HCM": {
            "Quận 1": ["Phường Bến Nghé", "Phường Bến Thành", "Phường Đa Kao"],
            "Quận 3": ["Phường Võ Thị Sáu", "Phường 1", "Phường 2"],
            "Quận Tân Bình": ["Phường 1", "Phường 2", "Phường 15"],
            "TP Thủ Đức": ["Phường Thảo Điền", "Phường An Phú", "Phường Hiệp Bình Chánh"]
        },
        "Đà Nẵng": {
            "Quận Hải Châu": ["Phường Hòa Cường Bắc", "Phường Hòa Cường Nam"],
            "Quận Thanh Khê": ["Phường Vĩnh Trung", "Phường Tân Chính"],
            "Quận Liên Chiểu": ["Phường Hòa Khánh Bắc", "Phường Hòa Khánh Nam"]
        }
    };

    $('#province').on('change', function() {
        const province = $(this).val();
        $('#district').html('<option value="" selected disabled>Quận/Huyện</option>');
        $('#ward').html('<option value="" selected disabled>Phường/Xã</option>');

        if (addressData[province]) {
            Object.keys(addressData[province]).forEach(district => {
                $('#district').append('<option value="'+district+'">'+district+'</option>');
            });
        }
    });

    $('#district').on('change', function() {
        const province = $('#province').val();
        const district = $(this).val();
        $('#ward').html('<option value="" selected disabled>Phường/Xã</option>');

        if (addressData[province] && addressData[province][district]) {
            addressData[province][district].forEach(ward => {
                $('#ward').append('<option value="'+ward+'">'+ward+'</option>');
            });
        }
    });
});