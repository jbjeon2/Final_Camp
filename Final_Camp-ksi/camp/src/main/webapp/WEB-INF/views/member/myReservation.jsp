<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>


<c:set var="reservationList" value="${map.boardList}" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>캠프보내조</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/mypage.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/boardList-style.css">

    <script src="https://kit.fontawesome.com/a2e8ca0ae3.js" crossorigin="anonymous"></script>

</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />

    <main class="myPage-content">
        
        <jsp:include page="/WEB-INF/views/member/sideMenu.jsp"/>

        <section class="myPage-main">

            <h1 class="myPage-title">예약 확인</h1>
            
            <span class="myPage-explanation">현재 회원님의 예약 정보를 확인할 수 있습니다.</span>

            <div class="list-wrapper">
                <table class="list-table">
                    
                    <thead>
                        <tr>
                            <th>예약 번호</th>
                            <th>캠핑장 이름</th>
                            <th>예약자</th>
                            <th>예약일</th>
                            <th>예약 인원 수</th>
                            <th>결제 금액</th>
                        </tr>
                    </thead>

                    <tbody>

                        <c:choose>
                            <c:when test="${empty reservationList}">
                                <!-- 게시글 목록 조회 결과가 비어있다면 -->
                                <tr>
                                    <th colspan="6">예약 내역이 존재하지 않습니다.</th>
                                </tr>
                            </c:when>

                            <c:otherwise>
                                <!-- 게시글 목록 조회 결과가 비어있지 않다면 -->

                                <!-- 향상된 for문처럼 사용 -->
                                <c:forEach var="reservation" items="${reservationList}">
                                    <tr>
                                        <td>${reservation.reservNo}</td>
                                        <td>${reservation.reservCamp}</td>
                                        <td>${reservation.reservName}</td>
                                        <td>${reservation.reservDate}</td>
                                        <td>${reservation.reservPeople}</td>
                                        <td>${reservation.reservPayment}</td>
                                    </tr>
                                </c:forEach>

                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

        </section>

    </main>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>


    <script src="${contextPath}/resources/js/mypage.js"></script>

</body>
</html>