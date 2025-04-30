package com.samseng.web.utils;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

@WebServlet(name = "AppInitServlet", urlPatterns = {}, loadOnStartup = 1)
public class AppInitServlet extends HttpServlet {
    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();

        // Load application-wide context parameters
        String companyName = context.getInitParameter("companyName");
        String companyEmail = context.getInitParameter("companyEmail");
        String companyContact = context.getInitParameter("companyContact");
        String companyAddress = context.getInitParameter("companyAddress");
        String companyLogo = context.getInitParameter("companyLogo");
        String copyright = context.getInitParameter("copyright");

        // Store them in context attributes so JSPs can access
        context.setAttribute("companyName", companyName);
        context.setAttribute("companyEmail", companyEmail);
        context.setAttribute("companyContact", companyContact);
        context.setAttribute("companyAddress", companyAddress);
        context.setAttribute("companyLogo", companyLogo);
        context.setAttribute("copyright", copyright);
    }
}