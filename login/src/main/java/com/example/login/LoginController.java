package com.example.login;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.mapper.BookInfoMapper;
import com.example.model.Books;


@Controller
public class LoginController {
	@Autowired
	private BookInfoMapper mapper;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String login() {
		return "login";
	}
	
	@RequestMapping(value="/loginSuccess", method = RequestMethod.POST)
	public String loginSuccess () {
		return "loginSuccess";
	}
	
	@RequestMapping(value = "/logOut", method = RequestMethod.POST)
	public String logOut() {
		return "login";
	}
	
	@RequestMapping(value = "/errorPage" , method = RequestMethod.POST) 
		public String errorPage () {
			return "errorPage";
		}
	
	
	@RequestMapping(value = "/bookRegister", method = RequestMethod.POST) 
	public String bookRegister (HttpServletRequest request ,Model model) {
		return "bookRegister";
	}
	
	@RequestMapping(value ="/successAddBook", method = RequestMethod.POST)
	public String successAddBook() {
		return "successAddBook";
	}
	
	@RequestMapping(value = "/deleteBookInfo" , method = RequestMethod.POST)
	public String deleteBookInfo(HttpServletRequest request ,Model model) {
		String url = "/loginSuccess";
		ArrayList<Books> books = null;
		int bookNo = Integer.parseInt(request.getParameter("deleteNo"));
		try {
			mapper.deleteBookInfo(bookNo); 
			books = mapper.selectBooksInfo(); 
			model.addAttribute("booksInfo",books);
		} catch (Exception e) {
			e.printStackTrace();
			url = "/errorPage";
		}
		return url;
	}
	
	
	@RequestMapping(value = "/bookInfoCheck", method = RequestMethod.POST) 
	public String bookInfoCheck (HttpServletRequest request ,Model model) {
		String url = "/successAddBook";
		String title = request.getParameter("bookTitle");
		String author = request.getParameter("author");
		String publisher = request.getParameter("publisher");
		String releaseDate = request.getParameter("releaseDate");
		int price = Integer.parseInt(request.getParameter("price"));
		String dateArr[] = releaseDate.split("/");
		int year = Integer.parseInt(dateArr[0]);
		int month = Integer.parseInt(dateArr[1])-1;
		int date = Integer.parseInt(dateArr[2]);
		
		Calendar cal = Calendar.getInstance();
		cal.set(year, month, date);
		Date date_ = cal.getTime();
		
		
		ArrayList<Books> books = null;
		try {
			System.out.println("タイトルは"+title);
			System.out.println("著者は"+author);
			System.out.println("出版社"+publisher);
			System.out.println("販売日"+releaseDate);
			System.out.println("価額"+price);
			Books book = new Books();
			book.setAuthor(author);
			book.setPrice(price);
			book.setPublisher(publisher);
			book.setReleaseDate(date_);
			book.setTitle(title);
			mapper.inertBookInfo(book);
			books = mapper.selectBooksInfo();
			model.addAttribute("booksInfo",books);
		} catch (Exception e) {
			e.printStackTrace();
			url = "/errorPage";
		}
		return url;
	}
	@RequestMapping(value="/updateBookInfo", method = RequestMethod.GET) 
	public String updateBookInfo (HttpServletRequest request, Model model, 
			@RequestParam("book_no") int book_no) {
		String url = "updateBookInfo";
		try {
			Books book = mapper.selectBookInfo(book_no);
			model.addAttribute("updateBookInfo", book);
		} catch (Exception e) {
			e.printStackTrace();
			url = "/errorPage";
		}
		return url;
	}	
	
	@RequestMapping(value="/updateSuccess", method = RequestMethod.POST)
	public String updateSuccess (HttpServletRequest request , Model model) {
		String url = "/loginSuccess";
		String title = request.getParameter("bookTitle");
		String author = request.getParameter("author");
		String publisher = request.getParameter("publisher");
		String releaseDate = request.getParameter("releaseDate");
		int price = Integer.parseInt(request.getParameter("price"));
		int book_no = Integer.parseInt(request.getParameter("book_no"));
		
		String dateArr[] = releaseDate.split("/");
		int year = Integer.parseInt(dateArr[0]);
		int month = Integer.parseInt(dateArr[1])-1;
		int date = Integer.parseInt(dateArr[2]);
		
		Calendar cal = Calendar.getInstance();
		cal.set(year, month, date);
		Date date_ = cal.getTime();
		
		Books book = new Books();
		book.setAuthor(author);
		book.setPrice(price);
		book.setPublisher(publisher);
		book.setReleaseDate(date_);
		book.setTitle(title);
		book.setBook_no(book_no);
		ArrayList<Books> books = null;
		try {
			mapper.updateBookInfo(book);
			books = mapper.selectBooksInfo();
			model.addAttribute("booksInfo",books);
		} catch (Exception e) {
			e.printStackTrace();
			url = "/errorPage";
		}
		return url;
	}
	
	
	@RequestMapping(value = "/loginCheck", method = RequestMethod.POST)
	public String loginCheck(HttpServletRequest request , Model model) {
		String url = "/loginSuccess";
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		if(id.equals("admin") && pass.equals("Admin1234")) {
			HttpSession session  = request.getSession();
			session.setAttribute("id", id);
			ArrayList<Books> books = null;
			try {
				books = mapper.selectBooksInfo();
				model.addAttribute("booksInfo",books);
			} catch (Exception e) {
				e.printStackTrace();
				url = "/errorPage";
			}
			return url;
		}
		else {
			model.addAttribute("error", "アカウントやパスワードが間違っています。");
			return "login";
		}
		
	}
	
	
	
	
}
