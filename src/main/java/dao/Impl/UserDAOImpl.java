package dao.Impl;

import dao.UserDAO;
import model.RoleObject;
import model.UserObject;
import util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class UserDAOImpl implements UserDAO {

	private boolean exe(Connection conn, PreparedStatement pre) {
		if (pre != null) {
			try {
				int results = pre.executeUpdate();
				System.out.println("Số dòng ảnh hưởng: " + results); // Debug
				conn.commit();
				return results > 0;
			} catch (SQLException e) {
				System.err.println("Lỗi SQL: " + e.getMessage()); // Debug
				e.printStackTrace();
				try {
					conn.rollback();
					System.err.println("Đã rollback giao dịch");
				} catch (SQLException ex) {
					System.err.println("Lỗi rollback: " + ex.getMessage());
					ex.printStackTrace();
				}
				return false;
			}
		}
		return false;
	}

	@Override
	public UserObject getUserByUsernamePassword(String username, String password) {
	    String sql = "SELECT u.*, r.role_name " +
	                 "FROM users u " +
	                 "INNER JOIN roles r ON u.role_id = r.role_id " +
	                 "WHERE user_email = ? AND password = ?";
	    try (Connection conn = DBUtil.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, username);
	        ps.setString(2, password);
	        try (ResultSet rs = ps.executeQuery()) {
	            if (rs.next()) {
	                return mapRowToUser(rs);
	            }
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return null;
	}

	private UserObject mapRowToUser(ResultSet rs) throws SQLException {
		UserObject user = new UserObject();
		user.setUserId(rs.getInt("user_id"));
		user.setPassword(rs.getString("password"));
		user.setGender(rs.getString("gender"));
		user.setFullname(rs.getString("user_fullname"));
		user.setPhoneNumber(rs.getString("user_phone_number"));
		user.setEmail(rs.getString("user_email"));
		user.setCreateDate(rs.getTimestamp("user_created_date"));
		user.setModifiedDate(rs.getTimestamp("user_modified_date"));
		int userActive = rs.getInt("user_isactive");
		user.setActive(userActive == 1 ? true : false);
		user.setAddress(rs.getString("user_address"));
		user.setLoginCount(rs.getInt("login_count"));

		int roleId = rs.getInt("role_id");
		RoleObject role = new RoleObject();
		role.setRoleId(roleId);
		role.setRoleName(rs.getString("role_name"));
		user.setRole(role);

		return user;
	}

	// quyet anh
	@Override
	public List<UserObject> getAllUsers() {

		List<UserObject> list = new ArrayList<>();
		String sql = "SELECT u.*, r.role_name FROM users u INNER JOIN roles r ON u.role_id = r.role_id ORDER BY u.user_created_date DESC;";

		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				UserObject p = new UserObject();
				p.setUserId(rs.getInt("user_id"));
				p.setFullname(rs.getString("user_fullname"));
				p.setPassword(rs.getString("password"));
				p.setGender(rs.getString("gender"));
				p.setAddress(rs.getString("user_address"));
				p.setLoginCount(rs.getInt("login_count"));
				int userActive = rs.getInt("user_isactive");
				p.setActive(userActive == 1 ? true : false);
				p.setEmail(rs.getString("user_email"));
				p.setPhoneNumber(rs.getString("user_phone_number"));
				p.setCreateDate(rs.getDate("user_created_date"));
				p.setModifiedDate(rs.getDate("user_modified_date"));

				RoleObject r = new RoleObject();
				r.setRoleId(rs.getInt("role_id"));
				r.setRoleName(rs.getString("role_name"));
				p.setRole(r);


				list.add(p);
			}


		} catch (SQLException e) {
			System.err.println("Lỗi getAllUsers: " + e.getMessage());
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public UserObject getUserById(int id) {
		String sql = "SELECT \n" + "  u.*,\n" + "  r.role_name\n" + "FROM users u\n"
				+ "INNER JOIN roles r ON u.role_id = r.role_id\n WHERE  user_id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				UserObject p = new UserObject();
				p.setUserId(rs.getInt("user_id"));
				p.setFullname(rs.getString("user_fullname"));
				p.setPassword(rs.getString("password"));
				p.setGender(rs.getString("gender"));
				p.setAddress(rs.getString("user_address"));
				p.setLoginCount(rs.getInt("login_count"));

				int userActive = rs.getInt("user_isactive");
				p.setActive(userActive == 1 ? true : false);
				p.setEmail(rs.getString("user_email"));
				p.setPhoneNumber(rs.getString("user_phone_number"));
				p.setCreateDate(rs.getDate("user_created_date"));
				p.setModifiedDate(rs.getDate("user_modified_date"));

				RoleObject r = new RoleObject();
				r.setRoleId(rs.getInt("role_id"));
				r.setRoleName(rs.getString("role_name"));
				p.setRole(r);
				return p;
			}
		} catch (SQLException e) {
			System.err.println("Lỗi getUserById: " + e.getMessage());
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public boolean deleteUser(int user_id) {
		String sql = "DELETE FROM users WHERE user_id=?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pre = conn.prepareStatement(sql)) {
			pre.setInt(1, user_id);
			return exe(conn, pre);
		} catch (SQLException e) {
			System.err.println("Lỗi deleteUser: " + e.getMessage());
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public boolean deactivateUser(int user_id) {
		System.out.println("Thực thi deactivateUser cho user_id: " + user_id);
		String sql = "UPDATE users SET user_isactive = 3 WHERE user_id = ?";
		try (Connection conn = DBUtil.getConnection(); PreparedStatement pre = conn.prepareStatement(sql)) {
			if (conn == null) {
				System.err.println("Kết nối CSDL là null");
				return false;
			}
			pre.setInt(1, user_id);
			return exe(conn, pre);
		} catch (SQLException e) {
			System.err.println("Lỗi deactivateUser: " + e.getMessage());
			e.printStackTrace();
			return false;
		}
	}
	@Override
	public Map<String, Integer> getNewUsersByMonth() {
		Map<String, Integer> result = new LinkedHashMap<>();
		String sql = "SELECT DATE_FORMAT(user_created_date, '%m/%Y') AS month, COUNT(*) AS count " +
				"FROM users " +
				"GROUP BY month " +
				"ORDER BY STR_TO_DATE(month, '%m/%Y')";
		try (Connection conn = DBUtil.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				result.put(rs.getString("month"), rs.getInt("count"));
			}
		} catch (SQLException e) {
			System.err.println("Lỗi getNewUsersByMonth: " + e.getMessage());
		}
		return result;
	}

	@Override
	public Map<String, Integer> getUserStatusCounts() {
		Map<String, Integer> result = new HashMap<>();
		String sql = "SELECT " +
				"CASE WHEN user_isactive = 1 THEN 'Hoạt động' ELSE 'Không hoạt động' END AS status, " +
				"COUNT(*) AS count " +
				"FROM users " +
				"GROUP BY status";
		try (Connection conn = DBUtil.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				result.put(rs.getString("status"), rs.getInt("count"));
			}
		} catch (SQLException e) {
			System.err.println("Lỗi getUserStatusCounts: " + e.getMessage());
		}
		return result;
	}

	@Override
	public Map<String, Integer> getUserGenderCounts() {
		Map<String, Integer> result = new HashMap<>();
		String sql = "SELECT gender, COUNT(*) AS count FROM users GROUP BY gender";
		try (Connection conn = DBUtil.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				String gender = rs.getString("gender");
				if (gender == null || gender.isEmpty()) gender = "Không xác định";
				result.put(gender, rs.getInt("count"));
			}
		} catch (SQLException e) {
			System.err.println("Lỗi getUserGenderCounts: " + e.getMessage());
		}
		return result;
	}

	@Override
	public int getTotalUserCount() {
		String sql = "SELECT COUNT(*) AS total_users FROM users";
		try (Connection conn = DBUtil.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			if (rs.next()) {
				return rs.getInt("total_users");
			}
		} catch (SQLException e) {
			System.err.println("Lỗi getTotalUserCount: " + e.getMessage());
		}
		return 0;
	}
	@Override
	public Map<String, Integer> getUserRoleCounts() {
		Map<String, Integer> roleCounts = new HashMap<>();
		String sql = "SELECT r.role_name, COUNT(*) as count " +
				"FROM users u JOIN roles r ON u.role_id = r.role_id " +
				"GROUP BY r.role_name";
		try (Connection conn = DBUtil.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while (rs.next()) {
				roleCounts.put(rs.getString("role_name"), rs.getInt("count"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return roleCounts;
	}

	@Override
	public boolean insertUser(UserObject user) {
		String sql = "INSERT INTO users(password, gender, user_fullname, user_phone_number, user_email, user_created_date, " +
				"user_modified_date, user_isactive, user_address, login_count, role_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection conn = DBUtil.getConnection();
			 PreparedStatement pre = conn.prepareStatement(sql)) {

			conn.setAutoCommit(false);
			pre.setString(1, user.getPassword());
			pre.setString(2, user.getGender());
			pre.setString(3, user.getFullname());
			pre.setString(4, user.getPhoneNumber());
			pre.setString(5, user.getEmail());
			pre.setDate(6, new java.sql.Date(user.getCreateDate().getTime()));
			pre.setDate(7, null); // modified_date = NULL
			pre.setBoolean(8, user.isActive());
			pre.setString(9, user.getAddress());
			pre.setInt(10, user.getLoginCount()); // mặc định là 0 hoặc 1
			pre.setInt(11, user.getRole().getRoleId());

			return this.exe(conn, pre);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	@Override
	public List<UserObject> getInactiveSoonUsers(int limit) {
		List<UserObject> list = new ArrayList<>();
		String sql = "SELECT u.*, r.role_name " +
				"FROM users u " +
				"JOIN roles r ON u.role_id = r.role_id " +
				"WHERE u.user_modified_date IS NOT NULL " +
				"ORDER BY u.user_modified_date ASC " +
				"LIMIT ?";
		try (Connection conn = DBUtil.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, limit);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(mapRowToUser(rs)); // dùng hàm mapRowToUser có sẵn
			}
		} catch (SQLException e) {
			System.err.println("Lỗi getInactiveSoonUsers: " + e.getMessage());
		}
		return list;
	}


}
