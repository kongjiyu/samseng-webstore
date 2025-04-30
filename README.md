# Samseng Webstore

A Jakarta EE-based e-commerce web application with modern features and a user-friendly interface.

## Getting Started

### Prerequisites
- JDK 17 or later
- IntelliJ IDEA (Ultimate Edition recommended)
- GlassFish 7.0.x
- MySQL 8.0 or later
- Node.js and npm

### Setup Instructions

1. **Clone the Repository**
   ```shell
   git clone https://github.com/kongjiyu/samseng-webstore.git
   cd samseng-webstore
   ```

2. **Open in IntelliJ IDEA**
   - Launch IntelliJ IDEA
   - Select `File > Open`
   - Navigate to the cloned repository and click `Open`
   - Wait for IntelliJ to import and index the project

3. **Configure Database**
   - Open MySQL and create a new database named `samseng_db`
   - Update `src/main/resources/META-INF/persistence.xml` with your database credentials:
     ```xml
     <property name="jakarta.persistence.jdbc.user" value="user"/>
     <property name="jakarta.persistence.jdbc.password" value="password"/>
     ```

4. **Install Node Dependencies**
   ```shell
   npm install
   ```

5. **Configure GlassFish in IntelliJ**
   - Click `Add Configuration` in the top-right corner
   - Click the `+` button and select `GlassFish Server > Local`
   - Configure GlassFish Server settings:
     - Server Domain: domain1
     - Username: admin
     - Password: (your GlassFish admin password)
   - In the `Deployment` tab:
     - Click `+` and select `Artifact`
     - Choose `samseng-webstore:war exploded`
     - Set Application Context to `/`

6. **Deploy the Application**
   - Click the green `Run` button in the top-right corner
   - Select your GlassFish configuration
   - Wait for the deployment to complete

7. **Build WAR File**
   - Go to `Build > Build Artifacts`
   - Select `samseng-webstore:war > Build`
   - The WAR file will be generated in `target/samseng-webstore.war`

8. **Insert Sample Data**
   - Run the SQL scripts in `src/main/resources/sql/dummy_data.sql`
   - This will populate the database with sample products, users, and categories

9. **Access the Application**
   - Open your browser and navigate to `http://localhost:8080`
   - Default admin credentials:
     - Username: admin@samseng.com
     - Password: admin123

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
   - Validity period management

### Technical Architecture

```
samseng-webstore/
│── src/main/
    ├── java/com.samseng.web/
    │   ├── controllers/        # Servlet controllers for HTTP request handling
    │   │   ├── product/       # Product-related controllers
    │   │   ├── user/          # User management controllers
    │   │   └── order/         # Order processing controllers
    │   ├── models/            # JPA entities
    │   │   ├── Product.java
    │   │   ├── User.java
    │   │   └── Order.java
    │   ├── repositories/      # Data access layer
    │   ├── services/          # Business logic
    │   └── utils/            # Helper classes
    ├── resources/
    │   ├── META-INF/         # JPA configuration
    │   └── sql/              # Database scripts
    └── webapp/
        ├── WEB-INF/          # Web configuration
        ├── admin/            # Admin interface
        ├── static/           # Static resources
        └── views/            # JSP templates
```

### Key Features
- Responsive design
- Secure authentication
- Product search and filtering
- Shopping cart management
- Order tracking
- Admin dashboard
- Image management
- Promo code system

## Contributing
Please read CONTRIBUTING.md for details on our code of conduct and the process for submitting pull requests.

## License
This project is licensed under the MIT License - see the LICENSE.md file for details