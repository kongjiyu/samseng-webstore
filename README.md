Samseng Webstore
================

TODO
1. Clone this git repo to your pc
```shell
git clone https://github.com/kongjiyu/samseng-webstore.git
```
2. Open this repo by using intelliJ
3. Change the database properties
```
Username:user
Password:password
```
4. open terminal and type
```shell
npm install
```
5. Deploy this project (top right corner)
6. Build WAR in Docker (top right corner)
6. Check the website by: http://localhost:8080/index.jsp

Project structure

### Project Structure

The project follows the standard **Jakarta EE MVC** structure:

```
samseng-webstore/
│── src/
│   ├── main/
│   │   ├── java/com.samseng.web/
│   │   │   ├── controllers/            # Handles HTTP requests and responses (Servlets)
│   │   │   ├── dto/                    # Data Transfer Objects for API requests/responses
│   │   │   ├── models/                 # JPA entity classes representing database tables
│   │   │   ├── repositories/           # Interfaces for database interactions using JPA
│   │   │   ├── services/               # Business logic layer
│   │   │   ├── HelloServlet.java       # Example servlet for handling basic HTTP requests
│   │   │   ├── RestApplication.java    # Jakarta EE Rest API Example
│   │   ├── resources/
│   │   │   ├── META-INF/               # Configuration files (e.g., persistence.xml for JPA)
│   │   ├── webapp/
│   │   │   ├── static/                 # Static files (CSS, JavaScript, images)
│   │   │   ├── views/                  # JSP files for rendering UI
│   │   │   ├── WEB-INF/                # Protected resources (e.g., web.xml)
│   │   │   ├── index.jsp               # Main entry page for the web application
```

This structure follows best practices for maintainability and scalability in Jakarta EE applications.