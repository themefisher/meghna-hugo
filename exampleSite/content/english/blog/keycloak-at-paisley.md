---
title: "Keycloak @Paisley"
date: 2020-05-22T13:23:10+01:00
image_webp: images/blog/blog-post-3.webp
image: images/blog/blog-post-3.jpg
author: Meysam Tamkin
description : "This is meta description"

---
# Keycloak @Paisley

## Overview

In this article, I’d like to introduce [Keycloak](https://www.keycloak.org/) as **a solution to manage authentication and authorization** that we used at Paisley. Although there are a few Identity and Access management systems I think highly of, but I’d pick Keycloak.
Keycloak is an open-source project developed and maintained by the **RedHat Community**.

> “Keycloak is an open-source Identity and Access Management solution
> aimed at modern applications and services. It makes it easy to secure
> applications and services with little to no code.”

Besides, it has many other attractive features, including User Federation, Identity Brokering and Social Login, and so on.Before doing setup Keycloak and Spring Boot, let's sum up what we have done so far.
First, I’m going to set Keycloak up with basic configuration and will talk about the main features of Keycloak.
Finally, I will configure and develop a secure Spring Boot application.

You can check out the full[ source code](https://github.com/Paisley-Digital/genesis) of the demo project we're going to build on GitHub.

***Let's get started!***

  

### Keycloak
 1. What is Keycloak?
	IAM or IdM(Identity Management) is a framework used to authenticate user identity and privileges. Keycloak is an identity and access management solution (IAM) for numerous applications and services, developed by RedHat, the world’s biggest Open Source software producer. The server comprises all important applications that an IAM solution needs to provide.
	
 2. Advantage of Keycloak

	- **Authorization & Authentication**
		 - Log in with one account to any of several related systems.
	- **Identity Brokering**
		- Intermediary service that connects multiple service providers with different identity providers via OpenID Connect or SAML 2.0 IdPs.
	- **LDAP & Active Directory**
		- Access to and query of servers and corporate data for authorized individuals.
	- **Security**
		- Completely isolated from applications and applications never see a user’s credentials.
	 - **Up-to-Date**
		 - Upgradable and regular releases and road map
	 - **Performance**
		 - Keycloak is a powerful solution for enterprise application
	 - **Active Community**
		 - Has a very active community.
	 - **Scalability**
		 - Can be adapted to your needs and there are some solutions to setup Keycloak cluster in various scenarios
	 - **Open Source**
		 - Apache License version 2.0: [Keycloak Source Code](https://github.com/keycloak/keycloak)

 3. Keycloak Setup Process

	> The installation process is based on its[ official manual](https://www.keycloak.org/docs/latest/getting_started/index.html).

	- [Download and unzip the installation file](https://downloads.jboss.org/keycloak/9.0.0/keycloak-9.0.0.zip)

	- Open `$keycloak_path/standalone/configuration/standalone.xml` with an editor:

		- Find public interface tag and replace 127.0.0.1 with 0.0.0.0 if you want it to bind to all network interfaces 
			```xml  
			<interface  name="public">  
			 <inet-address  value="${jboss.bind.address:0.0.0.0}"/>
			 </interface>
			 ```

	- Run `$keycloak_path/bin/standalone.sh` to start Keycloak server

	- Run `$keycloak_path/bin/jboss-cli.sh` and type `connect` in the opened cli to ensure that server is up and running, you can exit the cli afterward.

	-	Run`$keycloak_path/bin/add-user-keycloak.sh -r master -u admin -p admin` to add admin user to keycloak

	- Restart the server
**
**	- Go to[ https://SERVER_ADDRESS:8443/auth/admin/master/console/](https://paisley.digital:8443/auth/admin/master/console/)
		> You can set it up on a dev machine on AWS or GC
	- To add a Realm go to [https://SERVER_ADDRESS:8443/auth/admin/master/console/#/realms/master](https://paisley.digital:8443/auth/admin/master/console/) and add a realm, in our case we will add `paisley(your realm name)` realm for the development environment.

	- You can customize the created realm in the redirected page with options provided.

	    ![Add Realm](/images/blog/keycloak/add-realm.png#blogpost)

    - Create a client named `paisley-client(you can change to your name) `
    
        ![Create Client](/images/blog/keycloak/add-client.png#blogpost)

    - Go to the created client and change the access type to `confidential` and enable all those OAuth flows that are required for our scenarios just below the access type field.
        
        ![Create Client](/images/blog/keycloak/client-setting.png#blogpost)
            
    - Create a role in this case we created `CUSTOMER` role in `paisley-client` client.

        ![Create Client](/images/blog/keycloak/add-roles.png#blogpost)
            
   - Go to the client, choose `paisley-client,` and select the Mappers tab to create a mapper for Username according to the attached recorded scree.	
      - Enter `Username` in Name field
      - Choose `User Property` in Mapper Type field.
      - Enter `username` in Property field
      - Enter `user_name` in Token Claim Name

        ![Create Client](/images/blog/keycloak/mapper-client.png#blogpost)   

   - Create a user 
        
        ![Create Client](/images/blog/keycloak/add-user.png#blogpost)

   - Add a role to user
        
        ![Create Client](/images/blog/keycloak/user-role-mapping.png#blogpost)

   - Impersonate and set a password for user
        
        ![Create Client](/images/blog/keycloak/user-impersonate.png#blogpost)
        
        ![Create Client](/images/blog/keycloak/account-page.png#blogpost)

   - Get the client secret from client page/credentials tab
   
        ![Create Client](/images/blog/keycloak/client-credential.png#blogpost)  
     
   - Test getting a token from curl:
        ```shell script
        curl --location 
           --request POST 'https://your-host:8443/auth/realms/your-realm/protocol/openid-connect/token' 
           --header 'Content-Type: application/x-www-form-urlencoded'  
           --data-urlencode 'client_id=properties-client' 
           --data-urlencode 'grant_type=password' 
           --data-urlencode 'username=username' 
           --data-urlencode 'password=****' 
           --data-urlencode 'client_secret=******'
        ```
   - Output of above command should be similar to :
   
       ```json
      {
         "access_token":"eyJhbGciOiJSUzI1…...",
         "token_type":"bearer",
         "not-before-policy":0,
         "session_state":"6e0a4f56-871c-4f68-bdf0-3e16d5b6ad27",
          "scope":"email profile"
     }
        ```
    
        - The above token can be decoded on[ jwt.io](http://jwt.io/) website

   - Go to https://your-host:8443/auth/realms/your-realm/.well-known/openid-configuration to find the issuer URL. Issuer URL is https://your-hostl:8443/auth/realms/your-realm/.well-known/openid-configuration in this case, open it and copy public key, we need it for spring-boot configuration. Mind the format of public key string in application.yml, there are prefix and suffix stuff and a line break as \n which above string will be enclosed in between.
    