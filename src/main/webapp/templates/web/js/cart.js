document.querySelectorAll('.dropdown-item').forEach(function(item) {
    item.addEventListener('click', function(e) {
        e.preventDefault();
        const size = this.getAttribute('data-size');
        const productId = this.getAttribute('data-product-id'); // bạn thay bằng ID thật nếu có
        const quantity = 1;

        // Tạo URL để gửi yêu cầu
        const url = `/jsp-servlet/customer/add-to-cart?product_id=${productId}&size=${size}&quantity=${quantity}`;
        window.location.href = url;
    });
});

// Cart Detail
const $boxCartDetail = $(".cart-detail");
if ($boxCartDetail.length) {
    // Xử lý click nút tăng số lượng
    $boxCartDetail.find(".section-5-up").on("click", function () {
        const $parent = $(this).closest(".quantity");
        const $input = $parent.find("input");
        let number = parseInt($input.val()) || 0;
        $input.val(number + 1);
    });

    // Xử lý click nút giảm số lượng
    $boxCartDetail.find(".section-5-down").on("click", function () {
        const $parent = $(this).closest(".quantity");
        const $input = $parent.find("input");
        let number = parseInt($input.val()) || 0;
        if (number > 0) {
            $input.val(number - 1);
        }
    });
}
// End Cart Detail