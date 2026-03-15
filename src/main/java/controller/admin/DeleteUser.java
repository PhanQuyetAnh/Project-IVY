package controller.admin;

import dao.Impl.UserDAOImpl;
import dao.UserDAO;
import model.UserObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin/admin-delete-user")
public class DeleteUser extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    public void init() {
        userDAO = new UserDAOImpl();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String userIdParam = request.getParameter("userId");
        if (userIdParam != null && !userIdParam.trim().isEmpty()) {
            try {
                int userId = Integer.parseInt(userIdParam);
                boolean success = userDAO.deactivateUser(userId);
                response.getWriter().write("{\"status\": \"" + (success ? "success" : "fail") + "\"}");
            } catch (NumberFormatException e) {
                response.getWriter().write("{\"status\": \"fail\"}");
            }
        } else {
            response.getWriter().write("{\"status\": \"fail\"}");
        }
    }
}