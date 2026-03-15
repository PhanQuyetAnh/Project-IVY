package controller.auth;

import dao.Impl.UserDAOImpl;
import dao.UserDAO;
import model.UserObject;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class Login
 */
@WebServlet("/public/login")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public LoginController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher rd = request.getRequestDispatcher("/views/web/login.jsp");
		rd.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		String username = request.getParameter("username");
//		String password = request.getParameter("password");
//
//		if(username != null && !username.isEmpty() && password != null && !password.isEmpty()){
//			UserDAO userDAO = new UserDAOImpl();
//			UserObject userObject = userDAO.getUserByUsernamePassword(username, password);
//
//			if (userObject == null){
//				//loi tk or pass
//				response.sendRedirect("/jsp-servlet/public/login");
//			}else {
//				HttpSession session = request.getSession();
//				session.setAttribute("user", userObject);
//				session.setAttribute("role", userObject.getRole().getRoleName());
//				if (userObject.getRole().getRoleName().equals("ADMIN")) {
//					response.sendRedirect("/jsp-servlet/admin/admin-home");
//				}
//				else{
//					response.sendRedirect("/jsp-servlet/public/trang-chu");
//				}
//
//			}
//		}
//	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String contextPath = request.getContextPath(); // Lấy đường dẫn tự động (ví dụ: /jsp_servlet_war_exploded)

		if(username != null && !username.isEmpty() && password != null && !password.isEmpty()){
			UserDAO userDAO = new UserDAOImpl();
			UserObject userObject = userDAO.getUserByUsernamePassword(username, password);

			if (userObject == null){
				// Chuyển hướng về trang login nếu sai tk/mk
				response.sendRedirect(contextPath + "/public/login");
			} else {
				HttpSession session = request.getSession();
				session.setAttribute("user", userObject);

				String roleName = userObject.getRole().getRoleName();
				session.setAttribute("role", roleName);

				// In ra console để kiểm tra giá trị thực tế từ DB
				System.out.println("Login Success! Role is: " + roleName);

				if ("ADMIN".equals(roleName)) {
					response.sendRedirect(contextPath + "/admin/admin-home");
				} else {
					response.sendRedirect(contextPath + "/public/trang-chu");
				}
			}
		}
	}
}
