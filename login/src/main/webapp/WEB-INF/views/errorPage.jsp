<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>エーラページ</title>
<style>
	div {
		text-align: center;
	}
	#inputDiv {
		margin-top: 50px;
	}
	input {
		width: 150px;
		height: 50px;
		font-size: 20px;
		font-weight: bold;
	}
	h2 {
		margin-top : 10%;
		text-align: center;
		color: red;
		font-size: 30px;
		font-weight: bold;
	}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function () {
		$('#exit').click(function () {
			window.history.back();
		});
	});
</script>

</head>
<body>
	<div>
		<h2>登録中にエラーが発生しました。<br>
			管理者にお問合せ下さい。
		</h2>
		
		<div id="inputDiv">
			<input type="button" value="戻る" id="exit">
		</div>	
	</div>
</body>
</html>