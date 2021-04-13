---
title: "Integrate Spring Boot application with Keycloak  @Paisley"
date: 2020-05-23T19:23:10+01:00
image_webp: /images/blog/keycloak/spring-keycloak.webp
image: /images/blog/keycloak/spring-keycloak.png
author: Meysam Tamkin
description : "I'd like to explain how to use Keycloak to secure Your Rest API in Spring Boot, Spring Security."

---
# Integrate Spring Boot application with Keycloak 

### Set up a Spring Boot application 

In previous article, we have explored some cool Keycloak features have it up and running.

In this article, we’re going to cover the basics of integrating the Keycloak server and how to **connect and secure a Spring Boot application** with it.

To begin with, I'd like to explain how to use Keycloak **to secure Your Rest API in Spring Boot integrated with Spring Security**.

In this section, we will explain how to:

*   Set up a Spring Boot application for Keycloak;
*   Configure the Keycloak integration with Spring Boot
*   Define the application resources;
*   Add access policies based on user roles.

### **1.Prerequisites**

If you want to build this Demo app on your site you will need these materials:
*   JDK 8 or JDK 11+
*   an IDE
*   Maven
*   Spring Boot 2+
*   Keycloak 7+


### **2. Security Library**

Although there are numerous ways of integrating Keycloak on your app, I’d select one, which is independent of the Keycloak library.

For this reason, we should create some classes to integrate and extract the token from Keycloak.

Here is the Github [link](https://github.com/Paisley-Digital/cross-cutting) for the integrating OAuth protocol to fill roles and other necessary fields into the Spring Security Context.

   * clone the project

```shell script
 git clone https://github.com/Paisley-Digital/cross-cutting.git
```


> This is a separate project that you can add as a maven dependency on your main project. Otherwise you can copy and paste security classes on your app and just use it.


*   [SecurityProperties.java](https://github.com/Paisley-Digital/cross-cutting/blob/master/src/main/java/digital/paisley/security/SecurityProperties.java) and [ResourceServerConfiguration.java](https://github.com/Paisley-Digital/cross-cutting/blob/master/src/main/java/digital/paisley/security/ResourceServerConfiguration.java):
    *   To load a set of related properties from a YAML file, we created this bean. (Like API matcher)
    *   To configure the required CORS configuration and enable or disable the security of the application.
*   [SecurityContextUtils.java](https://github.com/Paisley-Digital/cross-cutting/blob/master/src/main/java/digital/paisley/security/SecurityContextUtils.java) :
    *   The  *SecurityContext* and  *SecurityContextHolder* are two fundamental classes of Spring Security. The `SecurityContext` is used to store the details of the currently authenticated user, also known as a principle. So, if you have to get the username or any other user details, you need to get this `SecurityContext` first. The `SecurityContextHolder` is a helper class, which provides access to the security context. This class is a wrapper to store Username and roles.
*   [OAuth2RestTemplateConfigurer.java](https://github.com/Paisley-Digital/cross-cutting/blob/master/src/main/java/digital/paisley/security/OAuth2RestTemplateConfigurer.java)
    *   For secured microservice to microservice call
*   [JwtAccessTokenCustomizer.java](https://github.com/Paisley-Digital/cross-cutting/blob/master/src/main/java/digital/paisley/security/JwtAccessTokenCustomizer.java)
    *   This class implements` JwtAccessTokenConverterConfigurer` to have OAuth2.0 features(extract token) for Spring boot microservices.
    *   This class assumes, that you have defined a Protocol Mapper in Keycloak to map user property 'username' to a claim named 'user_name' in the access token


### **3. Secure Spring Boot rest API**

*   Setup maven 

    These dependencies are necessary to add to your pom file. Also, you can add other dependencies that you need.

    *   `Spring-boot-starter-web`
    *   `Spring-boot-starter-oauth2-client`
        *   By adding that, it will secure your app with OAuth 2.0 by default.
    *   `Spring-boot-starter-oauth2-resource-server`
        *   This gives us all of the sensible defaults and auto-configuration of other starters.
    *   `Spring-boot-starter-security` 
        *   For using Spring Security.
        
*   Configure Keycloak In [application.yml](https://github.com/Paisley-Digital/embryo/blob/master/src/main/resources/application.yml)
    *   `rest.security.enabled`
        *   We can disable/enable security on spring boot
    *   `rest.security.api-matcher `
        *   Uses a regular expression to parsing URI template patterns.
    *   `rest.security.cors.*`
        *   Handle CORS configuration options.
    *   `rest.security.issuer-uri `
        *   This is a URI of the Issuer Identifier.
    *   `security.oauth.resource.* `
        *   You can fill all properties that relevant to oauth.resouce from this [URL](https://paisley.digital:8443/auth/realms/paisley/.well-known/openid-configuration) 
        *   You can use your domain and realm name instead of Paisley.

            ![App Properties](/images/blog/keycloak/application-yml.png#blogpost)


*  Application Logic

    We want to implement a controller and use `PreAuthorize` annotation for protecting our resources. The <code>PreAuthorize<strong> </strong></code>checks the given expression before invoking the method.

      ![Preauthorize Annotation](/images/blog/keycloak/preauthorize.png#blogpost)

    You can find this code [here](https://github.com/Paisley-Digital/embryo/blob/master/src/main/java/digital/paisley/embryo/controllers/ApiController.java).


### **4. Conclusion**

   In this post series, we have developed a Spring Boot application and secured it with Keycloak and Spring Security.  
   We have built classes to integrate Spring Security and OAuth without using the Keycloak library. 
   If you want to replace Keycloak with other OAuth implementation, you only need to modify application.yml on Spring Boot.
