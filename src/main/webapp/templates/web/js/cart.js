/**
 * IVY moda - Cart Logic (SSR Version)
 * Fix: Chống xung đột Toast & Hiển thị thông báo xóa + Fix lỗi trang Giỏ hàng lớn
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

        // Chặn mở Minicart nếu đang đứng ở trang Giỏ hàng lớn (Trang 1) hoặc trang Thanh toán
        if (window.location.pathname.includes('/customer/cart') || window.location.pathname.includes('/customer/checkout')) {
            window.location.href = contextPath + '/customer/cart'; // Nếu lỡ bấm icon giỏ hàng thì load lại trang cart
            return;
        }

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

    // 4. Quantity Down
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
    // =================================================================
    // CHỐT CHẶN: Kiểm tra nếu đang ở trang Giỏ hàng lớn thì load lại luôn
    // Không cho chạy lệnh bóc tách HTML và xổ Minicart bên dưới nữa
    // =================================================================
    if (window.location.pathname.includes('/customer/cart')) {
        window.location.reload();
        return;
    }

    const refreshUrl = window.location.href + (window.location.href.includes('?') ? '&' : '?') + "t=" + new Date().getTime();

    fetch(refreshUrl)
        .then(response => response.text())
        .then(htmlData => {
            const parser = new DOMParser();
            const doc = parser.parseFromString(htmlData, "text/html");

            const newItemsElement = doc.getElementById('miniCartItems');
            const newTotalWrapperElement = doc.getElementById('miniCartTotalWrapper');

            if (newItemsElement) {
                document.getElementById('miniCartItems').innerHTML = newItemsElement.innerHTML;
            }
            if (newTotalWrapperElement) {
                document.getElementById('miniCartTotalWrapper').innerHTML = newTotalWrapperElement.innerHTML;
            }

            updateCartBadge();

            if (openSidebar) {
                $('#miniCartSidebar, #miniCartOverlay').addClass('active');
            }
        })
        .catch(error => console.error('Lỗi khi cập nhật giỏ hàng:', error));
}


function deleteCartItem(pid, size) {
    // 1. Sửa lại đường link cho khớp với @WebServlet
    $.post(contextPath + '/customer/cart-delete-item', {
        productId: pid, // 2. Sửa chữ product_id thành productId cho khớp request.getParameter
        size: size
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

// ========== TOAST ENGINE ==========

let toastTimeout;

function showToast(message, duration = 3000) {
    $('#ivyAppToast').remove();
    clearTimeout(toastTimeout);

    if ($('#ivyToastCSS').length === 0) {
        $('head').append(`
            <style id="ivyToastCSS">
                #ivyAppToast {
                    position: fixed !important;
                    top: 100px !important;
                    right: -450px; 
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
                    right: 20px !important; 
                }
            </style>
        `);
    }

    const $toast = $('<div id="ivyAppToast"></div>');
    $('body').append($toast);

    let bgColor = '#28a745';
    let msgLower = message.toLowerCase();
    if (msgLower.includes('xóa') || message.includes('!')) bgColor = '#dc3545';
    else if (msgLower.includes('lỗi') || msgLower.includes('vui lòng')) bgColor = '#ffc107';

    $toast.text(message).css({
        'background-color': bgColor,
        'color': (bgColor === '#ffc107' ? '#000' : '#fff')
    });

    setTimeout(() => { $toast.addClass('active'); }, 10);

    toastTimeout = setTimeout(() => {
        $toast.removeClass('active');
        setTimeout(() => {
            $toast.remove();
        }, 500);
    }, duration);
}