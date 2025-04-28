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

import java.io.IOException;
import java.util.Date;
import java.util.Properties;


@WebServlet("/contact")
public class ContactUsServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data
        String senderName = request.getParameter("name");
        String senderEmail = request.getParameter("email");
        String senderMessage = request.getParameter("message");

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
        Session session = Session.getInstance(properties, auth);
        session.setDebug(true);

        try {
            // Create email message
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(userName));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress));
            msg.setSubject(subject);
            msg.setSentDate(new Date());
            msg.setText(messageContent);

            // Send message
            Transport.send(msg);

            request.setAttribute("toastMessage", "Email sent successfully.");
            request.setAttribute("toastType", "success");

            response.sendRedirect(request.getContextPath() + "/");
        } catch (MessagingException e) {
            e.printStackTrace();
            request.setAttribute("toastMessage", "Email sent failed: " + e.getMessage());
            request.setAttribute("toastType", "error");
        }
    }
}