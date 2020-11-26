<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import = "com.example.model.Books" %>
<%
	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/M/d");
	Books book = (Books)request.getAttribute("updateBookInfo");
	String releaseDate =  simpleDateFormat.format(book.getReleaseDate());
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>本の修正</title>
<style>
	.out {
		width : 100%;
	}
	#titleDiv {
		margin-top : 2%;
		width : 95%;
		font-weight: bold;
		height: 50px;
		overflow: hidden;
		text-align: right;
	}
	#contentDiv {
		width : 95%;
		margin-left: 50px;
	}
	
	.clear_both {
		border-bottom : 3px solid CornflowerBlue;
		margin-left: 50px;
		width : 92%;
		clear: both;
	}
	#sub {
		width : 140px;
		height : 40px;
		background-color: red;
		float : right;
		color: white;
		font-size : large;
		font-weight: bold;
	}
	
	#sectionDiv {
		width : 95%;
		border-top: 3px solid CornflowerBlue;
		padding-left: 20px;
		margin-top: 20px;
	}
	#footerDiv {
		width : 100%;
		padding-left: 20px;
		margin-top : 50px;
		text-align: center;
		margin-left: 3%;
	}
	#footerDiv input {
		padding: 10px;
		font-size: 25px;
		margin-right: 10px;
	}
	
	span {
		color: red;
	}
	table {
		border-spacing: 30px 10px;
		margin: 0 auto;
	}
	.bookInfo {
		width: 300px;
		height: 40px;
		font-size:  25px;
		font-weight: bolder;
	}
	.firstTD {
		font-size:  25px;
		font-weight: bolder;
		height:40px; 
		width: 35%;
		text-align: right;
	}
	.secondTD {
		font-size:  25px;
		height:40px;
		width: 65%;
	}
	
	#update {
		width: 170px;
		height: 70px;
		color: white;
		background: blue;
		text-align: center;
	}
	#back {
		width: 170px;
		height: 70px;
		color: white;
		background-color: gray;
		text-align: center;
	}
	
</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<script type="text/javascript">
	$(function () {
		$('#update').click(function () {
			  var regExp = /\s/g; // 空白チェック
			　 var priceRegExp = /^[0-9]+$/; //数字チェック
			  var dateExp = /[0-9]{4}\/(0?[1-9]|1[012])\/(0?[1-9]|[12][0-9]|3[01])/;  //販売日チェック	
			  var title = $('#bookTitle').val();
			  var author = $('#author').val();
			  var price = $('#price').val();
			  var releaseDate = $('#releaseDate').val();
			  var publisher　= $('#publisher').val();

			  if(title == '') {
				  alert("タイトルを入力してください。");
				  $('#bookTitle').focus();
				  return;
			  }
			  if(author == '') {
				  alert("著者を入力してください。");
				  $('#author').focus();
				  return;
			  }
			  if(price == '') {
				  alert("価額を入力してください。");
				  $('#price').focus();
				  return;
			  }
			  if(regExp.test(title) == true) {
				  alert("空白は入力できません。");
				  $('#bookTitle').focus();
				  return;	  
			  }
			  if(regExp.test(author) == true) {
				  alert("空白は入力できません。");
				  $('#author').focus();
				  return;
			  }
			  if(publisher != '') {
				if(regExp.test(publisher) == true) {
					 alert("空白は入力できません。");
					 $('#publisher').focus();
					 return;
				}
			  }
			  if(releaseDate != '') {
				if(regExp.test(releaseDate) == true) {
					alert("空白は入力できません。");
					$('#releaseDate').focus();
					return;
				}
				else {
					if(dateExp.test(releaseDate) == false) {
						alert("形式に合わないです。\n2020/5/5ように入力してください。");
						$('#releaseDate').focus();
						return;
					}
				}
			  }
			  if(priceRegExp.test(price) == false ) {
				  alert("価額は数字のみで入力してください。");
				  $('#price').focus();
				  return;
			  }
			  else {
				$('#bookInfo').submit();
			  }
		});

		$('#back').click(function () {
			window.history.back();
		});

		$('#sub').click(function () {
			$('#logOutForm').submit();
		});
	});
</script>
</head>
<body>
	<div class="out">
		<div id="titleDiv">
			<strong style="font-size: 20px;">${id}</strong>様がログイン中です。
			<input type="button" value="サインアウト" id="sub">
		</div>
		<div class="clear_both"><h1>修正</h1></div>
		<div id="contentDiv">
			<div style="margin-top: 30px;"></div>
			<form action="/updateSuccess" method="post" id="bookInfo">
				<input type="hidden" name="book_no" value="${updateBookInfo.book_no}">
				<table>
					<tr>
						<td class="firstTD"><label for="bookTitle"><span>*</span>タイトル</label></td>
						<td class="secondTD"><input type="text" id="bookTitle"
							class="bookInfo" name="bookTitle" maxlength="100"
							placeholder="最大100文字まで" value="${updateBookInfo.title}"></td>
					</tr>
					<tr>
						<td class="firstTD"><label for="author"><span>*</span>著者</label></td>
						<td class="secondTD"><input type="text" id="author"
							class="bookInfo" name="author" maxlength="50"
							placeholder="最大50文字まで" value="${updateBookInfo.author}"></td>
					</tr>
					<tr>
						<td class="firstTD"><label for="publisher">出版社</label></td>
						<td class="secondTD"><input type="text" id="publisher"
							class="bookInfo" name="publisher" maxlength="50"
							placeholder="最大50文字まで" value="${updateBookInfo.publisher}"></td>
					</tr>
					<tr>
						<td class="firstTD"><label for="releaseDate">販売日</label></td>
						<td class="secondTD"><input type="text" id="releaseDate"
							class="bookInfo" name="releaseDate" maxlength="10"
							placeholder="yyyy/M/d" value="<%=releaseDate%>">
						</td>
					</tr>
					<tr>
						<td class="firstTD"><label for="price"><span>*</span>価額</label></td>
						<td class="secondTD"><input type="text" id="price"
							class="bookInfo" name="price" maxlength="7" placeholder="数字のみ" value="${updateBookInfo.price}"></td>
					</tr>
				</table>
			</form>
		</div>	
		
		 <div id="footerDiv">
			<input type="button" value="変更" id="update">
			<form action="/logOut" method="post" id="logOutForm"></form>
			<input type="button" value="戻る" id="back">	
		</div>
	</div>
</body>
</html>