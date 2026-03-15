<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Báo cáo thống kê | IVY moda</title>
</head>
<body>
    <main id="main" class="main">
        <div class="pagetitle">
            <h1>Báo cáo thống kê</h1>
        </div>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        <section class="section">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Thống kê doanh thu và tồn kho</h5>
                            <div class="row">
                                <div class="col-lg-6">
                                    <canvas id="pieChart" style="max-height: 400px;"></canvas>
                                    <script>
                                        document.addEventListener("DOMContentLoaded", () => {
                                            new Chart(document.querySelector('#pieChart'), {
                                                type: 'pie',
                                                data: {
                                                    labels: ['Doanh thu', 'Giá trị tồn kho'],
                                                    datasets: [{
                                                        label: 'Giá trị (VNĐ)',
                                                        data: [<c:out value="${totalRevenue}"/>, <c:out value="${totalValue}"/>],
                                                        backgroundColor: [
                                                            'rgb(75, 192, 75)', // Xanh lá cho doanh thu
                                                            'rgb(255, 99, 132)' // Đỏ cho tồn kho
                                                        ],
                                                        hoverOffset: 4
                                                    }]
                                                },
                                                options: {
                                                    plugins: {
                                                        tooltip: {
                                                            callbacks: {
                                                                label: function(context) {
                                                                    let label = context.label || '';
                                                                    let value = context.raw || 0;
                                                                    return `${label}: ${value.toLocaleString('vi-VN')} VNĐ`;
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            });
                                        });
                                    </script>
                                </div>
                                <div class="col-lg-6 d-flex flex-column justify-content-center">
                                    <table class="table table-borderless">
                                        <tr>
                                            <th colspan="2"><h4>Thống kê hàng hóa</h4></th>
                                        </tr>
                                        <tr>
                                            <th>Doanh thu:</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${totalRevenue > 0}">
                                                        <fmt:formatNumber value="${totalRevenue}" pattern="#,###"/> VNĐ
                                                    </c:when>
                                                    <c:otherwise>0 VNĐ</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Giá trị tồn kho:</th>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${totalValue > 0}">
                                                        <fmt:formatNumber value="${totalValue}" pattern="#,###"/> VNĐ
                                                    </c:when>
                                                    <c:otherwise>0 VNĐ</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>
</body>
</html>