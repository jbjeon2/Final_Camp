<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">


    <title>로그인</title>

    <link rel="stylesheet" href="${contextPath}/resources/css/main.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/login.css">
    <!-- <link rel="stylesheet" href="${contextPath}/resources/css/signUpPage.css"> -->

</head>

<body>
    <main>
        <!-- hedaer include -->
        <jsp:include page="/WEB-INF/views/common/header.jsp" />


        <!-- 회원가입  -->
        <section class="signUp-content">
            <form action="login" method="POST" name="login-form" onsubmit="return loginValidate()">

                <label for="memberEmail">
                    <span class="required">*</span> 아이디(이메일)
                </label>

                <div class="signUp-input-area">
                    <input type="text" id="memberEmail" name="memberEmail" placeholder="아이디(이메일)"
                        maxlength="50" autocomplete="off" required>
                </div>

                <label for="memberPw">
                    <span class="required">*</span> 비밀번호
                </label>

                <div class="signUp-input-area">
                    <input type="text" id="memberPw" name="memberPw" placeholder="비밀번호" maxlength="30">
                </div>

                <button type="submit" id="login-btn">로그인</button>


                <!-- 네이버 로그인 -->
                <div>
                    <a href="javascript:;" id="naver_id_login" onclick="showLoginPopup();">
                        <img width="200" src="${contextPath}/resources/images/Nbtn.png"></a>
                </div>

            </form>


            <!-- 구글 로그인 -->
            <div id="g_id_onload"
                data-client_id="286178066358-saj0enkggrgfqm5mafdipok8ml0te2o1.apps.googleusercontent.com"
                data-callback="handleCredentialResponse" data-context="signin" data-ux_mode="popup"
                data-login_uri="http://localhost:8080/camp/member/login" data-auto_prompt="false">
            </div>

            <div class="g_id_signin" data-type="standard" data-shape="rectangular" data-theme="outline"
                data-text="signin_with" data-size="large" data-logo_alignment="left">
            </div>


            <!-- 카카오 로그인 -->
            <ul>
                <li onclick="kakaoLogin();">
                    <a href="javascript:void(0)">
                        <img src="https://k.kakaocdn.net/14/dn/btroDszwNrM/I6efHub1SN5KCJqLm1Ovx1/o.jpg"
                            width="222" alt="카카오 로그인 버튼" />
                    </a>
                </li>
            </ul>


        </section>

        <div class="social-loginbtns">


        </div>


    </main>



    <!-- footer include -->
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    <!-- jQuery 라이브러리 추가(CDN) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

    <script src="${contextPath}/resources/js/login.js"></script>

    <!-- 네이버 로그인 -->
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js"
        charset="utf-8"></script>

    <!-- 구글 로그인 -->
    <script src="https://accounts.google.com/gsi/client" async defer></script>


    <script type="text/javascript">
        const contextPath = "${contextPath}";

        function showLoginPopup() {
            let uri = 'https://nid.naver.com/oauth2.0/authorize?' +
                'response_type=code' +                  // 인증과정에 대한 내부 구분값 code 로 전공 (고정값)
                '&client_id=olUvYEgXTwnvQN94ySBM' +     // 발급받은 client_id 를 입력  ( 개인이 직접받아야해요 )
                '&state=NAVER_LOGIN_TEST' +             // CORS 를 방지하기 위한 특정 토큰값(임의값 사용)
                '&redirect_uri=http://localhost:8080/camp/login/naverLoginSuccess';   // 어플케이션에서 등록했던 CallBack URL를 입력

            // 사용자가 사용하기 편하게끔 팝업창으로 띄어준다.
            window.open(uri, "_self", "Naver Login Test PopupScreen", "width=450, height=600");
        }



        //구글로그인
        function decodeJwtResponse(token) {
            var base64Url = token.split('.')[1];
            var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
            var jsonPayload = decodeURIComponent(atob(base64).split('').map(function (c) {
                return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
            }).join(''));

            return JSON.parse(jsonPayload);
        };

        function handleCredentialResponse(response) {
            // decodeJwtResponse() is a custom function defined by you
            // to decode the credential response.
            const responsePayload = decodeJwtResponse(response.credential);
            console.log(responsePayload);
            console.log("ID: " + responsePayload.sub);
            console.log('Full Name: ' + responsePayload.name);
            console.log('Given Name: ' + responsePayload.given_name);
            console.log('Family Name: ' + responsePayload.family_name);
            console.log("Image URL: " + responsePayload.picture);
            console.log("Email: " + responsePayload.email);


            $.ajax({
                url: "googleLoginInfo",
                type: "POST",
                data: {
                    "memberNickname": responsePayload.name,
                    "memberEmail": responsePayload.email
                },

                success: function () {
                    window.location.href = '${contextPath}';
                },
                error: function () {

                }
            });

            // location.reload();
            // location.reload();
            // location.reload();
            // location.reload();
            // location.reload();

            // window.location.href = '${contextPath}';

            // 1초(1000ms) 후에 location.reload() 실행
            // setTimeout(function() {
            // location.reload();
            // }, 3000);

        }

        /*         구글로그아웃 -- 주석처리함.
                function signOut() {
                    var auth2 = gapi.auth2.getAuthInstance();
                    auth2.signOut().then(function () {
                    console.log('User signed out.');
                    });
                    };
            */
    </script>

    <!-- 카카오 로그인 -->
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.2.0/kakao.min.js"
        integrity="sha384-x+WG2i7pOR+oWb6O5GV5f1KN2Ko6N7PTGPS7UlasYWNxZMKQA63Cj/B2lbUmUfuC"
        crossorigin="anonymous"></script>
    <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>

    <script>
        //카카오로그인
        Kakao.init('9bf493951641e18dccd9f2901ddd2f54'); //발급받은 키 중 javascript키를 사용해준다.
        console.log("Kakao.isInitialized : " + Kakao.isInitialized()); // sdk초기화여부판단

        function kakaoLogin() {
            Kakao.Auth.login({
                success: function (response) {
                    Kakao.API.request({
                        url: '/v2/user/me',
                        success: function (response) {
                            console.log(response)
                            console.log("properties : " + response.properties);
                            console.log(response.properties);

                            const prop = response.properties;
                            console.log("prop.nickname : " + prop.nickname);
                            $.ajax({
                                url: "kakaoLoginInfo",
                                type: "POST",
                                data: { "memberNickname": prop.nickname },

                                success: function () {
                                    window.location.href = '${contextPath}';

                                    if (Kakao.Auth.getAccessToken()) {
                                        Kakao.API.request({
                                            url: '/v1/user/unlink',
                                            success: function (response) {
                                                console.log(response)
                                            },
                                            fail: function (error) {
                                                console.log(error)
                                            },
                                        })
                                        Kakao.Auth.setAccessToken(undefined)
                                    }

                                },
                                error: function () {

                                }
                            });


                        },
                        fail: function (error) {
                            console.log(error)
                        },
                    })
                },
                fail: function (error) {
                    console.log(error)
                },
            })
        }



    </script>

</body>

</html>