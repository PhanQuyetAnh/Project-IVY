package controller.admin;

import dao.Impl.UserDAOImpl;
import dao.UserDAO;

import model.UserObject;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ManageAccount
 */
@WebServlet("/admin/admin-manage-account")
public class ManageAccount extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;

	public void init() {
		userDAO = new UserDAOImpl();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//Lấy danh sách sản phẩm từ database
		List<UserObject> users = userDAO.getAllUsers();

		// Gửi dữ liệu sang JSP
		request.setAttribute("users", users);

		RequestDispatcher rd = request.getRequestDispatcher("/views/admin/manage-account.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
