package com.bookmanagement.servlet;

import com.bookmanagement.dao.UserDAO;
import com.bookmanagement.dao.UserDAOImpl;
import com.bookmanagement.model.Address;
import com.bookmanagement.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/addAddress")
public class AddAddressServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String password = request.getParameter("password");

        Address address = new Address();
        address.setCity(request.getParameter("city"));
        address.setState(request.getParameter("state"));
        address.setPinCode(Integer.parseInt(request.getParameter("pinCode")));

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        address.setAddressId(user.getUserId());
        user.setAddress(address);

        try {
            if (user.getPassword().equals(password) && userDAO.updateUser(user)) {
                session.setAttribute("successMessage", "Details Updated Successfully");
                response.sendRedirect("user-address.jsp");
            } else {
                session.setAttribute("failedMessage", "Password is incorrect");
                response.sendRedirect("user-address.jsp");
            }

        } catch (Exception e) {
            session.setAttribute("failedMessage", e.getMessage());
            response.sendRedirect("user-address.jsp");
        }
    }
}
