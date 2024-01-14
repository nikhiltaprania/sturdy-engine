package com.bookmanagement.servlet;

import com.bookmanagement.dao.UserDAO;
import com.bookmanagement.dao.UserDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        boolean isDeleted = userDAO.deleteUser(userId);

        HttpSession session = request.getSession();
        if (isDeleted) {
            userDAO.deleteAddressById(userId);
            session.setAttribute("message", "Account (ID " + userId + ") has been removed");
            response.sendRedirect("admin/manage-users.jsp");

        } else {
            session.setAttribute("message", "Something Went Wrong");
            response.sendRedirect("admin/manage-users.jsp");
        }
    }
}