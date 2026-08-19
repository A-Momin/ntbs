<details><summary style="font-size:20px;color:Orange;text-align:left">Flask Interview Questions</summary>

1.  <b style="color:magenta">What is Flask?</b>

-   Flask is a micro web framework for Python that is lightweight and modular. It is designed to be easy to use and does not impose any specific project structure.

2.  <b style="color:magenta">Explain the key differences between Flask and Django.</b>

-   Flask is a micro-framework, providing flexibility and minimalistic features, while Django is a full-stack web framework with more built-in features and a specific project structure.

3.  <b style="color:magenta">How is routing done in Flask?</b>

-   Routing in Flask is done using the @app.route() decorator. It binds a function to a URL so that when that URL is accessed, the function is executed.

4.  <b style="color:magenta">What is Flask-WTF and how is it used for form handling?</b>

-   Flask-WTF is a Flask extension that integrates with the WTForms library. It simplifies form creation, validation, and rendering in Flask applications.

5.  <b style="color:magenta">Explain Flask templates.</b>

-   Flask templates are used for rendering dynamic content in HTML files. They use Jinja2 syntax and allow embedding Python-like expressions within curly braces {{ }}.

6.  <b style="color:magenta">What is the purpose of Flask's app.config?</b>

-   app.config in Flask is a configuration object that holds configuration variables. It allows for easy configuration management in a Flask application.

7.  <b style="color:magenta">How does Flask handle HTTP requests and responses?</b>

-   Flask uses the Werkzeug library to handle HTTP requests and responses. Request and response objects are provided to route functions, allowing for easy manipulation.

8.  <b style="color:magenta">Explain Flask Blueprints.</b>

-   Blueprints in Flask are a way to organize a group of related views and other code. They help in creating modular applications and can be registered with an application.

9.  <b style="color:magenta">What is Flask-SQLAlchemy?</b>

-   Flask-SQLAlchemy is a Flask extension that provides integration with the SQLAlchemy ORM. It simplifies database operations in Flask applications.

10. <b style="color:magenta">How does Flask handle static files?</b>

-   Flask serves static files from the static folder in the application directory. They can be linked in templates using the url_for('static', filename='filename') function.

11. <b style="color:magenta">What is Flask's context?</b>

-   Flask's context is a way to make certain variables globally accessible during a request. The g object and the context_processor decorator are commonly used for this purpose.

12. <b style="color:magenta">How can you enable debug mode in Flask?</b>

-   Debug mode in Flask can be enabled by setting the debug attribute of the app object to True. It provides additional error information and auto-reloads the server on code changes.

13. <b style="color:magenta">What is Flask's request object?</b>

-   Flask's request object contains information about the current HTTP request, including form data, query parameters, and headers. It is available within route functions.

14. <b style="color:magenta">Explain Flask's session management.</b>

-   Flask's session management allows storing user-specific information across requests. The session object is used to set and retrieve session variables.

15. <b style="color:magenta">How can you secure a Flask application against cross-site request forgery (CSRF) attacks?</b>

-   Flask-WTF provides CSRF protection. It generates and validates CSRF tokens in forms to prevent CSRF attacks.

16. <b style="color:magenta">What is Flask's before_request decorator used for?</b>

-   The before_request decorator in Flask allows you to register a function that will run before each request. It is commonly used for tasks like authentication.

17. <b style="color:magenta">Explain Flask's error handling mechanism.</b>

-   Flask provides the @app.errorhandler decorator to handle specific HTTP errors or exceptions. Custom error pages or responses can be defined using this decorator.

18. <b style="color:magenta">What is Flask's current_app object?</b>

-   The current_app object in Flask provides access to the application instance within a request. It can be used to access configuration values and other application-level features.

19. <b style="color:magenta">What is Flask's url_for function used for?</b>

-   The url_for function generates a URL for a given view function. It allows for creating URLs dynamically, avoiding hardcoding in templates.

20. <b style="color:magenta">Explain Flask's after_request decorator.</b>

-   The after_request decorator in Flask allows you to register a function that will run after each request. It can be used for tasks like modifying the response.

21. <b style="color:magenta">How can you handle file uploads in Flask?</b>

-   File uploads in Flask can be handled using the request.files object. The secure_filename function from the Werkzeug library helps in securing filenames.

22. <b style="color:magenta">What is Flask-Migrate?</b>

-   Flask-Migrate is a Flask extension that provides integration with the Alembic database migration tool. It simplifies the process of managing database migrations in Flask applications.

23. <b style="color:magenta">Explain Flask's context_processor decorator.</b>

-   The context_processor decorator in Flask allows you to inject variables into the template context. These variables will be available in all templates.

24. <b style="color:magenta">How does Flask support JSON responses?</b>

-   Flask provides the jsonify function to create JSON responses. Additionally, the json module can be used to serialize Python objects to JSON format.

25. <b style="color:magenta">What is Flask-RESTful?</b>

-   Flask-RESTful is an extension for Flask that simplifies the creation of RESTful APIs. It provides features like resource classes, request parsing, and output formatting.

26. <b style="color:magenta">How does Flask handle environment configurations?</b>

-   Flask allows configuration through environment variables. The app.config.from_envvar method can be used to load configuration from a specified environment variable.

27. <b style="color:magenta">What is Flask's teardown_request decorator used for?</b>

-   The teardown_request decorator in Flask allows you to register a function that will be called after each request, regardless of success or failure. It is commonly used for cleanup tasks.

28. <b style="color:magenta">How can you use Flask to set up a RESTful API?</b>

-   Flask, combined with Flask-RESTful, allows you to define resource classes and easily create RESTful APIs. Endpoints can be mapped to HTTP methods for CRUD operations.

29. <b style="color:magenta">Explain the purpose of Flask's app.route and app.add_url_rule methods.</b>

-   Both methods are used to bind a URL to a view function. app.route is a decorator, while app.add_url_rule is an alternative method for defining routes.

30. <b style="color:magenta">How does Flask support testing?</b>

-   Flask provides a testing framework that allows you to create test cases for your application. The test_client and test_request_context objects assist in simulating HTTP requests and testing views.

</details>
