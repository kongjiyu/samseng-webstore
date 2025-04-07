import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class loginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (isValidLogin(email, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", email);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("loginError", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private boolean isValidLogin(String email, String password) {
        boolean isValid = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load JDBC driver
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/user", "root", "your_password");

            String sql = "SELECT password FROM account WHERE email = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                if (password.equals(storedPassword)) {
                    isValid = true;
                }
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isValid;
    }
}