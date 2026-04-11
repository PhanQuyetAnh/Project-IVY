/**
 * chatbot.js - Logic JavaScript cho ChatBot Widget
 * Xử lý: Toggle show/hide, Gửi tin nhắn, Hiển thị response
 * Lưu lịch sử chat vào localStorage
 */

$(document).ready(function() {

    // ===== BIẾN TOÀN CỤC =====
    const $chatWidget = $('#chatbot-widget');
    const $toggleBtn = $('#chatbot-toggle-btn');
    const $closeBtn = $('#chatbot-close-btn');
    const $messagesContainer = $('#chatbot-messages');
    const $input = $('#chatbot-message-input');
    const $sendBtn = $('#chatbot-send-btn');

    // LocalStorage key để lưu chat history
    const CHAT_HISTORY_KEY = 'chatbot_chat_history';

    let isLoading = false; // Cờ kiểm tra xem đang chờ response không

    // ===== KHỞI ĐỘNG: Load lịch sử chat từ localStorage =====
    loadChatHistory();

    // ===== EVENT: Click nút Toggle (Mở/Đóng ChatBot) =====
    $toggleBtn.on('click', function() {
        $chatWidget.addClass('active');  // ← Thêm class .active để hiển thị
        $toggleBtn.addClass('hidden');   // ← Ẩn nút toggle
        $input.focus(); // Tự động focus vào input
    });

    // ===== EVENT: Click nút Close (Đóng ChatBot) =====
    $closeBtn.on('click', function() {
        $chatWidget.removeClass('active');  // ← Xóa class .active để ẩn
        $toggleBtn.removeClass('hidden');   // ← Hiển thị lại nút toggle
    });

    // ===== EVENT: Click nút Send hoặc nhấn Enter =====
    $sendBtn.on('click', sendMessage);
    $input.on('keypress', function(e) {
        if (e.which === 13) { // Enter key
            sendMessage();
        }
    });

    // ===== FUNCTION: Load lịch sử chat từ localStorage =====
    function loadChatHistory() {
        try {
            const savedHistory = localStorage.getItem(CHAT_HISTORY_KEY);
            if (savedHistory) {
                const messages = JSON.parse(savedHistory);
                // Xóa tin nhắn initial (Xin chào)
                $messagesContainer.empty();
                // Restore các tin nhắn cũ
                messages.forEach(function(msg) {
                    appendMessage(msg.text, msg.sender, false); // false = không lưu lại (đã lưu)
                });
            }
        } catch(e) {
            console.error('Error loading chat history:', e);
        }
    }

    // ===== FUNCTION: Lưu tin nhắn vào localStorage =====
    function saveChatHistory() {
        try {
            const messages = [];
            $messagesContainer.find('.chatbot-message').each(function() {
                const $bubble = $(this).find('.message-bubble');
                const text = $bubble.text();
                const sender = $(this).hasClass('user-message') ? 'user' : 'bot';

                // Không lưu loading indicator
                if (text.trim() && text !== '...' && !text.includes('●')) {
                    messages.push({ text: text, sender: sender });
                }
            });
            localStorage.setItem(CHAT_HISTORY_KEY, JSON.stringify(messages));
        } catch(e) {
            console.error('Error saving chat history:', e);
        }
    }

    // ===== FUNCTION: Xóa lịch sử chat (gọi khi logout) =====
    function clearChatHistory() {
        try {
            localStorage.removeItem(CHAT_HISTORY_KEY);
        } catch(e) {
            console.error('Error clearing chat history:', e);
        }
    }

    // ===== PUBLIC FUNCTION: Xóa chat history khi logout =====
    // Gọi hàm này khi user click "Đăng xuất"
    window.clearChatHistoryOnLogout = function() {
        clearChatHistory();
    };

    // ===== FUNCTION: Gửi tin nhắn =====
    function sendMessage() {
        const message = $input.val().trim();

        // Kiểm tra tin nhắn không được rỗng
        if (!message || isLoading) {
            return;
        }

        // Hiển thị tin nhắn của user
        appendMessage(message, 'user');

        // Lưu chat history sau khi thêm tin nhắn
        saveChatHistory();

        // Xóa input
        $input.val('');

        // Hiện loading indicator
        showLoading();

        // Gửi AJAX request đến ChatBotController
        // ⚠️ FIX: Sử dụng đúng URL context path
        var contextPath = $('meta[name="contextPath"]').attr('content') || '/jsp-servlet';

        $.ajax({
            url: contextPath + '/chatbot',  // ← Sử dụng context path động
            type: 'POST',
            data: { message: message },
            dataType: 'json',
            timeout: 30000,  // Timeout 30 giây
            success: function(response) {
                removeLoading();

                if (response.success) {
                    // Hiển thị response từ bot
                    appendMessage(response.message, 'bot');
                } else {
                    appendMessage('❌ ' + response.message, 'bot');
                }

                // Lưu chat history sau khi nhận response
                saveChatHistory();
            },
            error: function(xhr, status, error) {
                removeLoading();

                // Debug: In lỗi chi tiết
                console.error('ChatBot Error:', {
                    status: status,
                    error: error,
                    statusCode: xhr.status,
                    responseText: xhr.responseText
                });

                var errorMsg = '❌ Lỗi kết nối';
                if (status === 'timeout') {
                    errorMsg = '❌ Timeout: Vui lòng kiểm tra kết nối mạng';
                } else if (xhr.status === 404) {
                    errorMsg = '❌ Lỗi 404: Endpoint /chatbot không tìm thấy';
                } else if (xhr.status === 500) {
                    errorMsg = '❌ Lỗi 500: Server error - Kiểm tra logs';
                }

                appendMessage(errorMsg, 'bot');
            }
        });

        isLoading = true;
    }

    // ===== FUNCTION: Thêm tin nhắn vào messages container =====
    function appendMessage(text, sender) {
        const messageClass = sender === 'user' ? 'user-message' : 'bot-message';
        const messageHTML = `
            <div class="chatbot-message ${messageClass}">
                <div class="message-bubble">${escapeHtml(text)}</div>
            </div>
        `;

        $messagesContainer.append(messageHTML);

        // Tự động cuộn xuống dưới cùng
        $messagesContainer.scrollTop($messagesContainer[0].scrollHeight);
    }

    // ===== FUNCTION: Hiển thị Loading Indicator =====
    function showLoading() {
        const loadingHTML = `
            <div class="chatbot-message bot-message" id="loading-indicator">
                <div class="message-bubble loading">
                    <div class="loading-dot"></div>
                    <div class="loading-dot"></div>
                    <div class="loading-dot"></div>
                </div>
            </div>
        `;

        $messagesContainer.append(loadingHTML);
        $messagesContainer.scrollTop($messagesContainer[0].scrollHeight);
    }

    // ===== FUNCTION: Xóa Loading Indicator =====
    function removeLoading() {
        $('#loading-indicator').remove();
        isLoading = false;
    }

    // ===== FUNCTION: Escape HTML để tránh XSS =====
    function escapeHtml(text) {
        const map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return text.replace(/[&<>"']/g, m => map[m]);
    }
});
