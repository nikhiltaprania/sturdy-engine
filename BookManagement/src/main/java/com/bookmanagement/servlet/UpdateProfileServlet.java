package com.bookmanagement.servlet;

import com.bookmanagement.dao.UserDAO;
import com.bookmanagement.dao.UserDAOImpl;
import com.bookmanagement.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String password = request.getParameter("password");

        User newUser = new User();
        newUser.setUserId(userId);
        newUser.setName(request.getParameter("fullName"));
        newUser.setEmail(request.getParameter("email"));
        newUser.setPhone(request.getParameter("phone"));

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        boolean isUpdated = userDAO.updateUser(newUser);

        try {
            if (user.getPassword().equals(password) && isUpdated) {
                session.setAttribute("successMessage", "Details Updated Successfully");
                response.sendRedirect("edit-profile.jsp");

            } else {
                session.setAttribute("failedMessage", "Password is incorrect");
                response.sendRedirect("edit-profile.jsp");
            }

        } catch (Exception e) {
            session.setAttribute("failedMessage", "Something Went Wrong");
            response.sendRedirect("edit-profile.jsp");
        }
    }
}