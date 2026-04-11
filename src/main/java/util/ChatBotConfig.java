package util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

/**
 * ChatBotConfig - Quản lý cấu hình ChatBot từ file .env
 * Đảm bảo API Key được lưu trữ an toàn, không hardcode trực tiếp vào mã nguồn.
 */
public class ChatBotConfig {

    private static final Map<String, String> envProperties = loadEnv();

    // OpenAI Configuration - Lấy giá trị từ file .env.
    // GIÁ TRỊ MẶC ĐỊNH ĐỂ TRỐNG ĐỂ ĐẢM BẢO BẢO MẬT KHI PUSH LÊN GITHUB.
    public static final String OPENAI_API_KEY = getEnv("OPENAI_API_KEY", "");
    public static final String CHATBOT_MODEL = getEnv("CHATBOT_MODEL", "gpt-3.5-turbo");
    public static final double CHATBOT_TEMPERATURE =
            Double.parseDouble(getEnv("CHATBOT_TEMPERATURE", "0.7"));
    public static final int CHATBOT_MAX_TOKENS =
            Integer.parseInt(getEnv("CHATBOT_MAX_TOKENS", "500"));

    // OpenAI API Endpoint
    public static final String OPENAI_API_URL = "https://api.openai.com/v1/chat/completions";

    // System Prompt cho ChatBot
    public static final String SYSTEM_PROMPT = """
        Bạn là một trợ lý bán hàng AI chuyên nghiệp cho cửa hàng thời trang IVY moda.
        
        ===== NHIỆM VỤ CHÍNH =====
        1. Phân tích ngữ cảnh câu hỏi của khách hàng (ví dụ: buổi tiệc tối, đi chơi, công sở, hẹn hò, du lịch)
        2. Sử dụng dữ liệu sản phẩm THỰC TẾ từ hệ thống để gợi ý sản phẩm CHÍNH XÁC
        3. Cung cấp thông tin chi tiết: ID sản phẩm, tên, giá, màu, size, mô tả, số lượng còn
        4. Hướng dẫn khách hàng cách chọn sản phẩm phù hợp với tình huống cụ thể
        
        ===== KHI NGƯỜI DÙNG HỎI VỀ SẢN PHẨM =====
        ✓ PHÂN TÍCH NGỮ CẢNH:
          - "Tôi có buổi tiệc tối nay" → Tìm sản phẩm trang trọng, sang trọng
          - "Đi chơi dạo phố" → Tìm sản phẩm casual, thoải mái
          - "Hẹn hò/Tình yêu" → Tìm sản phẩm duyên dáng, quyến rũ
          - "Du lịch/Chuyến đi" → Tìm sản phẩm nhẹ, thoải mái, thực dụng
          - "Công sở/Làm việc" → Tìm sản phẩm chuyên nghiệp, lịch sự
        
        ✓ TRÍCH DẪN THÔNG TIN CHÍNH XÁC:
          - Sử dụng từ dữ liệu sản phẩm được cung cấp (ID, tên, giá, màu, size, description)
          - Nếu sản phẩm phù hợp → Cung cấp ID sản phẩm để khách dễ tìm kiếm mua
          - Nhấn mạnh các đặc điểm phù hợp với nhu cầu của khách (từ description)
        
        ✓ GỢI Ý THÔNG MINH:
          - Nếu có sản phẩm phù hợp → Liệt kê 3-5 sản phẩm tốt nhất với giải thích TẠI SAO phù hợp
          - Nếu không có sản phẩm tương tự → Gợi ý sản phẩm thay thế gần nhất
          - Luôn nhắc khách xem ảnh chi tiết trước khi mua
        
        ===== QUY TẮC TRẢ LỜI =====
        ✓ Luôn sử dụng tiếng Việt tự nhiên, thân thiện, chuyên nghiệp
        ✓ Trích dẫn thông tin SẢN PHẨM CHÍNH XÁC từ hệ thống (không bịa đặt)
        ✓ Nếu không chắc chắn → Hỏi thêm để hiểu rõ nhu cầu khách ("Bạn muốn trang trọng hay casual?")
        ✓ Không cung cấp thông tin sai lệch về sản phẩm
        ✓ Nếu hỏi về thứ không liên quan thời trang → Lịch sự chuyển hướng về sản phẩm IVY
        
        ===== ĐỊNH DẠNG TRẢ LỜI GỢI Ý =====
        Khi gợi ý sản phẩm, hãy trả lời theo mẫu:
        "Dựa vào nhu cầu của bạn [ngữ cảnh], tôi gợi ý những sản phẩm phù hợp:
        
        1️⃣ [Tên sản phẩm] (ID: [ID])
           - Giá: [Giá]
           - Lý do phù hợp: [Giải thích tại sao sản phẩm này phù hợp]
           - Đặc điểm: [Lấy từ mô tả sản phẩm]
        
        2️⃣ [Tên sản phẩm] (ID: [ID])
           ...
        
        Hãy xem ảnh chi tiết và kiểm tra size trước khi mua!"
        """;

    /**
     * Load .env file từ project root hoặc classpath
     */
    private static Map<String, String> loadEnv() {
        Map<String, String> properties = new HashMap<>();
        try {
            // 1. Thử load từ các cấp thư mục khác nhau (cho môi trường dev)
            File envFile = new File(".env");
            if (!envFile.exists()) envFile = new File("../.env");
            if (!envFile.exists()) envFile = new File("../../.env");

            if (envFile.exists()) {
                try (BufferedReader br = new BufferedReader(new FileReader(envFile))) {
                    readToMap(br, properties);
                }
            } else {
                // 2. Thử load từ classpath (cho môi trường production/war file)
                var resource = ChatBotConfig.class.getClassLoader().getResourceAsStream(".env");
                if (resource != null) {
                    try (BufferedReader br = new BufferedReader(new InputStreamReader(resource))) {
                        readToMap(br, properties);
                    }
                } else {
                    System.err.println("⚠️  Warning: .env file not found! ChatBot might not work.");
                }
            }
        } catch (IOException e) {
            System.err.println("❌ Error loading .env file: " + e.getMessage());
        }
        return properties;
    }

    private static void readToMap(BufferedReader br, Map<String, String> properties) throws IOException {
        String line;
        while ((line = br.readLine()) != null) {
            line = line.trim();
            if (line.isEmpty() || line.startsWith("#") || line.startsWith(";")) {
                continue;
            }
            int equals = line.indexOf('=');
            if (equals > 0) {
                String key = line.substring(0, equals).trim();
                String value = line.substring(equals + 1).trim();
                properties.put(key, value);
            }
        }
    }

    /**
     * Lấy giá trị từ Map thuộc tính hoặc giá trị mặc định
     */
    private static String getEnv(String key, String defaultValue) {
        String value = envProperties.get(key);
        if (value == null || value.isEmpty()) {
            return defaultValue;
        }
        return value;
    }

    public static boolean isConfigured() {
        return OPENAI_API_KEY != null && !OPENAI_API_KEY.isEmpty();
    }

    public static String getApiKey() {
        return OPENAI_API_KEY;
    }
}