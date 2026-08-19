<h1 style="text-align:center"> <a href="https://docs.djangoproject.com/en/5.0/contents/">Django documentation contents</a> </h1>

-   How do I check Django installation: `$ django-admin --version`

-   Useful Django Extentions as a Tools: `django-extentions`

-   [settings.py](https://docs.djangoproject.com/en/4.0/ref/settings/)
-   [Logging](https://docs.djangoproject.com/en/4.2/topics/logging/)
-   [Doc: django-admin and manage.py](https://docs.djangoproject.com/en/4.1/ref/django-admin/#django-admin-and-manage-py)
-   [Validators](https://docs.djangoproject.com/en/4.1/ref/validators/)

-   **ChatGPT**:

    -   demo audit trails that log and monitor user activities with Django project


---

-   <details><summary style="font-size:25px;color:Orange">MVC vs MVT in context of Django Framework</summary>

    ![Django Architecture](/assets/django/django_model_view_template.png)

    The MVC and MVT pattern promotes separation of concerns, making it easier to manage and maintain complex software systems. It allows for modular development, where changes to one component have minimal impact on others. These pattarns are widely used in web development frameworks like Ruby on Rails, Django, and Spring MVC, as well as in desktop and mobile application development.
    In the context of the Django framework, the concepts of MVC (Model-View-Controller) and MVT (Model-View-Template) are often discussed. While they share similarities, there are also key differences in how they are implemented in Django.

    -   **MVC (Model-View-Controller)**: MVC stands for Model-View-Controller, a software architectural pattern commonly used for developing user interfaces. It divides an application into three interconnected components:

        -   `Model`: Represents the data and business logic of the application. It encapsulates the data structure and behavior, including data validation, manipulation, and storage. The model notifies the view of changes in the data so that the view can update accordingly. In essence, the model represents the application's state.

        -   `View`: Represents the presentation layer of the application. It displays the data from the model to the user and handles user input. Views are responsible for rendering the user interface and presenting information to the user in a readable format. In a web application, views often consist of HTML templates combined with dynamic content.

        -   `Controller`: Acts as an intermediary between the model and the view. It receives user input, processes it, and updates the model accordingly. Controllers handle user interactions and application logic, orchestrating communication between the model and the view. They interpret user actions (such as button clicks or form submissions) and determine how the application should respond.

    -   **MVT (Model-View-Template)**: MVT in Django is a design pattern that is a variation of the traditional Model-View-Controller (MVC) architecture pattern, tailored to suit Django's design philosophy. It divides an application into three interconnected components: **models**, **views**, and **templates**. This separation of concerns allows for easier maintenance, scalability, and code organization in Django projects.

        -   `Model`: Similar to MVC, the model represents the application's data and business logic. It defines the structure of database tables, manages data access and manipulation, and performs validation and business rules.

        -   `View`: In Django's MVT architecture, views are responsible for processing HTTP requests and returning HTTP responses. Unlike traditional MVC views, Django views encapsulate both the logic for handling requests and the logic for rendering HTML responses. Views interact with models to retrieve or update data and use templates to generate HTML output.

        -   `Template`: Templates in Django are responsible for defining the presentation layer of the application. They use Django's template language to generate dynamic HTML content based on data provided by the view. Templates separate the design and content of web pages from the Python code, allowing for a clean separation of concerns.

    -   **Key Differences**:

        -   `Controller vs. View`: In MVC, the controller mediates between the model and view, handling user input and selecting the appropriate view. In MVT, the view performs similar tasks but is also responsible for rendering HTML responses, which is typically the responsibility of templates in MVC.

        -   `Template vs. View`: Django's MVT separates the presentation layer into templates and views, with templates responsible for generating HTML output and views responsible for processing requests and providing data to templates. This differs from MVC, where views primarily handle user interactions and delegate rendering to templates.

        -   `Separation of Concerns`: Both MVC and MVT aim to separate concerns within an application, but they achieve this in slightly different ways. MVC emphasizes a clear separation between models, views, and controllers, while MVT focuses on separating request handling (views) from presentation (templates) and data access (models).

    In summary, while Django's MVT architecture shares similarities with MVC, it introduces some differences in how views and templates are structured and their respective responsibilities within the framework. Understanding these differences is crucial for effective development with Django.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Django Architecture, Terms & Concepts</summary>

    Django is a high-level web framework written in Python that encourages rapid development and clean, pragmatic design. Its architecture follows the Model-View-Template (MVT) architectural pattern, which is a slight variation of Model-View-Controller (MVC). The key components of Django's architecture include models, views, templates, and the framework itself. Key Components of Django Architecture:

    -   **Models**: A "model" refers to the component responsible for defining the structure and behavior of the application's data. Models represent the data stored in a relational database and encapsulate the logic for interacting with that data. They provide an abstraction layer that simplifies database operations and allows developers to work with data using high-level Python objects. Here are some key points about models in Django:

        -   `Data Structure Definition`: Models define the structure of the data stored in the database. Each model class represents a database table, and each attribute of the class corresponds to a field in the table. Django provides a wide range of field types (e.g., CharField, IntegerField, DateField) to define different types of data.

        -   `Object-Relational Mapping (ORM)`: Django's ORM (Object-Relational Mapper) allows developers to interact with the database using Python objects instead of raw SQL queries. Models provide methods and attributes for performing common database operations such as creating, retrieving, updating, and deleting records.

        -   `Business Logic`: Models encapsulate the business logic related to data manipulation and validation. Developers can define custom methods and properties within model classes to implement application-specific behavior, such as calculating derived values or performing data validation.

        -   `Relationships`: Models can define relationships between different types of data using ForeignKey, OneToOneField, and ManyToManyField fields. These relationships enable developers to establish connections between related records in the database and perform queries that span multiple tables.

        -   `Administration Interface`: Django's admin interface automatically generates a web-based administration interface based on the model definitions. This interface allows administrators to view, create, update, and delete records in the database without writing custom code.

        -   `Example`:

            ```python
            from django.db import models

            class Product(models.Model):
            name = models.CharField(max_length=255)
            price = models.DecimalField(max_digits=10, decimal_places=2)
            ```

    -   **Views**: A "view" refers to the component responsible for processing user requests and returning HTTP responses. Views contain the logic that retrieves data from the database, processes it, and then renders it into a format suitable for presentation to the user. Views in Django can be implemented as functions or as class-based views. Here are some key points about views in Django:

        -   `Processing User Requests`: Views are responsible for handling incoming HTTP requests from clients. They receive request data such as URL parameters, form submissions, and other relevant information.

        -   `Accessing Data`: Views interact with the application's models (database tables) to retrieve, update, or delete data as needed. They may use Django's ORM (Object-Relational Mapper) to perform database queries and manipulate data.

        -   `Business Logic`: Views contain the business logic of the application. They process the data retrieved from the models, perform any necessary calculations or transformations, and prepare the data to be presented to the user.

        -   `Rendering Responses`: Once the data has been processed, views are responsible for rendering the appropriate response. This may involve rendering HTML templates, generating JSON or XML responses for API endpoints, or redirecting the user to another URL.

        -   `URL Mapping`: Views are mapped to specific URLs in the Django project's URL configuration. The URL dispatcher determines which view function or class-based view should handle each incoming request based on the requested URL pattern.

        -   `Example`:

            ```python
            from django.shortcuts import render
            from .models import Product

            def product_list(request):
            products = Product.objects.all()
            return render(request, 'products/product_list.html', {'products': products})
            ```

    -   **Templates**: A "template" refers to a text-based file that contains the structure and layout of a web page or email message. Templates use a markup language, typically Django's template language, to define the presentation layer of an application. Templates allow developers to separate the design and content of a web page from the underlying Python code that generates dynamic content. Here are some key points about templates in Django:

        -   `Presentation Layer`: Templates are used to define the visual elements of a web page, such as HTML markup, CSS styles, and JavaScript code. They specify how dynamic data should be inserted into the page and how the page should be rendered for the end user.

        -   `Template Inheritance`: Django templates support inheritance, allowing developers to create a hierarchy of templates to reuse common elements across multiple pages. A base template can define the overall layout and structure of the site, while child templates can extend the base template and override specific blocks or sections as needed.

        -   `Context Variables`: Templates can access data passed to them from views using context variables. Context variables contain dynamic data retrieved from the database or calculated by the view function and are used to populate placeholders within the template.

        -   `Template Tags and Filters`: Django's template language provides built-in tags and filters for performing common operations within templates. Tags are used to control the flow of template rendering, iterate over lists, and include other templates. Filters modify the output of variables or perform text manipulation tasks.

        -   `Integration with Views`: Templates are typically rendered by view functions, which retrieve data from the database or other sources and pass it to the template for rendering. Django's rendering engine combines the template with the provided context data to generate the final HTML output sent to the client's browser. - `Example`:

    -   **URL Dispatcher**: The URL dispatcher is a key component responsible for mapping URLs to views within a Django project. It acts as a router that directs incoming HTTP requests to the appropriate view function based on the requested URL pattern. The URL dispatcher is defined in the urls.py module of each Django application and helps maintain a clean and organized URL structure for the web application. Here's how the URL dispatcher works in Django:

        -   `URL Patterns`: In Django, URL patterns are defined using Python regular expressions or simple string patterns. These patterns specify the URL paths that the application should respond to and the corresponding view functions that should handle the requests.

        -   `URL Configuration`: Each Django project typically has a central urls.py module that serves as the main entry point for defining URL patterns. This module includes a list of URL patterns along with their corresponding view functions or controller methods.

        -   `URL Patterns Mapping`: When an HTTP request is received by the Django server, the URL dispatcher examines the requested URL path and compares it against the list of URL patterns defined in the urls.py module. It then selects the first matching pattern and extracts any captured parameters from the URL.

        -   `View Function Invocation`: Once a matching URL pattern is found, the URL dispatcher invokes the associated view function or method, passing any captured parameters as arguments. The view function is responsible for processing the request, fetching data from the database or other sources, and generating an appropriate HTTP response.

        -   `Namespaces and App-Specific URLs`: Django allows developers to organize URL patterns using namespaces and include URLs from multiple applications into a single project. This helps maintain a modular and reusable URL structure, especially in large projects with multiple Django apps. - `Example`:

        ```python
        from django.urls import path
        from .views import product_list

        urlpatterns = [
        path('products/', product_list, name='product_list'),
        ]
        ```

    -   **Django Framework**:

        -   `Purpose`: The Django framework provides a set of tools, utilities, and conventions that streamline web development. It includes components for handling requests and responses, middleware for extending the functionality, authentication, form handling, and more.
        -   `Implementation`: Django itself is a Python package that you install and configure. It includes a development server for testing, an ORM for database interactions, a templating engine, and various modules for common web development tasks.

    -   **Middleware**:

        -   `Description`: Middleware is a way to process requests globally before they reach the views or after the response is returned. It allows you to perform actions such as authentication, security checks, and content processing.
        -   `Implementation`: Middleware components are configured in the MIDDLEWARE setting of the Django project. Django comes with built-in middleware, and you can also write custom middleware.

    -   **Settings:**

        -   `Description`: The settings file contains configuration settings for the Django project. It includes database configuration, middleware settings, template settings, and more.
        -   `Implementation`: The settings.py file in the project's main directory contains various configurations. Developers can modify this file to customize the behavior of the Django project.

    -   **Request-Response Cycle**:

        -   A user makes an HTTP request, which is processed by Django's URL dispatcher.
        -   The URL dispatcher maps the requested URL to the corresponding view function.
        -   The view function processes the request, interacts with models if needed, and prepares data for rendering.
        -   The view renders the data using a template, creating an HTML response.
        -   The HTML response is sent back to the user's browser, displaying the requested content.

    #### Other Terms & Concepts

    -   `Admin site`: The Django admin site is a built-in application that provides an interface for managing data in the database. It allows authorized users to create, read, update, and delete records in the database.

        -   Django comes with a built-in admin interface for managing models and data.
        -   Admin views are generated based on the model definitions.

    -   `Migration`: A migration is a way to update the database schema to match changes to the models. Migrations are created automatically by Django when changes are made to the models.

        -   Django migrations are a set of changes to your database schema. They allow you to evolve your database schema over time while preserving existing data. Here are key points about Django migrations:

        -   `Initialization`:
            -   Migrations are used to initialize a new database, update the schema, and handle changes to the models.
            -   The makemigrations command is used to create new migrations based on changes in models.
        -   `Models as Source of Truth`:
            -   Django follows the "models as a source of truth" approach. The database schema is derived from the models defined in your Django application.
        -   `Migration Files`:
            -   Migration files are Python scripts generated by the makemigrations command.
            -   They reside in the migrations directory of each Django app and represent changes to the database schema.
        -   `migrate Command`:
            -   The migrate command is used to apply migrations and update the database schema.
            -   It reads migration files, executes the changes, and maintains a record of which migrations have been applied.
        -   `Rollback`:
            -   Migrations support rollback. You can reverse a migration using the migrate command, undoing the changes made by a specific migration.
        -   `Database State Tracking`:
            -   Django maintains a special table (django_migrations) in the database to track which migrations have been applied.
        -   `Custom Migrations`:
            -   You can create custom migrations for specific operations or data migrations beyond what Django automatically generates.
        -   `Atomic Operations`:
            -   Migrations are designed to be atomic; either all the changes in a migration are applied, or none of them are.
        -   `Dependencies`:
            -   Migrations can have dependencies on other migrations, ensuring that they are applied in the correct order.
        -   `Schema and Data Changes`:
            -   Migrations handle both schema changes (e.g., adding or altering tables) and data migrations (e.g., transforming existing data during a schema change).

    -   `QuerySet`: A QuerySet is a collection of database objects that can be filtered, sorted, and manipulated. QuerySets are created by calling a method on a model manager.

        -   A Django QuerySet is a representation of a database query. It allows you to interact with your database and retrieve, filter, or manipulate data. Here are key points about Django QuerySets:

        -   `Lazy Evaluation`:

            -   QuerySets are lazy, meaning they are not evaluated until they are explicitly requested.
            -   Operations on a QuerySet, such as filtering or ordering, do not immediately hit the database; they are stored as part of the QuerySet.

        -   `Chaining Methods`:

            -   QuerySets support method chaining, allowing you to combine multiple operations into a single query.
            -   Each method returns a new QuerySet, which can be further refined.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Django Utilities & Managements</summary>

    -   Django Managements or Management Commands refers to a set of commands and utilities provided by the Django framework for performing various administrative tasks, such as creating database tables, running development servers, managing migrations, and more. These management commands are primarily accessed through the command-line interface (CLI) using the `manage.py` script located in your Django project's root directory. Here are some key aspects of Django management:

    -   [**django-admin & manage.py**](https://docs.djangoproject.com/en/5.0/ref/django-admin/#django-admin-and-manage-py)

        -   **django-admin**: `django-admin` is Django’s command-line utility for administrative tasks. Think of it as the **master controller** that exists outside of any specific project. It’s what you use to jumpstart the development process before your project even exists.

        -   **manage.py**:

            -   The `manage.py` script is a thin wrapper around the `django-admin` utility and created automatically in each Django project. It does the same thing as `django-admin` but also sets the `DJANGO_SETTINGS_MODULE` environment variable so that it points to your project’s `settings.py` file. Generally, when working on a single Django project, it’s easier to use `manage.py` than `django-admin`. If you need to switch between multiple Django settings files, use `django-admin` with `DJANGO_SETTINGS_MODULE` or the `--settings` command line option.
            -   It resides in the root directory of your Django project and is automatically generated when you create a new project using the `django-admin startproject` command.

    -   **Custom Management Commands**:

        -   Django allows you to define custom management commands to automate tasks specific to your project or app.
        -   Custom commands are defined as Python functions within a module inside the `management/commands` directory of your app.
        -   Each command function must accept `self` as its first argument and can define additional options and arguments using `add_arguments()`.
        -   Example:

        ```python
        from django.contrib.auth.models import User
        from django.core.management.base import BaseCommand
        from django.utils.crypto import get_random_string


        class Command(BaseCommand):
            """
            Examples: How to invoke the comands
                1.  $ python manage.py create_users 5
                2.  $ python manage.py create_users 5 -p manager --superuser
            """
            help = 'Generate random users'

            def add_arguments(self, parser):
                parser.add_argument('count', type=int, help='Indicates the number of users to be created')

                # Optional argument
                parser.add_argument('-p', '--prefix', type=str, help='Define a username prefix')
                parser.add_argument('-s', '--superuser', action='store_true', help='Create a superuser account')

            def handle(self, *args, **kwargs):
                count = kwargs['count']
                prefix = kwargs['prefix']
                superuser = kwargs['superuser']

                for i in range(count):
                    if prefix:
                        username = f'{prefix}_{get_random_string()}'
                    else:
                        username = get_random_string()

                    if superuser:
                        User.objects.create_superuser(username=username, email='hello@hi.com', password='123')
                    else:
                        User.objects.create_user(username=username, email='hello@hi.com', password='123')
        ```

        ```txt
        demo_app/
            __init__.py
            ...
            management/
                __init__.py
                commands/
                    __init__.py
                    hello.py
        ```

    -   **Running Management Commands Programmatically**:

        -   You can also run management commands programmatically from within your Django code using the `call_command()` function provided in Django's `django.core.management` module.
            ```python
            from django.core.management import call_command
            call_command("loaddata", "db_user_fixture.json")
            ```
        -   This allows you to integrate management commands into your application logic or scripts.


        > **Pro Tip:** You can always run `$ python manage.py help` to see all available commands (including those added by third-party apps) or `$ python manage.py help <command>` for detailed documentation on a specific utility.


        -   **Project & App Management**:

            -   `$ python manage.py startproject` -> Create a new Django project directory structure.
            -   `$ python manage.py startapp` -> Create a new Django application directory structure within the project.
            -   `$ python manage.py check` -> Inspect the entire project for common configuration and logic errors.
            -   `$ python manage.py diffsettings` -> Compare the current project settings against Django's default settings.

        -   **Database & Migrations**:

            -   `$ python manage.py makemigrations` -> Create new migration files based on changes detected in your models.
            -   `$ python manage.py migrate` -> Synchronize the database schema with your current models and migrations.
            -   `$ python manage.py showmigrations` -> List all migrations in the project and their current application status.
            -   `$ python manage.py sqlmigrate` -> Display the raw SQL statements that will be executed for a specific migration.
            -   `$ python manage.py squashmigrations` -> Consolidate a range of existing migrations into a single new migration.
            -   `$ python manage.py inspectdb` -> Introspect existing database tables and output a Django model module.
            -   `$ python manage.py sqlflush` -> Print the SQL statements required to return all tables to their initial state.
            -   `$ python manage.py sqlsequencereset` -> Print the SQL statements for resetting sequences for an app's tables.

        -   **Authentication & Authorization**:

            -   `$ python manage.py createsuperuser` -> Create a user account with administrative (superuser) permissions.
            -   `$ python manage.py changepassword` -> Change the password for a specific user account via the terminal.

        -   **Development & Shell**:

            -   `$ python manage.py runserver` -> Start a lightweight, auto-reloading development web server.
            -   `$ python manage.py runscript <script_name>` -> 
            -   `$ python manage.py shell` -> Open an interactive Python interpreter with the Django environment pre-loaded.
            -   `$ python manage.py dbshell` -> Launch the command-line client for your project's configured database engine.

        -   **Maintenance & Data Handling**:

            -   `$ python manage.py dumpdata` -> Export the contents of the database into a JSON, XML, or YAML fixture file.
            -   `$ python manage.py loaddata` -> Import data from a fixture file into your project's database.
            -   `$ python manage.py flush` -> Remove all data from the database while keeping the table structure intact.
            -   `$ python manage.py clearsessions` -> Clean up expired sessions from the database session table.
            -   `$ python manage.py remove_stale_contenttypes` -> Delete content types in the database that no longer have corresponding models.
            -   `$ python manage.py sendtestemail` -> Send a test email to verify the project's email configuration.
            -   `$ python manage.py createcachetable` -> Create the database table required for the database caching backend.

        -   **Static Files & Testing**:

            -   `$ python manage.py collectstatic` -> Gathers all static files from your apps into the directory specified by `STATIC_ROOT`.
            -   `$ python manage.py findstatic` -> Search for the absolute path(s) of one or more static files.
            -   `$ python manage.py test` -> Run the test suite for all installed applications in the project.
            -   `$ python manage.py testserver` -> Run a development server using data from the specified fixture(s).

        -   **Internationalization (i18n)**:

            -   `$ python manage.py makemessages` -> Scan the source tree for translatable strings and update the message files.
            -   `$ python manage.py compilemessages` -> Compile `.po` message files into `.mo` files for use by the translation engine.

        -   **django-admin Commands**
            -   `$ django-admin -h`
            -   `$ django-admin check`
            -   `$ django-admin compilemessages`
            -   `$ django-admin createcachetable`
            -   `$ django-admin dbshell`
            -   `$ django-admin diffsettings`
            -   `$ django-admin dumpdata`
            -   `$ django-admin flush`
            -   `$ django-admin inspectdb`
            -   `$ django-admin loaddata`
            -   `$ django-admin makemessages`
            -   `$ django-admin makemigrations`
            -   `$ django-admin migrate`
            -   `$ django-admin runserver`
            -   `$ django-admin sendtestemail`
            -   `$ django-admin shell`
            -   `$ django-admin showmigrations`
            -   `$ django-admin sqlflush`
            -   `$ django-admin sqlmigrate`
            -   `$ django-admin sqlsequencereset`
            -   `$ django-admin squashmigrations`
            -   `$ django-admin startapp`
            -   `$ django-admin startproject`
            -   `$ django-admin test`
            -   `$ django-admin testserver`

        </details>


        </details>

---

-   <details><summary style="font-size:25px;color:Orange">Models</summary>

    -   Models ([doc](https://docs.djangoproject.com/en/4.1/ref/models/))

    -   `Fields`: A Django model's fields define the data that can be stored in the corresponding database table. Fields can represent different data types such as text, integers, dates, booleans, etc.
    -   `Primary Key`: A primary key is a unique identifier for each row in a database table. In Django, every model must have a primary key field.
    -   `Relationships`: Django models can define relationships between themselves, such as a **one-to-many** relationship, a **many-to-many** relationship, or a **one-to-one** relationship.
    -   `Querysets`: Querysets are used to retrieve data from a database table. They are generated by querying the database using a Django model.
    -   `Managers`: Managers are responsible for querying the database to retrieve data, and they allow you to define custom methods for querying the database.
    -   `Model Forms`: Model forms are Django forms that are automatically generated based on a model's fields. They provide a simple way to create, edit, and delete model instances.
    -   `Meta class`: The Meta class is used to provide additional options for a model, such as specifying the ordering of querysets or changing the default behavior of a model manager.
    -   `Abstract Models`: An abstract model is a model that can't be instantiated on its own but provides common fields and methods that can be inherited by other models.
    -   `Migrations`: Migrations are a way of managing changes to a model's schema. They allow you to add, remove, or modify fields in a model without losing any existing data.

    #### Most common field classes and their common attributes:

    -   [Model field reference](https://docs.djangoproject.com/en/4.1/ref/models/fields/)

    -   [Field types](https://docs.djangoproject.com/en/4.1/ref/models/fields/#field-types):

        -   [SlugField](https://docs.djangoproject.com/en/4.1/ref/models/fields/#slugfield): a SlugField is a specialized field used in models to store short labels or slugs. A slug is a URL-friendly, human-readable string that typically contains letters, numbers, underscores, or hyphens. It’s often used for creating SEO-friendly URLs.

            -   Slugs are often generated from other fields like a title (e.g., turning "My First Blog Post" into "my-first-blog-post").
            -   Django ensures the slug is valid for URL use by validating its format (e.g., no spaces or special characters).
            -   Example:

            ```python
            from django.db import models
            from django.utils.text import slugify

            class BlogPost(models.Model):
                title = models.CharField(max_length=200)
                slug = models.SlugField(max_length=200, unique=True, blank=True)

                def save(self, *args, **kwargs):
                    # Automatically generate the slug from the title if it's not provided
                    if not self.slug:
                        self.slug = slugify(self.title)
                    super().save(*args, **kwargs)
            ```

        -   [TextField](https://docs.djangoproject.com/en/4.1/ref/models/fields/#textfield)
        -   [CharField](https://docs.djangoproject.com/en/4.1/ref/models/fields/#charfield)
        -   `EmailField`
        -   `BooleanField`
        -   `DateField`
        -   `FileField`
        -   `FilePathField`
        -   `ImageField`
        -   `AutoField`
        -   `DateTimeField`
        -   `FloatField`
        -   `DecimalField`
        -   `IntegerField`
        -   `UUIDField`

    -   [Relationship Fields](https://docs.djangoproject.com/en/4.1/ref/models/fields/#module-django.db.models.fields.related):

        ```python
        from django.db import models

        class Author(models.Model):
            name = models.CharField(max_length=100)

        class Book(models.Model):
            title = models.CharField(max_length=200)
            author = models.ForeignKey(Author, on_delete=models.CASCADE, related_name="books")
        ```

        -   **`ForeignKey(to, on_delete, **options)`** | [doc](https://docs.djangoproject.com/en/4.1/ref/models/fields/#foreignkey)

            -   The `ForeignKey` field is used to associate one object with another, where one object (the "source" or "parent") can have multiple related objects (the "targets" or "children"). In this relationship, multiple instances of the related model (child) can reference the same parent instance.
            -   A `Book` (Child) model with a `ForeignKey` to an `Author` (Parent) model establishes a relationship where each book is associated with one author, but an author can have multiple books.
            -   The relationship created is a **many-to-one** relationship from the perspective of the model where the field is defined (Book), which naturally appears as a **one-to-many** relationship from the perspective of the related model (Author).
            -   Behind the scenes, Django appends `_id` to the field name by default to create the database column name (can be overridden with `db_column`).
            -   Related model reference can be a class or string in the form `"app_label.ModelName"`, enabling forward declarations and circular dependency avoidance.
            -   A ForeignKey is not unique by default, because it is meant to allow many rows in the child table to point to the same parent row. If you want a true **one-to-one** relationship, you should use **OneToOneField**, or you can add `unique=True` to the **ForeignKey** field. In practice, **OneToOneField** is the clearer and more explicit choice.
            -   **Special Case: `primary_key=True` on ForeignKey converts to One-to-One**:
                -   If you set `primary_key=True` on a `ForeignKey`, the foreign key becomes the primary key of the child model.
                -   Since a primary key must be unique, this enforces a **One-to-One** relationship: each child can reference only one parent, and each parent can be referenced by at most one child.
                -   Example:
                    ```python
                    class Author(models.Model):
                        name = models.CharField(max_length=100)

                    class BookMetadata(models.Model):
                        book = models.ForeignKey(Author, on_delete=models.CASCADE, primary_key=True)
                        metadata = models.TextField()
                    ```
                -   In this case, `BookMetadata.book` is both a foreign key AND the primary key, creating a 1:1 relationship.
                -   This is functionally equivalent to using `OneToOneField`, but `OneToOneField` is more explicit and preferred for clarity.
            -   For soft deletes or audit trails, combine `on_delete=models.PROTECT` and manual cleanup to avoid cascading data loss.
            -   For self-referential relationships, use `ForeignKey('self', on_delete=...)`.
            -   Forward access: `book.author` (one-to-one object reference).
            -   Reverse access: `author.books.all()` using `related_name` or `author.book_set.all()`.
            -   Use `.select_related('author')` when you fetch child rows and need parent data in same query (join) for performance.
            -   Use `.prefetch_related()` for reverse or many queries where joined results produce duplicates.
            -   Common options:
                -   `on_delete`: controls behavior when the related object is deleted. Supported values:
                    -   `models.CASCADE` -> delete dependent rows; if the parent row is deleted, Django will also delete all related child rows automatically.
                    -   `models.PROTECT` -> prevent deletion by raising `ProtectedError`
                    -   `models.SET_NULL` -> set FK field to NULL (requires `null=True`)
                    -   `models.SET_DEFAULT` -> set FK field to `default` (requires `default`)
                    -   `models.SET(<callable|value>)` -> set to value/callable
                    -   `models.DO_NOTHING` -> do not modify child rows (database may raise integrity error)
                    -   `models.RESTRICT` (Django 3.1+) -> block deletion with `RestrictedError`
                -   `related_name`: name for reverse accessor on parent. If omitted, default is `<model>_set` (e.g. `author.book_set`). Setting `related_name='+'` does not creat reverse accessor on Parent
                -   `related_query_name`: name for reverse filter in **queryset lookups**; defaults to `related_name` or **model name** (e.g. `author.filter(Q(book__book_id))`).
                -   `to_field`: reference non-PK field on related model (must be unique).
                -   `limit_choices_to`: a dict/q or callable to limit admin/model choice selects.
                -   `db_constraint`: set to `False` to disable the database-level foreign key constraint (use with caution).
                -   `db_index`: defaults to `True`; useful for join performance.
                -   `null` and `blank`: allow NULL values and form blank input in the child model.
                -   `editable`, `db_column`, `verbose_name`, `help_text`.
                -   `primary_key`: setting to `True` converts the ForeignKey into a One-to-One relationship (each parent linked to at most one child).

        -   **`OneToOneField(to, on_delete, parent_link=False, **options)`** | [doc](https://docs.djangoproject.com/en/4.1/ref/models/fields/#onetoonefield)

            -   A `OneToOneField` is a type of `ForeignKey` with a **unique** constraint. It creates a one-to-one relationship, ensuring that each source object is associated with only one target object, and vice versa.
            -   Example: A `Profile` model with a `OneToOneField` to a `User` model creates a one-to-one relationship, where each user has a single profile, and each profile belongs to only one user.
            -   `on_delete`: When an object referenced by a `ForeignKey` is deleted, Django will emulate the behavior of the SQL constraint specified by the `on_delete` argument.
            -   `parent_link`: When True and used in a model which inherits from another concrete model, indicates that this field should be used as the link back to the parent class, rather than the extra `OneToOneField` which would normally be implicitly created by subclassing.

        -   **`ManyToManyField(to, **options)`** | [doc](https://docs.djangoproject.com/en/4.1/ref/models/fields/#manytomanyfield)

            -   A `ManyToManyField` is used to create a many-to-many relationship between objects. This means that multiple objects from one model can be related to multiple objects from another model, and vice versa.
            -   In database terms, **Django creates an intermediate join table automatically behind the scenes** to store the associations.
            -   Common examples include: `Student` ↔ `Course`, `Author` ↔ `Book`, `Tag` ↔ `Post`.
            -   Example: A `Student` model with a `ManyToManyField` to a `Course` model establishes a **many-to-many** relationship, where each student can enroll in multiple courses, and each course can have multiple students.

            ```python
            from django.db import models


            class Student(models.Model):
                name = models.CharField(max_length=100)


            class Course(models.Model):
                title = models.CharField(max_length=200)
                students = models.ManyToManyField(Student, related_name='courses')
            ```

            ```python
            # Create objects
            s1 = Student.objects.create(name='Alice')
            s2 = Student.objects.create(name='Bob')
            c1 = Course.objects.create(title='Django Basics')
            c2 = Course.objects.create(title='REST APIs')

            # Add relationships
            s1.courses.add(c1, c2)
            s2.courses.add(c1)

            # Query relationships
            print(s1.courses.all())
            print(c1.students.all())
            ```

            -   Useful methods for managing many-to-many relationships:
                -   `.add(...)` → add one or more related objects
                -   `.remove(...)` → remove a relationship
                -   `.set(...)` → replace the full set of related objects
                -   `.clear()` → remove all relationships

            -   We define an intermediate join table explicitly when you need to store extra data about the relationship itself, use a custom `through` model instead of the default hidden join table.

                -   Example:

                    -   A Student can enroll in many Courses
                    -   A Course can have many Students
                    -   But you also want to store enrollment_date or grade
                    -   In that case, Django cannot represent that with the default hidden join table, so you define your own model with a `through` argument.

                    ```py
                    from django.db import models

                    class Student(models.Model):
                        name = models.CharField(max_length=100)

                    class Course(models.Model):
                        title = models.CharField(max_length=200)
                        students = models.ManyToManyField(Student,through='Enrollment')

                    class Enrollment(models.Model):
                        student = models.ForeignKey(Student, on_delete=models.CASCADE)
                        course = models.ForeignKey(Course, on_delete=models.CASCADE)
                        enrolled_on = models.DateField()
                        grade = models.CharField(max_length=10, blank=True)
                    ```

        -   **`GenericForeignKey`** and **`GenericRelation`**:

            -   These fields are used when you need to create a generic relationship that can link a model to any other model. It's typically used for scenarios where a model can be related to different types of objects.
            -   Example: A Comment model can have a `GenericForeignKey` to allow it to be associated with various other models like BlogPost, Video, and Image.

        -   **Relation and Reverse Relations**:

            -   If no `related_name` is specified, the default reverse accessor is `modelname_set` (lowercase model name + `_set`). In this case the reverse access on `Author` becomes `author.book_set`.
            -   By defining `related_name` on a `ForeignKey` or `ManyToManyField`, you get a clear and conflict-free reverse manager. Example:

                ```python
                class Author(models.Model):
                    name = models.CharField(max_length=100)

                class Book(models.Model):
                    title = models.CharField(max_length=200)
                    author = models.ForeignKey(
                        Author,
                        on_delete=models.CASCADE,
                        related_name='books',            # reverse manager
                        related_query_name='written'     # reverse filter name
                    )
                    editor = models.ForeignKey(Author, on_delete=models.CASCADE, related_name='edited_books')

                # 1) get authors with one or more "Django" books (reverse filter via related_query_name)
                authors = Author.objects.filter(written__title__icontains='Django')

                # 2) same as:
                authors = Author.objects.filter(book__title__icontains='Django')   # default if no related_query_name

                # 3) with extra clarity / collision safety
                authors = Author.objects.filter(written__title__contains='API').distinct()
                ```

                -   `author.books.all()` and `author.edited_books.all()` are both available.
            -   `related_query_name` controls reverse queryset filtering (e.g. `Author.objects.filter(books__title__icontains='x')`). If unset, Django falls back to `related_name` or the source model name.
            -   `related_name='+'` disables reverse relation creation when you intentionally do not need backwards lookup or to avoid name collisions.
            -   For self-referential relations, use `ForeignKey('self', on_delete=models.CASCADE, related_name='children', null=True, blank=True)` and use `parent.children.all()` for reverse.

            -   Accessing related objects (forward):

                ```python
                book = Book.objects.select_related('author').get(id=1)
                print(book.author.name)
                ```

                ```sql
                SELECT "book"."id", "book"."title", "book"."author_id",
                       "author"."id", "author"."name"
                FROM "book"
                INNER JOIN "author" ON ("book"."author_id" = "author"."id")
                WHERE "book"."id" = 1;
                ```

            -   Accessing reverse relations:

                ```python
                author = Author.objects.prefetch_related('books').get(id=1)
                books = author.books.all()
                ```

                ```sql
                -- First query: Get author
                SELECT "author"."id", "author"."name" FROM "author" WHERE "author"."id" = 1;

                -- Second query: Get related books
                SELECT "book"."id", "book"."title", "book"."author_id"
                FROM "book" WHERE "book"."author_id" IN (1);
                ```

            -   Joins and performance:
                - `select_related` for foreign-key/one-to-one forward joins.
                - `prefetch_related` for reverse queries and many-to-many, avoids N+1 select.

            -   Behavioral notes:
                - `on_delete=models.CASCADE` removes dependent reverse objects automatically.
                - `on_delete=models.PROTECT` prevents deletion if reverse children exist.

            -   Introspection (runtime):

                ```python
                field = Author._meta.get_field('books')
                print(field.related_model, field.remote_field.related_name)
                ```
            -   ManyToMany reverse relation also follows `related_name` or defaults to `modelname_set`.

        -   **Options** of Relationship Fields:

            -   `related_name`: the name used to access related objects from the opposite side of the relationship.
            -   `ForeignKey.related_query_name`: a filter name used when searching from the related object back to this model.
            -   `limit_choices_to`: restricts which related objects can be selected in forms or the admin.
            -   `ForeignKey.to_field`: uses a different unique field on the related object instead of its default ID.
            -   `symmetrical`: for self-referential many-to-many relationships, controls whether the relation is mutual.
            -   `through`: specifies a custom intermediate table used to store many-to-many relationships.
            -   `through_fields`: defines which two fields on the intermediate table connect the two related models.
            -   `db_table`: sets the actual database table name for the relationship table.
            -   `db_constraint`: turns the database-level foreign key constraint on or off.
            -   `swappable`: allows this relationship to be replaced by another model at install time.

    -   **Options** of Fields: In Django, a Model represents a table in a database and its fields represent columns. Each field in a Django Model can have various options (parameters) to customize its behavior. Here are some commonly used Django model field options:

        -   `null` - If set to True, the field can be NULL in the database. The default is False.
        -   `blank` - If set to True, the field is allowed to be blank (i.e., have no value). The default is False.
        -   `choices` - A list of choices for the field. Each choice is a tuple containing two values: a database value and a human-readable value.
        -   `default` - The default value for the field. This can be a value or a callable that returns a value.
        -   `verbose_name` - A human-readable name for the field. If not provided, Django will use the field name with underscores replaced by spaces.
        -   `help_text` - Extra text to help users understand how to fill in the field.
        -   `max_length` - The maximum length of the field. Only applicable to text-based fields, such as CharField and TextField.
        -   `unique` - If set to True, the field must be unique across all records in the database. The default is False.
        -   `db_index` - If set to True, a database index will be created for the field. This can speed up database queries that use this field.
        -   `editable` - If set to False, the field will not be displayed in forms or editable in the admin interface. The default is True.
        -   `Enumeration types`
        -   `db_column`
        -   `db_tablespace`
        -   `error_messages`
        -   `primary_key`
        -   `unique_for_date`
        -   `unique_for_month`
        -   `unique_for_year`
        -   `validators`

    #### Most common Meta option:

    -   [Model Meta options](https://docs.djangoproject.com/en/4.1/ref/models/options/)

    In Django, the Meta class in a model serves several important purposes for defining and configuring how the model behaves and interacts with the database. The Meta class is a class within the model that allows you to set various options and metadata related to the model. Here are some of the primary purposes of the Meta class in a Django model:

    ```python
    class MyModel(models.Model):
        # Fields go here

        class Meta:
            db_table = 'custom_table_name'
            ordering = ['field_name']
            permissions = [
                ("can_view_special_content", "Can view special content"),
                ("can_edit_special_content", "Can edit special content"),
            ]

            verbose_name = 'Custom Name'
            verbose_name_plural = 'Custom Names'
            app_label = 'my_app'
    ```

    -   `Database Table Naming`: You can specify the name of the database table associated with the model. By default, Django will generate a table name based on the app and model name, but you can override this using the `db_table` attribute in the Meta class.
    -   `Model Ordering`: You can define the default ordering for query sets using the `ordering` attribute. This allows you to specify how the model's records should be sorted when queried.
    -   `Permissions`: The Meta class allows you to specify permissions for the model using the `permissions` attribute. This can be used to define custom permissions for the model.
    -   `default-permissions`: Defaults to ('add', 'change', 'delete', 'view'). You may customize this list, for example, by setting this to an empty list if your app doesn’t require any of the default permissions. It must be specified on the model before the model is created by migrate in order to prevent any omitted permissions from being created.
    -   `Unique Constraints`: You can specify unique constraints on model fields using the `unique_together` attribute in the Meta class. This ensures that combinations of field values are unique.

        ```python
        class MyModel(models.Model):
            name = models.CharField(max_length=50)
            category = models.CharField(max_length=50)

            class Meta:
                unique_together = ('name', 'category')
        ```
    -   `Verbose Name and Plural Name`: You can provide human-readable names for the model and its plural form using `verbose_name` and `verbose_name_plural` attributes. By default, Django uses the class name and adds an 's' for the plural form.
    -   `App Label`: The Meta class allows you to specify the label of the app using `app_label` attribute to which the model belongs. This can be useful when dealing with models from different apps.

    > The Meta class provides a way to configure various aspects of a Django model, including database-level options, permissions, and human-readable names. It helps in customizing the behavior and presentation of the model to fit the specific requirements of your project.

    -   **Model Meta options**:
        -   `verbose_name`: human-readable singular name for the model.
        -   `verbose_name_plural`: human-readable plural name for the model.
        -   `ordering`: default ordering for querysets on this model.
        -   `abstract`: marks the model as an abstract base class.
        -   `app_label`: overrides the application label used for the model.
        -   `base_manager_name`: manager used by inheritance and related queries.
        -   `db_table`: custom database table name for the model.
        -   `Table names`: notes how Django derives table names for models.
        -   `db_tablespace`: database tablespace for the model's table.
        -   `default_manager_name`: name of the default manager for the model.
        -   `default_related_name`: default reverse accessor name for relations.
        -   `get_latest_by`: field used by `latest()` / `earliest()` methods.
        -   `managed`: whether Django should manage the database table.
        -   `order_with_respect_to`: preserves ordering relative to another model.
        -   `permissions`: custom permission tuples for the model.
        -   `default_permissions`: default built-in permissions created for the model.
        -   `proxy`: marks the model as a proxy model without a new table.
        -   `required_db_features`: require DB features before using the model.
        -   `required_db_vendor`: require a specific DB backend vendor.
        -   `select_on_save`: force a select before saving model instances.
        -   `indexes`: database indexes to create for the model.
        -   `unique_together`: legacy tuple defining composite uniqueness.
        -   `index_together`: legacy tuple defining composite indexes.
        -   `constraints`: database constraints such as UniqueConstraint.

        -   **Read-only Meta attributes**:
            -   `label`: read-only model label (app_label.model_name).
            -   `label_lower`: read-only lowercase model label.

    #### [Model Inheritance Options](https://www.youtube.com/watch?v=4Xag2FzmN60&list=PLOLrQ9Pn6cazjoDEnwzcdWWf4SNS0QZml&index=9)

    > Django supports several model inheritance styles, allowing you to create relationships between models in different ways. The three main model inheritance styles in Django are:

    -   **Abstract Base Classes**: An abstract base class is a model class that is not intended to be instantiated on its own. It serves as a base class for other models, providing common fields and methods. Fields in the abstract base class are included in all child models.

        ```python
        from django.db import models

        class Base(models.Model):
            created_at = models.DateTimeField(auto_now_add=True)
            updated_at = models.DateTimeField(auto_now=True)

            class Meta:
                abstract = True

        class Child(Base):
            name = models.CharField(max_length=100)
        ```

        -   The Base class here is an abstract base class with common fields like `created_at` and `updated_at`. The Child class inherits from Base and includes an additional field, name.

    -   **Multi-table Inheritance**: Multi-table inheritance creates a database table for each model in the inheritance chain. Each table contains fields from both the parent and child models, and a database join is used to retrieve the complete set of fields for a specific instance.

        ```python
        from django.db import models

        class Parent(models.Model):
            name = models.CharField(max_length=100)

        class Child(Parent):
            extra_info = models.TextField()
        ```

        -   The Child model inherits from Parent, resulting in two database tables – one for each model.

    -   **Proxy Models**: Proxy models are used when you want to change the behavior of a model without changing its fields or creating a new database table. Proxy models use the same database table as the original model but can have additional methods or custom behavior.

        ```python
        from django.db import models

        class Base(models.Model):
            name = models.CharField(max_length=100)

        class ProxyChild(Base):
            class Meta:
                proxy = True

            def custom_method(self):
                return f"Custom method for {self.name}"
        ```

        -   The ProxyChild model here is a proxy model for the Base model. It doesn't create a new table but allows you to add custom methods or override existing ones.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Views</summary>

    #### [Request and response objects](https://docs.djangoproject.com/en/4.1/ref/request-response/#module-django.http):

    -   [HttpRequest Object](https://docs.djangoproject.com/en/4.0/ref/request-response/#httprequest-objects)
    -   [HttpResponse objects](https://docs.djangoproject.com/en/4.1/ref/request-response/#httpresponse-objects)
    -   [JsonResponse objects](https://docs.djangoproject.com/en/4.1/ref/request-response/#jsonresponse-objects)

    -   Django uses request and response objects to pass state through the system.
    -   When a page is requested, Django creates an `HttpRequest` object that contains metadata about the request. Then Django loads the appropriate view, passing the `HttpRequest` as the first argument to the view function. Each view is responsible for returning an `HttpResponse` object.

    -   <b style="color:#EE82EE">HttpRequest</b>: Follwongs are the most usefull attributes of `HttpRequest` object

        -   <b style="color:#EE82EE">HttpRequest</b>**.scheme**:

            -   A string representing the scheme of the request (http or https usually).

        -   <b style="color:#EE82EE">HttpRequest</b>**.body**:

            -   The raw HTTP request body as a bytestring. This is useful for processing data in different ways than conventional HTML forms: binary images, XML payload etc. For processing conventional form data, use HttpRequest.POST.
            -   You can also read from an HttpRequest using a file-like interface with HttpRequest.read() or HttpRequest.readline(). Accessing the body attribute after reading the request with either of these I/O stream methods will produce a RawPostDataException.

        -   <b style="color:#EE82EE">HttpRequest</b>**.path**:

            -   A string representing the full path to the requested page, not including the scheme, domain, or query string.
            -   Example: "/music/bands/the_beatles/"

        -   <b style="color:#EE82EE">HttpRequest</b>**.method**

            -   A string representing the HTTP method used in the request. This is guaranteed to be uppercase.

        -   <b style="color:#EE82EE">HttpRequest</b>**.content_type**

            -   A string representing the MIME type of the request, parsed from the CONTENT_TYPE header.

        -   <b style="color:#EE82EE">HttpRequest</b>**.content_params**

            -   A dictionary of key/value parameters included in the CONTENT_TYPE header.

        -   <b style="color:#EE82EE">HttpRequest</b>**.GET**

            -   A dictionary-like object containing all given HTTP GET parameters. See the QueryDict documentation below.

        -   <b style="color:#EE82EE">HttpRequest</b>**.POST**

            -   A dictionary-like object containing all given HTTP POST parameters, providing that the request contains form data. See the QueryDict documentation below. If you need to access raw or non-form data posted in the request, access this through the HttpRequest.body attribute instead.

            -   It’s possible that a request can come in via POST with an empty POST dictionary – if, say, a form is requested via the POST HTTP method but does not include form data. Therefore, you shouldn’t use if request.POST to check for use of the POST method; instead, use if request.method == "POST" (see HttpRequest.method).

            -   POST does not include file-upload information. See FILES.

        -   <b style="color:#EE82EE">HttpRequest</b>**.FILES**

            -   A dictionary-like object containing all uploaded files. Each key in FILES is the name from the `<input type="file" name="">`. Each value in FILES is an UploadedFile.
            -   FILES will only contain data if the request method was POST and the `<form>` that posted to the request had enctype="multipart/form-data". Otherwise, FILES will be a blank dictionary-like object.

        -   <b style="color:#EE82EE">HttpRequest</b>**.META**

            -   A dictionary containing all available HTTP headers. Available headers depend on the client and server, but here are some examples:

        -   Attributes set by middleware:

            -   <b style="color:#EE82EE">HttpRequest</b>**.session**

                -   From the `SessionMiddleware`: A readable and writable, dictionary-like object that represents the current session.

            -   <b style="color:#EE82EE">HttpRequest</b>**.site**

                -   From the `CurrentSiteMiddleware`: An instance of Site or RequestSite as returned by `get_current_site()` representing the current site.

            -   <b style="color:#EE82EE">HttpRequest</b>**.user**
                -   From the `AuthenticationMiddleware`: An instance of `AUTH_USER_MODEL` representing the currently logged-in user. If the user isn’t currently logged in, user will be set to an instance of `AnonymousUser`.

    #### [Class-Based Views (CBVs)](https://docs.djangoproject.com/en/4.1/topics/class-based-views/)

    -   [Built-in class-based views API](https://docs.djangoproject.com/en/4.1/ref/class-based-views/)
    -   [Class-based generic views - flattened index](https://docs.djangoproject.com/en/4.1/ref/class-based-views/flattened-index/)
    -   [Detailed descriptions of Class-Based Views](https://ccbv.co.uk/)

    ```python
    from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
    from django.contrib.auth.views import LoginView, LogoutView
    ```

    -   Django's Class-Based Views (CBVs) offer a wide range of useful views for handling common web development scenarios. Here are some of the most commonly used CBVs, along with their primary use cases and important parameters:

        -   `DetailView (DetailView)`:

            -   `Primary Use Case`: Display details of a single object.
            -   `Parameters`: model, template_name, context_object_name, slug_field, queryset, pk_url_kwarg.

        -   `ListView (ListView)`:

            -   `Primary Use Case`: Display a list of objects.
            -   `Parameters`: model, template_name, context_object_name, paginate_by, queryset.

        -   `CreateView (CreateView)`:

            -   `Primary Use Case`: Handle form submissions for creating new objects.
            -   `Parameters`: model, template_name, form_class, success_url.

        -   `UpdateView (UpdateView)`:

            -   `Primary Use Case`: Handle form submissions for updating existing objects.
            -   `Parameters`: model, template_name, form_class, success_url, slug_field, queryset, pk_url_kwarg.

        -   `DeleteView (DeleteView)`:

            -   `Primary Use Case`: Handle object deletion and confirmation.
            -   `Parameters`: model, template_name, success_url, slug_field, queryset, pk_url_kwarg.

        -   `TemplateView (TemplateView)`:

            -   `Primary Use Case`: Render static template pages.
            -   `Parameters`: template_name, extra_context.

        -   `RedirectView (RedirectView)`:

            -   `Primary Use Case`: Redirect to a different URL.
            -   `Parameters`: url, permanent, query_string, pattern_name.

        -   `ListView with Pagination (ListView with paginate_by)`:

            -   `Primary Use Case`: Display large lists of objects with pagination.
            -   `Parameters`: paginate_by (number of items per page).

        -   `DetailView with Slug (DetailView with slug_field)`:

            -   `Primary Use Case`: Display details of a single object based on a slug field.
            -   `Parameters`: slug_field, queryset, pk_url_kwarg.

        -   `Custom TemplateView (TemplateView)`:

            -   `Primary Use Case`: Render custom template pages with additional context data.
            -   `Parameters`: template_name, extra_context.

        -   `FormView (FormView)`:

            -   `Primary Use Case`: Handle form submissions with custom logic.
            -   `Parameters`: form_class, template_name, success_url.

        -   `Custom Views`:

            -   `Primary Use Case`: Create custom views by extending View or other CBVs to implement custom behavior tailored to your application's requirements.
            -   `Parameters`: Varies depending on the custom view's purpose.

    -   These are some of the most commonly used CBVs in Django, each designed for specific use cases. Parameters can be customized to configure the views according to your project's requirements. Django's CBVs provide a structured and organized way to handle various aspects of web development.

    -   CBVs provide several benefits over function-based views:

        -   `Reusability`: CBVs can be subclassed and customized to create new views with similar functionality. This reduces the amount of code duplication and makes it easier to maintain the code.
        -   `Extensibility`: CBVs can be easily extended to add new behavior or modify existing behavior. This allows developers to build complex views with minimal effort.
        -   `Consistency`: CBVs provide a consistent way to define views, making it easier to maintain and refactor code. This consistency also makes it easier for other developers to understand and work with the code.
        -   `Separation of concerns`: CBVs allow developers to separate the logic of handling HTTP requests and rendering responses from the implementation details of the view. This makes it easier to test the code and reduces the risk of errors.

    -   CBVs can be used in a variety of contexts, such as rendering HTML templates, handling form submissions, and generating API responses. They can also be combined with mixins to add additional functionality to views, such as authentication, caching, and pagination.

    -   Overall, class-based views are a powerful and flexible way to define views in Django, providing a consistent and extensible interface for handling HTTP requests and responses in a variety of contexts.

    #### django.views.generic.base

    -   <b style="color:#C71585">ContextMixin</b>

        -   <b style="color:#9370DB">.get_context_data(self, \*\*kwargs)</b>

    -   <b style="color:#C71585">View</b>

        -   <b style="color:#9370DB">.**init**(self, \*\*kwargs)</b>
        -   `as_view(cls, **initkwargs)`
        -   `view(request, *args, **kwargs)`
        -   <b style="color:#9370DB">.setup(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.dispatch(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.http_method_not_allowed(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.options(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.\_allowed_methods(self)</b>

    -   <b style="color:#C71585">TemplateResponseMixin</b>

        -   `template_name = None`
        -   `template_engine = None`
        -   `response_class = TemplateResponse`
        -   `content_type = None`
        -   <b style="color:#9370DB">.render_to_response(self, context, \*\*response_kwargs)</b>
        -   <b style="color:#9370DB">.get_template_names(self)</b>

    -   <b style="color:#C71585">TemplateView(TemplateResponseMixin, ContextMixin, View)</b>

        -   <b style="color:#9370DB">.get(self, request, \*args, \*\*kwargs)</b>

    -   <b style="color:#C71585">RedirectView(View)</b>
        -   `permanent = False`
        -   `url = None`
        -   `pattern_name = None`
        -   `query_string = False`
        -   <b style="color:#9370DB">.get_redirect_url(self, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.get(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.head(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.post(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.options(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.delete(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.put(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.patch(self, request, \*args, \*\*kwargs)</b>

    #### django.views.generic.edit

    -   <b style="color:#C71585">FormMixin(ContextMixin)</b>
        -   `initial = {}`
        -   `form_class = None`
        -   `success_url = None`
        -   `prefix = None`
        -   <b style="color:#9370DB">.get_initial(self)</b>
        -   <b style="color:#9370DB">.get_prefix(self)</b>
        -   <b style="color:#9370DB">.get_form_class(self)</b>
        -   <b style="color:#9370DB">.get_form(self, form_class=None)</b>
        -   <b style="color:#9370DB">.get_form_kwargs(self)</b>
        -   <b style="color:#9370DB">.get_success_url(self)</b>
        -   <b style="color:#9370DB">.form_valid(self, form)</b>
        -   <b style="color:#9370DB">.form_invalid(self, form)</b>
        -   <b style="color:#9370DB">.get_context_data(self, \*\*kwargs)</b>
    -   <b style="color:#C71585">ModelFormMixin(FormMixin, SingleObjectMixin)</b>
        -   `fields = None`
        -   <b style="color:#9370DB">.get_form_class(self)</b>
        -   <b style="color:#9370DB">.get_form_kwargs(self)</b>
        -   <b style="color:#9370DB">.get_success_url(self)</b>
        -   <b style="color:#9370DB">.form_valid(self, form)</b>
    -   <b style="color:#C71585">ProcessFormView(View)</b>
        -   <b style="color:#9370DB">.get(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.post(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.put(self, \*args, \*\*kwargs)</b>
    -   <b style="color:#C71585">BaseFormView(FormMixin, ProcessFormView)</b>
    -   <b style="color:#C71585">FormView(TemplateResponseMixin, BaseFormView)</b>
    -   <b style="color:#C71585">BaseCreateView(ModelFormMixin, ProcessFormView)</b>
        -   <b style="color:#9370DB">.get(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.post(self, request, \*args, \*\*kwargs)</b>
    -   <b style="color:#C71585">CreateView(SingleObjectTemplateResponseMixin, BaseCreateView)</b>
        -   `template_name_suffix = '_form'`
    -   <b style="color:#C71585">BaseUpdateView(ModelFormMixin, ProcessFormView)</b>
        -   <b style="color:#9370DB">.get(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.post(self, request, \*args, \*\*kwargs)</b>
    -   <b style="color:#C71585">UpdateView(SingleObjectTemplateResponseMixin, BaseUpdateView)</b>
        -   `template_name_suffix = '_form'`
    -   <b style="color:#C71585">DeletionMixin</b>
        -   `success_url = None`
        -   <b style="color:#9370DB">.delete(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.post(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.get_success_url(self)</b>
    -   <b style="color:#C71585">BaseDeleteView(DeletionMixin, BaseDetailView)</b>
    -   <b style="color:#C71585">DeleteView(SingleObjectTemplateResponseMixin, BaseDeleteView)</b>
        -   `template_name_suffix = '_confirm_delete'`

    #### django.views.generic.list

    -   <b style="color:#C71585">MultipleObjectMixin(ContextMixin)</b>
        -   <b style="color:#9370DB">.get_queryset(self)</b>
        -   <b style="color:#9370DB">.get_ordering(self)</b>
        -   <b style="color:#9370DB">.paginate_queryset(self, queryset, page_size)</b>
        -   <b style="color:#9370DB">.get_paginate_by(self, queryset)</b>
        -   <b style="color:#9370DB">.get_paginator(self, queryset, per_page, orphans=0</b>
        -   <b style="color:#9370DB">.get_paginate_orphans(self)</b>
        -   <b style="color:#9370DB">.get_allow_empty(self)</b>
        -   <b style="color:#9370DB">.get_context_object_name(self, object_list)</b>
        -   <b style="color:#9370DB">.get_context_data(self, \*, object_list=None, \*\*kwargs)</b>
    -   <b style="color:#C71585">BaseListView(MultipleObjectMixin, View)</b>
        -   <b style="color:#9370DB">.get(self, request, \*args, \*\*kwargs)</b>
    -   <b style="color:#C71585">MultipleObjectTemplateResponseMixin(TemplateResponseMixin)</b>
        -   <b style="color:#9370DB">.get_template_names(self)</b>
    -   <b style="color:#C71585">ListView(MultipleObjectTemplateResponseMixin, BaseListView)</b>

    #### django.views.generic.detail

    -   <b style="color:#C71585">SingleObjectMixin(ContextMixin)</b>
        -   <b style="color:#9370DB">.get_object(self, queryset=None)</b>
        -   <b style="color:#9370DB">.get_queryset(self)</b>
        -   <b style="color:#9370DB">.get_slug_field(self)</b>
        -   <b style="color:#9370DB">.get_context_object_name(self, obj)</b>
        -   <b style="color:#9370DB">.get_context_data(self, \*\*kwargs)</b>
    -   <b style="color:#C71585">BaseDetailView(SingleObjectMixin, View)</b>
        -   <b style="color:#9370DB">.get(self, request, \*args, \*\*kwargs)</b>
    -   <b style="color:#C71585">SingleObjectTemplateResponseMixin(TemplateResponseMixin)</b>
        -   <b style="color:#9370DB">.get_template_names(self)</b>
    -   <b style="color:#C71585">DetailView(SingleObjectTemplateResponseMixin, BaseDetailView)</b>

    #### django.contrib.auth.views

    -   <b style="color:#C71585">SuccessURLAllowedHostsMixin</b>
        -   <b style="color:#9370DB">.get_success_url_allowed_hosts(self)</b>
    -   <b style="color:#C71585">LoginView(SuccessURLAllowedHostsMixin, FormView)</b>
        -   `form_class = AuthenticationForm`
        -   `authentication_form = None`
        -   `redirect_field_name = REDIRECT_FIELD_NAME`
        -   `template_name = 'registration/login.html'`
        -   `redirect_authenticated_user = False`
        -   `extra_context = None`
        -   <b style="color:#9370DB">.dispatch(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.get_success_url(self)</b>
        -   <b style="color:#9370DB">.get_redirect_url(self)</b>
        -   <b style="color:#9370DB">.get_form_class(self)</b>
        -   <b style="color:#9370DB">.get_form_kwargs(self)</b>
        -   <b style="color:#9370DB">.form_valid(self, form)</b>
        -   <b style="color:#9370DB">.get_context_data(self, \*\*kwargs)</b>
    -   <b style="color:#C71585">LogoutView(SuccessURLAllowedHostsMixin, TemplateView)</b>
        -   `next_page = None`
        -   `redirect_field_name = REDIRECT_FIELD_NAME`
        -   `template_name = 'registration/logged_out.html'`
        -   `extra_context = None`
        -   <b style="color:#9370DB">.dispatch(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.post(self, request, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.get_next_page(self)</b>
        -   <b style="color:#9370DB">.get_context_data(self, \*\*kwargs)</b>
    -   <b style="color:#C71585">PasswordContextMixin</b>
        -   <b style="color:#9370DB">.get_context_data(self, \*\*kwargs)</b>
    -   <b style="color:#C71585">PasswordResetView(PasswordContextMixin, FormView)</b>
        -   `email_template_name = 'registration/password_reset_email.html'`
        -   `extra_email_context = None`
        -   `form_class = PasswordResetForm`
        -   `from_email = None`
        -   `html_email_template_name = None`
        -   `subject_template_name = 'registration/password_reset_subject.txt'`
        -   `success_url = reverse_lazy('password_reset_done')`
        -   `template_name = 'registration/password_reset_form.html'`
        -   `title = _('Password reset')`
        -   `token_generator = default_token_generator`
        -   <b style="color:#9370DB">.dispatch(self, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.form_valid(self, form)</b>
    -   <b style="color:#C71585">PasswordResetDoneView(PasswordContextMixin, TemplateView)</b>
        -   `template_name = 'registration/password_reset_done.html'`
        -   `title = _('Password reset sent')`
    -   <b style="color:#C71585">PasswordResetConfirmView(PasswordContextMixin, FormView)</b>
        -   `form_class = SetPasswordForm`
        -   `post_reset_login = False`
        -   `post_reset_login_backend = None`
        -   `reset_url_token = 'set-password'`
        -   `success_url = reverse_lazy('password_reset_complete')`
        -   `template_name = 'registration/password_reset_confirm.html'`
        -   `title = _('Enter new password')`
        -   `token_generator = default_token_generator`
        -   <b style="color:#9370DB">.dispatch(self, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.get_user(self, uidb64)</b>
        -   <b style="color:#9370DB">.get_form_kwargs(self)</b>
        -   <b style="color:#9370DB">.form_valid(self, form)</b>
        -   <b style="color:#9370DB">.get_context_data(self, \*\*kwargs)</b>
    -   <b style="color:#C71585">PasswordResetCompleteView(PasswordContextMixin, TemplateView)</b>
        -   `template_name = 'registration/password_reset_complete.html'`
        -   `title = _('Password reset complete')`
        -   <b style="color:#9370DB">.get_context_data(self, \*\*kwargs)</b>
    -   <b style="color:#C71585">PasswordChangeView(PasswordContextMixin, FormView)</b>
        -   `form_class = PasswordChangeForm`
        -   `success_url = reverse_lazy('password_change_done')`
        -   `template_name = 'registration/password_change_form.html'`
        -   `title = _('Password change')`
        -   <b style="color:#9370DB">.dispatch(self, \*args, \*\*kwargs)</b>
        -   <b style="color:#9370DB">.get_form_kwargs(self)</b>
        -   <b style="color:#9370DB">.form_valid(self, form)</b>
    -   <b style="color:#C71585">PasswordChangeDoneView(PasswordContextMixin, TemplateView)</b>
        -   `template_name = 'registration/password_change_done.html'`
        -   `title = _('Password change successful')`
        -   <b style="color:#9370DB">.dispatch(self, \*args, \*\*kwargs)</b>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Templating</summary>

    -   [Templates](https://docs.djangoproject.com/en/4.1/topics/templates/)

    A template is a text file containing static parts of the desired HTML output and special syntax describing how dynamic content will be inserted. Templates are typically used to generate HTML dynamically and provide a way to present data fetched from the database or computed by the application logic.

    #### Django Context Processors:

    A context processor is a Python function that allows you to add extra data to the context of every template rendered within a Django project. It's a convenient way to make certain data available globally to all templates without explicitly passing it in every view.

    A context processor is a function that takes a request object as its parameter and returns a dictionary of values that will be added to the context of the template. The context processor function is executed for every request, and its returned values are accessible in templates.

    -   **Definition of Context Processor**:

        -   `Create a Python Module for Context Processors`:

            -   Start by creating a Python module to store your context processors. This module can be named anything, but conventionally it's named `context_processors.py`.
            -   Place this module in one of your Django apps or create a new app specifically for context processors.

        -   `Define Context Processor Functions`:

            -   Within the `context_processors.py` module, define one or more context processor functions. Each function should take a request object as its only argument and return a dictionary containing the context data to be added to the template context.

                ```python
                def custom_context(request):
                    # Add custom data to the context
                    return {
                        'site_name': 'My Website',
                        'current_year': datetime.now().year,
                    }
                ```

        -   `Register Context Processor Functions`:

            -   Next, register your context processor functions with Django by adding them to the context_processors option in the TEMPLATES setting of your project's settings.py file.
            -   You need to provide the Python path to each context processor function as a string.
            -   Example (`settings.py`):

                ```python
                TEMPLATES = [
                    {
                        'BACKEND': 'django.template.backends.django.DjangoTemplates',
                        'DIRS': [BASE_DIR / 'templates'],
                        'APP_DIRS': True,
                        'OPTIONS': {
                            'context_processors': [
                                'django.template.context_processors.debug',
                                'django.template.context_processors.request',
                                'django.contrib.auth.context_processors.auth',
                                'django.contrib.messages.context_processors.messages',
                                'my_app.context_processors.custom_context',  # Register your context processor here
                            ],
                        },
                    },
                ]
                ```

            -   In this example, 'my_app.context_processors.custom_context' is the Python path to the custom_context() function defined in the context_processors.py module of the my_app Django app.

        -   `Access Context Data in Templates`:

            -   After registering the context processor, the data returned by the context processor function will be available in all templates rendered by Django.
            -   You can access the context data using Django's template language syntax, just like any other context variable.
            -   Example (template usage):

                ```html
                <title>{{ site_name }}</title>
                <p>&copy; {{ current_year }} {{ site_name }}</p>
                ```

    **Available Context Variables by Defaults**: In Django templates, several context variables are loaded by default. These context variables provide information about the current request, user authentication, and other common web application attributes. Here are the key default context variables:

    -   `request`: This context variable provides access to the current HTTP request object, allowing you to access request information, such as request headers, user agents, and more. This variable is automatically provided by Django in the template context whenever a view function or class-based view returns an HttpResponse object. Django automatically includes the request object in the context.
    -   `user`: If a user is authenticated, this context variable provides access to the current user object. It allows you to check the user's authentication status and access user-specific information, such as username and permissions. It is also included in the template context by Django automatically if the authentication middleware is enabled and the user is logged in. It represents the currently authenticated user. `user` and the following `perm` both context variables are defined in the context processor provided by the `auth` component located in `django.contrib` package.
    -   `perms`: This variable contains information about the permissions granted to the current user. It's useful for checking a user's permissions within templates.
    -   `messages`: This context variable is used for displaying user messages and notifications (e.g., success messages, error messages) to the user. It's often used in conjunction with Django's messaging framework. The messages variable is provided by the Django messages framework, which is typically enabled by including `django.contrib.messages.middleware.MessageMiddleware` in the MIDDLEWARE setting and 'django.contrib.messages' in the INSTALLED_APPS setting. The messages framework adds messages to the template context during the rendering process.
    -   `csrf_token`: The csrf_token context variable contains a CSRF token, which is used to protect against cross-site request forgery attacks. It's essential for secure form submissions. The CSRF middleware (`django.middleware.csrf.CsrfViewMiddleware`) is responsible for adding the CSRF token to the template context. During template rendering, Django automatically adds the `csrf_token` variable to the template context for views that require CSRF protection. This is done without explicit registration of the `django.template.context_processors.csrf` context processor in the `TEMPLATES` setting.
    -   `debug`: This variable is set to True if debugging is enabled in the Django settings (`DEBUG = True`). It can be used to conditionally display debug information or error handling in templates.

    These default context variables are available in Django templates and provide essential information and functionality for building web applications. You can access and use these variables to display content, handle user authentication, and manage application behavior within your templates.

    #### Variables

    -   A variable outputs a value from the context, which is a dict-like object mapping keys to values.
    -   Variables are surrounded by `{{` and `}}` like this:

        ```html
        <h1>
            My first name is {{ first_name }}. My last name is {{ last_name }}.
        </h1>
        ```

    #### Tag

    -   [Built-in template tags and filters](https://docs.djangoproject.com/en/4.0/ref/templates/builtins/)
    -   [Creating Custom Template Tags and Filters](https://www.youtube.com/watch?v=XtbvBlCyfT4)

    -   A template tag is a Python function that is executed within a template and allows you to perform more complex operations or logic than what is typically possible with the template language alone. Template tags provide additional functionality and allow you to manipulate data, control the flow of the template, or generate dynamic content.
    -   Template tags can accept arguments and perform operations such as querying the database, manipulating strings, iterating over lists, or applying conditional logic. They provide a way to extend the functionality of Django templates and keep the presentation logic separate from the business logic.
    -   Template tags are surrounded by `{% %}` tags in Django templates. There are two types of template tags: simple tags and inclusion tags.

        -   `Simple Tags`: Simple tags are used for performing simple operations or transformations on the data.
            They are defined as Python functions that take the context and any number of arguments and return a string that will be inserted into the template.

            -   Example: `{% tag_name argument1 argument2 %}`

        -   `Inclusion Tags`: Inclusion tags are used when you want to include another template and pass it a set of context data. They are defined as Python functions that take the context and any number of arguments and return a rendered template as a string.
            -   Example: `{% include_tag_name argument1 argument2 %}`

    -   **Definition of Template Tag**: Here's how you can define a custom template tag in Django:

        -   `Create a Python Module for Template Tags`:

            -   Start by creating a Python module to store your custom template tags. This module can be named anything, but conventionally it's named `templatetags` and placed within one of your Django apps.
            -   Inside the `templatetags` directory, create a new Python file `__init__.py` and `my_tags.py` to define your custom template tags.

        -   `Define Template Tag Functions`:

            -   Within the Python file, define one or more template tag functions. Each function should accept the context and any other arguments you want to pass from the template, and return the processed content as a string.
            -   Decorate the function with the `@register.simple_tag` decorator to indicate that it's a simple template tag.
            -   Example (`my_tags.py`):

                ```python
                # django_app/templatetags/my_tags.py
                from django import template

                register = template.Library()

                @register.simple_tag
                def current_time(format_string):
                    """Return the current time formatted as specified."""
                    from datetime import datetime
                    return datetime.now().strftime(format_string)
                ```

        -   `Load Template Tags in Templates`:

            -   To use your custom template tags in templates, you need to load the module containing the tags using the `{% load %}` tag.
            -   The `{% load %}` tag should be placed at the top of the template file where you want to use the custom tags.
            -   Example (template usage):

                ```html
                {% load my_tags %}
                <p>
                    The current time is {% current_time "%Y-%m-%d %H:%M:%S" %}.
                </p>
                ```

            -   In this example, we load the `my_tags` module containing the `current_time` template tag, and then call the `current_time` tag with a format string argument to display the current time in the specified format.

        -   `Registering More Complex Template Tags`:

            -   If you need to define more complex template tags that include block tags, you can use the` @register.tag` decorator instead of `@register.simple_tag`.
            -   With block tags, you can define tags that enclose content and manipulate it in various ways.
            -   If your tag needs to render HTML rather than return plain data, use an **inclusion tag**.

                1. Define the tag in `templatetags/custom_tags.py`:

                    ```python
                    @register.inclusion_tag('partials/item_list.html')
                    def render_items(items):
                        """
                        Renders a list of items as an HTML list.
                        Usage: {% render_items items %}
                        """
                        return {'items': items}
                    ```

                2. Create a partial template: `templates/partials/item_list.html`:

                    ```html
                    <ul>
                        {% for item in items %}
                        <li>{{ item }}</li>
                        {% endfor %}
                    </ul>
                    ```

                3. Use the tag in your main template:

                    ```html
                    {% load custom_tags %}

                    <h1>Item List</h1>
                    {% render_items items %}
                    ```

    -   **Built-in Template Tag**: Django comes with a set of built-in template tags that cover common use cases, such as looping over lists, conditionally displaying content, formatting dates, and more. Additionally, you can create your own custom template tags to encapsulate reusable functionality specific to your project. Followings are some examples of using a built-in template tags:

        -   `{% block %} and {% endblock %}`:

            ```html
            <!-- Example (base template) -->
            <!DOCTYPE html>
            <html>
                <head>
                    <title>{% block title %}Default Title{% endblock %}</title>
                </head>
                <body>
                    <div id="content">{% block content %}{% endblock %}</div>
                </body>
            </html>
            ```

            ```html
            <!-- Example (child template) -->
            {% extends 'base.html' %} {% block title %}Page Title{% endblock %}
            {% block content %}
            <p>This is the content of the page.</p>
            {% endblock %}
            ```

        -   `{% include %}`:

            ```html
            {% include 'header.html' %}
            ```

        -   `{% url %}`:

            ```html
            <a href="{% url 'app_name:view_name' arg1=value1 %}">Link Text</a>
            ```

        -   `{% with %}` and `{% endwith %}`:

            ```html
            {% with total_price=quantity * product.price %} Total: ${{
            total_price }} {% endwith %}
            ```

        -   `{% if %}` and `{% endif %}`:

            ```html
            {% if user.is_authenticated %} Welcome, {{ user.username }}! {% else
            %} Please log in. {% endif %}
            ```

        -   `{% for %}` and `{% endfor %}`:

            ```html
            {% for item in my_list %} {{ item }} {% endfor %}
            ```

        -   `autoescape`: Django auto-escaping is a feature of the Django web framework that helps prevent Cross-Site Scripting (XSS) attacks by automatically escaping potentially dangerous characters in output templates. To prevent XSS attacks, Django automatically escapes output in templates by default. Developers can also use a special syntax in Django templates to disable auto-escaping for a particular block of content if they need to output HTML or other markup.

            ```html
            {% autoescape off %} ... {% endautoescape %}
            ```

        -   ``:

            ```html

            ```

    -   **Custom Template Tag**:

        -   To use a custom template tag, you need to follow these steps:

            -   Create a Python module (e.g., templatetags) inside your app directory.
            -   Define your template tag functions in the module.
            -   Load the template tags in your template using the `{% load %}` tag.
            -   Use the template tag within your template.

        -   Example of using a custom template tag to perform a custom operation:

            ```html
            {% custom_tag argument1 argument2 %}
            ```

        -   Template tags provide a powerful mechanism for extending the capabilities of Django templates and allow you to create reusable and modular templates that can handle complex tasks and display dynamic content.

    #### Filters:

    -   [Built-in Filters](https://docs.djangoproject.com/en/4.1/ref/templates/builtins/#ref-templates-builtins-filters)
    -   [Writing custom template filters](https://docs.djangoproject.com/en/4.1/howto/custom-template-tags/#howto-writing-custom-template-filters)

    a template filter is a way to transform or modify the output of template variables or expressions within a Django template. Filters are applied using the pipe character | and can be chained together to perform multiple transformations. Here's how you can use and define template filters in Django:

    -   **Built-in Template Filters**: Django provides a set of built-in template filters that you can use out of the box. These filters cover a wide range of common transformations, such as formatting dates, manipulating strings, and filtering lists. Some examples of built-in filters include date, default, length, lower, title, truncatewords, and many more.Example:

        ```html
        Copy code {{ my_string|lower }}
        <!-- Convert my_string to lowercase -->
        {{ my_date|date:"Y-m-d" }}
        <!-- Format my_date as "YYYY-MM-DD" -->
        {{ my_list|length }}
        <!-- Get the length of my_list -->
        ```

        -   `Chaining Filters`: You can chain multiple filters together to perform sequential transformations on a value. Filters are applied from left to right, with the output of one filter becoming the input to the next filter.Example:

            ```html
            {{ my_string|lower|title }}
            <!-- Convert my_string to lowercase, then capitalize the first letter -->
            ```

    -   **Custom Template Filters**: You can define your own custom template filters to perform custom transformations that are not covered by the built-in filters. To define a custom filter, you need to create a Python function and register it as a template filter using the @register.filter decorator.Example (my_filters.py):

        ```python
        from django import template

        register = template.Library()

        @register.filter
        def add_prefix(value, prefix):
            """Add a prefix to the given value."""
            return f"{prefix}{value}"

        ```

        -   After defining the custom filter function, you need to load the filter library in your template using the {% load %} tag, and then you can use the custom filter in your template.Example (template usage):

            ```html
            {% load my_filters %} {{ my_string|add_prefix:"Prefix-" }}
            ```

            -   In this example, we define a custom filter add_prefix that adds a prefix to a given string. We then load the my_filters module containing the custom filter and apply the filter to a variable in the template.

    By using built-in and custom template filters in Django, you can easily manipulate and format data directly within your templates, making them more flexible and powerful. Template filters are a convenient way to perform common transformations and ensure consistency in the presentation of your data.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Forms</summary>

    -   [DOCS: Forms](https://docs.djangoproject.com/en/4.1/ref/forms/)
    -   [Working with forms](https://docs.djangoproject.com/en/4.1/topics/forms/)
    -   [The Forms API](https://docs.djangoproject.com/en/4.1/ref/forms/api/)
    -   [Form fields](https://docs.djangoproject.com/en/4.1/ref/forms/fields/)

    ```python
    from django.forms.fields import *
    from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, PasswordResetForm, SetPasswordForm
    ```

    -   **Form Class**:

        -   Django provides a `django.forms.Form` class to create HTML forms.
        -   Forms are used to handle user input, validate data, and generate HTML for rendering.

    -   **Field Types**:

        -   Django forms include various built-in field types (e.g., `CharField`, `IntegerField`, `EmailField`, etc.) to represent different types of input.

    -   **Validation**:

        -   Forms perform validation on submitted data based on field types and additional validation methods.
        -   Errors are generated for invalid input, and error messages can be displayed in the template.

    -   **Widgets**:

        -   Form fields use widgets to define how the input should be displayed in HTML.
        -   Examples of widgets include TextInput, PasswordInput, and CheckboxInput.

    -   **Form Rendering**:

        -   Django provides template tags and filters for rendering form fields in HTML templates.
        -   The `{{ form }}` variable in a template renders all fields of the form.

    -   **Handling Submissions**:

        -   Forms handle both initial form rendering and form submission.
        -   When a form is submitted, the data is validated, and if valid, it can be processed in the view.

    -   **CSRF Protection**:

        -   Django forms include built-in CSRF protection to prevent Cross-Site Request Forgery attacks.
        -   `{% csrf_token %}` is used in the form template to include a hidden input with a CSRF token.

    -   **Model Forms**:

        -   Django provides ModelForm which is a specialized form for working with Django models.
        -   It automatically generates form fields based on the model's fields.

    -   **Formsets**:

        -   Django allows the creation of formsets, which are a way to manage multiple forms on the same page.

    -   **Customization**:

        -   Forms can be customized by defining a form class and overriding methods like `__init__` and `clean`.
        -   Custom validation methods can be added to perform additional validation logic.

    -   **Rendering without a Model**:

        -   Forms can be used without a corresponding model. They can handle arbitrary data.
        -   This is useful for scenarios where data doesn't need to be stored in a database.

    -   **Dynamic Forms**:

        -   Form classes can be dynamically created or modified based on conditions or user input in the view.

    -   **Internationalization (i18n)**:

        -   Forms support internationalization by allowing translation of error messages and labels.

    -   **AJAX Support**:

        -   Forms can be used in combination with AJAX to submit and validate data without reloading the entire page.

    -   **Form Fields** and **Field Arguments**:

        -   Available Fields Arguments :

            -   `label`
            -   `widget`
            -   `help_text`
            -   `required`
            -   `label_suffix`
            -   `initial`
            -   `error_messages`
            -   `validators`
            -   `localize`
            -   `disabled`

        -   `CharField(**kwargs)`

            -   Default widget: By default, a `CharField` will have a `TextInput` widget, that produces an `<input type="text">` in the HTML. If you needed `<textarea>` instead, you’d specify the appropriate widget when defining your form field,
            -   Empty value: Whatever you’ve given as `empty_value`.
            -   Normalizes to: A string.
            -   Uses `MaxLengthValidator` and `MinLengthValidator` if `max_length` and `min_length` are provided. Otherwise, all inputs are valid.
            -   Error message keys: `required`, `max_length`, `min_length`
            -   Has the following optional arguments for validation:
                -   `max_length`/`min_length` → If provided, these arguments ensure that the string is at most or at least the given length.
                -   `strip` → If True (default), the value will be stripped of leading and trailing whitespace.
                -   `empty_value` → The value to use to represent “empty”. Defaults to an empty string.

    -   `Form Validations`: Django form validation methods are called automatically by the Django framework when the form is submitted. The validation methods are called in the following order:

        -   `is_valid()`: This method is called first to check if the submitted form data is valid. It checks if all required fields are present and if the data is in the correct format.

        -   `clean()`: This method is called next if `is_valid()` returns True. This method is responsible for performing additional validation and cleaning of the submitted data. It can modify the submitted data as needed and return a cleaned version of the data.

        -   `clean_<fieldname>()`: If the `clean()` method has not raised any errors, then the `clean_<fieldname>()` method is called for each field in the form. This method can be used to perform field-specific validation and cleaning.

        -   If any validation errors are encountered during the validation process, the errors are stored in the form's errors dictionary, which can be accessed in the template to display error messages to the user.

    -   `ModelForm`: Django `ModelForm` is a useful tool for creating HTML forms based on Django models. The `ModelForm` class provides various clean methods that can be used to validate and clean form data before it is saved to the database. Here are some of the clean methods available in Django ModelForm. By using these clean methods in your Django ModelForm, you can ensure that the data entered into your forms is validated and cleaned before it is saved to the database. This helps to ensure the integrity of your data and prevent errors or inconsistencies.

        -   `clean(self)`: This method is called after all other validation methods have been called. It can be used to validate multiple fields together and to perform custom validation logic that can't be handled by the individual field validation methods. For example, if you need to check if two fields are mutually exclusive, you can do so in the clean() method.

        -   `clean_<fieldname>(self)`: This method is called for each individual field after the field's default validation has been performed. It can be used to perform additional validation on the field or to clean the data in some way. For example, if you need to convert the value of a field to uppercase, you can do so in the `clean_<fieldname>()` method.

        -   `clean_<fieldname>_unique(self)`: This method is called for fields that have the `unique=True` option set. It can be used to check if the value of the field is unique among all other objects in the database. For example, if you have a User model with a unique email field, you can use clean_email_unique() to check if the email address is already in use.

        -   `clean_<fieldname>_choices(self)`: This method is called for fields that have `choices` defined. It can be used to validate that the value of the field is one of the allowed choices. For example, if you have a ChoiceField with the choices "Yes" and "No", you can use `clean<fieldname>_choices()` to ensure that the value is one of those two options.

        -   Each form field has a corresponding Widget class, which in turn corresponds to an HTML form widget such as `<input type="text">`. In most cases, the field will have a sensible `default widget`. For example, by default, a CharField will have a TextInput widget, that produces an `<input type="text">` in the HTML. If you needed `<textarea>` instead, you’d specify the appropriate widget when defining your form field,

    #### Django Widget

    -   [Widgets](https://docs.djangoproject.com/en/4.1/ref/forms/widgets/) || [Built-in widgets](https://docs.djangoproject.com/en/4.1/ref/forms/widgets/#built-in-widgets)

    -   In Django, a widget is a graphical representation of an HTML form input element. Widgets are used to render HTML forms in Django templates and to handle user input.

    -   Django provides a number of built-in widgets for different types of form fields, such as text inputs, checkboxes, radio buttons, and more. Widgets can also be customized or extended to create new types of form inputs or to modify the behavior of existing ones.

    -   Widgets are defined as classes in Django and are associated with form fields through the widget attribute of the field. For example, the TextInput widget is associated with the CharField form field, while the CheckboxInput widget is associated with the BooleanField form field.

    -   Widgets can be customized by subclassing the built-in widget classes or by creating new widget classes that inherit from the Widget class. Custom widgets can be used to render form inputs in a specific way or to handle user input in a custom way.

    -   Widgets can also be used to specify additional attributes for HTML form input elements, such as CSS classes, placeholder text, or default values. This can be done by passing additional parameters to the widget constructor.

    -   Some Widget classes are:

        -   `class TextInput`

            -   input_type: 'text'
            -   template_name: 'django/forms/widgets/text.html'
            -   Renders as: <input type="text" ...>

        -   `class EmailInput`:

            -   input_type: 'email'
            -   template_name: `django/forms/widgets/email.html`
            -   Renders as: <input type="email" ...>

        -   `class PasswordInput`:
            -   input_type: 'password'
            -   template_name: `django/forms/widgets/password.html`
            -   Renders as: <input type="password" ...>
            -   Takes one optional argument:
                -   render_value → Determines whether the widget will have a value filled in when the form is re-displayed after a validation error (default is False).

    -   Specifying widgets:

        ```python
        from django import forms

        class Person(forms.Form):
            name = forms.CharField()
            web_url = forms.URLField()
            about = forms.CharField(widget=forms.Textarea)
            email = forms.EmailField(widget=forms.TextInput(attrs={'class': 'form-control mb-3', 'placeholder': 'Email', 'id': 'form-email'}), max_length=254)
        ```

    #### FormSet

    An inline formset is a mechanism for working with multiple forms on a single page, particularly in the context of related models. It is used when you have a model with a `ForeignKey` or a `OneToOneField`, and you want to manage related model instances within the same form. Inline formsets are often used in scenarios where you have a parent model and one or more child models associated with it.

    ```python
    # models.py
    from django.db import models

    class ParentModel(models.Model):
        name = models.CharField(max_length=100)

    class ChildModel(models.Model):
        parent = models.ForeignKey(ParentModel, on_delete=models.CASCADE)
        child_name = models.CharField(max_length=100)

    # forms.py
    from django import forms

    class ParentForm(forms.ModelForm):
        class Meta:
            model = ParentModel
            fields = ['name']

    class ChildForm(forms.ModelForm):
        class Meta:
            model = ChildModel
            fields = ['child_name']

    # views.py
    from django.shortcuts import render
    from django.forms import inlineformset_factory
    from .models import ParentModel, ChildModel
    from .forms import ParentForm, ChildForm

    def my_view(request):
        parent = ParentModel()
        ChildFormSet = inlineformset_factory(ParentModel, ChildModel, form=ChildForm, extra=1)

        if request.method == 'POST':
            parent_form = ParentForm(request.POST, instance=parent)
            formset = ChildFormSet(request.POST, instance=parent)

            if parent_form.is_valid() and formset.is_valid():
                parent = parent_form.save()
                formset.save()

        else:
            parent_form = ParentForm(instance=parent)
            formset = ChildFormSet(instance=parent)

        return render(request, 'my_template.html', {'parent_form': parent_form, 'formset': formset})
    ```

    -   Available form-field attributes in Django Template

        -   `form.cleaned_data`
        -   `form.is_valid()`
        -   `{{ form.as_div }}` --> will render them wrapped in `<div>` tags.
        -   `{{ form.as_table }}` --> will render them as table cells wrapped in `<tr>` tags.
        -   `{{ form.as_p }}` --> will render them wrapped in `<p>` tags.
        -   `{{ form.as_ul }}` --> will render them wrapped in `<li>` tags.
        -   `{{ form.hidden_fields }}`
        -   `{{ form.visible_fields }}`
        -   `{{ form.management_form }}`
        -   `{{ form.non_form_errors }}`
        -   `{{ form.name_of_field }}`
        -   `{{ form.name_of_field.field }}`
            -   The Field instance from the form class that this `BoundField` wraps. You can use it to access Field attributes, e.g. `{{ char_field.field.max_length }}`
        -   `{{ form.name_of_field.value }}`
        -   `{{ form.name_of_field.errors }}`
        -   `{{ form.name_of_field.help_text }}`
        -   `{{ form.name_of_field.html_name }}`
        -   `{{ form.name_of_field.is_hidden }}`
            -   This attribute is True if the form field is a hidden field and False otherwise.
        -   `{{ form.name_of_field.label }}`
            -   The label of the field, e.g. "Email address".
        -   `{{ form.name_of_field.label_tag }}`
        -   `{{ form.name_of_field.lagend_tag }}`
        -   `{{ form.name_of_field.id_for_label }}`
        -   Looping over the form’s fields:
            ```html
            {% for field in form %}
            <div class="fieldWrapper">
                {{ field.errors }} {{ field.label_tag }} {{ field }} {% if
                field.help_text %}
                <p class="help">{{ field.help_text|safe }}</p>
                {% endif %}
            </div>
            {% endfor %}
            ```

    #### Forms Classes Hierarchy

    -   <b style="color:#C71585">DeclarativeFieldsMetaclass(MediaDefiningClass)</b>:
        -   <b style="color:#9370DB">.\_\_new\_\_(mcs, name, bases, attrs)</b>
    -   <b style="color:#C71585">BaseForm</b>:
        -   `default_renderer = None`
        -   `field_order = None`
        -   `prefix = None`
        -   `use_required_attribute = True`
        -   <b style="color:#9370DB">.\_\_init\_\_(self, ...)</b>
        -   <b style="color:#9370DB">.order_fields(self, field_order)</b>
        -   <b style="color:#9370DB">.\_\_str\_\_(self)</b>
        -   <b style="color:#9370DB">.\_\_repr\_\_(self)</b>
        -   <b style="color:#9370DB">.\_\_iter\_\_(self)</b>
        -   <b style="color:#9370DB">.\_\_getitem\_\_(self, name)</b>
        -   <b style="color:#9370DB">.errors(self)</b>
        -   <b style="color:#9370DB">.is_valid(self)</b>
        -   <b style="color:#9370DB">.add_prefix(self, field_name)</b>
        -   <b style="color:#9370DB">.add_initial_prefix(self, field_name)</b>
        -   <b style="color:#9370DB">.\_html_output(self, normal_row, error_row, row_ender, help_text_html, errors_on_separate_row)</b>
        -   <b style="color:#9370DB">.as_table(self)</b>
        -   <b style="color:#9370DB">.as_ul(self)</b>
        -   <b style="color:#9370DB">.as_p(self)</b>
        -   <b style="color:#9370DB">.non_field_errors(self)</b>
        -   <b style="color:#9370DB">.add_error(self, field, error)</b>
        -   <b style="color:#9370DB">.has_error(self, field, code=None)</b>
        -   <b style="color:#9370DB">.full_clean(self)</b>
        -   <b style="color:#9370DB">.\_clean_fields(self)</b>
        -   <b style="color:#9370DB">.\_clean_form(self)</b>
        -   <b style="color:#9370DB">.\_post_clean(self)</b>
        -   <b style="color:#9370DB">.clean(self)</b>
        -   <b style="color:#9370DB">.has_changed(self)</b>
        -   <b style="color:#9370DB">.changed_data(self)</b>
        -   <b style="color:#9370DB">.media(self)</b>
        -   <b style="color:#9370DB">.is_multipart(self)</b>
        -   <b style="color:#9370DB">.hidden_fields(self)</b>
        -   <b style="color:#9370DB">.visible_fields(self)</b>
        -   <b style="color:#9370DB">.get_initial_for_field(self, field, field_name)</b>
    -   <b style="color:#C71585">Form(BaseForm, metaclass=DeclarativeFieldsMetaclass)</b>:

    -   <b style="color:#C71585">BaseModelForm(BaseForm)</b>:
        -   <b style="color:#9370DB">.\_\_init\_\_(self, ...)</b>
        -   <b style="color:#9370DB">.\_get_validation_exclusions(self)</b>
        -   <b style="color:#9370DB">.clean(self)</b>
        -   <b style="color:#9370DB">.\_update_errors(self, errors)</b>
        -   <b style="color:#9370DB">.\_post_clean(self)</b>
        -   <b style="color:#9370DB">.validate_unique(self)</b>
        -   <b style="color:#9370DB">.\_save_m2m(self)</b>
        -   <b style="color:#9370DB">.save(self, commit=True)</b>
    -   <b style="color:#C71585">ModelForm(BaseModelForm, metaclass=ModelFormMetaclass)</b>:

    -   <b style="color:#C71585">modelform_factory(model, form=ModelForm, fields=None, exclude=None, formfield_callback=None, widgets=None, localized_fields=None, labels=None, help_texts=None, error_messages=None, field_classes=None)</b>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Some Built-in Apps in Django</summary>

    #### django.contrib.contenttypes:

    The `django.contrib.contenttypes` is a built-in application that provides a framework for creating, storing, and managing generic relationships between Django models. It allows you to create relationships between any two models without having to modify the models themselves. This is particularly useful when you have models that need to be related to multiple other models in a generic way, such as a tagging system, a commenting system, or a user-generated content system.

    -   **ContentType Model**:
        -   The ContentType model provided by `django.contrib.contenttypes` represents a content type - essentially, a Django model.
        -   This model is used to track the models (or content types) available in your Django project.
        -   It stores information such as the app label and model name for each registered model.
        -   You can access the ContentType model via `django.contrib.contenttypes.models.ContentType`.

    #### django.contrib.admin:

    -   [django-admin and manage.py](https://docs.djangoproject.com/en/4.0/ref/django-admin/#django-admin-createsuperuser)

    The Django Admin panel (madularized into `django.contrib.admin`) is a built-in feature of the Django web framework that provides a user-friendly interface for managing the administrative tasks of a Django project. It is a powerful tool that allows developers, administrators, and authorized users to perform various administrative operations without having to write custom views or templates.

    `django.contrib.admin` is included in the Django core and is available by default in every Django project. It is designed to simplify the process of creating and managing database content for non-technical users, allowing them to focus on managing content rather than dealing with the underlying database and code.

    The Django Admin panel offers the following features:

    -   `User Authentication`: The Admin panel provides a secure authentication system for administrators. It supports user registration, login, and password management.
    -   `CRUD Operations`: It allows administrators to perform Create, Read, Update, and Delete (CRUD) operations on the database records. Administrators can add, edit, and delete records directly from the Admin interface.
    -   `Automatic Interface Generation`: The Admin panel automatically generates the user interface based on the registered models in your Django project. It creates a customizable interface for each model, displaying fields, relationships, and actions associated with the model.
    -   `Filtering and Searching`: Administrators can filter and search records based on specific criteria. The Admin panel provides filter options for each field in a model, allowing administrators to narrow down the displayed records.
    -   `Permission Management`: Django Admin allows fine-grained control over user permissions and access rights. Administrators can define different user roles and assign specific permissions to each role, determining what operations users can perform in the Admin panel.
    -   `Customization`: The admin application is highly configurable and can be customized using Python code or templates to change the look and feel of the interface or to add custom functionality. Developers can define custom views, templates, forms, and widgets to extend the admin application's functionality.

    The Django Admin panel is automatically enabled when you create a Django project. By registering your models with the Admin panel, you can easily manage and interact with your project's data through a user-friendly interface. It is particularly useful for managing content, performing administrative tasks, and quickly prototyping functionality during the development process.

    #### django.contrib.auth:

    #### django.contrib.sessions:

    #### django.contrib.messages:

    In the context of the Django framework, the term "message" typically refers to the messages framework, which is a part of Django's contrib packages. The messages framework allows you to store simple messages in one request and retrieve them for display in a subsequent request. This is particularly useful for displaying notifications or feedback to users after they perform certain actions on a website. Here are the key components and concepts related to the Django messages framework:

    -   `Usage Scenario`: The messages framework is commonly used to display feedback messages to users after they submit forms, perform actions, or encounter errors on a website.

    -   `Adding Messages`:

        -   You can add messages to the message framework using the messages module provided by Django.
        -   Typically, you add messages in your views after certain actions are performed, such as form submissions, login attempts, or when errors occur.
        -   Messages are added to the user's session and are only displayed once on the next page load.

    -   `Message Levels`: Messages are classified into different levels based on their importance or nature. The available message levels in Django are: **DEBUG**, **INFO**, **SUCCESS**, **WARNING**, **ERROR**.

    -   `Message Storage Backend`:

        -   By default, Django stores messages in the user's session using the session framework.
        -   You can customize the message storage backend by implementing your own message storage backend class if you need to store messages differently, such as in a database or cache.

    -   `Message Middleware`:

        -   Django includes built-in middleware (django.contrib.messages.middleware.MessageMiddleware) that automatically adds a messages attribute to each request, containing the user's messages.
        -   This middleware is responsible for fetching messages from the session and making them available to your views and templates.

    -   `Displaying Messages`:

        -   Messages added to the message framework are typically displayed in templates using template tags provided by Django.
        -   The most common way to display messages is by iterating over them in your template and rendering them as HTML elements, such as divs or alerts.
        -   Django provides template tags like `{% if messages %}` and `{% for message in messages %}` to help you display messages in your templates.

        ```py
        # views.py
        from django.contrib import messages
        from django.shortcuts import render, redirect

        def my_view(request):
            if request.method == 'POST':
                # Process form data
                # Add success message
                messages.success(request, 'Form submitted successfully!')
                return redirect('success_page')
            return render(request, 'my_template.html')
        ```

        ```html
        <!-- my_template.html  -->
        {% if messages %}
        <ul class="messages">
            {% for message in messages %}
            <li class="{{ message.tags }}">{{ message }}</li>
            {% endfor %}
        </ul>
        {% endif %}
        ```

        -   When the form is successfully submitted, a success message is added to the message framework using messages.success(). Then, in the template, messages are iterated over and displayed using HTML elements. The specific CSS classes applied to each message will depend on its level (success, warning, error, etc.).

    -   `Clearing Messages`: Messages can be automatically cleared from the storage after being displayed. This prevents messages from persisting across multiple requests. The default behavior is to clear messages after rendering them in the template. Here's a basic example of how messages are used in a Django view:

    #### django.contrib.staticfiles:

    `django.contrib.staticfiles` is a built-in Django app that simplifies the management of static files (such as CSS, JavaScript, images, etc.) in a web project.

    1. **Static Files**: These are non-Python files, like CSS, JS, and images, that do not change dynamically and are typically served directly to clients (e.g., web browsers).

        - **Centralized Management**: It allows developers to gather all static files from different parts of the project (apps, third-party libraries) into a single location for easier deployment and management.
        - **Development vs. Production**: During development, static files can be served easily using the Django development server. In production, Django provides tools to collect these files into a single directory, which can then be served by a web server like Nginx or Apache.

    2. **Configuration**: In the `settings.py` file, you typically define a few settings related to static files:

        - `STATIC_URL`: The URL endpoint for static files (e.g., `/static/`).
        - `STATICFILES_DIRS`: A list of directories where Django will search for additional static files (besides the default app directories).
        - `STATIC_ROOT`: The directory where Django will collect all static files when you run the `collectstatic` command (used in production).

    3. **How It Works**:

        - **In Development**: When using Django’s development server (`python manage.py runserver`), static files are served automatically as long as `django.contrib.staticfiles` is enabled in `INSTALLED_APPS`.
        - **In Production**: You can run `python manage.py collectstatic`, which collects all the static files from your app directories and any directories specified in `STATICFILES_DIRS` into the `STATIC_ROOT` directory. From there, a web server can serve them.

    4. **Static Files Tag**: In Django templates, you can reference static files using the `{% static %}` template tag. For example:
        ```html
        <link rel="stylesheet" href="{% static 'css/style.css' %}" />
        ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Object Relational Mapper (ORM)</summary>

    -   [Django Documentations: QuerySet API](https://docs.djangoproject.com/en/4.2/ref/models/querysets/#queryset-api-reference)
    -   [Django Documentations: Making queries](https://docs.djangoproject.com/en/4.2/topics/db/queries/#lookups-that-span-relationships)
    -   [When QuerySets are evaluated](https://docs.djangoproject.com/en/4.2/ref/models/querysets/#when-querysets-are-evaluated)
    -   [Django ORM Cookbook](https://books.agiliq.com/projects/django-orm-cookbook/en/latest/)

    > Django ORM is a component of the Django web framework that provides a high-level, Pythonic way to interact with databases. It allows developers to work with databases using Python objects and methods, rather than writing raw SQL queries.

    > The Django ORM abstracts away the underlying database and provides a consistent API for performing common database operations, such as creating, retrieving, updating, and deleting records. It simplifies the process of working with databases and helps ensure the security and integrity of data. The main components of Django ORM include:

    > Querying Django models is all about mastering the **QuerySet API**. Django uses a "lazy" evaluation system, meaning it doesn't actually hit the database until you try to use the results (like looping over them or printing them). Here is a breakdown of techniques from basic to advanced.


    -   **Check what sql query gets generated after each ORM query**

        -   `$ python manage.py shell`
            ```python
            >>> from django.db import connection, reset_queries
            >>> from book.models import Book
            >>> reset_queries()
            >>> Book.objects.create(title="DSA", author="Walter Marks")
            >>> connection.queries
            ```

            -   `Complex Query`:

                ```sql
                SELECT department, COUNT(*) AS num_employees, AVG(salary) AS avg_salary
                FROM Employee
                WHERE joining_date BETWEEN '2023-01-01' AND '2023-12-31'
                    AND department IN ('HR', 'IT', 'Finance')
                GROUP BY department
                HAVING AVG(salary) > 60000
                ORDER BY avg_salary DESC
                LIMIT 5;
                ```

        ```python
        from django.db.models import Count, Avg

        # Method chained QuerySet equivalent of the SQL statement above
        result = Employee.objects.filter(
            joining_date__range=['2023-01-01', '2023-12-31'],
            department__in=['HR', 'IT', 'Finance']
        ).values('department').annotate(
            num_employees=Count('*'),
            avg_salary=Avg('salary')
        ).filter(
            avg_salary__gt=60000
        ).order_by(
            '-avg_salary'
        )[:5]
        ```


    -   <details><summary style="font-size:20px;color:Red">Terms & Concepts</summary>

        -   **Models**: Models are Python classes that represent database tables. Each model class corresponds to a table in the database, and each attribute of the model class represents a column in the table. Models define the structure of the data and provide methods for interacting with the database.
        -   **Fields**: Fields are the attributes of a model class that define the type and characteristics of the data stored in the corresponding database columns. Django provides a variety of built-in field types (e.g., CharField, IntegerField, DateField) for different data types and validation requirements.
        -   **QuerySet**: a QuerySet object is essentially a container that holds the results of a database query. It represents a list of objects retrieved from the database based on a specific query. It provides intuitive APIs to filter, update, delete, and perform other operations on database records.
        -   **Manager**: Manager is an interface through which you interact with the database using QuerySets. Each model class has a default manager that provides methods for performing database operations. You can also define custom managers to encapsulate common query logic or filter methods.
        -   **Database Migration**: Database migration is the process of synchronizing changes in model definitions (e.g., adding new fields, renaming tables) with the underlying database schema. Django provides a built-in migration system (using manage.py commands) to automate the generation and execution of database migration scripts.
        -   **Database Backend**: Database backend is the component responsible for communicating with the database. Django supports multiple database backends (e.g., PostgreSQL, MySQL, SQLite) and provides an abstraction layer that allows you to write database-agnostic code.
        -   **Manager()** vs **QuerySet()**: In Django, both Manager and QuerySet are integral parts of the Object-Relational Mapping (ORM) system, which allows you to interact with your database using Python objects instead of writing raw SQL queries. However, they serve different purposes within the Django ORM.

            -   [`Manager()`](https://docs.djangoproject.com/en/4.0/topics/db/managers/): A Manager is an interface through which database queries are executed. It's like a higher-level API that provides methods for creating, retrieving, updating, and deleting objects in the database. By default, every Django model has a default manager accessable through **.objects** (e.g., **Book.object**) attribute. You can also define your own custom managers to add specific methods or query functionality to your models.

                -   For example, you might create a custom manager to encapsulate common queries that you frequently use with a specific model. This allows you to encapsulate logic and reusability within the manager's methods.

                ```python
                from django.db import models

                class CustomManager(models.Manager):
                    def get_published(self):
                        return self.filter(published=True)

                class Post(models.Model):
                    title = models.CharField(max_length=100)
                    content = models.TextField()
                    published = models.BooleanField(default=False)

                    objects = CustomManager()  # Using the custom manager
                ```

                -   In the above example, the `CustomManager` class defines a method `get_published()` which returns published posts. The objects attribute is assigned an instance of `CustomManager`, making the method accessible as a query method on the model.

            -   [`QuerySet`](https://docs.djangoproject.com/en/4.1/ref/models/querysets/): A QuerySet is a representation of a database query. When you perform a query using a Manager method, it returns a QuerySet object. A QuerySet allows you to chain methods together to build complex queries. It is lazy-evaluated, meaning that the actual database query is executed only when the results are needed, typically when you iterate over the QuerySet or retrieve data from it.

                ```python
                published_posts = Post.objects.get_published()
                filtered_posts = published_posts.filter(title__icontains='Django')
                ```

                -   In the above example, `get_published()` returns a QuerySet of published posts, and then the `filter()` method is chained to further narrow down the selection to posts with titles containing "Django".
                -   In summary, Manager is responsible for defining query methods on a model, while QuerySet is the representation of the actual query and allows you to chain methods to build and refine queries. They work together to provide a powerful way to interact with your database using Python code.

            -   **model.Manager.create()** and **model.Model.save()**

                -   [Django ORM - Difference between save() and create()](https://www.youtube.com/watch?v=Q7HlaH3a_zc&list=PLOLrQ9Pn6cayYycbeBdxHUFrzTqrNE7Pe&index=24)

                -   `model.Manager.create(**kwargs)`: The `create()` method is a convenient way to create a new instance of a model and save it to the database in a single step. It's available on the model's default manager (usually named objects). Automatically creates and saves the object in a single call.

                    -   Limited flexibility compared to `save()`. You can't modify the instance after it's created before saving.
                    -   Does not allow easy handling of exceptions during creation and saving separately.

                    ```python
                    # Using create() to create and save a new instance
                    new_person = Person.objects.create(first_name='John', last_name='Doe')
                    ```

                -   `model.Model.save()`: The `save()` method is used on an instance of a model to save changes to the database. It's available on any instance of a model. Offers more flexibility as you can modify the instance's attributes before saving. Allows you to handle exceptions more granularly (e.g., you can catch specific database-related exceptions).

                    ```python
                    # Creating an instance and saving it separately using save()
                    new_person = Person(first_name='John', last_name='Doe')
                    new_person.save()
                    ```

                    ```python
                    # Modifying an instance and then saving it using save()
                    person = Person.objects.get(pk=1)
                    person.first_name = 'Jane'
                    person.save()
                    ```

        </details>

    -   <details><summary style="font-size:20px;color:Red">Field Lookups (Magic Double Underscores)</summary>

        > In the Django ORM, the "Magic Double Underscore" (`__`) is the syntax used to navigate **relationships** (joins) and apply **field lookups** (filters). It is the bridge between Pythonic attribute access and SQL clauses. Think of the double underscore as a "separator" that tells Django to dig deeper into a model's connections or to apply a specific operator to a field.

        1. **Field Lookups (The "How")**: By default, `filter(name="Alex")` performs an exact match (`=`). Double underscores allow you to use different SQL operators like `LIKE`, `IN`, `BETWEEN`, or `IS NULL`.

            | Lookup           | SQL Equivalent  | Usage                                                                |
            | :--------------- | :-------------- | :------------------------------------------------------------------- |
            | `__exact`        | `=`             | `User.objects.filter(name__exact="Alex")`                            |
            | `__icontains`    | `ILIKE '%val%'` | `Product.objects.filter(name__icontains="phone")` (Case-insensitive) |
            | `__gt` / `__gte` | `>` / `>=`      | `Order.objects.filter(price__gt=100)`                                |
            | `__in`           | `IN (...)`      | `Post.objects.filter(id__in=[1, 2, 3])`                              |
            | `__isnull`       | `IS NULL`       | `Profile.objects.filter(bio__isnull=True)`                           |
            | `__range`        | `BETWEEN`       | `Event.objects.filter(date__range=(start, end))`                     |

            -   **Django Lookup Operators**:  **Lookup Operators** are the specific keywords used in a `.filter()`, `.exclude()`, or `.get()` call to define **how** a database query should match a value. They are always used with the "Magic Double Underscore" (`__`) syntax: `field__lookuptype=value`.

                1. **Core Comparison Operators**: These are the most common operators used for numbers, dates, and basic string matching.

                    | Operator   | SQL Equivalent   | Description                                          |
                    | :--------- | :--------------- | :--------------------------------------------------- |
                    | `__exact`  | `=`              | An exact match (Default if no operator is provided). |
                    | `__iexact` | `ILIKE` (approx) | A case-insensitive exact match.                      |
                    | `__gt`     | `>`              | Greater than.                                        |
                    | `__gte`    | `>=`             | Greater than or equal to.                            |
                    | `__lt`     | `<`              | Less than.                                           |
                    | `__lte`    | `<=`             | Less than or equal to.                               |

                    **Example:**
                    ```python
                    # SQL: SELECT ... WHERE price > 50;
                    Product.objects.filter(price__gt=50)
                    ```
                2. **String Pattern Matching**: These operators allow you to search for partial strings within a text field.

                   * **`__contains`**: Case-sensitive containment test (SQL: `LIKE '%value%'`).
                   * **`__icontains`**: Case-insensitive version (SQL: `ILIKE '%value%'`).
                   * **`__startswith` / `__istartswith`**: Matches the beginning of a string.
                   * **`__endswith` / `__iendswith`**: Matches the end of a string.


                3. **List and Range Operators**: These are used when you want to check a field against a set of multiple values.

                   * **`__in`**: Checks if the field value exists within a provided list, tuple, or even another QuerySet.
                       * `User.objects.filter(id__in=[1, 5, 10])`
                   * **`__range`**: An inclusive "between" check, usually for dates or prices.
                       * `Order.objects.filter(created_at__range=(start_date, end_date))`
                   * **`__isnull`**: Takes a boolean (`True` or `False`) to check for `NULL` values in the database.
                       * `Profile.objects.filter(bio__isnull=True)`
                4. **Date and Time Specific Lookups**: Django allows you to "extract" parts of a date field to filter by specific time units.

                    -   **`__year`**, **`__month`**, **`__day`**: Filters by the specific calendar unit.
                    -   **`__week_day`**: Filters by the day of the week (1=Sunday, 7=Saturday).
                    -   **`__time`**: Casts a DateTime to a Time object for comparison.

                    ```python
                    # Get all users who joined in the month of December
                    User.objects.filter(date_joined__month=12)
                    ```

                5. **Relationship (Joined) Lookups**: The double underscore is also used to "span" across tables. You can use any of the operators above on a related model.

                    ```python
                    # Filter Books by the Author's name using icontains
                    Book.objects.filter(author__name__icontains="Hemingway")
                    ```

                -   **Summary Table**: 

                    | Goal                   | Operator Example               |
                    | :--------------------- | :----------------------------- |
                    | **Search text**        | `name__icontains="clinton"`    |
                    | **Check multiple IDs** | `id__in=[10, 20, 30]`          |
                    | **Filter by Date**     | `created_at__year=2026`        |
                    | **Check existence**    | `deleted_at__isnull=False`     |
                    | **Find price range**   | `price__gte=10, price__lte=50` |

        2. **Navigating Relationships (Spanning Joins)**: This is where the "magic" really happens. You use `__` to filter a model based on fields in a **related** model (ForeignKey, OneToOne, or ManyToMany).

            -   **Finding Books by a Specific Author**: If a `Book` has a ForeignKey to `Author`:
                ```python
                # Find all books where the author's name contains "Rowling"
                books = Book.objects.filter(author__name__icontains="Rowling")
                ```
                -   **Translation:** Django joins the `Book` and `Author` tables in SQL and filters by the `name` column in the `Author` table.

                ```sql
                SELECT "book"."id", "book"."title", "book"."author_id"
                FROM "book"
                INNER JOIN "author" ON ("book"."author_id" = "author"."id")
                WHERE "author"."name" ILIKE '%Rowling%';
                ```

            -   **Deep Nesting**: You can chain these indefinitely:
                ```python
                # Find comments on posts written by authors in the "Engineering" department
                comments = Comment.objects.filter(post__author__department__name="Engineering")
                ```

                ```sql
                SELECT "comment"."id", "comment"."text", "comment"."post_id"
                FROM "comment"
                INNER JOIN "post" ON ("comment"."post_id" = "post"."id")
                INNER JOIN "author" ON ("post"."author_id" = "author"."id")
                INNER JOIN "department" ON ("author"."department_id" = "department"."id")
                WHERE "department"."name" = 'Engineering';
                ```

           -    **Performance Warning: The "Hidden Join"**: Every time you use `__` to cross a relationship in a filter, Django performs a SQL `JOIN`.
               -   **The Risk:** Filtering through multiple `ManyToMany` relationships with `__` can lead to massive, slow queries.
               -   **The Fix:** Use `.select_related()` or `.prefetch_related()` if you plan to *access* those fields later, to avoid the N+1 problem.

        3. **Date and Time Extraction**: The double underscore allows you to "reach inside" a DateTime field to filter by specific parts of the date.

            ```python
            # Get all orders placed in the year 2024
            Order.objects.filter(created_at__year=2024)

            # Get all signups that happened on a Monday (2)
            User.objects.filter(date_joined__week_day=2)
            ```

        4. **When to use Double Underscores vs. Attributes**: A common point of confusion is when to use `.` (dot) vs `__` (double underscore).

            * **Use `__` in Querysets:** Inside `.filter()`, `.exclude()`, `.order_by()`, or `.values()`. This happens at the **Database level**.
            * **Use `.` on Instances:** When you already have a Python object in memory and want to access a property. This happens at the **Python level**.

            ```python
            # DB Level (Using __)
            user = User.objects.get(profile__city="New York")

            # Python Level (Using .)
            print(user.profile.city)
            ```

        </details>

    -   <details><summary style="font-size:20px;color:Red">Advanced Logic with Q and F Objects</summary>

        > Standard filters use `AND` logic. For more complex queries, use `Q` for boolean combinators and `F` for field-to-field operations.

        -   **`Q` Objects:** Used to express complex lookups with **OR**, **AND**, and **NOT** in a single query. Also supports nested conditions and parentheses via Python operators `|`, `&`, and `~`.

            ```python
            from django.db.models import Q

            # Name is 'Alice' OR 'Bob'
            User.objects.filter(Q(name='Alice') | Q(name='Bob'))
            ```

            ```sql
            SELECT "user"."id", "user"."name" FROM "user"
            WHERE ("user"."name" = 'Alice' OR "user"."name" = 'Bob');
            ```

            ```python
            # Users created in 2024 OR with is_staff flag
            User.objects.filter(Q(date_joined__year=2024) | Q(is_staff=True))
            ```

            ```sql
            SELECT "user"."id", "user"."name" FROM "user"
            WHERE (EXTRACT(YEAR FROM "user"."date_joined") = 2024 OR "user"."is_staff" = true);
            ```

            ```python
            # Exclude inactive users OR blocked users: NOT of Q
            User.objects.filter(~Q(is_active=False) & ~Q(is_blocked=True))
            ```

            ```sql
            SELECT "user"."id", "user"."name" FROM "user"
            WHERE (NOT ("user"."is_active" = false) AND NOT ("user"."is_blocked" = true));
            ```

            ```python
            # Nested logic:
            Purchase.objects.filter(
                Q(user__group='premium') &
                (Q(total__gt=500) | Q(status='complete'))
            )
            ```

            ```sql
            SELECT "purchase"."id", "purchase"."total" FROM "purchase"
            INNER JOIN "user" ON ("purchase"."user_id" = "user"."id")
            WHERE ("user"."group" = 'premium' AND ("purchase"."total" > 500 OR "purchase"."status" = 'complete'));
            ```

        -   **`F` Objects:** Enables performing operations where one field is compared or combined with another field **at the database level**. Useful for avoiding extra round-trips and keeping logic in SQL.

            ```python
            from django.db.models import F

            # Find products where stock is less than the minimum required
            Product.objects.filter(stock__lt=F('min_stock'))
            ```

            ```sql
            SELECT "product"."id", "product"."name" FROM "product"
            WHERE "product"."stock" < "product"."min_stock";
            ```

            ```python
            # Increase price by 10% in a query
            Product.objects.update(price=F('price') * 1.1)
            ```

            ```sql
            UPDATE "product" SET "price" = "product"."price" * 1.1;
            ```

            ```python
            # Avoid race conditions with atomic updates
            from django.db import transaction
            with transaction.atomic():
                Inventory.objects.filter(id=item_id).update(quantity=F('quantity') - 1)
            ```

            ```sql
            UPDATE "inventory" SET "quantity" = "inventory"."quantity" - 1
            WHERE "inventory"."id" = %s;
            ```

            - Comparing fields across relations
                ```python
                # Publishers where total revenue > budget (assuming fields exist on Publisher)
                Publisher.objects.filter(total_revenue__gt=F('budget'))
                ```

                ```sql
                SELECT "publisher"."id", "publisher"."name" FROM "publisher"
                WHERE "publisher"."total_revenue" > "publisher"."budget";
                ```

            - Cross-model comparison example (book price > author average price)
                ```python
                # Annotate author average book price, then filter books above that average
                from django.db.models import Avg

                authors = Author.objects.annotate(avg_book_price=Avg('books__price'))
                books = Book.objects.filter(price__gt=F('author__avg_book_price')).select_related('author')
                ```

                ```sql
                SELECT "book"."id", "book"."title", "book"."price", "book"."author_id"
                FROM "book"
                INNER JOIN "author" ON ("book"."author_id" = "author"."id")
                INNER JOIN (
                    SELECT "author"."id" AS "author_id", AVG("book"."price") AS "avg_book_price"
                    FROM "author"
                    LEFT OUTER JOIN "book" ON ("author"."id" = "book"."author_id")
                    GROUP BY "author"."id"
                ) AS "author_avg" ON ("author"."id" = "author_avg"."author_id")
                WHERE "book"."price" > "author_avg"."avg_book_price";
                ```

        -   **Combining `Q` and `F` Objects**: Use together for powerful SQL expressions.

            ```python
            from django.db.models import Q, F

            Product.objects.filter(
                Q(sale_price__isnull=True) | Q(sale_price__gt=F('cost_price'))
            )
            ```

            ```sql
            SELECT "product"."id", "product"."name" FROM "product"
            WHERE ("product"."sale_price" IS NULL OR "product"."sale_price" > "product"."cost_price");
            ```

        -   **Best practices**:
            - Use `Q` for dynamic query building and condition branches.
            - Avoid overcomplicating queries with excessive nested Q expressions; extract predicates to functions or variables.
            - Use `F` for atomic updates and to prevent inconsistent reads between Python and DB.
            - Use `.annotate()` with `F` expressions when you need computed results in the same QuerySet.

        -   **Troubleshooting**:
            - `Q` in `exclude()` is common pattern: `Model.objects.exclude(Q(field1='x') | Q(field2='y'))`.
            - `F` cannot be used in `.values()` directly in older Django versions; use `annotate()` first.
            - Beware of `F` with Tentative arithmetic on nullable fields; null behavior follows database semantics.

        </details>

    -   <details><summary style="font-size:20px;color:Red">Aggregation and Annotation</summary>


        -   **`aggregate()`**: Returns a dictionary of summary values (e.g., Average price of all books).
        -   **`annotate()`**: Adds a "virtual" field to every item in a QuerySet (e.g., Each author object gets a `book_count` field).

        ```python
        from django.db.models import Count, Avg
        # Get average price
        avg_price = Book.objects.aggregate(Avg('price'))

        # Count books per author
        authors = Author.objects.annotate(num_books=Count('book'))
        print(authors[0].num_books)
        ```

        </details>

    -   <details><summary style="font-size:20px;color:Red">N+1 Problem Explained</summary>

        > The **N+1 problem** is one of the most common performance killers in database-driven applications, including those built with Django and GraphQL. It occurs when your code executes one query to fetch a list of parent records, and then executes **additional** queries for every single child record in that list. If you have **N** items in your list, you end up making **N + 1** total calls to the database.

        1. **How the Problem Happens**:

            1.  **The "1" Query:** `SELECT * FROM books LIMIT 10;`
                -   *The database returns 10 books.*
            2.  **The "N" Queries:** For each post, your code looks for the author:
                -   Post 1: `SELECT * FROM authors WHERE id = 1;`
                -   Post 2: `SELECT * FROM authors WHERE id = 2;`
                -   ... (this continues 8 more times)
                -   Post 10: `SELECT * FROM authors WHERE id = 5;`

                > **Total Hits: 11 Database Queries.** If you were showing 100 books, you’d hit the database 101 times. This creates massive latency and can crash a database under high traffic.


        2. **How to Fix It**: There are two primary ways to solve this, depending on the relationship type:

            -   **JOINing (Django's `select_related`)**: For **One-to-One** or **Many-to-One** relationships, you can use a SQL JOIN to get everything in exactly **one** query.
                -   **SQL:** `SELECT * FROM books JOIN authors ON books.author_id = authors.id;`

            -   **Batching (Django's `prefetch_related` / DataLoaders)**: For **Many-to-Many** or **One-to-Many** relationships, you fetch the parents, collect all the child IDs, and fetch the children in one bulk "IN" query.
                -   **Step 1:** `SELECT * FROM books;`
                -   **Step 2:** `SELECT * FROM authors WHERE id IN (1, 2, 5, ...);`

        </details>

    -   <details><summary style="font-size:20px;color:Red">Useful ORM Methods</summary>

        -   `all()`: Returns all objects of the model.

            ```python
            all_objects = MyModel.objects.all()
            ```

        -   `filter()`: Returns a queryset of objects that match the given lookup parameters.

            ```python
            filtered_objects = MyModel.objects.filter(name="John")
            ```

            -   `$ Book.objects.filter(author__name="Jhon")`
            -   `$ Book.objects.filter(Q(authon__name="Jhon"))`
            -   `$ `

        -   `exclude()`: Returns a queryset excluding the objects that match the given lookup parameters.

            ```python
            excluded_objects = MyModel.objects.exclude(name="John")
            ```

        -   `get()`: Returns a single object that matches the given lookup parameters. Raises an error if multiple objects are found.

            ```python
            single_object = MyModel.objects.get(id=1)
            ```

        -   `create()`: Creates a new object with the given parameters and saves it to the database.

            ```python
            new_object = MyModel.objects.create(name="Jane", age=25)
            ```

        -   `update()`: Updates the objects that match the given lookup parameters with the new values.

            ```python
            MyModel.objects.filter(name="John").update(age=30)
            ```

        -   `delete()`: Deletes the objects that match the given lookup parameters.

            ```python
            MyModel.objects.filter(name="John").delete()
            ```

        -   `order_by()`: Orders the queryset by the specified field(s).

            ```python
            ordered_objects = MyModel.objects.all().order_by('-created_at') # Leading `-` indicates to order in reverse order
            ```

        -   `values()`: Returns a queryset that returns dictionaries instead of model instances.

            ```python
            data = MyModel.objects.values('name', 'age')
            ```

        -   `annotate()`: Adds annotations to each object in the queryset.

            ```python
            from django.db.models import Count
            annotated_objects = MyModel.objects.annotate(num_children=Count('children'))
            ```

        -   `distinct()`: Returns a queryset with duplicate results removed.

            ```python
            unique_objects = MyModel.objects.values('name').distinct()
            ```

        -   `count()`: Returns the number of objects in the queryset.

            ```python
            num_objects = MyModel.objects.count()
            ```

        -   `exists()`: Returns True if the queryset contains any results, False otherwise.

            ```python
            has_objects = MyModel.objects.filter(name="John").exists()
            ```

        -   `first()`: Returns the first object in the queryset, or None if the queryset is empty.

            ```python
            first_object = MyModel.objects.first()
            ```

        -   `last()`: Returns the last object in the queryset, or None if the queryset is empty.

            ```python
            last_object = MyModel.objects.last()
            ```

        -   `values_list()`: Returns a queryset that returns tuples instead of model instances.

            ```python
            data_tuples = MyModel.objects.values_list('name', 'age')
            ```

        -   `bulk_create()`: Creates multiple objects in a single database query.

            ```python
            MyModel.objects.bulk_create([MyModel(name='John'), MyModel(name='Jane')])
            ```

        -   `defer()`: Defers the loading of certain fields until they are accessed.

            ```python
            deferred_fields = MyModel.objects.defer('large_text_field')
            ```

        </details>

    -   <details><summary style="font-size:20px;color:Red">Multi-level nested forward and reverse query with Prefetch</summary>

        ```python
        class Publisher(models.Model):
            name = models.CharField(max_length=100)
            total_revenue = models.DecimalField(max_digits=10, decimal_places=2, default=0)
            budget = models.DecimalField(max_digits=10, decimal_places=2, default=0)

        class Author(models.Model):
            name = models.CharField(max_length=100)
            is_active = models.BooleanField(default=True)
            publisher = models.ForeignKey(Publisher, on_delete=models.CASCADE, related_name="authors")

        class Book(models.Model):
            title = models.CharField(max_length=100)
            release_year = models.IntegerField()
            price = models.DecimalField(max_digits=6, decimal_places=2, default=0)
            rating = models.FloatField(default=0)
            genre = models.CharField(max_length=50, default='Fiction')
            author = models.ForeignKey(Author, on_delete=models.CASCADE, related_name="books")
        ```

        -   **Multi-level Reverse Query (One → Many → Many)**: If you start at the **Publisher** and want to fetch all their **Authors**, and for each author, all their **Books**, you are moving "down" the relationship chain.

            -   **The Inefficient Way (N+1 x N+1)**:
                ```python
                publishers = Publisher.objects.all()
                for p in publishers:
                    for a in p.authors.all(): # Since each Publisher may have many Author: Hits DB for each publisher
                        for b in a.books.all(): # Since each Author may have many Book: Hits DB for each author
                            print(b.title)
                ```

            -   **The Optimized Way with `Prefetch`**: To nest prefetches, you use the **double-underscore** (`__`) syntax inside the `prefetch_related` call.

                ```python
                from django.db.models import Prefetch

                # Fetch Publishers + Authors + Books in exactly 3 queries
                publishers = Publisher.objects.prefetch_related('authors__books' ).all()
                ```

        -   **Multi-level Forward Query (One → One → One)**: If you start at the **Book** and want to fetch its **Author** and that author's **Publisher**, you are moving "up" the chain. Since these are single-value relationships (one book has one author), we use `select_related` for better performance.

            ```python
            # Fetches everything in 1 single SQL JOIN
            books = Book.objects.select_related('author__publisher').all()

            for b in books:
                print(f"{b.title} by {b.author.name} published by {b.author.publisher.name}")
            ```

        -   **Complex Nested Prefetching (The Pro Level)**: Sometimes you need to apply filters or ordering to the nested data. This requires the `Prefetch` object nested inside another `Prefetch` object.

            **Goal:** Fetch all Publishers, but only their "Active" Authors, and only "Recent" Books for those authors.

            ```python
            recent_books = Book.objects.filter(release_year__gt=2024)
            active_authors = Author.objects.filter(is_active=True).prefetch_related(
                Prefetch('books', queryset=recent_books)
            )

            # Deeply nested prefetch
            publishers = Publisher.objects.prefetch_related(
                Prefetch('authors', queryset=active_authors)
            ).all()
            ```

        -   **Advanced Nested select_related with Annotations**: Combine select_related with annotations for computed fields across relations.

            ```python
            from django.db.models import Count, Avg

            # Fetch books with author and publisher, plus author's book count
            books = Book.objects.select_related('author__publisher').annotate(
                author_book_count=Count('author__books')
            ).all()

            for book in books:
                print(f"{book.title} by {book.author.name} ({book.author_book_count} books) from {book.author.publisher.name}")
            ```

            ```sql
            SELECT "book"."id", "book"."title", "book"."author_id",
                   "author"."id", "author"."name", "author"."publisher_id",
                   "publisher"."id", "publisher"."name",
                   COUNT("author_books"."id") AS "author_book_count"
            FROM "book"
            INNER JOIN "author" ON ("book"."author_id" = "author"."id")
            INNER JOIN "publisher" ON ("author"."publisher_id" = "publisher"."id")
            LEFT OUTER JOIN "book" AS "author_books" ON ("author"."id" = "author_books"."author_id")
            GROUP BY "book"."id", "author"."id", "publisher"."id";
            ```

        -   **Complex Prefetch with Multiple Levels and Ordering**: Prefetch authors with their top-rated books, ordered by rating.

            ```python
            from django.db.models import Prefetch

            # Prefetch authors with their books ordered by release_year descending
            publishers = Publisher.objects.prefetch_related(
                Prefetch('authors', queryset=Author.objects.prefetch_related(
                    Prefetch('books', queryset=Book.objects.order_by('-release_year'))
                ))
            ).all()

            for publisher in publishers:
                for author in publisher.authors.all():
                    print(f"Author: {author.name}")
                    for book in author.books.all():
                        print(f"  Book: {book.title} ({book.release_year})")
            ```

            ```sql
            -- Query 1: Publishers
            SELECT "publisher"."id", "publisher"."name" FROM "publisher";

            -- Query 2: Authors for those publishers
            SELECT "author"."id", "author"."name", "author"."publisher_id"
            FROM "author"
            WHERE "author"."publisher_id" IN (...);

            -- Query 3: Books for those authors, ordered by release_year DESC
            SELECT "book"."id", "book"."title", "book"."release_year", "book"."author_id"
            FROM "book"
            WHERE "book"."author_id" IN (...)
            ORDER BY "book"."release_year" DESC;
            ```

        -   **Combining select_related and prefetch_related**: Use select_related for forward relations and prefetch_related for reverse ones in the same query.

            ```python
            # Books with author/publisher (select_related) + author's other books (prefetch_related)
            books = Book.objects.select_related('author__publisher').prefetch_related(
                Prefetch('author__books', queryset=Book.objects.exclude(id=F('id')))
            ).all()

            for book in books:
                print(f"Current book: {book.title}")
                print(f"Author: {book.author.name}, Publisher: {book.author.publisher.name}")
                print(f"Author's other books: {[b.title for b in book.author.books.all()]}")
            ```

            ```sql
            -- Query 1: Books with author and publisher via JOIN
            SELECT "book"."id", "book"."title", "book"."author_id",
                   "author"."id", "author"."name", "author"."publisher_id",
                   "publisher"."id", "publisher"."name"
            FROM "book"
            INNER JOIN "author" ON ("book"."author_id" = "author"."id")
            INNER JOIN "publisher" ON ("author"."publisher_id" = "publisher"."id");

            -- Query 2: Other books by the same authors (excluding current book)
            SELECT "book"."id", "book"."title", "book"."author_id"
            FROM "book"
            WHERE "book"."author_id" IN (...) AND NOT ("book"."id" = ...);
            ```

        -   **Prefetch with Conditional Filtering**: Use Prefetch to filter related objects based on complex conditions.

            ```python
            from django.db.models import Q

            # Prefetch authors with books that are either recent OR highly rated
            publishers = Publisher.objects.prefetch_related(
                Prefetch('authors', queryset=Author.objects.prefetch_related(
                    Prefetch('books', queryset=Book.objects.filter(
                        Q(release_year__gt=2020) | Q(rating__gt=4)
                    ))
                ))
            ).all()
            ```

            ```sql
            -- Query 1: Publishers
            SELECT "publisher"."id", "publisher"."name" FROM "publisher";

            -- Query 2: Authors
            SELECT "author"."id", "author"."name", "author"."publisher_id"
            FROM "author"
            WHERE "author"."publisher_id" IN (...);

            -- Query 3: Filtered books (recent or highly rated)
            SELECT "book"."id", "book"."title", "book"."release_year", "book"."rating", "book"."author_id"
            FROM "book"
            WHERE ("book"."release_year" > 2020 OR "book"."rating" > 4) AND "book"."author_id" IN (...);
            ```

        -   **Summary of Selection**: 

            | Direction          | Movement                   | Best Tool                  | Query Count          |
            | :----------------- | :------------------------- | :------------------------- | :------------------- |
            | **Forward**        | Book → Author              | `select_related`           | 1 (SQL JOIN)         |
            | **Reverse**        | Author → Books             | `prefetch_related`         | 2 (Separate Queries) |
            | **Nested Reverse** | Publisher → Author → Books | `prefetch_related('a__b')` | 3 (Separate Queries) |

        </details>

    -   <details><summary style="font-size:20px;color:Red">How to perform JOIN query?</summary>

        -   In Django's Object-Relational Mapping (ORM), you can perform JOIN operations to retrieve data from multiple database tables using various methods. Below are some common ways to perform a JOIN query in Django ORM.
        -   Assuming you have two Django models: `Author` and `Book`, and you want to join them based on a common field, such as author_id, here's a demonstration of multiple ways to perform a JOIN query:

        -   **Using `.select_related()` for `ForeignKey` and `OneToOne` Relationships**: Use `.select_related()` to perform a single SQL `INNER JOIN` for forward one-to-one and many-to-one relationships, eliminating the N+1 query problem.

            -   **How it works**: Performs a **single database query with JOIN** and loads related object data into Python memory in one go. The related object is immediately available without additional queries.

            -   **When to use**:
                - **Forward ForeignKey relations** (e.g., `book.author` when Book has FK to Author) — single JOIN is most efficient.
                - **Forward OneToOneField** (e.g., `profile.user`) — one-to-one relation makes JOIN optimal.
                - **Always needed relations** — if you will access the related object in all rows, use `select_related`.
                - Small to medium related objects — JOIN overhead is worth it to avoid multiple queries.

            -   **When NOT to use**:
                - **Reverse ForeignKey relations** → use `prefetch_related` (e.g., `author.books`).
                - **ManyToMany fields** → use `prefetch_related` (JOIN causes cartesian product/row duplication).
                - **Large related object sets** → JOIN duplicates parent row for each related row (use `prefetch_related` instead).
                - When accessing related data conditionally — may waste a JOIN if not all results use the related object.

            -   **`N+1` Problem Solved**:

                ```python
                # Bad: N+1 queries (1 for books + N queries for each book's author)
                books = Book.objects.all()
                for book in books:
                    print(book.author.name)  # Separate query per book

                # Good: 1 query with JOIN
                books = Book.objects.select_related('author').all()
                for book in books:
                    print(book.author.name)  # No additional query
                ```

            -   **Chaining multiple `.select_related()`**:
                ```python
                # Follow multiple ForeignKey chains in one query
                books = Book.objects.select_related('author__publisher').all()
                # Equivalent to: select_related('author').select_related('publisher') but more efficient
                ```

                ```sql
                SELECT "book"."id", "book"."title", "book"."author_id",
                       "author"."id", "author"."name", "author"."publisher_id",
                       "publisher"."id", "publisher"."name"
                FROM "book"
                INNER JOIN "author" ON ("book"."author_id" = "author"."id")
                INNER JOIN "publisher" ON ("author"."publisher_id" = "publisher"."id");
                ```

            -   **Deep/Nested relations** (following FK chains):
                ```python
                # Join through multiple levels: Book -> Author -> Publisher
                books = Book.objects.select_related('author__publisher').all()
                for book in books:
                    print(book.author.publisher.name)  # All loaded, no extra queries
                ```

                ```sql
                SELECT "book"."id", "book"."title", "book"."author_id",
                       "author"."id", "author"."name", "author"."publisher_id",
                       "publisher"."id", "publisher"."name"
                FROM "book"
                INNER JOIN "author" ON ("book"."author_id" = "author"."id")
                INNER JOIN "publisher" ON ("author"."publisher_id" = "publisher"."id");
                ```

            -   **Real-world nested example**:
                ```python
                from myapp.models import Order

                # Fetch orders with customer and customer's city in a single JOIN
                orders = Order.objects.select_related('customer__city').all()
                for order in orders:
                    print(f"{order.customer.name} from {order.customer.city.name}")
                ```

                ```sql
                SELECT "order"."id", "order"."total", "order"."customer_id",
                       "customer"."id", "customer"."name", "customer"."city_id",
                       "city"."id", "city"."name"
                FROM "order"
                INNER JOIN "customer" ON ("order"."customer_id" = "customer"."id")
                INNER JOIN "city" ON ("customer"."city_id" = "city"."id");
                ```

            -   **Performance implications**:
                - **Query count**: 1 query vs N+1 (huge win).
                - **Data transfer**: Single query sends all data at once; JOIN can duplicate parent rows if related set is large.
                - **Memory**: Related objects cached in Python; no lazy-loading overhead.
                - **Best when**: related object is small and frequent (like Author with 10-20 fields for 1000 books).

            -   **Accessing related fields directly (no extra queries)**:
                ```python
                book = Book.objects.select_related('author').get(id=1)
                # author is already in memory from the JOIN
                print(book.author.name)  # No query fired
                ```

            -   **Combining with filters**:
                ```python
                # Filter on related fields; select_related still works
                books = Book.objects.filter(author__country='USA').select_related('author').all()
                ```

            -   **Common pitfall: Redundant select_related on already tiny queryset**:
                ```python
                # OK but unnecessary; single book fetch is fast regardless
                book = Book.objects.select_related('author').get(id=1)

                # Better; if fetching many books, absolutely use select_related
                books = Book.objects.select_related('author').all()[:100]
                ```

            -   **Chaining with prefetch_related for mixed relation types**:
                ```python
                # Use both: select_related for ForeignKey, prefetch_related for reverse FK
                books = Book.objects.select_related('author').prefetch_related('reviews')
                # author loaded via JOIN, reviews loaded via separate query + cached
                ```

            -   **Checking what queries are executed** (debugging):
                ```python
                from django.db import connection
                from django.test.utils import CaptureQueriesContext

                with CaptureQueriesContext(connection) as ctx:
                    books = Book.objects.select_related('author').all()
                    for book in books:
                        print(book.author.name)

                print(f"Total queries: {len(ctx.captured_queries)}")  # Should be 1
                ```

            -   **Comparison: `select_related` vs `prefetch_related`**:
                | Aspect              | `select_related`         | `prefetch_related`       |
                | ------------------- | ------------------------ | ------------------------ |
                | Queries             | 1 (JOIN)                 | 2+ (separate)            |
                | Use Case            | Forward FK, OneToOne     | Reverse FK, M2M          |
                | Memory              | Data duplicated per JOIN | Data cached once         |
                | Cartesian explosion | Risk with large sets     | No risk                  |
                | Speed               | Fast for small relations | Fast for large relations |

        -   **Using `.prefetch_related()` for Reverse Relations and `ManyToMany`**: When dealing with reverse `ForeignKey`, `ManyToMany`, or `OneToOne` relationships, use `.prefetch_related()` to retrieve related objects efficiently.

            -   **How it works**: Executes **separate database queries** (one per prefetched relation) and caches results in Python memory. Unlike `select_related`, it does NOT perform **JOIN** at the database level. When you use `prefetch_related`, Django performs two (or more) distinct steps:
                -   **Main Query**: It fetches all the primary objects (e.g., all Authors).
                -   **Prefetch Query**: It collects all the IDs from the first result, then runs a single query to fetch all related objects (e.g., all Books belonging to those specific authors) using an **IN** clause.
                -   **The "Stitching"**: Django’s ORM joins these objects in memory, so when you loop through `author.book_set.all()`, no new database hits occur.

            -   **When to use**:
                - Reverse ForeignKey lookups (e.g., `author.books` when Book has FK to Author).
                - `ManyToManyField` relations (always requires separate query; JOIN would cause cartesian product).
                - `OneToOneField` reverse relations.
                - When the related set is expected to be large (JOIN would duplicate parent rows).

            -   **When NOT to use**:
                - Forward ForeignKey or OneToOne relations → use `select_related` (single JOIN query is faster).
                - When you only need IDs or a single field → use `values_list()` or `only()`.

            -   **The N+1 Problem** (solved by prefetch_related):
                ```python
                # Bad: N+1 queries (1 for authors + N queries for each author's books)
                authors = Author.objects.all()
                for author in authors:
                    print(author.books.all())  # Separate query per author

                # Good: 2 queries (1 for authors + 1 for all related books)
                authors = Author.objects.prefetch_related('books')
                for author in authors:
                    print(author.books.all())
                ```

            -   **Basic Example** (ManyToMany):
                ```python
                from myapp.models import Author, Book

                # 2 total queries: 1 for authors, 1 for all related books
                authors = Author.objects.prefetch_related('books').all()

                for author in authors:
                    books = author.books.all()  # No additional query, cached
                    print(f"Author: {author.name}, Books: {[book.title for book in books]}")
                ```

                ```sql
                -- Query 1: Fetch all authors
                SELECT "author"."id", "author"."name" FROM "author";

                -- Query 2: Fetch all related books for the authors above
                SELECT "book"."id", "book"."title", "book"."author_id"
                FROM "book"
                WHERE "book"."author_id" IN (1, 2, 3, ...);  -- IDs from Query 1
                ```

            -   **Chaining multiple prefetch_related**:
                ```python
                # Prefetch multiple relations in one operation
                authors = Author.objects.prefetch_related('books', 'awards').all()
                ```

                ```sql
                -- Query 1: Fetch all authors
                SELECT "author"."id", "author"."name" FROM "author";

                -- Query 2: Fetch all books for authors
                SELECT "book"."id", "book"."title", "book"."author_id"
                FROM "book"
                WHERE "book"."author_id" IN (1, 2, 3, ...);

                -- Query 3: Fetch all awards for authors
                SELECT "award"."id", "award"."title", "award"."author_id"
                FROM "award"
                WHERE "award"."author_id" IN (1, 2, 3, ...);
                ```

            -   **Nested prefetch (related relations of related objects)**:
                ```python
                from django.db.models import Prefetch

                # Prefetch books AND their authors' publishers for each author
                authors = Author.objects.prefetch_related(
                    Prefetch('books', queryset=Book.objects.select_related('author__publisher'))
                )
                # Now: author.books.all() gives cached Book objects with author and publisher already loaded

                # All data is cached—no additional queries in this loop
                for author in authors:
                    print(f"Author: {author.name}")
                    
                    # Access prefetched books (no query fired)
                    for book in author.books.all():
                        print(f"  Book: {book.title}")
                        
                        # Access select_related publisher (no query fired)
                        print(f"    Publisher: {book.author.publisher.name}")
                ```

                -   **Key points**:
                    - `author.books.all()` uses the cached prefetch result; no new query.
                    - `book.author.publisher` already loaded via `select_related` in the Prefetch queryset; no new query.
                    - Total queries for the entire loop: **exactly 2** (no N+1 problem).
                    - Without prefetch/select_related, this loop would execute **1 + N + (N × M)** queries (author + books per author + publishers per book).


                ```sql
                -- Query 1: Fetch all authors
                SELECT "author"."id", "author"."name" FROM "author";

                -- Query 2: Fetch books with their authors and publishers (JOIN for select_related)
                SELECT "book"."id", "book"."title", "book"."author_id",
                       "author"."id", "author"."name", "author"."publisher_id",
                       "publisher"."id", "publisher"."name"
                FROM "book"
                INNER JOIN "author" ON ("book"."author_id" = "author"."id")
                INNER JOIN "publisher" ON ("author"."publisher_id" = "publisher"."id")
                WHERE "book"."author_id" IN (1, 2, 3, ...);
                ```

            -   **Using `Prefetch` object for filtering prefetched results**: Sometimes you don't want all related objects; you want a filtered subset. For this, Django provides the Prefetch object.

                ```python
                from django.db.models import Prefetch

                # Fetch authors, but only prefetch their "highly_rated" books
                authors = Author.objects.prefetch_related(
                    Prefetch('books', queryset=Book.objects.filter(rating__gt=4))
                )
                # author.books.all() now contains only highly_rated books, cached
                ```

                ```sql
                -- Query 1: Fetch all authors
                SELECT "author"."id", "author"."name"
                FROM "author";

                -- Query 2: Fetch only highly rated books for these authors
                SELECT "book"."id", "book"."title", "book"."rating", "book"."author_id"
                FROM "book"
                WHERE "book"."rating" > 4 AND "book"."author_id" IN (1, 2, 3, ...);
                ```

            -   **Performance implications**:
                - `select_related`: 1 query with JOIN; slower if related volume is large (cartesian explosion).
                - `prefetch_related`: 2+ queries (separate) but faster overall due to no duplication.
                - For reverse FK with 100+ children per parent, prefer `prefetch_related`.

            -   **Combining with filters**: Avoid filtering on prefetched relations in QuerySet (use manual Python **filtering post-fetch**, or **filter before prefetch**):
                ```python
                # Book.objects.prefetch_related('author') is separate; filter on Book first
                books = Book.objects.filter(title__icontains='Django').prefetch_related('author')
                ```

                -   Assuming **Author ↔ Book** is a **ManyToManyField** (via pivot table), `select_related()` is not available; `prefetch_related()` is the right ORM tool.
                -   When **Book → Author** (forward FK), use select_related('author') for a true one-query JOIN.

                ```sql
                -- Query 1 (books)
                SELECT "book"."id","book"."title","book"."author_id"
                FROM "book"
                WHERE "book"."title" ILIKE '%Django%';

                -- Query 2 (authors)
                SELECT "author"."id","author"."name",...
                FROM "author"
                WHERE "author"."id" IN (...book.author_id values...);
                ```

            -   **Common pitfall**: Calling `.all()` on a prefetched reverse relation loses the cache:
                ```python
                # Good: uses cache
                author.books.all()

                # Bad: loses cache if you filter (executes new query)
                author.books.filter(published=True)
                ```

        -   **Custom Joins using `.filter()` and `annotate()`**: Custom joins in Django ORM allow you to query across related models with specific conditions, aggregations, and annotations without writing raw SQL. This is achieved through `.filter()` for conditions and `.annotate()` for adding computed fields. These methods leverage Django's ORM to perform implicit **JOIN**s based on model relationships.

            -   **How it works**: Django's ORM automatically generates **JOIN**s when you traverse relationships using double underscores (`__`). `.filter()` applies **WHERE** conditions across joins, while `.annotate()` adds aggregated or computed fields using functions like `Count`, `Sum`, `Avg`, etc.

            -   **When to use**:
                - When you need conditional joins (e.g., **filter based on related model fields**).
                - For aggregations across relationships (e.g., count related objects).
                - To avoid N+1 queries by fetching related data in a single query.
                - When `select_related` or `prefetch_related` aren't sufficient for complex conditions.

            -   **Basic Example with `.filter()`**:
                ```python
                from myapp.models import Author, Book

                # Find authors who have books published after 2020
                authors = Author.objects.filter(book__published_date__year__gt=2020).distinct()
                # This performs an INNER JOIN: SELECT DISTINCT author.* FROM author INNER JOIN book ON author.id = book.author_id WHERE book.published_date > '2020-01-01'
                ```

                ```sql
                SELECT DISTINCT "author"."id", "author"."name"
                FROM "author"
                INNER JOIN "book" ON ("author"."id" = "book"."author_id")
                WHERE EXTRACT(YEAR FROM "book"."published_date") > 2020;
                ```

            -   **Using `.annotate()` for Aggregations**:
                ```python
                from django.db.models import Count, Sum, Avg

                # Annotate authors with book count and total sales
                authors = Author.objects.annotate(
                    book_count=Count('book'),
                    total_sales=Sum('book__sales')
                ).filter(book_count__gt=5)  # Only authors with more than 5 books

                for author in authors:
                    print(f"{author.name}: {author.book_count} books, ${author.total_sales} sales")
                ```

                ```sql
                SELECT "author"."id", "author"."name",
                       COUNT("book"."id") AS "book_count",
                       SUM("book"."sales") AS "total_sales"
                FROM "author"
                LEFT OUTER JOIN "book" ON ("author"."id" = "book"."author_id")
                GROUP BY "author"."id", "author"."name"
                HAVING COUNT("book"."id") > 5;
                ```

            -   **Advanced: Combining `.filter()` and `.annotate()` with Q Objects**:
                ```python
                from django.db.models import Q

                # Authors with books in 'Fiction' genre OR published in 2023
                authors = Author.objects.filter(
                    Q(book__genre='Fiction') | Q(book__published_date__year=2023)
                ).annotate(
                    fiction_books=Count('book', filter=Q(book__genre='Fiction')),
                    recent_books=Count('book', filter=Q(book__published_date__year=2023))
                ).distinct()
                ```

                ```sql
                SELECT DISTINCT "author"."id", "author"."name",
                       COUNT(CASE WHEN "book"."genre" = 'Fiction' THEN 1 END) AS "fiction_books",
                       COUNT(CASE WHEN EXTRACT(YEAR FROM "book"."published_date") = 2023 THEN 1 END) AS "recent_books"
                FROM "author"
                INNER JOIN "book" ON ("author"."id" = "book"."author_id")
                WHERE ("book"."genre" = 'Fiction' OR EXTRACT(YEAR FROM "book"."published_date") = 2023)
                GROUP BY "author"."id", "author"."name";
                ```

            -   **Using F Objects for Field Comparisons Across Joins**:
                ```python
                from django.db.models import F

                # Books where sales > author's average book sales
                books = Book.objects.filter(
                    sales__gt=F('author__avg_sales')  # Compare book sales to author's average
                ).select_related('author')
                ```

                ```sql
                SELECT "book"."id", "book"."title", "book"."sales", "book"."author_id",
                       "author"."id", "author"."name", "author"."avg_sales"
                FROM "book"
                INNER JOIN "author" ON ("book"."author_id" = "author"."id")
                WHERE "book"."sales" > "author"."avg_sales";
                ```

            -   **Subqueries for Complex Custom Joins**:
                ```python
                from django.db.models import Subquery, OuterRef, Exists

                # Authors who have at least one book with sales > 1000
                authors = Author.objects.filter(
                    Exists(Book.objects.filter(author=OuterRef('pk'), sales__gt=1000))
                )
                ```

                ```sql
                SELECT "author"."id", "author"."name"
                FROM "author"
                WHERE EXISTS (
                    SELECT 1 FROM "book"
                    WHERE "book"."author_id" = "author"."id" AND "book"."sales" > 1000
                );
                ```

                ```python
                # Annotate with max book sales using subquery
                authors = Author.objects.annotate(
                    max_book_sales=Subquery(
                        Book.objects.filter(author=OuterRef('pk')).aggregate(Max('sales'))['sales__max']
                    )
                )
                ```

                ```sql
                SELECT "author"."id", "author"."name",
                       (SELECT MAX("book"."sales") FROM "book" WHERE "book"."author_id" = "author"."id") AS "max_book_sales"
                FROM "author";
                ```

            -   **Window Functions for Advanced Aggregations** (Django 2.0+):
                ```python
                from django.db.models import Window, F
                from django.db.models.functions import Rank

                # Rank books by sales within each author
                books = Book.objects.annotate(
                    sales_rank=Window(
                        expression=Rank(),
                        partition_by=[F('author')],
                        order_by=F('sales').desc()
                    )
                ).order_by('author', 'sales_rank')
                ```

                ```sql
                SELECT "book"."id", "book"."title", "book"."sales", "book"."author_id",
                       RANK() OVER (PARTITION BY "book"."author_id" ORDER BY "book"."sales" DESC) AS "sales_rank"
                FROM "book"
                ORDER BY "book"."author_id", "sales_rank";
                ```

            -   **Performance Considerations**:
                - Custom joins with `.filter()` and `.annotate()` generate efficient SQL but can become complex; monitor query execution with `connection.queries`.
                - Use `.distinct()` to avoid duplicates when joining many-to-many or reverse relations.
                - For large datasets, consider indexing foreign key fields and related lookup fields.
                - Avoid over-annotating; only annotate what you need to prevent unnecessary computations.

            -   **Common Pitfalls**:
                - Forgetting `.distinct()` can lead to duplicate results in reverse relations.
                - Using `.filter()` after `.annotate()` applies conditions to annotated fields, not the original query.
                - Complex annotations can generate heavy SQL; test with small datasets first.
                - Ensure related fields are properly indexed for performance.

            -   **Real-World Example: E-commerce Dashboard**:
                ```python
                from django.db.models import Count, Sum, Avg

                # Get customers with order stats
                customers = Customer.objects.annotate(
                    total_orders=Count('order'),
                    total_spent=Sum('order__total_amount'),
                    avg_order_value=Avg('order__total_amount')
                ).filter(total_orders__gt=0).order_by('-total_spent')

                for customer in customers:
                    print(f"{customer.name}: {customer.total_orders} orders, ${customer.total_spent} spent, avg ${customer.avg_order_value}")
                ```

                ```sql
                SELECT "customer"."id", "customer"."name",
                       COUNT("order"."id") AS "total_orders",
                       SUM("order"."total_amount") AS "total_spent",
                       AVG("order"."total_amount") AS "avg_order_value"
                FROM "customer"
                LEFT OUTER JOIN "order" ON ("customer"."id" = "order"."customer_id")
                GROUP BY "customer"."id", "customer"."name"
                HAVING COUNT("order"."id") > 0
                ORDER BY "total_spent" DESC;
                ```

            -   **Comparison with Other Join Methods**:
                | Method                      | Use Case                     | Queries       | Complexity |
                | --------------------------- | ---------------------------- | ------------- | ---------- |
                | `.filter()` + `.annotate()` | Conditional/aggregated joins | 1 (optimized) | Medium     |
                | `select_related`            | Forward FK/OneToOne          | 1 (JOIN)      | Low        |
                | `prefetch_related`          | Reverse/ManyToMany           | 2+ (batched)  | Low        |
                | Raw SQL                     | Complex/unexpressible        | 1 (custom)    | High       |

            -   **Debugging Custom Joins**:
                ```python
                from django.db import connection

                # Enable query logging
                authors = Author.objects.filter(book__genre='Fiction').annotate(book_count=Count('book'))
                print(connection.queries[-1]['sql'])  # View generated SQL
                ```

        -   **Using Raw SQL Queries**: In cases where you need to perform complex joins that are not easily expressible in Django's query syntax, you can use raw SQL queries. Be cautious when using raw SQL to ensure security and portability.

            ```python
            from django.db import connection

            # Execute a raw SQL query with JOIN
            with connection.cursor() as cursor:
                cursor.execute(
                    """
                    SELECT myapp_author.name, myapp_book.title
                    FROM myapp_author
                    INNER JOIN myapp_book ON myapp_author.id = myapp_book.author_id
                    """
                )
                results = cursor.fetchall()

            # Process the results
            for row in results:
                print(f"Author: {row[0]}, Book Title: {row[1]}")
            ```

        </details>

    #### Django Fixtures

    -   Django fixtures are a way of loading data into the database that your Django application is using. A fixture is a collection of data that Django knows how to import into a database.
    -   Fixtures are typically written as a JSON, XML or YAML file and can be used to load initial data into your database when you set up your application, as well as to provide test data when running tests. They can be useful for populating your database with sample data for development, for sharing data between different instances of an application, and for resetting the database to a known state for testing purposes.

    -   [How to use Django loaddata and dumpdata?](https://zerotobyte.com/how-to-use-django-loaddata-and-dumpdata/)

    -   `$ python manage.py dumpdata account.UserBase -o account/fixtures/users.json --indent 2`
    -   `$ python manage.py dumpdata account.UserBase --output users.xml --format xml`
    -   `$ python manage.py dumpdata account.UserBase --output users.yaml --format yaml`
    -   `$ python manage.py loaddata users.json` → load data from `user.json` file across all fixtures.
    -   `$ python manage.py loaddata fixture_name` → load data only from given fixture.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Authentication & Authorizations</summary>

    -   [API Authentication Explained (Finally) — Basic Auth, Bearer & JWT](https://www.youtube.com/watch?v=I747kI_y9eQ&t=355s)
    -   [Using the Django authentication system](https://docs.djangoproject.com/en/4.1/topics/auth/default/)
    -   [Customizing authentication in Django](https://docs.djangoproject.com/en/4.0/topics/auth/customizing/#customizing-authentication-in-django)
    -   [Session Vs JWT: The Differences You May Not Know!](https://www.youtube.com/watch?v=fyTxwIa-1U0)
    -   [7 Authentication Concepts Every Developer Should Know](https://www.youtube.com/watch?v=iX8g4LqF8p8)

    Django provides a robust authentication and authorization system. These two components are essential for securing web applications by verifying the identity of users and determining their access rights. Let's delve into the details of the authentication and authorization system in Django:

    #### Authentication in Django

    The authentication process involves verifying the identity of users accessing your web application and allowing or denying them access based on their credentials. Django provides a robust authentication system out of the box, making it easy to implement user authentication features in your web applications.

    Developers can configure authentication settings in the Django settings file (settings.py) to customize authentication behavior, such as specifying authentication backends, login URL, logout URL, etc.

    -   **User Model**: Django provides a built-in User model (`django.contrib.auth.models.User`) that represents users in the system. This model includes fields such as `username`, `password`, `email`, `firstname`, `lastname`, etc. You can use this model as-is or extend it to add custom fields as needed. The authentication system seamlessly integrates with the User model to perform authentication-related operations.

        -   Django provides a built-in User model that represents users in the authentication system.
        -   This model includes fields like username, password, email, etc.
        -   You can extend the User model or use a custom user model to add additional fields.
        -   When a user attempts to log in, Django verifies the credentials (username and password) against the user records stored in the database using the User model.

    -   **Authentication Backend**: Django uses authentication backends to handle the authentication process. By default, Django's authentication system uses `django.contrib.auth.backends.ModelBackend`, which authenticates users against the User model. However, you can define custom authentication backends to authenticate users against other sources, such as `LDAP`, `OAuth`, etc.

        -   Django supports pluggable authentication backends that allow you to customize the authentication process.
        -   Common authentication backends include `ModelBackend` (default), which uses the database-backed user model, and LDAPBackend, which integrates with LDAP directories.

    -   **Authentication Views**: Django provides built-in views (`django.contrib.auth.views`) for handling authentication-related tasks. views related to authentication handle the logic for user authentication tasks such as logging in, logging out, registering, password reset, password change, etc. These views interact with authentication forms, perform necessary actions based on user input, and render appropriate templates to the user. Django provides built-in views and utilities to simplify the implementation of authentication-related functionality. Here are some key views related to authentication in Django:

        -   `Login View`: The login view (`django.contrib.auth.views.LoginView`) handles the user authentication process. It renders the login form, receives user input, validates credentials, and logs in the user if authentication is successful. If authentication fails, it renders the login form again with appropriate error messages. You can customize this view to add extra functionality or use a custom login form.
        -   `Logout View`: The logout view (`django.contrib.auth.views.LogoutView`) logs out the currently authenticated user. It clears the user's session and redirects them to a specified URL (usually the login page or home page). This view typically does not render any template since it performs a server-side action.
        -   `Password Reset Views`: Django provides several views (`PasswordResetView`, `PasswordResetDoneView`, `PasswordResetConfirmView`, `PasswordResetCompleteView`) to handle the password reset process. These views render forms for initiating password reset, confirming password reset, and displaying success messages. They interact with password reset forms, validate user input, and send password reset emails with unique tokens.
        -   `Password Change View`: The password change view (`django.contrib.auth.views.PasswordChangeView`) handles requests for changing the password of the currently authenticated user. It renders a form for entering old and new passwords, validates user input, and updates the user's password if validation passes. It redirects the user to a specified URL upon successful password change.
        -   `Password Reset Email Confirmation View`: If you're using Django's built-in password reset functionality with email confirmation, you may need to create a custom view to handle the password reset email confirmation process. This view validates the token sent in the password reset email and renders a form for setting a new password.
        -   `User Registration View`: While Django does not provide a built-in view for user registration, you can create a custom registration view to handle user registration requests. This view renders a registration form, receives user input, validates form data, creates a new user object, and saves it to the database. It may also perform additional tasks such as sending welcome emails or activating user accounts
        -   The `django.contrib.auth` module includes functions like `authenticate`, `login`, and `logout` for programmatic authentication.

    -   **Authentication Decorators**: Decorators like `@login_required` in `django.contrib.auth.decorators` can be used to restrict access to certain views only to authenticated users.

        ```python
        from django.contrib.auth.decorators import login_required

        @login_required
        def my_protected_view(request): # View code for authenticated users only
        ...
        ```

    -   **Form**: forms related to authentication play a crucial role in handling user input for authentication purposes, such as logging in, registering, resetting passwords, etc. These forms allow users to interact with the authentication system of your Django application. Django provides several built-in forms and utilities to make it easier to work with authentication-related functionality. Here are some key forms related to authentication in Django:

        -   `Authentication Forms`: Django provides the AuthenticationForm class (`django.contrib.auth.forms.AuthenticationForm`) for handling user login. This form typically consists of fields for username/email and password. It validates user input and performs authentication against the user credentials stored in the database. You can use this form in your login view to authenticate users.
        -   `User Creation Forms`: To allow users to register or create accounts in your Django application, you can use the UserCreationForm class (`django.contrib.auth.forms.UserCreationForm`). This form includes fields for username, email, password, and password confirmation. It validates user input, creates a new user object, and saves it to the database. You can customize this form or create your own registration form if needed.
        -   `Password Reset Forms`: Django provides the PasswordResetForm class (`django.contrib.auth.forms.PasswordResetForm`) for handling password reset requests. When users forget their passwords, they can submit their email address through a form, and Django sends them a password reset email with a unique token. This form validates the submitted email address and initiates the password reset process.
        -   `Set Password Forms`: After receiving a password reset email, users need to set a new password for their accounts. Django provides the SetPasswordForm class (`django.contrib.auth.forms.SetPasswordForm`) for this purpose. This form includes fields for new password and password confirmation. It validates the submitted passwords and updates the user's password in the database.
        -   `Change Password Forms`: Users who are logged in to your Django application may want to change their passwords for security reasons. Django provides the PasswordChangeForm class (`django.contrib.auth.forms.PasswordChangeForm`) for handling password change requests. This form includes fields for old password, new password, and password confirmation. It validates the submitted passwords and updates the user's password in the database.

    -   **Authentication Middleware**: Django's authentication middleware (`django.contrib.auth.middleware.AuthenticationMiddleware`) is responsible for associating authenticated users with their requests. It adds a user attribute to the request object, which contains the authenticated user object if the user is logged in.

        -   The `django.contrib.auth.middleware.AuthenticationMiddleware` is included by default in Django settings.
        -   It associates users with requests using session-based authentication.

    -   **Session Management**: After successful authentication, Django creates a session for the user and stores session data in the database or cache backend. The session ID is typically stored in a cookie on the client-side, allowing Django to identify authenticated users on subsequent requests.

    -   **Permissions and Authorization**: In addition to authentication, Django provides a permissions and authorization system that allows you to control access to different parts of your application based on user roles and permissions. You can define permissions for models and views and use decorators (`@login_required`, `@permission_required`) to restrict access to authenticated users or users with specific permissions.

    #### Authorization in Django

    -   [Permissions and Authorization](https://docs.djangoproject.com/en/5.0/topics/auth/default/#permissions-and-authorization)

    Authorization refers to the process of determining whether a user has permission to perform a specific action or access a particular resource within your web application. Django provides a powerful and flexible authorization system that allows you to define fine-grained access control rules based on user roles, permissions, and other criteria. Here's an overview of the authorization process in Django:

    -   **Permissions**: Django's authorization system revolves around permissions, which are predefined rules that specify what actions a user can perform on a particular resource. Each permission is associated with a codename (e.g., `add`, `change`, `delete`, `view`) and a human-readable name (e.g., `Can add book`, `Can change book`, `Can delete book`, `Can view book`).

        -   Django provides a permission system where permissions are associated with models and views.
        -   Permissions include actions like `view`, `add`, `change`, and `delete`.
        -   Users can be assigned specific permissions directly or through group memberships.

    -   **Permission Model**: Django provides a built-in Permission model (`django.contrib.auth.models.Permission`) that represents individual permissions in the system. Each permission is associated with a content type (e.g., a model class) and applies to one or more specific actions (e.g., `add`, `change`, `delete`, `view`). Permissions are typically defined at the model level but can also be assigned to specific views or other resources.

        -   Models can define custom permissions using the class Meta option permissions.
        -   This allows for fine-grained control over who can perform specific actions on instances of a model.

        ```python
        class MyModel(models.Model):
            name = models.CharField(max_length=100)

            class Meta:
                permissions = [
                    ("can_change_name", "Can change the name of the model"),
                ]
        ```

    -   **User Groups**: Django allows you to organize users into groups, where each group can have one or more permissions assigned to it. By assigning permissions to groups rather than individual users, you can simplify permission management and apply consistent access control rules to users with similar roles or responsibilities.

        -   Users can be organized into groups, and permissions can be assigned to groups.
        -   This simplifies the process of managing permissions for multiple users.

    -   **User Permissions**: In addition to group-based permissions, Django allows you to assign permissions directly to individual users. This gives you finer control over access rights for specific users who may have unique requirements or roles within your application.

    -   **Permission Checks**: Django provides several ways to check whether a user has a particular permission. You can use the `user.has_perm()` method to check permissions programmatically in your views, templates, or other parts of your application. Additionally, Django provides decorators (`@permission_required`, `@login_required`) and template tags (`{% if user.has_perm %}`) to perform permission checks in views and templates, respectively.

        ```python
        from django.contrib.auth.decorators import permission_required

        @permission_required('myapp.can_publish')
        def my_publishing_view(request): # View code for users with 'myapp.can_publish' permission
        ...
        ```

    -   **Custom Permissions**: In addition to the built-in permissions provided by Django, you can define custom permissions to represent specific access control rules in your application. You can subclass Django's Permission model or define custom permission constants to represent custom permissions. Custom permissions can be assigned to users or groups like built-in permissions.

    -   **Object-Level Permissions**: Django's authorization system also supports object-level permissions, allowing you to define access control rules based on individual objects rather than just model-level permissions. Object-level permissions enable fine-grained control over access to specific instances of a model, such as allowing users to edit their own posts but not others'.
        -   Django supports object-level permissions to control access to individual instances of a model.
        -   This is achieved using the `django.contrib.auth.mixins.PermissionRequiredMixin` or by checking permissions manually in views.

    #### Session-Based Authorization

    -   ![Django Session Archictures](/assets/django/django-session-steps.png)

    1. **Overview**:

        - Session-based authentication relies on server-side sessions to manage user authentication. When a user logs in, a session is created on the server, and a session ID is stored in a cookie on the client side. Subsequent requests include this session ID, allowing the server to identify the user.
        - Django provides built-in support for session-based authentication through the use of middleware and the `django.contrib.auth` module.

    2. **Usecases**:

        - `Traditional Web Applications`:

            - Session-based authentication is well-suited for traditional web applications where the server maintains session state for each user.
            - When a user logs in, the server creates a session and stores user-related information on the server. A session identifier (usually stored in a cookie) is sent to the client, and subsequent requests include this identifier for authentication.
            - `Pros`:
                - Django's built-in authentication system supports session-based authentication out of the box, making it easy to implement.
                - The server can store and manage user-specific data on the server side.

        - `Web Applications with Server-Side Rendering (SSR)`:

            - Applications using server-side rendering, where the server generates HTML content for each request, can benefit from session-based authentication.
            - The server can include user-specific data in the HTML response, making it available on the client side.

        - `Confidential Information`:

            - For applications dealing with highly sensitive information, session-based authentication provides an additional layer of security.
            - Sessions can be configured with additional security measures, such as short expiration times, to minimize the risk of unauthorized access.

    3. **Key Components**:

        - `Middleware`: The `django.contrib.sessions.middleware.SessionMiddleware` is responsible for handling sessions. Make sure it's included in the MIDDLEWARE setting.
        - `Authentication Views`: Django provides built-in views for authentication, including login and logout views. These can be used or customized as needed.
        - `User Model`: Django's User model (in `django.contrib.auth.models`) represents the user, including fields for username, password, email, etc.

    4. **Workflow**:

        - User logs in using credentials.
        - Server validates credentials and creates a session for the user.
        - Server save the session ID in the Backend (e.g. Database) and add it to response to the client.
        - Session ID is stored in a cookie on the client side.
        - Subsequent requests include the session ID for server-side identification.
        - Sessions can have expiration times, and users may need to re-authenticate after a certain period of inactivity.
        - Example:

        ```python
        # django_app/views.py
        from django.contrib.auth import authenticate, login
        from django.contrib.auth import logout
        from django.shortcuts import render, redirect

        def login_view(request):
            if request.method == 'POST':
                username = request.POST['username']
                password = request.POST['password']
                user = authenticate(request, username=username, password=password)
                if user is not None:
                    login(request, user)
                    return redirect('home')
                else:
                    return render(request, 'login.html', {'error': 'Invalid credentials'})
            else:
                return render(request, 'login.html')


        def logout_view(request):
            logout(request)
            return redirect('home')
        ```

        ```python
        # django_app/urls.py
        from django.contrib.auth import views as auth_views
        urlpatterns = [
            path('login/', auth_views.LoginView.as_view(tem
            path('logout/', auth_views.LogoutView.as_view(n
        ]
        ```

    #### Token-Based Authorization

    -   [Why is JWT popular?](https://www.youtube.com/watch?v=P2CPd9ynFLg)

    1. **Overview**:

        - Token-based authentication involves the use of tokens (usually JSON Web Tokens or JWTs) to authenticate users. Instead of storing session information on the server, the server sends a token to the client upon successful authentication. The client includes this token in the headers of subsequent requests for authentication.
        - Token-based authentication is commonly used in web APIs and stateless applications where session-based authentication is not feasible.
        - With token-based authentication, a user obtains a token (usually a JSON Web Token or JWT) after successfully authenticating with the server. When a user logs in, tokens are created using a cryptographic algorithm based on user credentials during authentication and can include claims (e.g., user ID, expiration).
        - The token is then included in the headers of subsequent requests to authenticate the user. The server verifies the token's validity and grants access accordingly.
        - While Django itself does not provide built-in support for JWTs, third-party packages like `djangorestframework-simplejwt` can be used to implement token-based authentication in Django.
        - Tokens can have expiration times, and users may need to refresh their tokens to maintain an active session.

    2. **Usecases**:

        - `Single-Page Applications (SPAs) and APIs`:

            - Token-based authentication is commonly used in Single-Page Applications (SPAs) and APIs where the server is stateless, and each request should include authentication information.
            - Upon successful login, the server issues a token (usually a JSON Web Token or JWT) to the client. Subsequent requests include this token in the authorization header.
            - `Pros`:
                - `Stateless`: The server does not need to store session state, making it easier to scale horizontally.
                - `Decoupled Architecture`: Allows for a decoupled architecture where the server and client can be developed independently.

        - `Mobile Applications`:

            - Mobile applications, where the client may not be trusted to store session cookies securely, often use token-based authentication.
            - The token is stored securely on the mobile device and sent with each request to authenticate the user.

        - `Microservices Architecture`:

            - In a microservices architecture, where services may be distributed and stateless, token-based authentication simplifies the authentication process.
            - Each microservice can independently validate and authorize requests based on the token.

        - `Cross-Domain Authentication`:

            - Token-based authentication is suitable for scenarios where the client and server may reside on different domains.
            - CORS (Cross-Origin Resource Sharing) headers can be configured to allow requests with the authentication token to be made from different origins.

    3. Example:

        - Install the djangorestframework-simplejwt package:

            - `$ pip install djangorestframework-simplejwt`

        - `Configure settings`:

            ```python
            # settings.py
            REST_FRAMEWORK = {
                "DEFAULT_AUTHENTICATION_CLASSES": [
                    "rest_framework.authentication.SessionAuthentication",
                    "rest_framework_simplejwt.authentication.JWTAuthentication",
                ]
            }
            ```

        - `Usage in views`:

            ```python
            # django_app/views.py
            from rest_framework.authtoken.views import obtain_auth_token
            from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView, TokenVerifyView

            # Obtain token
            class MyTokenObtainPairView(TokenObtainPairView):
                serializer_class = MyTokenObtainPairSerializer

            # Refresh token
            class MyTokenRefreshView(TokenRefreshView):
                serializer_class = MyTokenRefreshSerializer

            # django_app/urls.py
            urlpatterns = [
                path('auth/', obtain_auth_token),
                # path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
                # path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
                # path('token/verify/', TokenVerifyView.as_view(), name='token_verify'),
            ]
            ```

        - `Invoke from Python Client`:

            ```python
            import requests
            from getpass import getpass

            auth_endpoint = "http://localhost:8000/api/auth/"
            username = input("What is your username?\n")
            password = getpass("What is your password?\n")

            auth_response = requests.post(auth_endpoint, json={'username': username, 'password': password})
            print(auth_response.json())

            if auth_response.status_code == 200:
                token = auth_response.json()['token']
                headers = {
                    "Authorization": f"Bearer {token}"
                }
                endpoint = "http://localhost:8000/api/products/"

                get_response = requests.get(endpoint, headers=headers)

                data = get_response.json()
                next_url = data['next']
                results = data['results']
                print("next_url", next_url)
                print(results)
            ```

    4. **rest_framework.authtoken.views** vs **rest_framework_simplejwt.views**: `rest_framework.authtoken.views` and `rest_framework_simplejwt.views` are two different modules in Django REST Framework (DRF) that provide views for token-based authentication, but they offer different functionalities and use different token generation mechanisms.

        - `rest_framework.authtoken.views:`

            - This module provides views for token-based authentication using Django's built-in token authentication system.
            - The main view provided by rest_framework.authtoken.views is ObtainAuthToken, which is used for obtaining authentication tokens.
            - When a user logs in with their username and password, ObtainAuthToken generates a random token associated with the user and returns it as a response.
            - The token is typically stored in the database associated with the user model, and subsequent requests include the token in the request headers for authentication.
            - This module is suitable for basic token-based authentication needs and integrates seamlessly with Django's authentication system.

        - `rest_framework_simplejwt.views:`

            - This module provides views for token-based authentication using JSON Web Tokens (JWTs) with the djangorestframework-simplejwt package.
            - The main view provided by rest_framework_simplejwt.views is TokenObtainPairView, which is used for obtaining JWT authentication tokens.
            - When a user logs in with their username and password, TokenObtainPairView generates a JWT containing user information and additional data (e.g., expiration time) and returns it as a response.
            - JWTs are signed using cryptographic algorithms (e.g., HMAC or RSA), ensuring their authenticity and integrity.
            - The djangorestframework-simplejwt package offers advanced features such as token expiration, token refreshing, and custom claims, making it suitable for more complex authentication requirements.

    -   **DRF Token** vs **JSON Web Token (JWT)** Authentication: Both Token Authentication systems are popular methods for securing APIs in Django Rest Framework (DRF). Each method has its own characteristics, and the choice between them depends on factors such as ease of use, flexibility, and specific project requirements.

        -   DRF Token Authentication (`rest_framework.authtoken`):

            -   Uses a simple token system where a unique token is generated for each user.
            -   Tokens are stored in a database table associated with the user.
            -   Tokens are created and managed by the Django authentication framework.
            -   Tokens are stored in the database, and each user has a corresponding token.
            -   Tokens are random strings, providing a level of security.
            -   Tokens can be manually invalidated by removing them from the database.

        -   JSON Web Token (JWT) Authentication (`djangorestframework-simplejwt`):
            -   Uses JSON Web Tokens, which are self-contained and can include user information and expiration.
            -   Tokens are not stored on the server; the server validates and decodes the token on each request.
            -   Tokens are created based on user credentials during authentication and can include claims (e.g., user ID, expiration).
            -   Tokens are signed using a secret key or a public/private key pair.
            -   Provides stateless authentication, as tokens contain all necessary information.
            -   Token expiration adds an additional layer of security.

    #### Comparison

    -   `Stateless vs Stateful`:
        -   Session-based authentication is stateful as it relies on the server storing user-related information.
        -   Token-based authentication is stateless, making it suitable for distributed and scalable architectures.
    -   `Security`: Both mechanisms can be secure when implemented correctly. Session-based authentication may provide additional security features such as session timeout and CSRF protection.
    -   `Complexity`: Token-based authentication is often considered more complex to implement, but it provides greater flexibility and decoupling.

    Both session-based and token-based authentication have their pros and cons. Session-based authentication is simpler to implement in Django, especially for web applications, while token-based authentication is often used in API-driven applications and provides more flexibility for decoupled systems. The choice between them depends on the specific requirements and architecture of the project.

    <details><summary style="font-size:20px;color:magenta">django.contrib.auth</summary>

    -   <b style="color:#C71585">PermissionManager(django.db.models.Manager)</b>

    -   -   `.use_in_migrations = True`
        -   <b style="color:#9370DB">.get_by_natural_key(codename, app_label, model)</b>

    -   <b style="color:#C71585">Permission(django.db.models.Model)</b>

        -   `.name = django.db.models.CharField(_('name'), max_length=255)`
        -   `.content_type = django.db.models.ForeignKey(ContentType, django.db.models.CASCADE, verbose_name=_('content type'),)`
        -   `.codename = django.db.models.CharField(_('codename'), max_length=100)`
        -   `.objects = PermissionManager()`

        -   <b style="color:#9370DB">.\_\_str\_\_()</b>
        -   <b style="color:#9370DB">.natural_key()</b>

    -   <b style="color:#C71585">GroupManager(django.db.models.Manager)</b>

        -   `.use_in_migrations = True`
        -   <b style="color:#9370DB">.get_by_natural_key(name)</b>

    -   <b style="color:#C71585">Group(django.db.models.Model)</b>

        -   `.name = django.db.models.CharField(_('name'), max_length=150, unique=True)`
        -   `.permissions = django.db.models.ManyToManyField(Permission,verbose_name=_('permissions'),blank=True,)`
        -   `.objects = GroupManager()`
        -   <b style="color:#9370DB">.natural_key()</b>

    -   <b style="color:#C71585">UserManager(BaseUserManager)</b>

        -   `use_in_migrations = True`
        -   <b style="color:#9370DB">.\_create_user(username, email, password, \*\*extra_fields)</b>
        -   <b style="color:#9370DB">.create_user(username, email=None, password=None, \*\*extra_fields)</b>
        -   <b style="color:#9370DB">.create_superuser(username, email=None, password=None, \*\*extra_fields)</b>
        -   <b style="color:#9370DB">.with_perm(perm, is_active=True, include_superusers=True, backend=None, obj=None)</b>

    -   <b style="color:#C71585">PermissionsMixin(django.db.models.Model)</b>

        -   `.is_superuser = django.db.models.BooleanField(...)`
        -   `.groups = django.db.models.ManyToManyField(...)`
        -   `.user_permissions = django.db.models.ManyToManyField(...)`
        -   <b style="color:#9370DB">.get_user_permissions(obj=None)</b>
        -   <b style="color:#9370DB">.get_group_permissions(obj=None)</b>
        -   <b style="color:#9370DB">.get_all_permissions(obj=None)</b>
        -   <b style="color:#9370DB">.has_perm(perm, obj=None)</b>
        -   <b style="color:#9370DB">.has_perms(perm_list, obj=None)</b>
        -   <b style="color:#9370DB">.has_module_perms(app_label)</b>

    -   <b style="color:#C71585">AbstractUser(AbstractBaseUser, PermissionsMixin)</b>

        -   `.username_validator = UnicodeUsernameValidator()`
        -   `.username = django.db.models.CharField(...)`
        -   `.first_name = django.db.models.CharField(_('first name'), max_length=150, blank=True)`
        -   `.last_name = django.db.models.CharField(_('last name'), max_length=150, blank=True)`
        -   `.email = django.db.models.EmailField(\_('email address'), blank=True)`
        -   `.is_staff = django.db.models.BooleanField(...)`
        -   `.is_active = django.db.models.BooleanField(...)`
        -   `.date_joined = django.db.models.DateTimeField(_('date joined'), default=timezone.now)`
        -   `.objects = UserManager()`
        -   `.EMAIL_FIELD = 'email'`
        -   `.USERNAME_FIELD = 'username'`
        -   `.REQUIRED_FIELDS = ['email']`

        -   <b style="color:#9370DB">.clean()</b>
        -   <b style="color:#9370DB">.get_full_name()</b>
        -   <b style="color:#9370DB">.get_short_name()</b>
        -   <b style="color:#9370DB">.email_user(subject, message, from_email=None, \*\*kwargs)</b>

    -   <b style="color:#C71585">User(AbstractUser)</b>

    -   <b style="color:#C71585">AnonymousUser</b>

        -   `.id = None`
        -   `.pk = None`
        -   `.username = ''`
        -   `.is_staff = False`
        -   `.is_active = False`
        -   `.is_superuser = False`
        -   `._groups = EmptyManager(Group)`
        -   `._user_permissions = EmptyManager(Permission)`
        -   <b style="color:#9370DB">.save()</b>
        -   <b style="color:#9370DB">.delete()</b>
        -   <b style="color:#9370DB">.set_password(raw_password)</b>
        -   <b style="color:#9370DB">.check_password(raw_password)</b>
        -   <b style="color:#9370DB">.groups()</b>
        -   <b style="color:#9370DB">.user_permissions()</b>
        -   <b style="color:#9370DB">.get_user_permissions(obj=None)</b>
        -   <b style="color:#9370DB">.get_group_permissions(obj=None)</b>
        -   <b style="color:#9370DB">.get_all_permissions(obj=None)</b>
        -   <b style="color:#9370DB">.has_perm(perm, obj=None)</b>
        -   <b style="color:#9370DB">.has_perms(perm_list, obj=None)</b>
        -   <b style="color:#9370DB">.has_module_perms(module)</b>
        -   <b style="color:#9370DB">.is_anonymous()</b>
        -   <b style="color:#9370DB">.is_authenticated()</b>
        -   <b style="color:#9370DB">.get_username()</b>

    </details>

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Sessions</summary>

    sessions are a mechanism for persisting user data across HTTP requests. They allow web applications to store and retrieve data associated with a particular user's session, such as user authentication status, preferences, shopping cart contents, and more.

    -   **Initialization**:

        -   When a user makes an HTTP request to a Django-powered application, Django automatically creates a session object for that user if one doesn't already exist.
        -   The session object is typically stored on the server-side, and a session ID is generated to uniquely identify the session.

    -   **Session ID**:

        -   Django includes the session ID in the HTTP response headers sent back to the client. By default, Django uses cookies to store the session ID, but you can configure it to use other mechanisms like URL-based session IDs or custom headers.
        -   The session ID allows Django to associate subsequent requests from the same user with the corresponding session object.

    -   **Data Storage**:

        -   You can store arbitrary data in the session object using a dictionary-like interface. Common use cases include storing user authentication information, shopping cart contents, user preferences, and temporary form data.
        -   The session data is serialized and stored in a backend storage mechanism configured in your Django settings. Django provides several built-in session backends, including **database-backed sessions**, **file-based sessions**, and **cache-based sessions**.

    -   **Session Middleware**:

        -   Django uses middleware to enable session management. The `django.contrib.sessions.middleware.SessionMiddleware` middleware is responsible for managing sessions. It must be included in the MIDDLEWARE setting to handle the creation, serialization, and storage of session data.
        -   This middleware is responsible for initializing the session object for each request, saving any changes made to the session data, and setting the appropriate session cookie or identifier in the response.
        -   Example MIDDLEWARE setting in `settings.py`:

            ```python
            MIDDLEWARE = [
                # ...
                'django.contrib.sessions.middleware.SessionMiddleware',
                # ...
            ]
            ```

    -   **Session Engine**:

        -   Django supports multiple session engines, which are responsible for storing and retrieving session data. The default session engine is the database-backed engine (`django.contrib.sessions.backends.db`), but other options include caching engines, file-based sessions, and more.

        -   Example `SESSION_ENGINE` setting in `settings.py`:

            ```python
            SESSION_ENGINE = 'django.contrib.sessions.backends.db'
            ```

    -   **Session Configuration**:

        -   Configuration options for sessions can be customized in the `settings.py` file. This includes settings such as `SESSION_COOKIE_NAME`, `SESSION_COOKIE_AGE`, `SESSION_SAVE_EVERY_REQUEST`, and others.
        -   `SESSION_COOKIE_NAME`: This setting defines the name of the cookie used to store the session ID on the client side (i.e., the user's browser). Default Value `SESSION_COOKIE_NAME` is 'sessionid'.
        -   `SESSION_SAVE_EVERY_REQUEST`: This setting controls whether to save the session data on every request. The Default Value is 'False'.
        -   `SESSION_COOKIE_AGE`: Session data can have an expiration time, which is controlled by the `SESSION_COOKIE_AGE` setting. Django automatically deletes expired sessions during its cleanup process. By default, Django uses browser-length sessions, which expire when the user closes their browser.

        -   Example session settings:

            ```python
            SESSION_COOKIE_NAME = 'my_session_cookie'
            SESSION_COOKIE_AGE = 1209600 # Two weeks in seconds
            ```

    -   **Accessing Session Data**:

        -   Within your Django views or other parts of your application, you can access the session data using the `request.session` attribute, which provides a dictionary-like interface to interact with the session.
        -   For example, you can set session variables using `request.session['key'] = value`, retrieve session variables using `value = request.session.get('key', default)`, or delete session variables using `del request.session['key']`.

        -   Example usage in a view:

            ```python
            def my_view(request): # Storing data in the session
                request.session['user_id'] = 123

                # Retrieving data from the session
                user_id = request.session.get('user_id')

                # Deleting a session key
                del request.session['user_id']
            ```

    -   **Security Concerns**:

        -   Session data is typically stored as a cookie on the user's browser. It's important to use secure and tamper-proof session cookies to prevent security vulnerabilities. Django provides settings like `SESSION_COOKIE_SECURE` and `SESSION_COOKIE_HTTPONLY` for this purpose.
        -   The settings `SESSION_COOKIE_SECURE` and `SESSION_COOKIE_HTTPONLY` are used to enhance the security of session cookies. They control certain attributes of the session cookie that is sent to the client's browser.
            -   `SESSION_COOKIE_SECURE`: When set to 'True', this setting instructs the browser to only send the session cookie over HTTPS connections. The default Value is 'False'.
            -   `SESSION_COOKIE_HTTPONLY`: When set to 'True', this setting prevents JavaScript code from accessing the session cookie via the document.cookie API. The default Value is 'True'.

    -   **Session Cleanup**:
        -   Django provides management commands (`clearsessions`) to clean up expired sessions from the session store. This helps prevent the session store from growing too large over time.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Caching</summary>

    Caching in Django is a powerful mechanism to improve the performance and scalability of your web applications by reducing the amount of dynamic content generation required for each request. By storing and reusing previously generated responses, you can significantly reduce the load on your database and other backend components, leading to faster response times and a better user experience.

    ### Types of Caching in Django

    1. **Database Caching**: Stores query results in the cache, reducing the number of database hits.
    2. **File System Caching**: Stores cache entries as files on the filesystem.
    3. **Memory-Based Caching**: Stores cache entries in memory using backends like Memcached or Redis.
    4. **In-Memory Caching**: Simple caching that stores data in the memory of the Python process itself (suitable for small-scale applications).

    ### Django Caching Framework

    Django provides a flexible caching framework that supports various cache backends. The framework can be configured to use one or more cache backends and allows you to control the caching behavior at different levels: per-site, per-view, template fragment, or low-level API.

    ### Configuring Cache Backends

    You can configure the cache backend in your `settings.py` file. Here are some examples:

    -   **In-Memory Caching (Local Memory Cache)**:

        ```python
        CACHES = {
            'default': {
                'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
                'LOCATION': 'unique-snowflake',
            }
        }
        ```

    -   **Memcached**:

        ```python
        CACHES = {
            'default': {
                'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
                'LOCATION': '127.0.0.1:11211',
            }
        }
        ```

    -   **Redis**:

        ```python
        CACHES = {
            'default': {
                'BACKEND': 'django_redis.cache.RedisCache',
                'LOCATION': 'redis://127.0.0.1:6379/1',
                'OPTIONS': {
                    'CLIENT_CLASS': 'django_redis.client.DefaultClient',
                }
            }
        }
        ```

    ### Types of Caching in Django

    1. **Per-Site Caching**:

        - Caches the entire site. All views will use the same cache.

        ```python
        MIDDLEWARE = [
            'django.middleware.cache.UpdateCacheMiddleware',
            'django.middleware.common.CommonMiddleware',
            'django.middleware.cache.FetchFromCacheMiddleware',
            # other middleware
        ]

        CACHE_MIDDLEWARE_SECONDS = 600  # Cache duration in seconds
        CACHE_MIDDLEWARE_KEY_PREFIX = ''  # Prefix for cache keys
        ```

    2. **Per-View Caching**:

        - Caches individual views. You can control which views are cached and for how long.

        ```python
        from django.views.decorators.cache import cache_page

        @cache_page(60 * 15)
        def my_view(request):
            # view code
        ```

    3. **Template Fragment Caching**:

        - Caches specific parts of a template. Useful for caching expensive template snippets.

        ```html
        {% load cache %} {% cache 500 sidebar %}
        <div class="sidebar">... expensive sidebar content ...</div>
        {% endcache %}
        ```

    4. **Low-Level Caching API**:

        - Provides a way to cache arbitrary data in your views or models.

        ```python
        from django.core.cache import cache

        def my_view(request):
            data = cache.get('my_key')
            if not data:
                data = expensive_calculation()
                cache.set('my_key', data, timeout=60*15)
            return HttpResponse(data)
        ```

    ### Advanced Caching Techniques

    1. **Cache Versioning**:

        - Allows you to version your cache keys to invalidate old cache entries without changing the cache key names.

        ```python
        cache.set('my_key', data, timeout=60*15, version=2)
        cache.get('my_key', version=2)
        ```

    2. **Cache Key Prefixing**:

        - Use prefixes to avoid key collisions when using the same cache for multiple applications.

        ```python
        CACHE_MIDDLEWARE_KEY_PREFIX = 'myapp'
        ```

    3. **Custom Cache Backends**:

        - You can implement your custom cache backend by subclassing Django's `BaseCache` class.

    4. **Distributed Caching**:
        - Use distributed caching solutions like Redis or Memcached for scaling out across multiple servers.

    ### Cache Invalidation:

    Proper cache invalidation is crucial to ensure that your users see the most up-to-date content. Django provides several ways to handle cache invalidation:

    1. **Time-based Invalidation**:Specify a timeout when setting cache entries.
    2. **Manual Invalidation**:Manually delete or update cache entries as needed.
        ```python
        cache.delete('my_key')
        ```
    3. **Signal-based Invalidation**:Use Django's signals to automatically invalidate cache entries when certain events occur (e.g., model save or delete).

    ### Best Practices

    1. **Choose the Right Cache Backend**: Select a cache backend that fits your application's needs and deployment environment.
    2. **Use Cache Wisely**: Cache data that is expensive to generate and does not change frequently.
    3. **Monitor Cache Performance**: Use monitoring tools to keep an eye on cache hit/miss rates and performance metrics.
    4. **Handle Cache Failures Gracefully**: Ensure your application can handle cache backend failures without crashing.

    -   **Example**: Combining Different Caching Strategies

    Here's an example combining per-view and template fragment caching:

    ```python
    from django.views.decorators.cache import cache_page
    from django.shortcuts import render

    @cache_page(60 * 15)
    def my_view(request):
        data = fetch_data()
        return render(request, 'my_template.html', {'data': data})

    # my_template.html
    {% load cache %}
    <!DOCTYPE html>
    <html>
    <head>
        <title>My Page</title>
    </head>
    <body>
        <h1>My Data</h1>
        {% cache 500 data_fragment %}
            <div>
                {{ data }}
            </div>
        {% endcache %}
    </body>
    </html>
    ```

    In this example, the entire view is cached for 15 minutes, and a specific part of the template (data fragment) is cached for 500 seconds. This setup can significantly improve the performance of your application by reducing the load on your backend systems.

    By understanding and leveraging Django's caching framework, you can optimize your web application's performance, ensuring a better user experience and more efficient resource usage.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Middleware</summary>

    -   [Middleware](https://docs.djangoproject.com/en/4.2/topics/http/middleware/)

    ### What is middleware:

    Middleware in Django is a framework of hooks into Django's request/response processing. It's a lightweight, low-level plugin system that allows you to modify request objects, response objects, or view behavior. Middleware is a powerful tool for handling cross-cutting concerns, such as authentication, logging, and security, in a centralized and reusable way across your Django project.

    Middleware sits between the request and the view, allowing you to modify requests entering the application, or responses leaving it. It's particularly useful for common functionality that needs to be applied to all requests or responses, such as authentication, session management, CORS handling, and more.

    Django's middleware follows a design pattern known as "chain of responsibility." Each middleware component is a Python class that defines methods to process requests and responses. Middleware classes are stacked in a list, and Django applies them in sequence, passing the request object through each middleware class in the list.

    #### Writing your own middleware

    -   A middleware factory is a callable that takes a `get_response` callable and returns a middleware. A middleware is a callable that takes a request and returns a response, just like a view.

    -   A middleware can be written as a function that looks like this:

        ```python
        def custom_middleware(get_response):
            # This is the middleware function
            def middleware(request):
                # This code is executed for each request before the view is called
                print("Middleware processing request")

                # Call the next middleware or the view
                response = get_response(request)

                # This code is executed for each response after the view is called
                print("Middleware processing response")

                return response

            # Return the middleware function
            return middleware
        ```

    -   it can be written as a class whose instances are callable, like this:

        ```python
        # myapp/middleware.py
        class MyCustomMiddleware:
            def __init__(self, get_response):
                self.get_response = get_response

            def __call__(self, request):
                # This method is called for each incoming request. It should return a
                # response object or call the next middleware or view function in the
                # chain using the get_response callable.
                response = self.get_response(request)

                # Code to be executed for each request/response after the view (if any)

                return response

            def process_request(self, request):
                # Code to be executed before the view function is called
                pass

            def process_exception(self, request, exception):
                # This method is called when an exception occurs during the processing of the request.
                pass

            def process_view(self, request, view_func, view_args, view_kwargs):
                # This method is called just before the view function is called.
                pass

            def process_response(self, request, response):
                # This method is called just before the response is returned to the client.
                return response
        ```

    #### Middleware Hooks:

    Middleware hooks are specific methods that can be implemented in middleware classes to perform additional processing at various stages of the request/response cycle. These hooks allow you to customize the behavior of middleware and add additional functionality to your Django application.

    -   `process_request(self, request)`: This method is called before the view function is called. It receives the request object and can be used to modify the request or perform any preprocessing tasks. For example, you can perform authentication, URL routing, or session management operations here.

    -   `process_view(self, request, view_func, view_args, view_kwargs)`: This method is called just before the view function is called. It receives the request object, the view function (view_func), and its arguments and keyword arguments. It allows you to modify the view function or perform additional processing based on the view being called. For example, you can add additional context to the request or perform authorization checks.

    -   `process_exception(self, request, exception)`: This method is called when an exception occurs during request processing. It receives the request object and the raised exception. You can handle the exception, log it, or return an alternative response. This hook is useful for implementing custom error handling or exception logging.

    -   `process_template_response(self, request, response)`: This method is called when the response returned by the view function is a TemplateResponse instance. It receives the request object and the response object. You can modify the template context or the response before it is rendered. This hook is commonly used to add additional context variables or modify the response content.

    -   `process_response(self, request, response)`: This method is called after the view function has completed. It receives the request object and the response object. You can modify the response or perform any post-processing tasks. For example, you can add headers to the response or modify its content.

    By implementing these middleware hooks, you can extend the functionality of middleware classes and customize their behavior according to your application's needs.

    **Notes**:

    -   The `get_response` callable provided by Django might be the actual view (if this is the last listed middleware) or it might be the next middleware in the chain. The current middleware doesn’t need to know or care what exactly it is, just that it represents whatever comes next.

    -   The above is a slight simplification – the `get_response` callable for the last middleware in the chain won’t be the actual view but rather a wrapper method from the handler which takes care of applying view middleware, calling the view with appropriate URL arguments, and applying template-response and exception middleware.

    -   Middleware can either support only synchronous Python (the default), only asynchronous Python, or both. See Asynchronous support for details of how to advertise what you support, and know what kind of request you are getting.

    -   Middleware can live anywhere on your Python path.

    -   Middleware factories must accept a `get_response` argument. You can also initialize some global state for the middleware. Keep in mind a couple of caveats:

        -   Django initializes your middleware with only the `get_response` argument, so you can’t define `__init__(...)` as requiring any other arguments.
        -   Unlike the `__call__(...)` method which is called once per request, `__init__(...)` is called only once, when the web server starts.

    #### How you activate middleware:

    -   Add the fully qualified names of your middleware classes to the MIDDLEWARE setting. The order in which you add middleware classes to the list determines the order in which they are executed.

        ```py
        # settings.py

        MIDDLEWARE = [
            'django.middleware.security.SecurityMiddleware',  # Example built-in middleware
            'myapp.middleware.MyCustomMiddleware',            # Your custom middleware as Class
            'myapp.middleware.custom_middleware',             # Your custom middleware as function
        ]
        ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Signals</summary>

    -   [Django Signals Documentation](https://docs.djangoproject.com/en/5.0/topics/signals/#module-django.dispatch)
    -   [Builtin Signals](https://docs.djangoproject.com/en/4.1/ref/signals/)
    -   [the Basics of Django Signals](https://www.youtube.com/watch?v=T6PyDm79PFo&list=RDCMUCRM1gWNTDx0SHIqUJygD-kQ&start_radio=1&rv=T6PyDm79PFo&t=24)
    -   [Django ORM - Introducing Django Signals and the Observer Pattern](https://www.youtube.com/watch?v=p4vLpz1D4ow&list=PLOLrQ9Pn6cayYycbeBdxHUFrzTqrNE7Pe&index=38)
    -   [Django ORM - Receiving Signals](https://www.youtube.com/watch?v=c4NEn7H5czA&list=PLOLrQ9Pn6cayYycbeBdxHUFrzTqrNE7Pe&index=36)
    -   [Django ORM - Receiving Signals Specifying a Model](https://www.youtube.com/watch?v=BZ0vJDclU74&list=PLOLrQ9Pn6cayYycbeBdxHUFrzTqrNE7Pe&index=37)

    -   Django Signals is a implementation of the **Observer Design Pattern** in Django framework, which allows objects (observers) to subscribe to and receive notifications from a subject (publisher) about changes in its state.
    -   Signaling refers to the process of sending and receiving signals, which are notifications or messages that are sent when certain events occur within the Django framework or your application. Signals allow you to decouple different parts of your application and perform actions in response to specific events without tightly coupling the code.
    -   Django Signals are a built-in feature of the Django framework specifically designed to allow decoupled components within a Django application to communicate and respond to events.
    -   Signals are used to enable the "sender" of a signal to notify a group of "receivers" that something has happened. Here are some key concepts related to signals in Django:
    -   Signals in Django provide a way to establish event driven connection between two decoupled application.. They allow different parts of an application to communicate with each other without tight coupling, enabling modularity and extensibility. Signals are commonly used for tasks like updating related models, sending notifications, triggering background tasks, and more.
    -   Signals are typically used within the Django framework for various purposes such as model lifecycle events (e.g., post_save, pre_delete), request/response cycle events (e.g., request_started, request_finished), or custom events within an application.

    To use signals in your Django project, you'll need to import the necessary signals, write signal handlers, and register the handlers with the corresponding signals.

    #### Signals Terminology

    -   **Signals**: Signals are objects representing specific actions or events that occur within a Django application. Django provides built-in signals, such as `pre_save`, `post_save`, `pre_delete`, `post_delete`, etc., which are triggered at different points during the lifecycle of a model.
    -   **Senders**: A sender is the entity that sends a signal. In Django, senders are typically Django model classes, but they can be any Python object.
    -   **Signal Handlers/Receivers**: A receiver is a callable that gets executed in response to a signal being sent. Receivers define the actions to be performed when a specific signal is received. Receivers are registered to signals using connected to a signal using the `@receiver` decorator (`django.dispatch.receiver`) or the `Signal.connect(receiver, sender=None, weak=True, dispatch_uid=None)` method and can be located anywhere in the codebase.
    -   **Signal Registration**: Signal receivers need to be registered with the appropriate signal to establish the connection between the sender and the receiver. A signal handler can be registered with a signal using either the `@receiver` decorator (`django.dispatch.receiver`) or the `Signal.connect(receiver, sender=None, weak=True, dispatch_uid=None)` method.

    #### Defining Signals

    To define a custom signal, you can create an instance of the Signal class from django.dispatch. You typically define signals as module-level variables in a `signals.py` file within your Django app. Each signal represents a specific event that you want to notify other parts of your application about.

    ```python
    from django.dispatch import Signal

    # Define a custom signal
    user_registered = Signal()
    ```

    #### Signal Receiving / Registering Handler

    Once you've defined a signal, you can connect one or more signal handlers to it.

    -   Receiving a signal involves defining a receiver function or method and connecting it to the signal.
    -   The `@receiver` decorator and `django.dispatch.Signal.connect(receiver, sender=None, weak=True, dispatch_uid=None)` are commonly used to connect a function or method to a signal.

        ```python
        from django.dispatch import receiver
        from myapp.signals import user_registered, my_signal

        # Define a signal handler
        @receiver(user_registered)
        def handle_user_registered(sender, **kwargs):
            # Perform actions in response to the signal
            print("User registered:", sender)
        ```

    -   The order in which receivers are connected to a signal can be controlled to determine the execution order.
    -   The `dispatch_uid` parameter or the `@receiver` decorator's `order` attribute is used for this purpose.

        ```python
        @receiver(my_signal, dispatch_uid='my_unique_identifier', , order=1)
        def first_handler(sender, **kwargs):
            pass

        def second_handler(sender, **kwargs):
            pass

        # alternative approch to register a handler to a signal
        my_signal.connect(second_handler, sender=None, weak=True, dispatch_uid=None)

        ```

    #### Sending Signals

    In various parts of your application, you can send signals using the `send()` method of the signal object. When you send a signal, all connected signal handlers are executed in the order they were connected.

    ```python
    from myapp.signals import user_registered


    def account_register(request):

        if request.method == 'POST':
            registerForm = RegistrationForm(request.POST)
            if registerForm.is_valid():
                user = registerForm.save(commit=False)

                # Send a signal
                user_registered.send(sender=account_register.__name__, user=user)

                return HttpResponse('registered succesfully and activation sent')
        else: registerForm = RegistrationForm()
        return render(request, 'account/registration/register.html', {'form': registerForm})
    ```

    -   Sending a signal involves using the `django.dispatch.Signal` class to create a signal instance.
    -   The `send()` method of the signal instance is then called to dispatch the signal along with any necessary data.

    #### Built-in Signals

    Django provides several built-in signals that are sent at different points during the lifecycle of a Django application or when certain events occur, such as when a model is saved, deleted, or a request is processed. You can connect signal handlers to these built-in signals to perform custom actions in response to these events.

    ```python
    from django.contrib.auth.models import (AbstractBaseUser, PermissionsMixin)
    from django.db.models.signals import post_save

    class UserBase(AbstractBaseUser, PermissionsMixin):

        email = models.EmailField(_('email address'), unique=True)
        user_name = models.CharField(max_length=150, unique=True)
        first_name = models.CharField(max_length=150, blank=True)

    def on_user_create_handler(sender, instance, **kwargs):
        print(f"The user with username- '{instance.user_name}' has just been created")

    post_save.connect(on_user_create_handler, sender=UserBase)
    ```

    -   **Model Signals**:
        -   `django.db.models.signals.pre_init`: Sent just before an instance's `__init__()` method is called.
        -   `django.db.models.signals.post_init`: Sent just after an instance's `__init__()` method has been called.
        -   `django.db.models.signals.pre_save`: Sent just before a model's `save()` method is called.
        -   `django.db.models.signals.post_save`: Sent just after a model's `save()` method has been called.
        -   `django.db.models.signals.pre_delete`: Sent just before a model's `delete()` method is called.
        -   `django.db.models.signals.post_delete`: Sent just after a model's `delete()` method has been called.
        -   `django.db.models.signals.m2m_changed`: Sent when a ManyToManyField on a model is changed.
    -   **Management Signals**:
        -   `django.db.models.signals.request_started`: Sent when Django starts processing an HTTP request.
        -   `django.db.models.signals.request_finished`: Sent when Django finishes processing an HTTP request.
        -   `django.db.models.signals.got_request_exception`: Sent when an exception is raised during the processing of an HTTP request.
    -   **Database Signals**:
        -   `django.db.backends.signals.connection_created`: Sent when a database connection is created.
    -   **Request/response signals**:
        -   `django.core.signals.request_finished`
        -   `django.core.signals.got_request_exception`

    #### Disconnecting Signal Handlers

    If you no longer want a signal handler to be executed when a signal is sent, you can disconnect it using the `disconnect()` method of the signal object.

    ```python
    from django.db.models.signals import post_save
    post_save.disconnect(on_user_create_handler, sender=UserBase)
    ```

    -   **Decoupled Communication**:

        -   Signals enable a decoupled communication mechanism between different parts of a Django application.
        -   One part of the application can send a signal, and another part can listen for that signal without directly importing or depending on each other.

    -   **Publisher-Subscriber Pattern**:

        -   Django signals follow the publisher-subscriber pattern.
        -   The part of the code that sends (publishes) a signal is known as the sender, and the part that listens (subscribes) to the signal is known as the receiver.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Rendering Documentaion (OpenAPI3.0)</summary>

    > Integrating `drf-spectacular` is the modern standard for generating OpenAPI 3.0 schemas in Django Rest Framework (DRF). It has largely replaced older tools like `drf-yasg`. Here is the step-by-step guide to setting it up and rendering your documentation.

    1. **Install the Package**:First, install the library using pip. It is also recommended to install the optional "Sidecar" packages if you want to serve the Swagger UI static files locally rather than from a CDN.

        ```bash
        pip install drf-spectacular
        # Optional: for self-hosted UI assets
        pip install drf-spectacular-sidecar 
        ```

    2. **Update `settings.py`**:You need to register the app and tell DRF to use `drf-spectacular` as its default schema generator.

        ```python
        INSTALLED_APPS = [
            # ...
            'rest_framework',
            'drf_spectacular',
            'drf_spectacular_sidecar', # Add this if you installed sidecar
        ]

        REST_FRAMEWORK = {
            'DEFAULT_SCHEMA_CLASS': 'drf_spectacular.openapi.AutoSchema',
        }
        ```

    3. **Configure Schema Metadata**:Add a `SPECTACULAR_SETTINGS` dictionary to your `settings.py` to define the title, version, and UI preferences.

        ```python
        SPECTACULAR_SETTINGS = {
            'TITLE': 'Your Project API',
            'DESCRIPTION': 'Detailed description of your API service',
            'VERSION': '1.0.0',
            'SERVE_INCLUDE_SCHEMA': False,
            # If using sidecar for local static files:
            'SWAGGER_UI_DIST': 'SIDECAR',
            'SWAGGER_UI_FAVICON_HREF': 'SIDECAR',
            'REDOC_DIST': 'SIDECAR',
        }
        ```

    4. **Define URL Patterns**:To render the schema in a browser (like Swagger or ReDoc), you need to add specific routes to your project's `urls.py`.

        ```python
        from drf_spectacular.views import SpectacularAPIView, SpectacularRedocView, SpectacularSwaggerView
        from django.urls import path

        urlpatterns = [
            # ... your other patterns
            
            # 1. The actual schema export (JSON/YAML)
            path('api/schema/', SpectacularAPIView.as_view(), name='schema'),
            
            # 2. Swagger UI:
            path('api/docs/swagger/', SpectacularSwaggerView.as_view(url_name='schema'), name='swagger-ui'),
            
            # 3. ReDoc UI (Alternative):
            path('api/docs/redoc/', SpectacularRedocView.as_view(url_name='schema'), name='redoc'),
        ]
        ```

    5. **Render and View the Schema**:Once your server is running, you can access the documentation through your browser:

        -    **Swagger UI:** Go to `http://127.0.0.1:8000/api/docs/swagger/` to interact with your API.
        -    **ReDoc:** Go to `http://127.0.0.1:8000/api/docs/redoc/` for a clean, three-panel documentation view.
        -    **Raw Schema:** Go to `http://127.0.0.1:8000/api/schema/` to download the `schema.yml` file.

    6. **Customizing Endpoints (Optional)**:If you need to add specific descriptions or define custom responses for a view, use the `@extend_schema` decorator in your `views.py`.

        ```python
        from drf_spectacular.utils import extend_schema

        class MyView(APIView):
            @extend_schema(
                summary="Fetch user profile",
                description="This endpoint returns specific user details.",
                responses={200: MySerializer}
            )
            def get(self, request):
                # ... logic
        ```

    -   **Generate a static file (`schema.yml`)**:

        -   `$ python manage.py spectacular --file schema.yml`

        > The `schema.yml` file is the "source of truth" for your API. It follows the **OpenAPI Specification (OAS)**, which is a universally recognized standard for describing RESTful APIs in a machine-readable format. Here is a breakdown of its purpose, usage, and how to render it.

        1. **The Purpose of `schema.yml`**:Think of `schema.yml` as a **contract** between the backend and anyone who uses the API (frontend developers, mobile developers, or third-party integrators). It defines:

            -   **Endpoints:** Every available URL (e.g., `/api/users/`).
            -   **Methods:** What actions are allowed (GET, POST, PUT, DELETE).
            -   **Parameters:** What inputs the API expects (query params, headers, or body data).
            -   **Data Models:** The exact structure of the JSON sent or received.
            -   **Authentication:** Which endpoints require a token or session.

        2. **How is it Used?**:Generating this file isn't just for show; it powers several automated workflows:

            -   **Automated Documentation:** Tools like Swagger UI and ReDoc read this file to create the interactive "Try it out" pages you see in your browser.
            -   **Client Code Generation:** Frontend teams can use tools like `openapi-generator` to automatically create TypeScript interfaces or API fetch functions based on your schema. This prevents "broken" integrations when field names change.
            -   **API Testing:** You can import `schema.yml` into tools like **Postman** or **Insomnia** to instantly create a collection of requests without typing them manually.
            -   **Contract Testing:** In CI/CD pipelines, you can run tests to ensure that the code actually behaves exactly as the `schema.yml` says it should.

        3. **Is it possible to render `schema.yml`?**:Yes, absolutely. Since a `.yml` file is just a text file, "rendering" it means turning that text into a visual, interactive interface.

            -   **Method A**: Inside your Django Project (Live)

                > If you have `drf-spectacular` installed, you don't even need to handle the file manually. The views you added to `urls.py` do the rendering for you:

                -   **SwaggerView:** Renders the schema as an interactive sandbox.
                -   **RedocView:** Renders the schema as a clean, searchable technical manual.

            -   **Method B**: Static/External Rendering

                > If someone gives you a `schema.yml` file and you want to see what the API looks like without running a server:

                1. **Swagger Editor:** Go to [editor.swagger.io](https://editor.swagger.io/) and paste the content of your `schema.yml`. It will render the UI on the right side instantly.
                2. **VS Code Extensions:** Install "OpenAPI (Swagger) Editor" to preview the documentation directly inside your IDE.
                3. **Redoc CLI:** You can use a command-line tool to turn the YAML into a single, standalone HTML file:
                ```bash
                npx @redocly/cli build-docs schema.yml
                ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Django Security Features</summary>

    ##### CSRF (Cross Site Request Forgery)

    -   [CSRF Documentation](https://docs.djangoproject.com/en/4.2/ref/csrf/)
    -   [How to use Django’s CSRF protection](https://docs.djangoproject.com/en/4.2/howto/csrf/#using-csrf)
    -   [Security tips for web developers](https://www.squarefree.com/securitytips/web-developers.html#CSRF)

    **Cross-Site Request Forgery** (CSRF) is a type of web vulnerability where an attacker tricks a user into performing actions on a website without their knowledge or consent. Django, being a security-focused web framework, provides robust CSRF protection by default. Let's dive into the details of how CSRF protection works in Django:
    CSRF protection is a mechanism of guarding against a particular type of attack, which can occur when a user has not logged out of a web site, and continues to have a valid session. In this circumstance a malicious site may be able to perform actions against the target site, within the context of the logged-in session.

    -   To guard against these type of attacks, you need to do two things:

        -   Ensure that the 'safe' HTTP operations, such as `GET`, `HEAD` and `OPTIONS` cannot be used to alter any server-side state.
        -   Ensure that any 'unsafe' HTTP operations, such as `POST`, `PUT`, `PATCH` and `DELETE`, always require a valid CSRF token.

    -   If you're using `SessionAuthentication` you'll need to include valid CSRF tokens for any `POST`, `PUT`, `PATCH` or `DELETE` operations.

    -   In order to make AJAX requests, you need to include CSRF token in the HTTP header, as described in the Django documentation.

    -   **Django's CSRF Protection Mechanism**: Django's CSRF protection is designed to prevent unauthorized requests from being processed. Here's how it works:

        -   `Middleware`:

            -   Django includes a middleware component called `django.middleware.csrf.CsrfViewMiddleware`. This middleware is responsible for adding CSRF tokens to outgoing forms and checking incoming requests for valid tokens.

        -   `CSRF Token Generation`:

            -   When a user visits a Django website, the server generates a unique CSRF token for that user's session. This token is a random string.

            -   The token is stored both in the session data (server-side) and as a cookie in the user's browser (client-side).

        -   `Token Inclusion in Forms`:

            -   When rendering an HTML form, Django's template system automatically includes the CSRF token as a hidden field within the form.

                ```html
                <form method="post" action="/example/">
                    {% csrf_token %}
                    <!-- other form fields -->
                    <input type="submit" value="Submit" />
                </form>
                ```

            -   The `{% csrf_token %}` template tag inserts the CSRF token.

        -   `Token Validation on Submission`:

            -   When the user submits the form, the token value from the hidden field is included in the POST data.

            -   Upon receiving the POST request, Django's `CsrfViewMiddleware` checks the submitted token against the token stored in the user's session.

            -   If the tokens match, the request is considered legitimate, and the action (e.g., form submission) is allowed to proceed.

            -   If the tokens do not match or if no token is included in the request, Django raises a CSRFTokenMissing or CSRFTokenError exception, depending on the circumstances.

        -   `Token Rotation`:

            -   To prevent certain types of attacks, Django rotates (changes) the CSRF token for a user's session whenever they log in or log out.

            -   This means that even if an attacker manages to obtain a valid token, it becomes useless once the user logs out or their session expires.

    -   **CSRF Protection in Practice**:

        -   Django's CSRF protection is transparent to developers and is automatically applied to all forms generated using Django's form system.
        -   Developers don't need to manually verify CSRF tokens; Django does this automatically. Here's what developers need to do:

            -   Use Django's built-in form system to render forms (`{% csrf_token %}` is automatically included).
            -   Ensure that all POST requests (form submissions) are protected by CSRF tokens.

    -   **Limitations**: While Django's CSRF protection is effective, there are a few considerations

        -   `It relies on cookies`: CSRF protection depends on the browser storing and sending the CSRF cookie, which may not work in some situations (e.g., when using an API with a client that doesn't support cookies).

        -   `AJAX requests`: For AJAX requests, developers need to ensure that the CSRF token is included in the request headers manually.

        -   `Same-origin policy`: CSRF protection assumes that the attacker can't make cross-origin requests with the user's credentials. If there are weaknesses in the same-origin policy (e.g., CORS misconfigurations), CSRF attacks may still be possible.

    In summary, Django's CSRF protection is a robust defense against CSRF attacks, and it's seamlessly integrated into the framework. Developers should ensure that they use Django's form system correctly and be aware of the limitations when dealing with non-standard scenarios.

    ##### CORS (Cross Origin Resource Sharing): [Django CORS Guide](https://www.stackhawk.com/blog/django-cors-guide/)

    Cross-Origin Resource Sharing (CORS) is a security feature implemented by web browsers to prevent unauthorized cross-origin requests. It allows servers to specify who can access their resources and under what conditions. This is particularly important in the context of web applications where resources from different origins (domains, protocols, or ports) might need to interact.

    -   **Same-Origin**: When a request is made to a resource on the same origin as the requesting application, it is considered a **same-origin request**.

        -   **Definition of Origin**: An origin is defined as a combination of:

            1. **Protocol** (e.g., `http` or `https`)
            2. **Domain** (e.g., `example.com`)
            3. **Port** (e.g., `80`, `443`, or custom)

        -   **Examples of Same-Origin**: A request is **same-origin** if all three components are identical between the client and the server.

            -   Client: `http://example.com/page.html`
            -   Server: `http://example.com/api/resource`

                -   **Same Protocol**: `http`
                -   **Same Domain**: `example.com`
                -   **Same Port**: Implicit `80` (default for HTTP)

            -   These requests do not trigger CORS because browsers consider them secure by default.

    -   **Cross-Origin**: When a request is made to a resource on a different origin than the requesting application, it is considered a **cross-origin request**.

        -   **When is a Request Cross-Origin?**: A request becomes cross-origin if any of the following differ between the client and server:

            1. **Protocol**: e.g., `http://example.com` vs. `https://example.com`
            2. **Domain**: e.g., `http://example.com` vs. `http://api.example.com`
            3. **Port**: e.g., `http://example.com:80` vs. `http://example.com:8080`

        -   **Examples of Cross-Origin**

            1. **Different Domain**:
                - Client: `http://example.com`
                - Server: `http://api.example.com`
            2. **Different Protocol**:
                - Client: `http://example.com`
                - Server: `https://example.com`
            3. **Different Port**:

                - Client: `http://example.com:80`
                - Server: `http://example.com:8080`

            4. These requests are blocked by browsers by default unless the server explicitly allows them via CORS.

    In the context of Django Framework, CORS comes into play when you have a web application running on one domain (origin) and it needs to make requests to a server on another domain (different origin). By default, web browsers restrict such requests due to security reasons, but CORS allows servers to specify which origins are allowed to access their resources. Here's how CORS works in Django:

    -   **Middleware**: Django doesn't provide built-in CORS support out of the box, but you can implement it using middleware. You can write custom middleware to intercept incoming requests and modify responses to include CORS headers. Alternatively you can install Django package like `django-cors-headers` for handling CORS.

        -   `$  pip install django-cors-headers`
        -   After installation, you need to add it to your INSTALLED_APPS and MIDDLEWARE in your Django settings:

            ```python
            # settings.py
            INSTALLED_APPS = [
                'corsheaders',
            ]

            MIDDLEWARE = [
                'corsheaders.middleware.CorsMiddleware',
            ]
            ```

    -   **CORS headers**: When a browser makes a cross-origin request, it sends an **Origin** header indicating the origin of the requesting page. The server can then determine whether to allow the request based on this header. If the server allows the request, it responds with appropriate CORS headers, such as **Access-Control-Allow-Origin**, **Access-Control-Allow-Methods**, **Access-Control-Allow-Headers**, etc.

    -   **Configuration**: In Django, you can configure CORS middleware to allow requests from specific origins, methods, headers, and other criteria. This configuration can be done in your Django settings file.

        -   With django-cors-headers installed and configured, you can control CORS behavior in your Django project's settings. For example, you might allow all origins (not recommended for production) or specify specific origins that are allowed to access your API:

        ```python
        # settings.py
        CORS_ALLOWED_ORIGINS = [
            "http://localhost:3000",  # Example: Allow requests from a specific frontend
            "https://yourfrontenddomain.com",
        ]
        ```

    -   **Handling Preflight Requests**: For certain types of cross-origin requests, such as those using HTTP methods other than GET, POST, or HEAD, the browser sends a preflight request (HTTP OPTIONS) to determine if the actual request is safe to send. The server must respond to these preflight requests with appropriate CORS headers indicating whether the actual request is allowed. Django-cors-headers takes care of handling preflight requests by default.

    -   **Security Considerations**: While CORS allows controlled access to resources from different origins, it's important to configure it securely to prevent unauthorized access. You should carefully consider which origins, methods, and headers are allowed to ensure the security of your application.

    It's important to configure CORS thoughtfully to strike a balance between security and the functional requirements of your web application. Always consider the security implications, especially if you are allowing cross-origin requests from multiple domains.

    ##### Cross-Site Scripting (XSS)

    Cross-Site Scripting (XSS) is a common web application security vulnerability that occurs when an attacker injects malicious scripts (typically JavaScript) into web pages that are then viewed by other users. These scripts execute in the context of the user's browser, potentially leading to unauthorized access, data theft, session hijacking, or other security breaches.

    In the context of the Django framework, XSS vulnerabilities can occur if web developers do not properly handle and sanitize user-generated content or input. Django provides several built-in features and best practices to mitigate the risk of XSS:

    -   `Django Templates and Autoescaping`: Django templates use an autoescape feature by default. This means that by wrapping any data within template tags, such as {{ variable }}, Django will automatically escape the content to ensure it's safe to render in the HTML. For example, if a user-provided input is displayed using {{ user_input }}, any HTML or JavaScript in the input will be escaped, rendering it harmless.

    -   `Safe Unescaping`: Sometimes, you may need to include HTML or JavaScript in your templates. In such cases, you can use the |safe filter to explicitly mark content as safe. However, use this with caution, as it can introduce vulnerabilities if not handled correctly.

    -   `Middleware and Content Security Policies (CSP)`: Django allows you to add middleware to set Content Security Policies (CSP) in your application. CSP headers can restrict the sources from which content can be loaded, mitigating the risk of loading malicious scripts.

    -   `Input Validation and Sanitization`: Always validate and sanitize any user input on the server side. Django provides form handling mechanisms that help you define what is valid input.

    -   `Cross-Site Request Forgery (CSRF) Protection`: Protect your application against CSRF attacks using Django's built-in CSRF protection. This ensures that any actions requiring state-changing requests are performed by the user intentionally.

    -   `Avoiding Inline JavaScript`: Whenever possible, avoid using inline JavaScript within HTML elements. Use event handlers and external JavaScript files.

    Here's an example of a simple Django template that demonstrates how autoescaping works:

    ```html
    <!DOCTYPE html>
    <html>
        <head>
            <title>XSS Example</title>
        </head>
        <body>
            <h1>{{ user_input }}</h1>
        </body>
    </html>
    ```

    In this example, if the user_input variable contains malicious JavaScript, it will be automatically escaped and displayed as plain text, making it safe.

    By following best practices, using Django's built-in security features, and being cautious about user-generated content, you can significantly reduce the risk of XSS vulnerabilities in your Django applications. Security should always be a top priority when developing web applications to protect both your application and your users.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Importing Objects</summary>

    ```python
    ========================================================================================

    from django.contrib.auth.models import User, AbstractBaseUser, BaseUserManager, Group, Permission, PermissionsMixin
    from django.contrib.auth import login, logout, get_user_model
    from django.contrib.auth.decorators import login_required
    from django.contrib.auth.views import LoginView, LogoutView
    from django.contrib.auth.forms import UserCreationForm, AuthenticationForm, PasswordResetForm, SetPasswordForm
    from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
    from django.contrib.auth.tokens import PasswordResetTokenGenerator

    from django.contrib import admin, messages
    from django.contrib.admin import ModelAdmin
    from django.contrib.sites.shortcuts import get_current_site

    from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
    from django.views.decorators.csrf import csrf_exempt

    from django.urls import include, path, reverse
    from django.conf import settings
    from django.conf.urls.static import static

    from django.http import HttpResponse, JsonResponse
    from django.utils import reverse, timezone
    from django.utils.encoding import force_bytes, force_text
    from django.utils.http import urlsafe_base64_decode, urlsafe_base64_encode
    from django.shortcuts import render, redirect, get_object_or_404

    from django.db import models
    from django.db.models.functions import Coalesce

    from django.template.loader import render_to_string
    from decimal import Decimal
    from six import text_type
    from django.forms.models import model_to_dict
    # =============================================================================

    from django.core.mail import send_mail
    send_mail('Subject here','Here is the message.','from@example.com',['to@example.com'],fail_silently=False,)
    ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Deployment</summary>

    -   [Top 5 Most-Used Deployment Strategies](https://www.youtube.com/watch?v=AWVTKBUnoIg)
    -   [How to use Django with uWSGI](https://docs.djangoproject.com/en/4.2/howto/deployment/wsgi/uwsgi/)
    -   [How to use Django with Gunicorn](https://docs.djangoproject.com/en/4.2/howto/deployment/wsgi/gunicorn/)
    -   [Setting up Django and your web server with uWSGI and nginx](https://uwsgi-docs.readthedocs.io/en/latest/tutorials/Django_and_nginx.html#)
    -   [Deploying Django with Docker Compose](https://www.youtube.com/watch?v=mScd-Pc_pX0&t=1928s)

    -   `Gunicorn` vs `uWSGI` vs `Uvicorn`: `Gunicorn`, `uWSGI` and `Uvicorn` are popular Python WSGI (Web Server Gateway Interface) servers that are commonly used to serve Python web applications.
        -   **Gunicorn** (short for Green Unicorn) is a Python WSGI HTTP server that is designed to be lightweight, fast, and easy to use. It can handle multiple requests concurrently and can scale to handle large numbers of requests. `Gunicorn` is commonly used in conjunction with a reverse proxy server, such as `Nginx` or `Apache`, which handles incoming requests and passes them on to `Gunicorn`.
        -   **uWSGI** is a more feature-rich WSGI server that is designed to be highly configurable and extensible. It supports multiple protocols and interfaces, including WSGI, FastCGI, and HTTP. `uWSGI` is known for its ability to handle high traffic volumes and its support for a variety of advanced features, including load balancing, caching, and process management.
        -   **Uvicorn**: Uvicorn is an ASGI (Asynchronous Server Gateway Interface) server that is used to run asynchronous web applications written in Python. ASGI is a specification for asynchronous web servers and applications, allowing for better support of long-lived connections and real-time communication.
    -   `Apache` is a popular web server that has been around for a long time. It is widely used and supports a wide range of features and modules, making it highly configurable and adaptable to different use cases. `Apache` is primarily used for serving static content and dynamic content through the use of modules such as PHP or Python.
    -   `Nginx` is a newer web server that has gained popularity in recent years due to its high performance and scalability. `Nginx` is designed to handle large volumes of traffic and can serve both static and dynamic content. `Nginx` is often used as a **reverse proxy** in front of other web servers, such as `Apache` or `Tomcat`, to improve performance and reliability.
    -   `Tomcat` is a Java-based web server and application server that is designed to serve Java applications. It supports the Java Servlet and JavaServer Pages (JSP) specifications and is often used to serve Java web applications. `Tomcat` is highly configurable and can be extended through the use of plugins and modules.

    #### `Proxy Server` vs `Reverse Proxy Server`:

    -   `Proxy Server`: A proxy server acts as an intermediary between a client and a server. When a client makes a request to access a resource (e.g., a web page), the request is first sent to the proxy server. The proxy server then forwards the request to the destination server on behalf of the client. The response from the server is relayed back to the client through the proxy server. A proxy server can reside in various locations within a network architecture, depending on its intended purpose and the network's configuration; for example, On-Premises Network, Data Center, Cloud Environment, Content Delevary Networks (CDNs) etc. The key characteristics of a proxy server include:

        -   `Client-side configuration`: The client needs to be aware of and configured to use the proxy server.
        -   `Client anonymity`: The server sees the proxy server's IP address instead of the client's IP address.
        -   `Caching`: Proxy servers can cache responses, allowing subsequent requests for the same resource to be served directly from the cache instead of going to the server again.
        -   Proxy servers are often used for purposes such as improving performance through caching, controlling access to resources (e.g., content filtering, firewall), and providing anonymity for clients.

    -   `Reverse Proxy Server`: A reverse proxy server is similar to a proxy server but operates on the server-side instead of the client-side. It sits between the client and the destination server and forwards client requests to the appropriate backend servers based on various criteria (e.g., load balancing, request routing, SSL termination). The client is unaware of the presence of the reverse proxy and communicates directly with it. The key characteristics of a reverse proxy server include:

        -   `Server-side configuration`: The server is configured to use the reverse proxy to handle incoming requests.
        -   `Load balancing`: Reverse proxies distribute client requests across multiple backend servers to balance the load.
        -   `SSL termination`: Reverse proxies can handle SSL encryption/decryption, offloading this task from backend servers.
        -   `Caching`: Reverse proxies can also cache responses to improve performance.
        -   Reverse proxy servers are commonly used for load balancing, high availability, SSL termination, request routing, and as a security layer protecting backend servers by shielding them from direct access.

    -   The image below show how 'client', 'Nginx', and 'uWSGI' work together.

        -   ![server configuration for Django](/assets/django/nginx-uwsgi.webp)

    #### `Reverse Proxy Server` vs `Web Server Gateway Interface` (WSGI):

    A Reverse Proxy Server and a Web Server Gateway Interface (WSGI) serve different roles in web application architecture, but they are complementary components. Here's a comparison of the two:

    -   `Reverse Proxy Server`: A reverse proxy server is a server that sits between client devices and backend web servers. It receives incoming client requests, such as HTTP requests, and forwards those requests to the appropriate backend server or application.

        -   `Purpose`:

            -   `Load Balancing`: Reverse proxies can distribute client requests across multiple backend servers to balance the load and improve performance and reliability.
            -   `Security`: They can provide an additional layer of security by hiding the internal structure of the network and filtering out malicious traffic.
            -   `SSL Termination`: Reverse proxies can handle SSL/TLS encryption and decryption, offloading this resource-intensive task from the backend servers.
            -   `Caching`: They can cache frequently requested content to reduce the load on backend servers and improve response times.

        -   `Examples`: `Nginx` and `Apache` HTTP Server are commonly used as reverse proxy servers. CDNs (Content Delivery Networks) often use reverse proxies to cache and serve static content.

    -   `Web Server Gateway Interface (WSGI)`: WSGI is a specification in Python that defines a standard interface between web servers and web applications or frameworks. It allows web servers to communicate with Python web applications in a consistent and standardized way.

        -   `Purpose`:

            -   WSGI serves as an interface between a web server and a Python web application or framework.
            -   It allows different web servers to run Python web applications written using various frameworks, such as Flask, Django, or Pyramid.

        -   `Examples`: Popular Python web servers like `Gunicorn`, `uWSGI`, and `mod_wsgi` (for Apache) implement the WSGI standard. Python web frameworks, including Flask and Django, can be deployed using WSGI servers.

    -   `Relationship`:

        -   `A reverse proxy server and WSGI serve different but complementary roles`:

            -   The reverse proxy server handles tasks like load balancing, SSL termination, and security at the network level, sitting between clients and backend servers.
            -   WSGI, on the other hand, handles the communication between a web server and a Python web application at the application level, allowing the Python code to receive and process HTTP requests.

        -   In a typical web application architecture, a reverse proxy server (e.g., Nginx) may be used to handle tasks like load balancing and SSL termination, while a WSGI server (e.g., Gunicorn or uWSGI) interfaces with the Python web application to serve dynamic content.

    In summary, a reverse proxy server and WSGI serve different purposes in web application architecture. The reverse proxy manages network-level tasks, while WSGI provides a standardized interface for communication between web servers and Python web applications. Together, they enable the deployment of Python web applications in a scalable and secure manner.

    #### ASGI (Asynchronous Server Gateway Interface):

    ASGI is a specification for asynchronous web servers and frameworks in Python. It allows Python web applications to handle asynchronous operations, such as long-lived connections and real-time communication, in an efficient and non-blocking manner.

    ASGI servers are the web servers that implement the ASGI specification. These servers are responsible for handling incoming ASGI requests and routing them to the appropriate ASGI application or framework. Some popular ASGI servers include Daphne, Uvicorn, Hypercorn, and more. Uvicorn, for example, is widely used and known for its simplicity and performance.

    -   `Purpose`:

        -   ASGI is designed to handle asynchronous web applications and services that require real-time interactions, like chat applications, streaming, and server-sent events.
        -   It provides a standardized interface for handling asynchronous HTTP requests and WebSocket connections.

    -   `Usage`:

        -   ASGI servers are commonly used with asynchronous web frameworks like FastAPI and Starlette to build high-performance web applications that require real-time capabilities.
        -   To run an ASGI application with a server like Uvicorn, you typically use a command like this:

            -   `$ uvicorn core.asgi:app --host 0.0.0.0 --port 8000`
            -   In this example, `asgi` is the Python module in `core` directory which containing your ASGI application instance assigned to `app` variable (`app` is the instance of your ASGI application within that module).

    -   <details><summary style="font-size:20px;color:#C71585">gunicorn (Green Unicorn)</summary>

        **Gunicorn** (short for "Green Unicorn") is a production-grade, Python **WSGI HTTP Server**. If you've been using `python manage.py runserver` to view your Django site, you've been using a "development server." It’s great for coding, but it’s fragile and can only handle one request at a time. Gunicorn is the "grown-up" version designed to handle real-world internet traffic.

        > **Gunicorn** is the bridge that takes incoming web traffic and distributes it across multiple Python processes to ensure your app stays fast, stable, and concurrent.

        1. **What is it used for?**: In a production environment, your web stack usually looks like a relay race. Gunicorn sits in the middle:
            1. **Nginx (The Gatekeeper):** Handles SSL, static files, and buffering. It receives the request from the user and hands it off to...
            2. **Gunicorn (The Translator):** It takes the request from Nginx and translates it into a format your Python code understands (WSGI). It manages multiple "workers" to handle many users at once.
            3. **Django/Flask (The Brains):** Your code processes the request and sends a response back through Gunicorn to Nginx, then to the user.

        2. **How it Works: The "Pre-fork Worker Model"**: Gunicorn’s secret sauce is its **Pre-fork** architecture. Here is the breakdown:
            - **The Master Process:** Think of this as the "Manager." It doesn't handle actual web requests. Its only job is to spawn, manage, and kill worker processes. If a worker dies, the Master immediately creates a new one.
            - **The Worker Processes:** These are the "Employees." When a request comes in, one of these workers picks it up, runs your Python code, and returns the result.

            Because Gunicorn "pre-forks" (creates) these workers before the requests arrive, it can handle multiple concurrent users much more efficiently than a single-threaded development server.

        3. **Key Concepts & Terms**:

            | Term             | Explanation                                                                                                                                                                |
            | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
            | **WSGI**         | Web Server Gateway Interface. It is the standardized "handshake" protocol that allows web servers (like Gunicorn) to talk to Python applications.                          |
            | **Workers**      | The number of simultaneous processes running. A common formula is .                                                                                                        |
            | **Worker Class** | The type of worker. "Sync" (default) is for standard tasks. "Gevent" or "Eventlet" are "async" workers used if your app stays connected for a long time (like WebSockets). |
            | **Binding**      | Telling Gunicorn which IP and Port to listen on (e.g., `127.0.0.1:8000`).                                                                                                  |
            | **Timeout**      | How long Gunicorn will wait for a worker to finish a request before killing it and restarting (default is 30 seconds).                                                     |

        4. **Why can't I just use `runserver`?**: Using Django’s `runserver` in production is like trying to use a golf cart to pull a semi-truck.
            - **Concurrency:** `runserver` is usually single-threaded. If one user triggers a heavy 10-second report, _everyone else_ is blocked until it's done.
            - **Stability:** If your code crashes on one request, `runserver` might die entirely. Gunicorn just kills that specific worker and moves on.
            - **Security:** Development servers aren't audited for security and are vulnerable to various types of denial-of-service attacks.


        -   `gunicorn.socket` vs `gunicorn.service`: these are systemd units used for running Gunicorn, a Python WSGI HTTP server. They serve different purposes within the systemd service management system.

            -   `gunicorn.socket`: This file represents a Socket Unit which nanage inter-process communication through sockets. It defines a system socket that listens for incoming connections and passes them to the associated service unit (`gunicorn.service`). The `gunicorn.socket` unit allows systemd to manage the socket activation process, where the socket is created on-demand when a connection is received. This helps improve resource usage by only starting the Gunicorn process when needed.
            -   `gunicorn.service`: This file represents a Service Unit. It defines the Gunicorn service that handles the incoming connections received through the associated socket (`gunicorn.socket`). The `gunicorn.service` unit specifies the command to start the Gunicorn process, along with its configuration options and other settings.

        -   `$ gunicorn core.wsgi:application --bind 0.0.0.0:8000`
            -   specifies the network address and port to bind the server to:
                -   `0.0.0.0` means the server will listen on all available network interfaces, making it accessible from any host.
                -   `8000` is the port number the server will listen on.
        -   `$ gunicorn core.wsgi:application --config ./gunicorn_config.py`

        </details>

    -   <details><summary style="font-size:20px;color:#C71585">hypercorn</summary>

        **Hypercorn** is an ASGI (Asynchronous Server Gateway Interface) web server. If Gunicorn is the "Sync" veteran and Uvicorn is the "Speed" specialist, Hypercorn is the **"Protocol Powerhouse."**

        It was originally part of the **Quart** framework (an async version of Flask) before being spun out as a standalone server. It is built using "sans-io" libraries (like `h11`, `h2`, and `wsproto`), which means the logic of the protocols is separated from the network code, making it incredibly robust and flexible.

        1. **What is it used for?**: Hypercorn is used to serve modern, asynchronous Python web applications. Its main selling point is **protocol completeness**.

            1. **Serving Async Frameworks:** It is the primary way to run frameworks like **FastAPI, Quart, and Starlette** in production.
            2. **Modern Web Protocols:** It is often chosen specifically when a project needs native **HTTP/2** or **HTTP/3 (QUIC)** support, which many other Python servers lack or handle only partially.
            3. **Hybrid Environments:** Because it can wrap WSGI apps (like Django or Flask) in an ASGI interface, it can be used to "modernize" older apps without changing their code.

        2. **Key Components & Concepts**

            -   **The ASGI Interface**: The "spiritual successor" to WSGI. Unlike WSGI, which is strictly "one request, one response," ASGI allows for a constant stream of communication. This is what makes real-time features like **WebSockets** and **Server-Sent Events (SSE)** possible.

            -   **Protocol Handlers**: Hypercorn is unique because of its native support for a wide range of protocols:

                * **HTTP/1.1:** The legacy standard.
                * **HTTP/2:** Supports multiplexing (sending multiple files over one connection) and **Server Push**.
                * **HTTP/3 (QUIC):** The newest standard that runs over UDP instead of TCP, reducing latency significantly for mobile users and unstable connections.

            -   **Flexible Event Loops**: While most servers are locked into one way of handling tasks, Hypercorn allows you to choose your "engine":

                * **asyncio:** The Python standard library loop.
                * **uvloop:** A high-performance drop-in replacement for asyncio (often used for speed).
                * **Trio:** A newer, "human-friendly" async library that focuses on structured concurrency.

        3. **Hypercorn vs. Gunicorn vs. Uvicorn**: To understand Hypercorn, you have to see where it fits in the family tree:

            | Feature              | Gunicorn                 | Uvicorn                   | Hypercorn               |
            | -------------------- | ------------------------ | ------------------------- | ----------------------- |
            | **Primary Standard** | WSGI (Sync)              | ASGI (Async)              | ASGI (Async)            |
            | **Speed**            | Moderate                 | **Fastest** (with uvloop) | High                    |
            | **HTTP/2 Support**   | No                       | Partial (experimental)    | **Full Support**        |
            | **HTTP/3 Support**   | No                       | No                        | **Yes** (optional)      |
            | **WebSockets**       | No                       | Yes                       | **Yes**                 |
            | **Best For**         | Traditional Django/Flask | High-speed FastAPI        | Complex Protocols/Quart |

        4. **Important Terms to Know**

            * **QUIC:** The underlying transport protocol for HTTP/3. It's designed to be faster and more secure than traditional TCP.
            * **ALPN (Application-Layer Protocol Negotiation):** A TLS extension that Hypercorn uses to "negotiate" with the browser to decide whether to use HTTP/1.1 or HTTP/2 during the initial handshake.
            * **Worker Class:** Just like Gunicorn, Hypercorn can spawn multiple "workers." You can specify the type (e.g., `--worker-class trio`) depending on your application's needs.
            * **Backpressure:** A concept Hypercorn manages where it slows down receiving data if the application is too busy to process it, preventing the server from crashing under load.

        > **Pro Tip:** If you just want raw speed for a simple REST API, go with **Uvicorn**. If you need your Python app to serve **HTTP/2 or HTTP/3** directly to the internet without a heavy proxy like Nginx in the way, **Hypercorn** is your best bet.

        </details>

    -   <details><summary style="font-size:20px;color:#C71585">uvicorn</summary>

        -   `uvicorn myapp:app --host 0.0.0.0 --port 8000`

            -   `myapp` refers to the Python module containing your ASGI application.
            -   `app` is the instance of your ASGI application within that module.
            -   `--host` and `--port` options specify the host and port on which `uvicorn` should listen.

        </details>

    -   <details><summary style="font-size:20px;color:#C71585">uWSGI</summary>

        -   [uWSGI (universal Web Server Gateway Interface)](https://uwsgi-docs.readthedocs.io/en/latest/index.html): It's a popular web server interface and application server gateway that facilitates communication between web servers and web applications, allowing them to work together seamlessly. uWSGI is commonly used in deploying Python web applications, but it supports multiple programming languages and frameworks.

        -   What is `uwsgi_params` file?

            -   The `uwsgi_params` file is a configuration file used by uWSGI, which is a fast and flexible application server commonly used for hosting Python web applications. The `uwsgi_params` file contains a set of predefined variables and configurations that are used to communicate between the web server (such as Nginx) and the uWSGI application server.
            -   The contents of the `uwsgi_params` file typically include directives that define how certain aspects of the communication between Nginx and uWSGI should be handled. These directives often include settings related to request buffering, proxying, and headers.
            -   Some common directives found in the `uwsgi_params` file include:

                -   `uwsgi_param QUERY_STRING $query_string;`

                    -   This directive sets the value of the QUERY_STRING variable to the value of the query string provided in the original HTTP request.

                -   `uwsgi_param REQUEST_METHOD $request_method;`

                    -   This directive sets the value of the REQUEST_METHOD variable to the HTTP request method (e.g., GET, POST, etc.).

                -   `uwsgi_param CONTENT_TYPE $content_type;`

                    -   This directive sets the value of the CONTENT_TYPE variable to the type of the content being sent in the request, such as "application/json" or "text/html".

                -   `uwsgi_param CONTENT_LENGTH $content_length;`
                    -   This directive sets the value of the CONTENT_LENGTH variable to the size of the content being sent in the request.

            -   These directives are used to pass information from Nginx to the uWSGI application server, enabling proper handling of requests and responses.
            -   The `uwsgi_params` file is typically included in the Nginx configuration when using uWSGI as the application server. It ensures that the necessary variables and configurations are available for the communication between Nginx and uWSGI to work correctly.
            -   It's important to note that the specific contents of the `uwsgi_params` file can vary depending on the configuration and requirements of your specific application or environment.

        </details>

    -   <details><summary style="font-size:20px;color:#C71585">Nginx</summary>

        -   [Learn Proper NGINX Configuration Context Logic](https://www.youtube.com/watch?v=C5kMgshNc6g&t=683s)
        -   [How to Deploy Django on Nginx with uWSGI (full tutorial)](https://www.youtube.com/watch?v=ZpR1W-NWnp4&t=21s)
        -   [How to Secure Nginx with Lets Encrypt on Ubuntu 20.04 with Certbot?](https://www.youtube.com/watch?v=R5d-hN9UtpU)

        #### Terms and Concepts

        -   `nginx.conf`: The nginx configuration file, typically named `nginx.conf`, is a text-based file that specifies how the Nginx web server should behave. The `nginx.conf` file is written in a language called NGINX configuration language or NGINX Configuration Syntax. It is a custom configuration syntax specific to NGINX. It contains a set of directives within different contexts to specify their scope and define various aspects of server functionality, such as server listening ports, request handling, load balancing, caching, and security settings. The main contexts in an `nginx.conf` file are:

        -   `default.conf.tpl`: It is a template file for a server block configuration in Nginx. A server block (also known as a virtual host) is a configuration that defines how Nginx should handle requests for a specific domain or IP address. The ".tpl" extension suggests that this file is a template that can be used to generate an actual default.conf file. Typically, you would have multiple `*.conf.tpl` files, each representing a different virtual host configuration template.

        -   `Main Context`: The main context includes directives that apply globally to the entire Nginx server. It is typically defined within the http block. Directives within this context affect the overall behavior of the server, such as the number of worker processes, the user and group that the server runs as, and the configuration for logging. It typically contains directives such as server, upstream, and include.

            -   ![Main Context](/assets/nginx/main-context.png)

        -   `Events Context`: The events context, also defined within the http block, is used to configure how Nginx handles connections and events. Directives in this context control parameters such as the maximum number of connections, the worker connections, and the multi_accept setting.

        -   `HTTP Context`: The HTTP context contains server-level configurations and is defined within the http block. It includes directives related to HTTP protocol settings, server-wide proxies, gzip compression, SSL/TLS settings, and default MIME types. Server blocks (virtual servers) are typically defined within the HTTP context.

        -   `Server Context`: The server context defines the configuration for a specific virtual server (server block). It is contained within the http context and includes directives that apply to a particular server or group of servers. Directives within the server context may include the server name, listening ports, SSL/TLS configurations, proxy settings, and location blocks.

        -   `Location Context`: The location context is defined within a server context and is used to configure how Nginx handles specific URL patterns or paths. Directives within the location context determine how requests matching the specified pattern are processed. Examples of directives within the location context are root, try_files, proxy_pass, rewrite, and access control directives such as allow and deny.

        -   `Directive`: A directive is a command that configures a specific aspect of the server's behavior. Each directive is placed within the appropriate context to ensure it is applied at the desired level, whether it is server-wide, specific to a virtual server, or for handling requests matching a particular URL pattern. The context hierarchy and directive placement allow for fine-grained control over the server's behavior and functionality. It's important to note that the structure and directives in the `nginx.conf` file may vary depending on the specific setup and requirements of your web server. Understanding the purpose and proper usage of each directive is essential for configuring Nginx to meet your application's needs. Examples of commonly used directives are:

            -   ![Directives](/assets/nginx/directives.png)

            -   `listen`: Specifies the IP address and port on which Nginx should listen for incoming requests.
            -   `server_name`: Defines the domain name(s) associated with the server block.
            -   `root`: Specifies the document root directory where static files are located.
            -   `proxy_pass`: Forwards requests to a specified backend server.
            -   `try_files`: Defines the fallback behavior for file requests that do not exist.
            -   `ssl_certificate and ssl_certificate_key`: Configures SSL/TLS certificates for secure connections.
            -   `gzip`: Enables compression of HTTP responses to reduce file size.
            -   `access_log and error_log`: Specifies the log file locations for access and error logging.

        -   `Block` vs `Context`: In Nginx configuration files, the terms "block" and "context" are often used interchangeably to refer to a section of directives that serve a specific purpose. The distinction between blocks and contexts can be a bit nuanced, but in general, blocks refer to the specific groups of directives enclosed within curly braces, while contexts refer to the overall hierarchical structure and scope of the configuration file.

        -   `Block`: A block in Nginx refers to a group of directives enclosed within curly braces {}. Blocks define the scope and boundaries of a configuration section and determine where directives are applicable. There are several types of blocks in an nginx.conf file:

        -   `Include Directive`: The include directive in Nginx is used to include external configuration files within the main `nginx.conf` file. It allows you to split your configuration into multiple files for better organization and easier maintenance. Using the include directive can help simplify the management of complex configurations by dividing them into smaller, modular files. It allows you to reuse common configurations across multiple server blocks, separate different aspects of the configuration, and make it easier to maintain and update your Nginx setup. Here's how the include directive works:

            -   `Syntax`: The include directive is written as follows:

                ```txt
                include file_path;
                ```

                -   `file_path` represents the path to the external configuration file you want to include. It can be an absolute path or a relative path to the nginx.conf file.

            -   `Usage`: The include directive can be used in various contexts within the nginx.conf file. For example:

                -   `Global context`: It can be placed in the main http block of the nginx.conf file to include global configurations that apply to the entire server.
                -   `Server context`: It can be placed within individual server blocks to include server-specific configurations.
                -   `Location context`: It can be placed within location blocks to include specific configuration snippets related to handling requests for specific URL patterns.

            -   `Multiple Includes`: You can use multiple include directives to include multiple configuration files. They can be specified in the same context or in different contexts, depending on where you want the configurations to apply. For example:

                ```txt
                include /path/to/file1.conf;
                include /path/to/file2.conf;
                ```

            -   `Wildcard Includes`: The include directive also supports wildcard patterns (_) to include multiple files that match a specific pattern. For example, you can use include /path/to/_.conf; to include all configuration files with the .conf extension in the specified directory.

        #### Basic Nignx Commands

        -   `$ nginx -v` → Check Nginx version
        -   `$ sudo nginx -t` → Check configuration file syntex before reloading
        -   `$ nginx -T` → Display current configuration
        -   `$ nginx -s reload` → Reload Nginx

        #### Configuration file

        -   `/ect/nginx/nginx.conf` → Main file location of Nginx
        -   `/ect/nginx/conf.d/*.conf` → Include file location of Nginx

        </details>

    </details>

---



