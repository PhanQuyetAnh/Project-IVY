<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Trang quản lý tài khoản | IVY moda</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <style>
    .badge-green {
      background-color: #28a745;
      color: white;
      padding: 5px 10px;
      border-radius: 12px;
    }
    .badge-red {
      background-color: #dc3545;
      color: white;
      padding: 5px 10px;
      border-radius: 12px;
    }
    .badge-orange {
      background-color: #f4a261; /* Màu cam */
      color: white;
      padding: 5px 10px;
      border-radius: 12px;
    }
    .hidden-row {
      display: none; /* Class để ẩn dòng */
    }
  </style>
</head>
<body>
<main class="main" id="main">
  <section class="section">
    <div class="row">
      <div class="col-12">
        <h1 class="box-title">Quản lý người dùng</h1>

        <div class="section-5">
          <div class="inner-wrap">
            <div class="inner-change-status">
              <div class="inner-item">
                <select id="statusFilter" name="status">
                  <option value="">-- Điều kiện --</option>
                  <option value="1">Tên</option>
                  <option value="2">ID</option>
                  <option value="3">Ngày tạo</option>
                </select>
              </div>
              <div class="inner-item">
                <button id="filterButton">Sắp xếp</button>
              </div>
            </div>
            <div class="inner-search">
              <i class="fa-solid fa-magnifying-glass"></i>
              <input type="text" placeholder="Tìm kiếm" />
            </div>
            <div class="report-user" style="margin: auto; display: flex; align-items: center">
              <a class="btn btn-lg btn-outline-info btn-light"
                 href="admin-report-user" style="">
                <i class="fa-regular fa-flag"></i><h4>Biểu đồ thống kê</h4>
              </a>

            </div>
            <div class="create-user" style="margin: auto; display: flex; align-items: center">
              <a class="btn btn-lg btn-outline-info btn-light"
                 href="admin-add-user" style="">
                <i class="fa-solid fa-plus"></i><h4>Add</h4>
              </a>
            </div>
            <div class="create-user" style="margin: auto; display: flex; align-items: center">
              <a class="btn btn-lg btn-outline-info btn-light"
                 href="inactive-users" style="">
                <i class="fa-solid fa-exclamation"></i></i><h4>Inactive</h4>
              </a>
            </div>


          </div>

        </div>
        <div class="section-6">
          <div class="table-2" style="width: 99%">
            <table>
              <thead>
              <tr>
                <th>ID</th>
                <th>Họ tên</th>
                <th>Giới tính</th>
                <th>Email</th>
                <th>Ngày tạo</th>
                <th>Trạng thái</th>

                <th>Hành động</th>
              </tr>
              </thead>
              <tbody>
              <c:set var="itemsPerPage" value="7" />
              <c:set var="totalItems" value="${fn:length(users)}" />
              <c:set var="totalPages" value="${(totalItems + itemsPerPage - 1) / itemsPerPage}" />
              <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />

              <c:forEach var="user" items="${users}" varStatus="loop">
                <c:if test="${loop.index >= (currentPage - 1) * itemsPerPage and loop.index < currentPage * itemsPerPage}">
                  <tr data-user-id="${user.userId}">
                    <td>${user.userId}</td>
                    <td>${user.fullname}</td>
                    <td>${user.gender}</td>
                    <td>${user.email}</td>
                    <td>${user.createDate}</td>
                    <td class="status-cell">
                      <c:choose>
                        <c:when test="${user.active}">
                          <div class="badge badge-green">Hoạt động</div>
                        </c:when>
                        <c:otherwise>
                          <div class="badge badge-red">Ngừng HD</div>
                        </c:otherwise>
                      </c:choose>
                    </td>



                    <td>
                      <div class="d-flex justify-content-start gap-2">
                        <a class="btn btn-sm btn-outline-info" href="${pageContext.request.contextPath}/admin/admin-detail-user?userId=${user.userId}">
                          <i class="fa-solid fa-eye"></i>
                        </a>
                        <c:if test="${not empty user.userId}">
                          <a class="btn btn-sm btn-outline-danger inner-remove" onclick="confirmDelete(event, '${user.userId}'); return false;">
                            <i class="fa-solid fa-trash-can"></i>
                          </a>
                        </c:if>
                      </div>
                    </td>
                  </tr>
                </c:if>
              </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
        <nav>
          <ul class="pagination justify-content-start mt-4" id="pages">
            <c:if test="${currentPage > 1}">
              <li class="page-item">
                <a class="page-link" href="?page=${currentPage - 1}&status=${param.status}"><i class="fa-solid fa-chevron-left"></i></a>
              </li>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
              <li class="page-item ${currentPage == i ? 'active' : ''}">
                <a class="page-link" href="?page=${i}&status=${param.status}">${i}</a>
              </li>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
              <li class="page-item">
                <a class="page-link" href="?page=${currentPage + 1}&status=${param.status}"><i class="fa-solid fa-chevron-right"></i></a>
              </li>
            </c:if>
          </ul>
        </nav>
      </div>
    </div>
  </section>
  <script>
    // Định nghĩa hàm confirmDelete ngay tại đây
    function confirmDelete(event, userId) {
      console.log('Gọi confirmDelete với userId:', userId, ' (kiểu:', typeof userId, ')');
      if (confirm('Bạn có chắc chắn muốn xóa người dùng này?')) {
        const row = event.target.closest('tr');
        if (row) {
          const statusCell = row.querySelector('.status-cell');
          if (statusCell) {
            statusCell.innerHTML = '<div class="badge badge-red">Ngừng HĐ</div>';
            row.classList.add('hidden-row'); // Ẩn dòng
            console.log('Đã cập nhật và ẩn row cho userId:', userId);
          } else {
            console.log('Không tìm thấy status-cell cho userId:', userId);
          }
        } else {
          console.log('Không tìm thấy row từ event cho userId:', userId);
        }
      }
    }

    // Chạy các sự kiện khác sau khi DOM tải
    window.onload = function() {
      //tìm kiếm theo tên hoặc email
      document.querySelector('.inner-search input').addEventListener('keyup', function() {
        const keyword = this.value.toLowerCase();
        const rows = document.querySelectorAll('table tbody tr');
        rows.forEach(row => {
          const name = row.cells[1].textContent.toLowerCase();
          const email = row.cells[3].textContent.toLowerCase();
          row.style.display = (name.includes(keyword) || email.includes(keyword)) ? '' : 'none';
        });
      });

      //Sắp xếp
      document.getElementById('filterButton').addEventListener('click', () => {
        const sortBy = document.getElementById('statusFilter').value;
        const tbody = document.querySelector('table tbody');
        const rows = Array.from(tbody.querySelectorAll('tr'));

        if (sortBy === '1') {
          //Sắp xếp theo tên
          rows.sort((a, b) => {
            const nameA = a.cells[1].textContent.toLowerCase().trim().split(' ').pop();
            const nameB = b.cells[1].textContent.toLowerCase().trim().split(' ').pop();
            return nameA.localeCompare(nameB);
          });
        } else if (sortBy === '2') {
          //Sắp xếp theo id
          rows.sort((a, b) => {
            const idA = parseInt(a.cells[0].textContent);
            const idB = parseInt(b.cells[0].textContent);
            return idA - idB;
          });
        }
        else if (sortBy === '3') {
          // Sắp xếp theo ngày tạo (mới nhất lên đầu)
          rows.sort((a, b) => {
            const dateA = new Date(a.cells[4].textContent.trim());
            const dateB = new Date(b.cells[4].textContent.trim());
            return dateB - dateA; // Mới nhất lên đầu
          });
        }

        tbody.innerHTML = '';
        rows.forEach(row => tbody.appendChild(row));
      });
    };
  </script>
</body>
</html>