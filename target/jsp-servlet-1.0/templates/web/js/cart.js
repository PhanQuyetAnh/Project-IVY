/**
 * IVY moda - Cart Logic (SSR Version)
 * Fix: Chống xung đột Toast & Hiển thị thông báo xóa
 */

const contextPath = window.location.pathname.includes('/jsp_servlet_war_exploded') ? '/jsp_servlet_war_exploded' : '';

$(document).ready(function() {
    // 1. Sidebar reload state
    if (sessionStorage.getItem('keepMiniCartOpen') === 'true') {
        $('#miniCartSidebar').css('transition', 'none');
        $('#miniCartSidebar, #miniCartOverlay').addClass('active');
        setTimeout(function() {
            $('#miniCartSidebar').css('transition', 'transform 0.3s ease-in-out');
        }, 50);
        sessionStorage.removeItem('keepMiniCartOpen');
    }

    // 2. Sidebar Toggle
    $(document).on('click', '.header .inner-cart a, .cart-icon, .bag-icon, #openMiniCart', function(e) {
        e.preventDefault();
        e.stopPropagation();
        $('#miniCartSidebar, #miniCartOverlay').addClass('active');
    });

    $(document).on('click', '#miniCartClose, #miniCartOverlay', function() {
        $('#miniCartSidebar, #miniCartOverlay').removeClass('active');
    });

    // 3. Quantity Up
    $(document).on('click', '.btn-qty-up', function() {
        const pid = $(this).attr('data-product-id');
        const size = $(this).attr('data-product-size');
        updateCartQuantity(pid, size, 'up');
    });

    // 4. Quantity Down (CHỐT: Hiển thị thông báo xóa ngay tại đây)
    $(document).on('click', '.btn-qty-down', function() {
        const pid = $(this).attr('data-product-id');
        const size = $(this).attr('data-product-size');
        const currentQty = parseInt($(this).closest('.item-quantity-control').find('.qty-display').text()) || 1;

        if (currentQty <= 1) {
            showToast('! Đã xóa sản phẩm khỏi giỏ hàng');
        }
        updateCartQuantity(pid, size, 'down');
    });

    // 5. Remove Item
    $(document).on('click', '.btn-remove-item', function() {
        if (confirm("Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?")) {
            const pid = $(this).attr('data-product-id');
            const size = $(this).attr('data-product-size');
            deleteCartItem(pid, size);
        }
    });
});

// ========== AJAX FUNCTIONS ==========

function updateCartQuantity(pid, size, action) {
    $.post(contextPath + '/customer/update-cart', {
        product_id: pid, size: size, action: action
    }, function() {
        refreshCartUI(true);
    }).fail(function() {
        showToast('✗ Lỗi cập nhật số lượng');
    });
}

function refreshCartUI(openSidebar = false) {
    const refreshUrl = window.location.href + (window.location.href.includes('?') ? '&' : '?') + "t=" + new Date().getTime();

    // Dùng Fetch API (thay cho $.get) để đảm bảo sạch sẽ hoàn toàn
    fetch(refreshUrl)
        .then(response => response.text())
        .then(htmlData => {
            const parser = new DOMParser();
            const doc = parser.parseFromString(htmlData, "text/html");

            // Bóc tách nội dung bằng Vanilla JS (Không dùng jQuery ở đây)
            const newItemsElement = doc.getElementById('miniCartItems');
            const newTotalWrapperElement = doc.getElementById('miniCartTotalWrapper');

            if (newItemsElement) {
                // Đổ dữ liệu vào Sidebar thực trên màn hình
                document.getElementById('miniCartItems').innerHTML = newItemsElement.innerHTML;
            }
            if (newTotalWrapperElement) {
                document.getElementById('miniCartTotalWrapper').innerHTML = newTotalWrapperElement.innerHTML;
            }

            // Sau khi đắp HTML xong, gọi lại các hàm bổ trợ
            updateCartBadge();

            if (openSidebar) {
                // Chỉ dùng jQuery cho việc thêm class (vì nó không dính đến eval)
                $('#miniCartSidebar, #miniCartOverlay').addClass('active');
            }
        })
        .catch(error => console.error('Lỗi khi cập nhật giỏ hàng:', error));
}


function deleteCartItem(pid, size) {
    $.post(contextPath + '/customer/delete-cart-item', {
        product_id: pid, size: size
    }, function() {
        showToast('! Đã xóa sản phẩm khỏi giỏ hàng');
        refreshCartUI(true);
    });
}

function updateCartBadge() {
    let rowCount = $('#miniCartItems .cart-item').length;
    if ($('#miniCartItems .mini-cart-empty').length > 0) rowCount = 0;
    $('#cartBadge').text(rowCount);
}

// ========== TOAST ENGINE (CHỐT CSS & ANIMATION) ==========

let toastTimeout; // Biến này để quản lý thời gian, tránh bị chồng chéo khi click nhanh

function showToast(message, duration = 3000) {
    // 1. Nếu đang có thông báo cũ, xóa ngay lập tức để hiện cái mới
    $('#ivyAppToast').remove();
    clearTimeout(toastTimeout);

    // 2. Tự động Inject CSS nếu chưa có (Đã fix vị trí top: 100px)
    if ($('#ivyToastCSS').length === 0) {
        $('head').append(`
            <style id="ivyToastCSS">
                #ivyAppToast {
                    position: fixed !important;
                    top: 100px !important;
                    right: -450px; /* Bắt đầu từ ngoài rìa phải */
                    min-width: 300px !important;
                    padding: 16px 24px !important;
                    border-radius: 8px !important;
                    z-index: 9999999 !important;
                    color: #fff !important;
                    font-weight: 600 !important;
                    box-shadow: 0 4px 15px rgba(0,0,0,0.25) !important;
                    transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275) !important;
                    bottom: auto !important;
                }
                #ivyAppToast.active {
                    right: 20px !important; /* Trượt vào trong màn hình */
                }
            </style>
        `);
    }

    // 3. Tạo thẻ Toast mới
    const $toast = $('<div id="ivyAppToast"></div>');
    $('body').append($toast);

    // 4. Phân loại màu sắc
    let bgColor = '#28a745'; // Mặc định: Xanh
    let msgLower = message.toLowerCase();
    if (msgLower.includes('xóa') || message.includes('!')) bgColor = '#dc3545'; // Đỏ
    else if (msgLower.includes('lỗi') || msgLower.includes('vui lòng')) bgColor = '#ffc107'; // Vàng

    $toast.text(message).css({
        'background-color': bgColor,
        'color': (bgColor === '#ffc107' ? '#000' : '#fff')
    });

    // 5. Hiển thị: Trượt vào
    setTimeout(() => { $toast.addClass('active'); }, 10);

    // 6. Tự động biến mất: Trượt ra rồi XÓA HẲN (remove)
    toastTimeout = setTimeout(() => {
        $toast.removeClass('active'); // Trượt ra ngoài rìa
        setTimeout(() => {
            $toast.remove(); // Xóa thẻ khỏi DOM để không đọng lại ở mép
        }, 500); // Đợi hiệu ứng trượt kết thúc rồi mới xóa
    }, duration);
}