package com.samseng.web.controllers;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;
import java.util.regex.Pattern;

@WebServlet("/contact")
public class ContactUsServlet extends HttpServlet {
    private static final String EMAIL_REGEX = "^[A-Za-z0-9+_.-]+@(.+)$";
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve form data
        String senderName = request.getParameter("name");
        String senderEmail = request.getParameter("email");
        String senderMessage = request.getParameter("message");

        // Validate input
        if (!validateInput(senderName, senderEmail, senderMessage, session)) {
            response.sendRedirect(request.getContextPath() + "/contact.jsp");
            return;
        }

        try {
            sendEmail(senderName, senderEmail, senderMessage, session);
            response.sendRedirect(request.getContextPath() + "/");
        } catch (Exception e) {
            session.setAttribute("toastMessage", "Failed to send email: " + e.getMessage());
            session.setAttribute("toastType", "error");
            response.sendRedirect(request.getContextPath() + "/contact.jsp");
        }
    }

    private boolean validateInput(String name, String email, String message, HttpSession session) {
        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("toastMessage", "Name is required.");
            session.setAttribute("toastType", "error");
            return false;
        }

        if (email == null || email.trim().isEmpty()) {
            session.setAttribute("toastMessage", "Email is required.");
            session.setAttribute("toastType", "error");
            return false;
        }

        if (!EMAIL_PATTERN.matcher(email).matches()) {
            session.setAttribute("toastMessage", "Invalid email format.");
            session.setAttribute("toastType", "error");
            return false;
        }

        if (message == null || message.trim().isEmpty()) {
            session.setAttribute("toastMessage", "Message is required.");
            session.setAttribute("toastType", "error");
            return false;
        }

        if (message.length() > 1000) {
            session.setAttribute("toastMessage", "Message is too long. Maximum 1000 characters allowed.");
            session.setAttribute("toastType", "error");
            return false;
        }

        return true;
    }

    private void sendEmail(String senderName, String senderEmail, String senderMessage, HttpSession session) 
            throws MessagingException {
        // SMTP configuration
        String host = "smtp.gmail.com";
        String port = "587";
        final String userName = "nglk-wm23@student.tarc.edu.my";
        final String password = "etiedckgvjlidztw";        // App password

        String toAddress = "kongjiyu0198@gmail.com";       // Receiver
        String subject = "Contact Us Message from " + senderName;
        String messageContent = "Name: " + senderName + "\n"
                + "Email: " + senderEmail + "\n"
                + "Message: \n" + senderMessage;

        // Set SMTP properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.ssl.trust", host);

        // Create authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };

        // Create session
        Session mailSession = Session.getInstance(properties, auth);
        mailSession.setDebug(true);

        try {
            // Create email message
            Message msg = new MimeMessage(mailSession);
            msg.setFrom(new InternetAddress(userName));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
            msg.setSubject(subject);
            msg.setSentDate(new Date());
            msg.setText(messageContent);

            // Send message
            Transport.send(msg);

            session.setAttribute("toastMessage", "Your message has been sent successfully. We'll get back to you soon!");
            session.setAttribute("toastType", "success");
        } catch (MessagingException e) {
            session.setAttribute("toastMessage", "Failed to send email. Please try again later.");
            session.setAttribute("toastType", "error");
            throw e;
        }
    }
}