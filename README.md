# Samseng Webstore

A modern Jakarta EE-based e-commerce web application, designed for easy deployment and development using Docker. The project features a modular architecture, robust user and product management. All core services (application server, database, etc.) are containerized for a seamless developer experience.

## Prerequisites

- [Docker](https://www.docker.com/) (latest version recommended)
- [Docker Compose](https://docs.docker.com/compose/) (if not included with Docker Desktop)
- IntelliJ IDEA
- (Optional) Node.js and npm (for static asset development)

## Getting Started

### Setup Instructions

1. **Clone the Repository in IntelliJ**

   - Open IntelliJ IDEA
   - Go to `File > New > Project from Version Control > Git` (or use the welcome screen's Clone option)![1746001482968](images/README/1746001482968.png)
   - Paste the repository URL: https://github.com/kongjiyu/samseng-webstore.git![1746001558827](images/README/1746001558827.png)
   - Choose your desired directory and click `Clone`
2. **Configure Database Connection in IntelliJ**

   - On the right sidebar, open the `Database` tool window
   - Right-click `localhost` and select `Properties`![1746001740199](images/README/1746001740199.png)
   - Enter the credentials:
     - User: `user`
     - Password: `password`
   - Press `Test Connection` to ensure the connection
   - Click `Save`![1746001849159](images/README/1746001849159.png)
3. **Deploy and Run the Application**

   - At the top right corner of IntelliJ, select the pre-configured `deploy` run configuration![1746001962065](images/README/1746001962065.png)
   - Click the green `Run` button![1746002027618](images/README/1746002027618.png)
4. **Build WAR File Using Docker (Platform-Specific)**

   - Choose the appropriate build script for your operating system:
     - For macOS/Linux: run `Build WAR in Docker-Unix`
     - For Windows: run `build WAR in Docker-Windows`
5. **Run the Build WAR Script**

   - Execute the chosen script to build the WAR file inside Docker
6. **Verify Database Deployment**

   - In IntelliJ, open the `Database` tool window
   - Expand `localhost > user > public > tables` to check that the tables have been created
7. **Run Dummy Data Script**

   - At the top right corner of IntelliJ, run the `DummyData` file to populate the database with sample data
8. **Access the Website**

   - Open your browser and go to `http://localhost:8080`

## Project Modules

### Core Modules

1. **User Management**

   - User registration and authentication
   - Profile management
   - Role-based access control (Admin/Customer)
2. **Product Management**

   - Product CRUD operations
   - Category management
   - Product variants and attributes
   - Image upload and management
3. **Shopping Cart**

   - Add/remove items
   - Quantity management
   - Price calculation
   - Session management
4. **Order Processing**

   - Order creation and management
   - Order status tracking
   - Order history
5. **Promotion System**

   - Promo code management
   - Discount calculations

### Technical Architecture

```
samseng-webstore/
│── src/main/
    ├── java/com.samseng.web/
    │   ├── controllers/        # Servlet controllers for HTTP request handling
    │   ├── models/             # JPA entities
    │   ├── repositories/       # Data access layer
    │   ├── services/           # Business logic
    │   └── utils/              # Helper classes
    ├── resources/
    │   ├── META-INF/         # JPA configuration
    │   └── sql               # Database scripts
    └── webapp/
        ├── WEB-INF/          # Web configuration
        ├── admin/            # Admin interface
        ├── static/           # Static resources
        └── views/            # JSP templates
```

### Key Features

- Secure authentication
- Product search and filtering
- Shopping cart management
- Order tracking
- Admin dashboard
- Image management
- Promo code system

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
