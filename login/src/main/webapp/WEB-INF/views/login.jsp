<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<style>
	.wrap {
		width: 100%;
		height: 100%;
	}
	.container {
		position: absolute;
		top : 50%;
		left : 50%;
		width: 1000px;
		height: 600px;
		margin-left : -500px;
		margin-top : -300px;
	}
	h1 {
		margin-top : 50px;
		margin-bottom : 50px;
		font-size : xx-large;
		font-weight: bolder;
	}
	.userInfo {
		margin : 0 auto;
		text-align: center;
	}
	label {
		font-size: x-large;
		font-weight: bolder;
	}
	.inputInfo {
		background-color: lavender;
		width: 300px;
		height: 50px;
		margin-left: 50px;
		font-size: 20px;
		margin-top: 20px;
	}
	.submitButton {
		width: 300px;
		height: 70px;
		margin-bottom: 50px;
		font-weight: bold;
		font-size:  x-large;
		margin-top: 60px;
		background-color: RoyalBlue;
		color: white;
	}
	.findPass {
		font-size: 20px;
		font-weight: bold;
	}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function () {
		$('#errorMessage').hide();
		var errorMessage = $('#errorMessage').attr('value');
		if(errorMessage != "" || errorMessage != null ) {
			$('#errorMessage').show();
		}

		$('.submitButton').click(function () {
			var id = $('#id').val();
			var pass = $('#pass').val();
			var idRegExp = /^[A-Za-z0-9]{4,20}$/;
			var passRegExp = /^(?=.*[A-Z])[A-Za-z0-9]{8,32}$/;
			var checkId = idRegExp.test(id);
			var checkPass = passRegExp.test(pass);

			if(checkId == false && checkPass == false ) {
				alert("アカウントとパスワードが形式に合わないです。\n"
					　　+"アカウントは4 ~ 20 英文字と数字のみで入力してください。\n"
					　　+"パスワードは8 ~ 32　英文字の大文字が必ず１文字以上が含まれて\n"
					  +"英文字と数字のみで入力してください。");
				$('#id').focus();
			}else if(checkId == false) {
				alert("アカウントが形式に合わないです。\n"
					+"4 ~ 20 英文字と数字のみで入力してください。");
				$('#id').focus();
			}else if(checkPass == false) {
				alert("パスワードが形式に合わないです。\n"
					+"8 ~ 32　英文字の大文字は必ず１文字以上が含まれて\n"
					+"英文字と数字のみで入力してください。");
				$('#pass').focus();
			}else {
				$('#loginForm').submit();
			}	
		});
	}); 
</script>
</head> 
<body>
	<div class="wrap">
		<div class="header"></div>
		<div class="container">
			<div class="userInfo">
				<form action="/loginCheck" method="post" id="loginForm">
					<h1>ログイン</h1>
					<div id="errorMessage">${error}</div>
					<label for="id">アカウント</label> 
					<input type="text" id="id" name="id" class="inputInfo" maxlength="20"><br>
					<label for="pass">パスワード</label> 
					<input type="password" id="pass" name="pass" class="inputInfo" maxlength="32"><br>
					<input type="button" value="サインイン" class="submitButton">
				</form>
				<a href="#" class="findPass">パスワードをお忘れの方はこちらへ</a>
			</div>
		</div>
		<div class="footer"></div>
	</div>
</body>
</html>