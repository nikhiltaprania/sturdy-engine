package com.bookmanagement.servlet;

import com.bookmanagement.dao.UserCartDAO;
import com.bookmanagement.dao.UserCartDAOImpl;
import com.bookmanagement.model.Address;
import com.bookmanagement.model.Book;
import com.bookmanagement.model.Orders;
import com.bookmanagement.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/processOrder")
public class OrderProcessServlet extends HttpServlet {
    private final UserCartDAO userCartDAO = new UserCartDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        user.setPhone(request.getParameter("phone"));

        Address address = new Address();
        address.setAddressId(user.getUserId());
        address.setCity(request.getParameter("city"));
        address.setState(request.getParameter("state"));
        address.setPinCode(Integer.parseInt(request.getParameter("pinCode")));

        user.setAddress(address);

        Orders order = new Orders();
        order.setOrderDate(Date.valueOf(LocalDate.now()));
        order.setUser(user);
        order.setTotalAmount(Double.parseDouble(request.getParameter("totalAmount")));
        List<Book> books = userCartDAO.getAllBooksOfAUser(user.getUserId());
        order.setBooks(books);

        if (userCartDAO.placeOrder(order)) {
            for (Book book : books) {
                userCartDAO.deleteABookOfAUser(user.getUserId(), book.getBookId());
            }
            response.sendRedirect("order-success.jsp");

        } else {
            session.setAttribute("message", "Something Went Wrong On Server");
            response.sendRedirect("payment-page.jsp");
        }
    }
}