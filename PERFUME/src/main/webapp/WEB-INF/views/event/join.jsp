<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${ pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>signUp</title>

    <style>
        body{
            background-color: #f6f6f2;
        }
        section{
            margin-left: auto;
            margin-right: auto;
            width: 800px;
        }
        section * {
            margin-left: auto;
            margin-right: auto;
        }

        input[type=button] {
            background-color: rgb(226, 217, 179);
            border-color: rgb(226, 217, 179);
        }
        input[type=button]:hover {
            background-color: rgb(120, 116, 100);
            border-color: rgb(120, 116, 100);
        }

        button[id^=btn]{
            background-color: rgb(226, 217, 179);
            border-color: rgb(226, 217, 179);
        }
        button[id^=btn]:hover {
            background-color: rgb(120, 116, 100);
            border-color: rgb(120, 116, 100);
        }
        
/* h1 */
        #title {
            margin-top: 10%;
            margin-bottom: 5%;
        }
/* 생년월일 */
        #topDivBirth{
            margin-bottom: 0;
        }
        #divBirth1{
            height: 30px;
        }
        #labelBirth {
            margin-left: 11px;
        }
        #birth-year, #birth-month, #birth-date{
            width: 30%;
            float: left;
            margin-right: 5px;
            margin-left: 5px;
        }
        #birth-year, #birthHelpBlock{
            margin-left: 13px;
        }
        
/* 전화번호 */
        #phone, #verification-code{
            width: 63%;
            float: left;
            margin-right: 5px;
        }
        #btnPh1, #btnPh2 {
            float: left;
        }
        #phDiv {
            margin-bottom: 20px;
        }
/* 주소 */
        #sample6_postcode {
            width: 63%;
            float: left;
            margin-right: 5px;
        }
        .addressDiv{
            margin-bottom: 6px;
        }

/* 약관 동의 */
        .form-check-label{
            width: 310px;
            font-size: small;
        }
        #btnAgr1, #btnAgr2 {
            margin-top: 5px;
        }
        .divAgr {
            background-color: white;
            font-size: small;
            height: 150px;
            padding: 4%;
            border: 1px solid gray;
            display: none;
            overflow: auto;
        }
        pre {
            white-space: pre-wrap;
        }

/* 제출 버튼 */
        #submitDiv{
            width: 800px;
            margin: auto;
            margin-bottom: 10%;
        }
        #btnSubmit{
            width: 25%;
            margin-left: auto;
            margin-right: auto;
            display:block;
            background-color: rgb(120, 116, 100);
            border-color: rgb(120, 116, 100);
        }
        /* #btnSubmit:hover {
            background-color: rgb(226, 217, 179);
            border-color: rgb(226, 217, 179);
        } */
    

    </style>
    <!-- jQuery -->
    <script src="./js/jquery-3.6.3.js"></script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
</head>
<body>

    <section>

    <h6 style="color:red;">아이디, 이메일 전화 번호 중복 검사 ajax로, 약관 체크박스 변경 셀렉트 색상 변경, 비번 안전 보통 등등, 유효성 검사 완료해야 폼 넘어가게</h6>
    <h1 id="title" align="center">회원가입</h1>
    <form class="needs-validation" novalidate>
        <div class="form-group">
            <div class="col-md-6 mb-3">
                <label for="userId">아이디</label>
                <input type="text" class="form-control" id="userId" aria-describedby="idHelpBlock" placeholder="아이디 입력" pattern="^[a-z][a-z0-9]{3,11}$"
                        data-toggle="tooltip" data-placement="top" title="첫 글자는 반드시 영문 소문자, 4 ~ 12자의 영문 소문자 숫자" required>
                <!-- <small id="idHelpBlock" class="form-text text-muted">
                    첫 글자는 반드시 영문 소문자, 4 ~ 12자의 영문 소문자 숫자
                </small> -->
                <span id="idCheck"></span>
                <!-- <div class="valid-feedback">
                    멋진 아이디네요
                </div> -->
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-6 mb-3">
                <label for="password">비밀번호</label>
                <input type="password" id="password" class="form-control" aria-describedby="pwdHelpBlock" placeholder="비밀번호 입력" 
                        data-toggle="tooltip" data-placement="top" title="하나 이상의 대소문자, 하나의 숫자 및 하나의 특수 문자를 포함한 8 ~ 12자"
                        pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$" required>
                <!-- <small id="pwdHelpBlock" class="form-text text-muted">
                    하나 이상의 대소문자, 하나의 숫자 및 하나의 특수 문자를 포함한 8 ~ 12자 
                </small> -->
                <span id="pwdCheck"></span>
                <!-- <div class="valid-feedback">
                    비밀번호를 입력했을 때 뜨는 문구
                </div> -->
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-6 mb-3">
                <label for="confirm-password">비밀번호 확인</label>
                <input type="password" id="confirm-password" class="form-control" aria-describedby="pwdChHelpBlock" placeholder="비밀번호 입력" required>
                <!-- <small id="pwdChHelpBlock" class="form-text text-muted">
                    비밀번호 체크 확인하십숑
                </small> -->
                <span id="conPwdCheck"></span>
                <!-- <div class="valid-feedback">
                    비밀번호를 입력하셨습니다.
                </div> -->
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-6 mb-3">
                <label for="name">이름</label>
                <input type="text" id="name" class="form-control" aria-describedby="nameHelpBlock" placeholder="이름 입력"
                        pattern="^[가-힣]{2,10}$" required>
                <!-- <small id="nameHelpBlock" class="form-text text-muted">
                    이름 제대로 적어랑
                </small> -->
                <span id="nameCheck"></span>
                <!-- <div class="valid-feedback">
                    이름 입력완료
                </div> -->
            </div>
        </div>
<!-- 생년월일 -->
        <div id="topDivBirth" class="form-group">
            <div id="divBirth1" class="form-row">
                <div  class="col-md-6 mb-3">
                    <label id="labelBirth" for="birth-year">생년월일</label>
                </div>
            </div>
            <div id="divBirth2" class="form-row">
                <div id="divBirth3" class="col-md-6 mb-3">
                    <input type="text" class="form-control" id="birth-year" aria-describedby="birthHelpBlock" placeholder="년" pattern="^(19[0-9][0-9]|20\d{2})$" required>
                    <!-- <small id="birthHelpBlock" class="form-text text-muted">
                        생년월일 제대로 적어랑
                    </small> -->
                    <!-- <div class="invalid-feedback">
                        생년월일 년
                    </div> -->
                    <!-- <label for="birth-month"></label> -->
                    <select class="custom-select" id="birth-month" required>
                        <option selected disabled value="">월</option>
                        <option value="01">1월</option>
                        <option value="02">2월</option>
                        <option value="03">3월</option>
                        <option value="04">4월</option>
                        <option value="05">5월</option>
                        <option value="06">6월</option>
                        <option value="07">7월</option>
                        <option value="08">8월</option>
                        <option value="09">9월</option>
                        <option value="10">10월</option>
                        <option value="11">11월</option>
                        <option value="12">12월</option>
                    </select>
                    <!-- <div class="invalid-feedback">
                        생년월일 월
                    </div> -->
                    <!-- <label for="birth-date"></label> -->
                    <input type="text" class="form-control" id="birth-date" placeholder="일" aria-describedby="birthHelpBlock" required>
                    <!-- <div class="invalid-feedback">
                        생년월일 일
                    </div> -->
                    <small id="birthHelpBlock" class="form-text text-muted">
                    년(네 자리 ex.1995) 일(두 자리 ex.01)로 입력해주세요.
                    </small>
                    <span id="birthCheck"></span>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-6 mb-3">
                <label for="gender">성별</label>
                <select class="custom-select" id="gender" name="gender" required>
                    <option disabled value="">성별</option>
                    <option value="01">남성</option>
                    <option value="02">여성</option>
                </select><br>
                <!-- <small id="genderHelpBlock" class="form-text text-muted">
                    성별 선택
                </small> -->
                <!-- <div class="valid-feedback">
                    이름 입력완료
                </div> -->
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-6 mb-3">
                <label for="email">이메일</label>
                <input type="email" id="email" class="form-control" aria-describedby="emailHelpBlock" placeholder="이메일 입력"
                        pattern="^[a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$" required>
                <small id="emailHelpBlock" class="form-text text-muted">
                    이메일 인증을 위해 필수 입력사항입니다.
                </small>
                <span id="emailCheck"></span>
                <!-- <div class="valid-feedback">
                    이름 입력완료
                </div> -->
            </div>
        </div>
<!-- 전화번호 인증 버튼 연결 챗 gpt 확인하기 -->
        <div class="form-group">
            <div class="col-md-6 mb-3">
                <label for="phone">전화번호</label>
                <div id="phDiv">
                    <input type="tel" id="phone" class="form-control" aria-describedby="phoneHelpBlock" placeholder="전화번호를 입력해주세요" pattern="^[0-9]{10,11}$" required>
                    <button type="button" id="btnPh1" class="btn btn-secondary" onclick="sendVerificationCode()">인증번호 받기</button><br>
                </div>
                <div>
                    <input type="text" id="verification-code" name="verification-code" class="form-control" placeholder="인증번호를 입력해주세요" required>
                    <button type="button" id="btnPh2" class="btn btn-secondary" onclick="verifyCode()">인증번호 확인</button><br>
                </div>
                <small id="phoneHelpBlock" class="form-text text-muted">
                    휴대폰 인증을 위해 필수 입력사항입니다.
                </small>
                <span id="phoneCheck"></span>
                <!-- <div class="valid-feedback">
                    폰번호 입력완료
                </div> -->
            </div>
        </div>
<!-- 주소 api -->
        <div class="form-group">
            <div class="col-md-6 mb-3">
                <!-- <label for="email">이메일</label>
                <input type="email" id="email" class="form-control" aria-describedby="emailHelpBlock" placeholder="이메일 입력" required>
                <small id="emailHelpBlock" class="form-text text-muted">
                    이메일 인증을 위해 필수 입력사항입니다.
                </small>
                <div class="valid-feedback">
                    이름 입력완료
                </div> -->
                
                <label for="sample6_postcode">주소</label>
                <div class="addressDiv">
                    <input type="text" id="sample6_postcode" class="form-control" aria-describedby="addressHelpBlock" placeholder="우편번호" required>
                    <input type="button" id="addressBtn"class="btn btn-secondary" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                </div>
                <div class="addressDiv">
                    <input type="text" id="sample6_address" class="form-control" placeholder="주소" >
                </div>
                <div class="addressDiv">
                    <input type="text" id="sample6_detailAddress"class="form-control"  placeholder="상세주소">
                </div>
                <div class="addressDiv">
                    <input type="text" id="sample6_extraAddress" class="form-control" placeholder="참고항목">
                </div>
                <!-- <small id="addressHelpBlock" class="form-text text-muted">
                    정확한 주소를 입력해 주세요.
                </small> -->
                <!-- <div class="valid-feedback">
                    주소 입력완료
                </div> -->
            </div>
        </div>

        <div class="form-group">
            <div class="col-md-6 mb-3">
                <div class="form-check">
                    <label class="form-check-label"><input type="checkbox" id="check-all" class="form-check-input" onchange="checkAll()"> <b>[전체 동의]</b><br>
                    <div>
                        이용약관 및 개인정보 수집 및 이용,<br>
                        쇼핑정보 수신(선택)에 모두 동의합니다.
                    </div>
                    </label><br>
                    <label class="form-check-label"><input type="checkbox" name="option1" id="essential-agreement" class="form-check-input" required> <b>[필수]</b> 이용 약관에 동의합니다.</label>
                    <!-- 버튼 아코디언 챗 gpt 참고 -->
                    <button type="button" id="btnAgr1" class="btn btn-secondary btn-sm" onclick="showEssentialAgreement()">+</button>    
                    <div id="essential-agreement-content" class="divAgr">
                        <h6><b>필수 약관</b></h6>
                        <pre>
제1조(목적)

이 약관은 (주)퍼퓸그라피 (전자상거래 사업자)가 운영하는 사이버 몰(이하 "몰"이라 한다)에서 제공하는 인터넷 관련 서비스(이하 "서비스"라 한다)를 이용함에 있어 사이버 몰과 이용자의 권리•의무 및 책임사항을 규정함을 목적으로 합니다.
「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 반하지 않는 한 이 약관을 준용합니다」

제2조(정의)

①"몰" 이란 회사가 재화 또는 용역(이하 "재화 등"이라 함)을 이용자에게 제공하기 위하여 컴퓨터 등 정보통신설비를 이용하여 재화 등을 거래할 수 있도록 설정한 가상의 영업장을 말하며, 아울러 사이버몰을 운영하는 사업자의 의미로도 사용합니다.

②"이용자"란 "몰"에 접속하여 이 약관에 따라 "몰"이 제공하는 서비스를 받는 회원 및 비회원을 말합니다.

③"회원"이라 함은 “몰”에 회원등록을 한 자로서, 계속적으로 “몰”이 제공하는 서비스를 이용할 수 있는 자를 말합니다.

④"비회원"이라 함은 회원에 가입하지 않고 "몰"이 제공하는 서비스를 이용하는 자를 말합니다.

제3조 (약관 등의 명시와 설명 및 개정)

①"몰"은 이 약관의 내용과 상호 및 대표자 성명, 영업소 소재지 주소(소비자의 불만을 처리할 수 있는 곳의 주소를 포함), 전화번호•모사전송번호•전자우편주소, 사업자등록번호, 통신판매업신고번호, 개인정보관리책임자 등을 이용자가 쉽게 알 수 있도록 사이버몰의 초기 서비스화면(전면)에 게시합니다. 다만, 약관의 내용은 이용자가 연결화면을 통하여 볼 수 있도록 할 수 있습니다.

②"몰"은 이용자가 약관에 동의하기에 앞서 약관에 정하여져 있는 내용 중 청약철회•배송책임•환불조건 등과 같은 중요한 내용을 이용자가 이해할 수 있도록 별도의 연결화면 또는 팝업화면 등을 제공하여 이용자의 확인을 구하여야 합니다.

③"몰"은 「전자상거래 등에서의 소비자보호에 관한 법률」, 「약관의 규제에 관한 법률」, 「전자문서 및 전자거래기본법」, 「전자금융거래법」, 「전자서명법」, 「정보통신망 이용촉진 및 정보보호 등에 관한 법률」, 「방문판매 등에 관한 법률」, 「소비자기본법」 등 관련 법을 위배하지 않는 범위에서 이 약관을 개정할 수 있습니다.

④"몰"이 약관을 개정할 경우에는 적용일자 및 개정사유를 명시하여 현행약관과 함께 몰의 초기화면에 그 적용일자 7일 이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다. 이 경우 "몰"은 개정 전 내용과 개정 후 내용을 명확하게 비교하여 이용자가 알기 쉽도록 표시합니다.

⑤"몰"이 약관을 개정할 경우에는 그 개정약관은 그 적용일자 이후에 체결되는 계약에만 적용되고 그 이전에 이미 체결된 계약에 대해서는 개정전의 약관조항이 그대로 적용됩니다. 다만 이미 계약을 체결한 이용자가 개정약관 조항의 적용을 받기를 원하는 뜻을 제3항에 의한 개정약관의 공지기간 내에 "몰"에 송신하여 "몰"의 동의를 받은 경우에는 개정약관 조항이 적용됩니다.

⑥이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 전자상거래 등에서의 소비자보호에 관한 법률, 약관의 규제 등에 관한 법률, 공정거래위원회가 정하는 전자상거래 등에서의 소비자 보호지침 및 관계법령 또는 상관례에 따릅니다.</pre>
                    </div>
                    <label class="form-check-label"><input type="checkbox" name="option2" id="optional-agreement" class="form-check-input"> <b>[선택]</b> 마케팅 용도와 광고성 정보 수신에 동의합니다.</label>
                    <button type="button" id="btnAgr2" class="btn btn-secondary btn-sm" onclick="showOptionalAgreement()">+</button>
                    <div id="optional-agreement-content" class="divAgr">
                        <h6><b>선택 약관</b></h6>
                        <pre>
할인쿠폰 및 혜택, 이벤트, 신상품 소식 등 쇼핑몰에서 제공하는 유익한 쇼핑정보를 SMS나 이메일로 받아보실 수 있습니다.

단, 주문/거래 정보 및 주요 정책과 관련된 내용은 수신동의 여부와 관계없이 발송됩니다.

선택 약관에 동의하지 않으셔도 회원가입은 가능하며, 회원가입 후 회원정보수정 페이지에서 언제든지 수신여부를 변경하실 수 있습니다.</pre>
                    </div>
                </div>
            </div>
        </div>
        <div id="submitDiv">
            <button id="btnSubmit" class="btn btn-secondary btn-lg" type="submit" onclick="return check();">회원가입</button>
        </div>
    </form>
    </section>

    

    <script>

//    let validate = [];
//    let validate = false;

    // Example starter JavaScript for disabling form submissions if there are invalid fields
    (function() {

    'use strict';

        window.addEventListener('load', function() {
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.getElementsByClassName('needs-validation');
            // Loop over them and prevent submission
            var validation = Array.prototype.filter.call(forms, function(form) {
            
                form.addEventListener('submit', function(event) {
                    if (form.checkValidity() === false) {
                        event.preventDefault();
                        event.stopPropagation();

                    }
                    form.classList.add('was-validated');
                }, false);
            });
        }, false);

    })();

        // 아이디 체크
        $('#userId').keyup((event) => {
        // let id = event.target.value;                // 자바스크립트용 표현
        let id = $(event.target).val();             // 제이쿼리 표현
        let regExp = /^[a-z][a-z0-9]{3,11}$/        // 정규표현식
        

        // 유효성 체크만 되어있음
        // db와 비교해서 중복되는 값이 잇는지 확인하는 것도 포함시키기
        if(id === null || id === '') {
            $('#idCheck').text('');
        } else if(regExp.test(id)) {
            $('#idCheck')
                .text('사용 가능한 아이디')
                .css({color: 'green', fontweight: 'bold'});
                

            // $("#btnSubmit"). attr("disabled", true);
        } else {
            $('#idCheck')
                .text('첫 글자는 반드시 영문 소문자, 4 ~ 12자의 영문 소문자 숫자')
                .css({color: 'red', fontweight: 'bold'});

            // $("#btnSubmit"). attr("disabled", false);
        }

        });

        // 비밀번호 체크
        $('#password').keyup((event) => {
        // let id = event.target.value;                // 자바스크립트용 표현
        let pwd = $(event.target).val();             // 제이쿼리 표현
        let regExp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,12}$/        // 정규표현식

        if(pwd === null || pwd === '') {
            $('#pwdCheck').text('');
        } else if(regExp.test(pwd)) {
            $('#pwdCheck')
                .text('사용 가능한 비밀번호')
                .css({color: 'green', fontweight: 'bold'});
        } else {
            $('#pwdCheck')
                .text('하나 이상의 영문 대문자, 소문자, 숫자 및 특수 문자를 포함한 8 ~ 12자')
                .css({color: 'red', fontweight: 'bold'});
        }
        });

        // 비밀번호 일치 확인
        $('#confirm-password').keyup((event) => {
            let pass1 = document.getElementById('password').value;

            let pass2 = document.getElementById('confirm-password').value;

            if(pass2 === null || pass2 === ''){
                $('#conPwdCheck').text('');
            } else if(pass1 !== pass2){
                $('#conPwdCheck').text('비밀번호가 일치하지 않습니다.')
                .css({color: 'red', fontweight: 'bold'});
            } else{
                $('#conPwdCheck')
                .text('비밀번호가 일치합니다.')
                .css({color: 'green', fontweight: 'bold'});
            }
        });

        // 이름 체크
        $('#name').keyup((event) => {
        // let id = event.target.value;                // 자바스크립트용 표현
        let name = $(event.target).val();             // 제이쿼리 표현
        let regExp = /^[가-힣]{2,10}$/        // 정규표현식

        if(name === null || name === '') {
            $('#nameCheck').text('');
        } else if(regExp.test(name)) {
            $('#nameCheck')
                .text('사용 가능한 이름')
                .css({color: 'green', fontweight: 'bold'});
        } else {
            $('#nameCheck')
                .text('띄어쓰기 없이 한글로만 작성해 주십시오.')
                .css({color: 'red', fontweight: 'bold'});
        }
        });

        // 생년월일
        // 년
        $('#birth-year').keyup((event) => {
            // let id = event.target.value;                // 자바스크립트용 표현
            let year = $(event.target).val();             // 제이쿼리 표현
            let regExp = /^(19[0-9][0-9]|20\d{2})$/       // 정규표현식
            var now = new Date();	                        // 현재 날짜 및 시간
            var nowYear = now.getFullYear();
            
            if(year > nowYear) {
                $('#birthCheck').text('유효하지 않은 연도입니다.');
            } else {
                if(year === null || year === '') {
                    $('#birthCheck').text('');
                } else if(regExp.test(year)) {
                    $('#birthCheck')
                        .text('태어난 연도를 정확히 입력하셨습니다.')
                        .css({color: 'green', fontweight: 'bold'});
                } else {
                    $('#birthCheck')
                        .text('태어난 연도를 정확히 입력해 주세요')
                        .css({color: 'red', fontweight: 'bold'});
                }
            }
        });
        // 일
        $('#birth-date').keyup((event) => {

            // let id = event.target.value;                // 자바스크립트용 표현
            let date = $(event.target).val();             // 제이쿼리 표현
            let birthMonth = $('#birth-month option:selected').val();

            console.log(birthMonth);

            if(birthMonth == '01' || birthMonth == '03' || birthMonth == '05' || birthMonth == '07' || birthMonth == '08' || birthMonth == '10' || birthMonth == '12') {
                
                let regExp = /^(0[1-9]|[1-2][0-9]|3[0-1])$/
                
                if(date === null || date === '') {
                    $('#birthCheck').text('');
                } else if(regExp.test(date)) {
                    $('#birthCheck')
                        .text('태어난 일을 정확히 입력하셨습니다.')
                        .css({color: 'green', fontweight: 'bold'});
                } else {
                    $('#birthCheck')
                        .text('태어난 일을 정확히 입력해 주세요')
                        .css({color: 'red', fontweight: 'bold'});
                }

            } else if(birthMonth == '04' || birthMonth == '06' || birthMonth == '09' || birthMonth == '11') {
                
                let regExp = /^(0[1-9]|[1-2][0-9]|3[0])$/
                
                if(date === null || date === '') {
                    $('#birthCheck').text('');
                } else if(regExp.test(date)) {
                    $('#birthCheck')
                        .text('태어난 일을 정확히 입력하셨습니다.')
                        .css({color: 'green', fontweight: 'bold'});
                } else {
                    $('#birthCheck')
                        .text('태어난 일을 정확히 입력해 주세요')
                        .css({color: 'red', fontweight: 'bold'});
                }

            } else { // 2월
                
                let birthYear = $('#birth-year').val();
                // 윤년
                var isleap = (birthYear % 4 == 0 && (birthYear % 100 != 0 || birthYear % 400 == 0));
                
                if(isleap){
                    let regExp = /^(0[1-9]|[1-2][0-9])$/
    
                    if(date === null || date === '') {
                        $('#birthCheck').text('');
                    } else if(regExp.test(date)) {
                        $('#birthCheck')
                            .text('태어난 일을 정확히 입력하셨습니다.')
                            .css({color: 'green', fontweight: 'bold'});
                    } else {
                        $('#birthCheck')
                            .text('태어난 일을 정확히 입력해 주세요')
                            .css({color: 'red', fontweight: 'bold'});
                    }
                    
                } else {
                    let regExp = /^(0[1-9]|[1-2][0-8])$/
    
                    if(date === null || date === '') {
                        $('#birthCheck').text('');
                    } else if(regExp.test(date)) {
                        $('#birthCheck')
                            .text('태어난 일을 정확히 입력하셨습니다.')
                            .css({color: 'green', fontweight: 'bold'});
                    } else {
                        $('#birthCheck')
                            .text('태어난 일을 정확히 입력해 주세요')
                            .css({color: 'red', fontweight: 'bold'});
                    }

                }
            }
        });

        // 이메일 체크 
        $('#email').keyup((event) => {
        // let id = event.target.value;                // 자바스크립트용 표현
        let email = $(event.target).val();             // 제이쿼리 표현
        let regExp = /^[a-z0-9\.\-_]+@([a-z0-9\-]+\.)+[a-z]{2,6}$/       // 정규표현식

        // 유효성 체크만 되어있음
        // db와 비교해서 중복되는 값이 잇는지 확인하는 것도 포함시키기
        if(email === null || email === '') {
            $('#emailCheck').text('');
        } else if(regExp.test(email)) {
            $('#emailCheck')
                .text('')
                .css({color: 'green', fontweight: 'bold'});            
        } else {
            $('#emailCheck')
                .text('이메일 형식에 맞게 제대로 입력해주세요. (ex.perfume@mimoa.com)')
                .css({color: 'red', fontweight: 'bold'});            
        }
        });

        // 폰 체크
        $('#phone').keyup((event) => {
        // let id = event.target.value;                // 자바스크립트용 표현
        let phone = $(event.target).val();             // 제이쿼리 표현
        let regExp = /^[0-9]{10,11}$/       // 정규표현식

        // 유효성 체크만 되어있음
        // db와 비교해서 중복되는 값이 잇는지 확인하는 것도 포함시키기
        if(phone === null || phone === '') {
            $('#phoneCheck').text('');
        } else if(regExp.test(phone)) {
            $('#phoneCheck')
                .text('')
                .css({color: 'green', fontweight: 'bold'});            
        } else {
            $('#phoneCheck')
                .text("전화번호를 '-'없이 숫자만 입력해주세요")
                .css({color: 'red', fontweight: 'bold'});
        }
        });


        // 약관 동의 전체 체크 기능
        function checkAll() {
            var checkboxes = document.getElementsByClassName("form-check-input");
            var checkAllCheckbox = document.getElementById("check-all");
            
            for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = checkAllCheckbox.checked;
            }
        }

        // 약관 동의 본문 보기 아코디언 기능
        function showEssentialAgreement(event) {
            var cont = document.getElementById("essential-agreement-content");
            if (cont.style.display === "block") {
                cont.style.display = "none";
            } else {
                cont.style.display = "block";
            }
        }
        function showOptionalAgreement(event) {
            var cont = document.getElementById("optional-agreement-content");
            if (cont.style.display === "block") {
                cont.style.display = "none";
            } else {
                cont.style.display = "block";
            }
        }

        // 주소 api
        function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
        }


    </script>



    <!-- 주소 api -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <!-- Bootstrap jQuery, JS -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>
</body>
</html>