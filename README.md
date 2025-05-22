# Prsweb_Grails


PRSweb is a web-based application built using the Grails framework, designed to host and visualize polygenic risk score (PRS) results. It supports uploading summary statistics and metadata for various PRS models and enables user-friendly browsing and data exploration.

---

## 🛠 Technologies Used

- **Grails Framework** (version 3.x)
- **Groovy**
- **MySQL / H2** (depending on environment)
- **GORM**
- **Gradle**

---

## 📁 Project Structure


---

## 🚀 Deployment Instructions

### 🔧 Prerequisites

Ensure the following are installed:

- Java 8 or higher (check with `java -version`)
- Grails 3.x (install via SDKMAN or download from [grails.org](https://grails.org))
- MySQL (optional if using H2 for dev)
- Git

---

### 🧪 Local Development Setup


#### 1. Clone the Repository

git clone https://github.com/statgen/Prsweb_Grails.git
``cd Prsweb_Grails```



#### 2.** Configure the Application**
Edit the configuration in grails-app/conf/application.yml or grails-app/conf/application.groovy to set database credentials, e.g.:

```dataSource:
  driverClassName: com.mysql.cj.jdbc.Driver
  url: jdbc:mysql://localhost:3306/prswebdb
  username: root
  password: your_password```

  grails run-app
The application will be available at http://localhost:8080.

## Production Deployment (Manual)
#### 1. Create WAR

```grails war```

#### 2. Deploy the WAR on Tomcat or Jetty
Place the generated .war file in the webapps directory of your server.

#### 3. Configure Environment Variables
Use production profile in application.yml or environment-specific settings:


``environments:
  production:
    dataSource:
      url: jdbc:mysql://host:3306/prswebdb
      username: prod_user
      password: prod_pass```






