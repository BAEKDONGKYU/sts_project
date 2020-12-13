<%@page import="java.text.DecimalFormat"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import = "com.example.model.Books" %>
<%@ page import = "java.util.ArrayList" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.out {
	width : 100%;
}

#titleDiv {
	margin-top : 2%;
	width : 95%;
	font-weight: bold;
	height: 80px;
	overflow: hidden;
	text-align: right;
}

.deleteButton {
	width: 70px;
	background-color: red;
	color: white;
	font-weight: bold;
}

.contentDiv  {
	margin-left: 50px;
}
.footerDiv {
	text-align: right;
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

#bookRegister {
	width: 140px;
	height: 40px;
	font-weight: bold;
	font-size: large;
	background-color : CornflowerBlue;
	margin-top : 25px;
	margin-right : 50px;
	color: white;
	margin-right: 5%;
}
.clear_both {
	clear: both;
}
a {
	font-weight: bold;
	font-size: x-large;
}

table {
	border-top: 1px solid black;
	border-bottom : 1px solid black;
	width: 95%;
}

.left_sort_th {
	text-align: left;
	font-weight: bold;
	font-size: large;
	
}
.right_sort_th {
	text-align: center;
	font-weight: bold;
	font-size: large;
	width: 15%;
	
}
#price_td {
	text-align: right;
}
#errorMessage_tr {
	height: 70px;
}
#errorMessage_td {
	text-align: center;
	color: red;
	font-weight: bold;
	font-size: x-large;
}
table th {
	border-bottom: 1px solid black;
}
a {
	font-size: medium;
}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>

<script type="text/javascript">
	$(function () {	
		$('#sub').click(function (){
			$('#logOutForm').submit();
		});
			
		$('#bookRegister').click(function () {
			$('#bookRegisterForm').submit();
		});

		$('.deleteButton').click(function (){
			var result = confirm("掃除しますか？");
			if(result) {
				var deleteNo = $(this).parent().prevAll("#bookNo").val();
				$("#deleteNo").val(deleteNo);
				$("#deleteBookForm").submit();
			}
		});

	});
</script>
<title>ログイン成功</title>
</head>
<body>
	<div class="out">
		<div id="titleDiv">
			<strong style="font-size: 20px;">${id}</strong>様がログイン中です。
			<input type="button" value="サインアウト" id="sub">	
		</div>
	    <div class="clear_both"></div>
		<div class="contentDiv">
			<h1>本一覧</h1>
			<table>
				<tr class="table_th">
					<th class="left_sort_th">タイトル</th>
					<th class="left_sort_th">著者</th>
					<th class="left_sort_th">出版社</th>
					<th class="left_sort_th">発売日</th>
					<th class="right_sort_th">値段</th>
				</tr>
			<%
				ArrayList<Books> books = (ArrayList<Books>)request.getAttribute("booksInfo");
				DecimalFormat formatter = new DecimalFormat("###,###");
				if(books.size() > 0 ) {
					for(int i=0; i<books.size(); i++) {
						String title = books.get(i).getTitle();
						String author = books.get(i).getAuthor();
						String publisher = books.get(i).getPublisher();
						int book_no = books.get(i).getBook_no();
						if(author.length() > 10) {
							author = author.substring(0,9)+"...";
						}
						if(publisher.length() > 10) {
							publisher = publisher.substring(0,9)+"...";
						}
						if(title.length() > 10) {
							title = title.substring(0,9)+ "...";
						}
		     %>
		     	<tr>
		     		<td class="title_td">
		     			<a href="/updateBookInfo?book_no=<%=book_no%>">
		     			<%=title %>
		     			</a>			
		     		</td>
		     		<input type="hidden" value="<%=book_no%>" id="bookNo">
		     		<td><%=author %></td>
		     		<td><%=publisher%></td>
		     		<td>
		     			<fmt:formatDate value="<%=books.get(i).getReleaseDate()%>" pattern="yyyy年 M月 d日"/>
		     		</td>
		     		<td id="price_td">
		     			<%=formatter.format(books.get(i).getPrice()) %>円
		     			<input type="button" value="掃除" class="deleteButton">
		     		</td>
		     	</tr>
		     <%		
					}
				}else {
			  %>
			  	<tr id="errorMessage_tr">
			  		<td rowspan="5" colspan="5" id="errorMessage_td">登録された本がありません</td>
			  	</tr>
			  <%
				}
				
			%>			
			</table>
			<div class="footerDiv">
				<form action="/bookRegister" method="post" id="bookRegisterForm"></form>
				<form action="/deleteBookInfo"method="post" id="deleteBookForm">
					<input type="hidden" id="deleteNo" name="deleteNo">
				</form>
				<form action="/logOut" method="post" id="logOutForm"></form>
				<input type="button" value="登録" id="bookRegister">	
			</div>
		</div>	
	</div>
</body>
</html>