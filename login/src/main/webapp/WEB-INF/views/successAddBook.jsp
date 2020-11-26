<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>本の登録完了ページ</title>
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
		color : white;
		font-weight: bold;
		background-color: gray;
	}
	h2 {
		margin-top : 10%;
		text-align: center;
		font-size: 30px;
		font-weight: bold;
	}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function () {
		$('#exit').click(function () {
			$('#inputForm').submit();
		});
	});
</script>

</head>
<body>
	<div>
		<h2>本を登録しました。</h2>
		
		<div id="inputDiv">
			<form action="/loginCheck" method="post" id="inputForm">
				<input type="hidden" name="id" value="admin">
				<input type="hidden" name="pass" value="Admin1234">
			</form>
			<input type="button" value="一覧へ" id="exit">
		</div>	
	</div>
</body>
</html>