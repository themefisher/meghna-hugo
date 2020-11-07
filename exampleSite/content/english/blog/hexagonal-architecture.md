---
title: "Hexagonal Architecture @Paisley"
date: 2020-11-05T19:23:10+01:00
image_webp: /images/blog/keycloak/ports-and-adapters.webp
image: /images/blog/architecture/ports-and-adapters.png
author: Meysam Tamkin
description : "In this post, we'll explain about Hexagonal Architecture with an example."

---
# Hexagonal Architecture 

### Overview

Hexagonal Architecture or Port and Adapters Architecture is a pattern for use in software design. Also, the best advantage obtained from it is decoupling within the core domain logic and other dependencies.
In this post, we'll implement a Spring Boot app using Hexagonal Architecture. This example contains the simple Author and Book model. 
Also, you can find the full example here: [link](https://github.com/Paisley-Digital/hexagonal-architecture)


### **1.Prerequisites**

If you want to build this Demo app on your site you will need these materials:
*   JDK 8 or JDK 11+
*   an IDE
*   Maven
*   Spring Boot 2+

### **2. Application Core**

The critical role of the Application Core is serving Business Logic. It includes business functions and domains.
Moreover, the core can interact with other outside parties like persistence entities. Additionally, it performs operations on the received data.

#### **2.1 Domain**

The primary role of the Core is to administer the code that implements and touches business logic.
To take the first step, let's start with the Domain layer.
Firstly, we'll create a simple Author entity:
```java
 public class Author {
     public String name;
     // standard setters and getters
 }
```

Next, we'll implement the Book entity:
```java
public class Book {
    public String name;
    public List authors;
    // standard setters and getters
 }
```
#### **2.2 Ports**

In this section, we'll implement some ports to achieve our Business logic that interacts with the outside.
First, we'll create an incoming port. External components use this.
Let's create the BookAuthoeService:

```java
public interface BookAuthorService {
    void addBook(BookDto bookDto);
    List getAllBook();
    void addAuthor(AuthorDto authorDto);
    List getAllAuthor();
}
```

Besides, we also need an interface to act as an outgoing port to interact with the database.
Let's create BookAuthorPersistencePort:

```java
public interface BookAuthorPersistencePort {
    void addBook(BookDto bookDto);
    List getAllBook();
    void addAuthor(AuthorDto authorDto);
    List getAllAuthor();
}
```

#### **2.3 Service** 
To wire all pieces together and drive the execution, we need a service. Also, it implements the incoming port and interacts with the database by injected the outcoming port.
Let's create DTOs to interact service with the outside of the Core:

```java
public class AuthorDto {
    public String name;
    // standard setters and getters
}
public class BookDto {
    public String name;
    public List authors;
    // standard setters and getters
}
```
Moreover, we'll create BookAuthorService:

```java
@Service
public class BookAuthorServiceImpl implements BookAuthorService {
    private BookAuthorPersistencePort bookAuthorPersistencePort;
    public BookAuthorServiceImpl(BookAuthorPersistencePort bookAuthorPersistencePort) {
        this.bookAuthorPersistencePort = bookAuthorPersistencePort;
    }
    @Override
    public void addBook(BookDto bookDto) {
        bookAuthorPersistencePort.addBook(bookDto);
    }
    @Override
    public List getAllBook() {
        return bookAuthorPersistencePort.getAllBook();
    }
    @Override
    public void addAuthor(AuthorDto authorDto) {
        bookAuthorPersistencePort.addAuthor(authorDto);
    }
    @Override
    public List getAllAuthor() {
        return bookAuthorPersistencePort.getAllAuthor();
    }
}
```
### **3. Adapters**
Typically, Ports are interfaces to be spent by external parties. Consequently, Adapters are implementations of ports.

#### **3.1 Primary Adapters** 
In this part, we'll perform a typical REST Controller as the primary adapter to allow the user to talk with our Core:

```java
@RestController
public class ApiController {
    private final BookAuthorService bookAuthorService;
    public ApiController(BookAuthorService bookAuthorService) {
        this.bookAuthorService = bookAuthorService;
    }
    @GetMapping(value = "/books", produces = { "application/json" })
    public ResponseEntity<?> getBooks() {
        return new ResponseEntity<>(bookAuthorService.getAllBook(), HttpStatus.OK);
    }
    @PostMapping(value = "/books", produces = { "application/json" })
    public ResponseEntity<?> addBook(BookDto bookDto) {
        bookAuthorService.addBook(bookDto);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }
    @GetMapping(value = "/authors", produces = { "application/json" })
    public ResponseEntity<?> getAuthors() {
        return new ResponseEntity<>(bookAuthorService.getAllAuthor(), HttpStatus.OK);
    }
    @PostMapping(value = "/authors", produces = { "application/json" })
    public ResponseEntity<?> addAuthor(AuthorDto authorDto) {
        bookAuthorService.addAuthor(authorDto);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }
}
```
The REST Controller can drive the application. In other words, it's a request's gate to get through the application.

#### **3.2 Secondary Adapters** 
Typically, Secondary Adapters used by external entities. Therefore, we'll implement BookAuthorAdapter as a Secondary Adapter:

```java
@Service
public class BookAuthorAdapter implements BookAuthorPersistencePort {
    final private BookRepository bookRepository;
    final private AuthorRepository authorRepository;
    public BookAuthorAdapter(BookRepository bookRepository, AuthorRepository authorRepository) {
        this.bookRepository = bookRepository;
        this.authorRepository = authorRepository;
    }
    @Override
    public void addBook(BookDto bookDto) {
        Book book = mapBookDtoToBook(bookDto);
        bookRepository.save(book);
    }
    @Override
    public List getAllBook() {
        return bookRepository.findAll()
            .stream()
            .map(this::mapBookToBookDto)
            .collect(Collectors.toList());
    }
    @Override
    public void addAuthor(AuthorDto authorDto) {
        Author author = mapAuthorDtoToAuthor(authorDto);
        authorRepository.save(author);
    }
    @Override
    public List getAllAuthor() {
        return authorRepository.findAll()
            .stream()
            .map(this::mapAuthorToAuthorDto)
            .collect(Collectors.toList());
    }
    private BookDto mapBookToBookDto(Book book) {
        return BookDto.builder()
            .name(book.name)
            .authors(book.authors.stream()
                .map(this::mapAuthorToAuthorDto)
                .collect(Collectors.toList()))
            .build();
    }
    private Book mapBookDtoToBook(BookDto bookDto) {
        return Book.builder()
            .name(bookDto.name)
            .authors(bookDto.authors.stream()
                .map(this::mapAuthorDtoToAuthor)
                .collect(Collectors.toList()))
            .build();
    }
    private AuthorDto mapAuthorToAuthorDto(Author author) {
        return AuthorDto.builder()
            .name(author.name)
            .build();
    }
    private Author mapAuthorDtoToAuthor(AuthorDto authorDto) {
        return Author.builder()
            .name(authorDto.name)
            .build();
    }
}
```

Finally, we'll create contact between database and application.
Next, let's implement AuthorRepository and BookRepository that connected to MongoDB through Spring Data:

```java
public interface AuthorRepository extends MongoRepository<Author, Long> {
}
public interface BookRepository extends MongoRepository<Book, Long> {
}
```

### **Conclusion**

In this post, we've performed a quick and practical application based on Hexagonal Architecture.
Firstly, we started with the core principles. After that, we created some ports to make a connection between the external component and Core.
Next, we created a Primary Adapter with Spring Boot REST Controller. Finally, we made a Secondary Adapter using MongoDB and Spring Data.
