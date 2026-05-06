package service;

import util.ChatBotConfig;
import util.ProductSearchHelper;
import dao.Impl.ProductImpl;
import model.ProductObject;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.ArrayList;

/**
 * ChatBotService - Xử lý giao tiếp với OpenAI API
 * Gửi tin nhắn của user đến GPT-3.5 và trả về response
 * Tích hợp: Lấy dữ liệu sản phẩm từ database để trả lời chính xác
 */
public class ChatBotService {

    /**
     * Gửi tin nhắn đến OpenAI GPT-3.5 và nhận response
     * Nếu user hỏi về sản phẩm, trước tiên sẽ lấy dữ liệu từ database
     *
     * @param userMessage - Tin nhắn từ người dùng
     * @return Response từ chatbot
     * @throws IOException - Nếu có lỗi khi gọi API
     */
    public static String getChatResponse(String userMessage) throws IOException {
        // Kiểm tra API Key
        if (!ChatBotConfig.isConfigured()) {
            return "❌ Chatbot chưa được cấu hình. Vui lòng kiểm tra API Key.";
        }

        try {
            // 1. Lấy dữ liệu sản phẩm từ database nếu user hỏi về sản phẩm
            String productContext = getProductDataIfRelevant(userMessage);

            // 2. Xây dựng JSON request body cho Gemini (kèm dữ liệu sản phẩm nếu có)
            String jsonBody = buildGeminiJsonRequest(userMessage, productContext);

            // 3. Tạo HTTP Request
            String apiUrl = ChatBotConfig.GEMINI_API_URL + "?key=" + ChatBotConfig.getApiKey();
            URL url = new URL(apiUrl);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json");
            conn.setDoOutput(true);
            conn.setConnectTimeout(30000);
            conn.setReadTimeout(60000);

            // 4. Gửi request body
            try (OutputStream os = conn.getOutputStream()) {
                byte[] input = jsonBody.getBytes(StandardCharsets.UTF_8);
                os.write(input, 0, input.length);
            }

            // 5. Kiểm tra response code
            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                String errorMsg = readStream(conn.getErrorStream());
                return "❌ Lỗi API Gemini: " + responseCode + " - " + errorMsg;
            }

            // 6. Đọc response body
            String responseBody = readStream(conn.getInputStream());

            // 7. Parse JSON response từ Gemini
            String botMessage = extractMessageFromGeminiJson(responseBody);

            return botMessage;

        } catch (Exception e) {
            System.err.println("ChatBot Error: " + e.getMessage());
            e.printStackTrace();
            return "❌ Lỗi: " + e.getMessage();
        }
    }

    /**
     * Lấy dữ liệu sản phẩm từ database nếu user hỏi về sản phẩm
     * Sử dụng Smart Search: tìm kiếm dựa trên:
     * - Từ khóa trực tiếp (tên sản phẩm, màu, size)
     * - Ngữ cảnh (buổi tiệc, đi chơi, đi làm) → tìm sản phẩm phù hợp
     * - Mô tả sản phẩm (productDescription) để gợi ý chính xác
     */
    private static String getProductDataIfRelevant(String userMessage) {
        try {
            String messageLower = userMessage.toLowerCase();

            // Danh sách từ khóa liên quan đến sản phẩm
            String[] productKeywords = {
                    "sản phẩm", "áo", "quần", "váy", "giá", "mua", "bao nhiêu",
                    "có", "gì", "giống", "màu", "size", "kích", "loại", "hàng",
                    "hãy gợi ý", "tìm", "nào", "tiệc", "đi chơi", "đi làm",
                    "hẹn hò", "dạo phố", "du lịch", "công sở", "casual", "formal",
                    "phù hợp", "thích hợp", "phần", "mặc", "đi", "mới"
            };

            boolean isProductRelated = false;
            for (String keyword : productKeywords) {
                if (messageLower.contains(keyword)) {
                    isProductRelated = true;
                    break;
                }
            }

            if (!isProductRelated) {
                return "";
            }

            // Lấy danh sách sản phẩm từ database
            ProductImpl productDAO = new ProductImpl();
            List<ProductObject> allProducts = productDAO.getAllProducts();

            if (allProducts == null || allProducts.isEmpty()) {
                return "";
            }

            // Tìm sản phẩm liên quan dựa trên từ khóa và ngữ cảnh
            List<ProductObject> matchedProducts = findRelevantProducts(userMessage, allProducts);

            // Xây dựng thông tin sản phẩm để trả về
            StringBuilder productInfo = new StringBuilder();
            productInfo.append("\n\n[THÔNG TIN SẢN PHẨM TỪ HỆ THỐNG - PHÙ HỢP VỚI YÊU CẦU]:\n");

            if (matchedProducts.isEmpty()) {
                // Nếu không tìm được sản phẩm cụ thể, trả về 5 sản phẩm phổ biến đầu tiên
                productInfo.append("(Hiển thị sản phẩm phổ biến)\n");
                for (int i = 0; i < Math.min(5, allProducts.size()); i++) {
                    productInfo.append(formatProductInfo(allProducts.get(i)));
                }
            } else {
                // Trả về sản phẩm phù hợp (max 5 sản phẩm)
                for (int i = 0; i < Math.min(5, matchedProducts.size()); i++) {
                    productInfo.append(formatProductInfo(matchedProducts.get(i)));
                }
            }

            return productInfo.toString();

        } catch (Exception e) {
            System.err.println("Error getting product data: " + e.getMessage());
            e.printStackTrace();
            return "";
        }
    }

    /**
     * Tìm sản phẩm phù hợp với yêu cầu của user
     * Sử dụng phân tích ngữ cảnh (context analysis) để gợi ý chính xác
     */
    private static List<ProductObject> findRelevantProducts(String userMessage, List<ProductObject> allProducts) {
        List<ProductObject> relevantProducts = new ArrayList<>();
        String messageLower = userMessage.toLowerCase();

        // ===== TRUY VẤN ĐẶC BIỆT: Sản phẩm bán chạy, giá cao/thấp =====

        // 1. Sản phẩm bán chạy nhất (có số lượng còn cao nhất = đã bán chạy)
        if (messageLower.contains("bán chạy") || messageLower.contains("phổ biến") ||
            messageLower.contains("bán đắt") || messageLower.contains("top bán")) {
            List<ProductObject> topSelling = new ArrayList<>(allProducts);
            topSelling.sort((p1, p2) -> Integer.compare(p2.getProductQuantity(), p1.getProductQuantity()));
            return topSelling.subList(0, Math.min(5, topSelling.size()));
        }

        // 2. Sản phẩm giá cao nhất
        if (messageLower.contains("giá cao nhất") || messageLower.contains("đắt nhất") ||
            messageLower.contains("giá cao") || messageLower.contains("cao cấp")) {
            List<ProductObject> topPrice = new ArrayList<>(allProducts);
            topPrice.sort((p1, p2) -> Double.compare(p2.getProductPrice(), p1.getProductPrice()));
            return topPrice.subList(0, Math.min(5, topPrice.size()));
        }

        // 3. Sản phẩm giá thấp nhất
        if (messageLower.contains("giá thấp nhất") || messageLower.contains("rẻ nhất") ||
            messageLower.contains("giá rẻ") || messageLower.contains("bé nhất")) {
            List<ProductObject> lowestPrice = new ArrayList<>(allProducts);
            lowestPrice.sort((p1, p2) -> Double.compare(p1.getProductPrice(), p2.getProductPrice()));
            return lowestPrice.subList(0, Math.min(5, lowestPrice.size()));
        }

        // ===== TÌM KIẾM BÌNH THƯỜNG DỰA TRÊN NGỮ CẢNH =====

        // Phân tích ngữ cảnh từ câu hỏi
        boolean isFormalEvent = messageLower.contains("tiệc") || messageLower.contains("formal") ||
                messageLower.contains("công sở") || messageLower.contains("chính thức");
        boolean isCasual = messageLower.contains("casual") || messageLower.contains("thoải mái") ||
                messageLower.contains("đi chơi") || messageLower.contains("dạo phố");
        boolean isDate = messageLower.contains("hẹn hò") || messageLower.contains("hẹn") ||
                messageLower.contains("tình yêu");
        boolean isTravel = messageLower.contains("du lịch") || messageLower.contains("đi du") ||
                messageLower.contains("chuyến đi");

        // Tìm sản phẩm dựa trên từ khóa trực tiếp
        for (ProductObject product : allProducts) {
            String productName = product.getProductName() != null ? product.getProductName().toLowerCase() : "";
            String description = product.getProductDescription() != null ? product.getProductDescription().toLowerCase() : "";
            String color = product.getProductColor() != null ? product.getProductColor().toLowerCase() : "";

            int relevanceScore = 0;

            // 1. Kiểm tra từ khóa trực tiếp
            if (productName.contains(messageLower) || messageLower.contains(productName)) {
                relevanceScore += 100;
            }
            if (color.contains(messageLower) || messageLower.contains(color)) {
                relevanceScore += 50;
            }

            // 2. Kiểm tra ngữ cảnh dựa trên mô tả sản phẩm
            if (isFormalEvent) {
                if (description.contains("trang trọng") || description.contains("formal") ||
                        description.contains("công sở") || description.contains("sang trọng") ||
                        description.contains("lịch sự")) {
                    relevanceScore += 80;
                }
                // Chuyển sang check category bằng Tên sản phẩm
                if (productName.contains("váy") || productName.contains("áo") || productName.contains("quần tây") || productName.contains("sơ mi")) {
                    relevanceScore += 30;
                }
            }

            if (isCasual) {
                if (description.contains("casual") || description.contains("thoải mái") ||
                        description.contains("thường ngày") || description.contains("năng động")) {
                    relevanceScore += 80;
                }
                if (productName.contains("áo thun") || productName.contains("jean") || productName.contains("quần đùi")) {
                    relevanceScore += 30;
                }
            }

            if (isDate) {
                if (description.contains("duyên dáng") || description.contains("quyến rũ") ||
                        description.contains("xinh xắn") || description.contains("cổ điển")) {
                    relevanceScore += 80;
                }
                if (productName.contains("váy") || (productName.contains("áo") && !productName.contains("áo sơ mi"))) {
                    relevanceScore += 30;
                }
            }

            if (isTravel) {
                if (description.contains("thoải mái") || description.contains("nhẹ") ||
                        description.contains("thực dụng") || description.contains("du lịch")) {
                    relevanceScore += 80;
                }
                if (productName.contains("áo") || productName.contains("quần") || productName.contains("váy")) {
                    relevanceScore += 30;
                }
            }

            // 3. Nếu có điểm số, thêm vào danh sách
            if (relevanceScore > 0) {
                // Lưu trữ điểm số tạm thời
                product.setAverageRating((double) relevanceScore); // Tái sử dụng field này để lưu score
                relevantProducts.add(product);
            }
        }

        // Sắp xếp sản phẩm theo điểm số (cao nhất trước)
        relevantProducts.sort((p1, p2) -> Double.compare(p2.getAverageRating(), p1.getAverageRating()));

        return relevantProducts;
    }

    /**
     * Format thông tin sản phẩm thành chuỗi dễ đọc
     * Bao gồm: ID, Tên, Giá, Màu, Size, Mô tả, Số lượng
     */
    private static String formatProductInfo(ProductObject product) {
        StringBuilder info = new StringBuilder();
        info.append("🛍️ [Mã SP: ").append(product.getProductCode()).append("] ");
        info.append(product.getProductName());

        if (product.getProductColor() != null && !product.getProductColor().isEmpty()) {
            info.append(" (Màu: ").append(product.getProductColor()).append(")");
        }

        info.append("\n   💰 Giá: ").append(String.format("%.0f VNĐ", product.getProductPrice()));

        if (product.getProductSize() != null && !product.getProductSize().isEmpty()) {
            info.append(" | Size: ").append(product.getProductSize());
        }

        if (product.getProductQuantity() > 0) {
            info.append(" | Còn: ").append(product.getProductQuantity()).append(" sp");
        } else {
            info.append(" | Hết hàng");
        }

        if (product.getProductDescription() != null && !product.getProductDescription().isEmpty()) {
            String description = product.getProductDescription();
            // Lọc bỏ thẻ HTML để AI dễ đọc hơn
            description = description.replaceAll("<[^>]*>", "");
            // Cắt ngắn nếu quá dài
            if (description.length() > 150) {
                description = description.substring(0, 150) + "...";
            }
            info.append("\n   📝 Mô tả: ").append(description);
        }

        info.append("\n");
        return info.toString();
    }

    /**
     * Xây dựng JSON request body cho Gemini text:generateText endpoint
     * Format: { "prompt": { "text": "..." } }
     */
    private static String buildGeminiJsonRequest(String userMessage, String productContext) {
        String systemPrompt = ChatBotConfig.SYSTEM_PROMPT;

        // Nếu có dữ liệu sản phẩm, thêm vào system prompt
        if (productContext != null && !productContext.isEmpty()) {
            systemPrompt = systemPrompt + productContext +
                    "\n\nHãy sử dụng thông tin sản phẩm trên để trả lời câu hỏi của khách hàng một cách cụ thể và chính xác. Luôn nhắc đến Tên sản phẩm và Mã SP khi gợi ý.";
        }

        // Kết hợp system prompt và user message
        String combinedContent = systemPrompt + "\n\nCâu hỏi của khách hàng: " + userMessage;
        String escapedContent = escapeJson(combinedContent);

        // Format cho text:generateText endpoint
        return "{"
                + "\"prompt\":{"
                + "\"text\":\"" + escapedContent + "\""
                + "},"
                + "\"temperature\":" + ChatBotConfig.CHATBOT_TEMPERATURE + ","
                + "\"maxOutputTokens\":" + ChatBotConfig.CHATBOT_MAX_TOKENS
                + "}";
    }

    /**
     * Escape JSON string (handle quotes, newlines, etc.)
     */
    private static String escapeJson(String text) {
        if (text == null) return "";
        return text
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
    }

    /**
     * Đọc InputStream thành String
     */
    private static String readStream(InputStream is) throws IOException {
        if (is == null) return "";

        StringBuilder sb = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line);
            }
        }
        return sb.toString();
    }

    /**
     * Extract message từ Gemini API text:generateText response
     * JSON format: { "candidates": [{ "output": "..." }] }
     */
    private static String extractMessageFromGeminiJson(String jsonResponse) {
        try {
            // Tìm vị trí của "output" key (đây là response format của text:generateText)
            int outputIndex = jsonResponse.indexOf("\"output\":");
            if (outputIndex == -1) {
                // Thử tìm "text" field (fallback)
                outputIndex = jsonResponse.indexOf("\"text\":");
                if (outputIndex == -1) {
                    return "❌ Lỗi: Không tìm thấy output trong response từ Gemini";
                }
                outputIndex += 6; // length of "text":
            } else {
                outputIndex += 9; // length of "output":
            }

            // Tìm quote đầu tiên sau "output":
            int firstQuote = jsonResponse.indexOf("\"", outputIndex);
            if (firstQuote == -1) {
                return "❌ Lỗi: Format response từ Gemini không hợp lệ";
            }

            // Tìm quote kết thúc (xử lý escaped quotes)
            int lastQuote = firstQuote + 1;
            while (lastQuote < jsonResponse.length()) {
                if (jsonResponse.charAt(lastQuote) == '"' &&
                    (lastQuote == 0 || jsonResponse.charAt(lastQuote - 1) != '\\')) {
                    break;
                }
                lastQuote++;
            }

            if (lastQuote >= jsonResponse.length()) {
                return "❌ Lỗi: Không tìm thấy end quote trong response từ Gemini";
            }

            // Extract message
            String message = jsonResponse.substring(firstQuote + 1, lastQuote);

            // Unescape special characters
            message = message
                    .replace("\\n", "\n")
                    .replace("\\r", "\r")
                    .replace("\\t", "\t")
                    .replace("\\\"", "\"")
                    .replace("\\\\", "\\");

            return message.trim();

        } catch (Exception e) {
            System.err.println("Error parsing Gemini JSON response: " + e.getMessage());
            e.printStackTrace();
            return "❌ Lỗi khi xử lý response từ Gemini API";
        }
    }
}