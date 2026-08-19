<details><summary style="font-size:30px;color:White">Python Terminology</summary>

-   **PYTHONPATH**:
    -   `PYTHONPATH` is an environment variable in Python that tells the interpreter where to locate the module files imported into a program. It is a colon-separated list of directories that the Python interpreter searches for modules when executing your code.
    -   When you try to import a module, Python looks for the module in the directories listed in sys.path. The PYTHONPATH environment variable allows you to customize this search path.
-   **sys.path**: In your Python script, you can modify the sys.path list to include the directories containing your Python modules.

    ```python
    import sys
    sys.path.append('/path/to/your/module')
    # Now you can import your module
    import your_module
    ```

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Analyze Different Import Errors</summary>

    -   **Absolute Import Errors**

        ```python
        import mymodule
        ```

        -   When `mymodule.py` is in the Python path or the same directory.
        -   **`ModuleNotFoundError: No module named 'mymodule'`**
        -   Caused when `mymodule` is not in `sys.path`.
        -   ✅ Fix: Ensure the module is in the working directory or use `PYTHONPATH`.

    -   **Relative Import Errors**

        ```python
        from ..utils import helper
        ```

        -   Only inside a **package** run using `python -m package.module`.
        -   **`ImportError: attempted relative import with no known parent package`**
        -   Caused when running a module as a script directly.
        -   ✅ Fix: Run using the `-m` flag:
        -   `python -m package.module`

        > In Python, relative imports use dot notation to specify the location of the module you want to import relative to the current file. A single dot `.` refers to the current package, while double dots `..` refer to the parent package.

        > However, you can't just use them anywhere. There are two "golden rules" for relative imports to work.

        -   **1. The File Must Be Part of a Package**: A relative import only works if the files involved are recognized as part of a Python package. Usually, this means the directory contains an `__init__.py` file (though modern Python often treats directories as packages implicitly).

        -   **You Must Run the Code as a Module**: This is where most people get stuck. If you try to run a script containing relative imports directly (e.g., `python my_script.py`), it will fail with a `ImportError: attempted relative import with no known parent package`.

            -   **Why?** Because when you run a file directly, Python sets its name to `__main__`. In this state, the file has no "parent" context; it thinks it is the root of the universe. To use relative imports, you must run your code using the module flag from **outside** the package:

            -   `python -m my_package.subpackage.my_script`

        -   **Visualizing the Structure**
            Imagine a project folder named `project_root`:

            ```text
            project_root/
            │
            ├── main.py
            └── my_package/
                ├── __init__.py
                ├── utils.py (contains 'helper')
                └── sub/
                    ├── __init__.py
                    └── script.py  <-- You are writing code here
            ```



            In `script.py`, if you want to access `helper` inside `utils.py`, you are moving "up" one level to the `my_package` folder and then looking for `utils`.
            **The Code:** `from ..utils import helper`

        -   **When to Use Them vs. Absolute Imports**

            | Feature         | Relative Import (`from .. import x`)                                                | Absolute Import (`from pkg.mod import x`)                             |
            | :-------------- | :---------------------------------------------------------------------------------- | :-------------------------------------------------------------------- |
            | **Refactoring** | **Easier.** You can rename the top-level package without breaking internal imports. | **Harder.** You must update every import if the package name changes. |
            | **Clarity**     | Can get confusing with many dots (`....`).                                          | Very clear; you always know exactly where the module is.              |
            | **Execution**   | Requires running via `python -m`.                                                   | Works more easily with direct script execution.                       |

        **The Bottom Line:** Use relative imports primarily when building large, redistributable libraries where the internal structure is tightly coupled. If you are building a simple application or a script you intend to run directly, **absolute imports** (starting from the project root) are usually much less of a headache.


    -   **Circular Import Errors**

        ```python
        # a.py
        from b import func_b

        # b.py
        from a import func_a
        ```

        -   **`ImportError` or `AttributeError: partially initialized module`**
        -   Occurs when two modules import each other directly or indirectly.
        -   ✅ Fix: Move imports inside functions or restructure the code.

    -   **Wildcard Import Errors**

        ```python
        from mymodule import *
        ```

        -   May import unintended names.
        -   **Namespace pollution.**
        -   **Cannot be used inside functions** (in Python 3+).
        -   ✅ Fix: Avoid `*` imports. Use explicit imports.

    -   **File Name Conflicts**

        ```python
        import json
        ```

        -   Having a local file named `json.py`.

        > 🔥 Error: **`AttributeError: module 'json' has no attribute 'loads'`**
        > ✅ Fix: Rename your file to avoid standard library conflicts.

    -   **Missing `__init__.py` in Packages**

        -   Trying to import from a subdirectory without `__init__.py` can fail (especially in older Python versions).
            > ✅ Fix: Add `__init__.py` files to define a package structure.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Scope and Namespace</summary>

    -   [Scope and Execution Context](https://realpython.com/python-scope-legb-rule/)
    -   [What Are Python Namespaces](https://code.tutsplus.com/tutorials/what-are-python-namespaces-and-why-are-they-needed--cms-28598)

    ```python
    def check_namespace():
        # Define a variable in the local (function) namespace
        local_var = "I am in the local (function) namespace"

        # Use globals() to get a list of names in the global namespace
        global_namespace = list(globals().keys())

        # Use locals() to get a list of names in the global namespace
        local_namespace = list(locals().keys())

        # Use dir(__builtins__) to get a list of names in the built-in namespace
        built_in_namespace = dir(__builtins__)

        print(f"Local Namespace: \n\t{local_namespace}")
        print(f"Global Namespace: \n\t{global_namespace}")
        print(f"Built-in Namespace: \n\t{built_in_namespace}")

    # Call the function to check namespaces
    check_namespace()
    ```

    ##### What is Namespace in Python?

    A namespace is a container that holds a set of names and their corresponding objects, such as variables, functions, classes, etc. Namespaces are used to organize and manage the names used in a Python program to avoid naming conflicts.

    There are several namespaces, which are essentially mappings from names to objects. These namespaces help organize and manage the names used in a Python program. Here are the main namespaces in Python:

    -   **Built-in Namespace**:

        -   Contains built-in functions, exceptions, and types like print(), TypeError, int, etc.
        -   Automatically available in all Python programs without needing to import anything.

    -   **Global Namespace**:

        -   Contains names defined at the top level of a module or script.
        -   Variables, functions, classes, and other objects defined at the module level belong to the global namespace.
        -   Accessible from anywhere within the module or script.

    -   **Local Namespace**:

        -   Created when a function is called and destroyed when the function exits.
        -   Contains names defined within the function.
        -   Variables, parameters, and other objects defined inside a function belong to the local namespace.
        -   Accessible only within the function where they are defined.

    -   **Enclosing Namespace (or Nonlocal Namespace)**:

        -   Introduced by nested functions (functions defined inside other functions).
        -   Contains names from the enclosing function's local namespace that are referenced in the nested function.
        -   Allows nested functions to access variables from the enclosing scope.

    -   **Class Namespace**:

        -   Contains attributes (variables and methods) defined within a class.
        -   Each class has its own namespace.
        -   Class-level variables and methods are defined in this namespace.

    -   **Instance Namespace**:

        -   Created when an instance of a class is created.
        -   Contains attributes specific to each instance of the class.
        -   Instance variables are defined in this namespace and are unique to each instance.

    -   **Module Namespace**:

        -   Contains names defined within a module.
        -   Similar to the global namespace but specific to individual modules.
        -   All names defined in a module become attributes of the module object.

    These namespaces help Python manage the names used in a program, prevent naming conflicts, and provide scoping rules for variable access and resolution. Understanding namespaces is essential for writing clear, maintainable, and efficient Python code.

    When you use a name in your Python code, the interpreter looks for that name in the local namespace first, then in the enclosing namespace (if applicable), followed by the global namespace, and finally in the built-in namespace. This order is known as the LEGB rule (Local, Enclosing, Global, Built-in).

    ##### What is Scope in Python?

    A scope is a block of code where an object in Python remains relevant. Every object in Python rvesides in a scope. The concept of scope rules how variables and names are looked up in your code. It determines the visibility of a variable within the code. The scope of a name or variable depends on the place in your code where you create that variable.

    In Python, scope refers to the region of a program where a particular variable is accessible and can be referenced. It defines the visibility and lifetime of a variable within a program. Python has four main types of scope:

    -   `Local Scope` (Function Scope):

        -   Variables defined within a function have a local scope.
        -   Local variables can only be accessed within the function where they are defined.
        -   The lifetime of local variables is limited to the execution of the function. Once the function completes its execution, the local variables are destroyed.
        -   If a variable with the same name exists in both the local and global scope, the local variable takes precedence inside the function.

    -   `Enclosing Scope` (Nested Function Scope):

        -   When functions are defined within other functions (nested functions), they create an enclosing scope.
        -   Variables in the enclosing scope are accessible to the nested function, but not to the outermost (global) scope.
        -   The enclosing scope allows inner functions to access variables from outer functions, but not vice versa.

    -   `Global Scope`:

        -   Variables defined at the top level of a Python program or in a module have a global scope.
        -   Global variables can be accessed from any part of the code, including inside functions.
        -   The lifetime of global variables lasts throughout the entire program's execution.
        -   To modify a global variable from within a function, you need to use the global keyword to indicate that you are referring to the global variable and not creating a new local variable.

    -   `Built-in Scope`:
        -   The built-in scope contains all the names of Python's built-in functions, such as print(), len(), etc.
        -   These built-in names are available globally in any part of the code without the need to import anything.

    Note: Local scope objects can be synced with global scope objects using keywords such as `global`.

    -   Names and Scopes in Python

        -   Since Python is a dynamically-typed language, variables in Python come into existence when you first assign them a value. On the other hand, functions and classes are available after you define them using `def` or `class`, respectively. Finally, modules exist after you import them. As a summary, you can create Python names through one of the following operations:

        -   Assignments, Import operations, Function definitions, Argument definitions in the context of functions, Class definitions.

    -   Python Scope vs Namespace

        -   In Python, the concept of scope is closely related to the concept of the namespace. As you’ve learned so far, a Python scope determines where in your program a name is visible. Python scopes are implemented as dictionaries that map names to objects. These dictionaries are commonly called namespaces. These are the concrete mechanisms that Python uses to store names. They’re stored in a special attribute called `.__dict__`.

        -   Names at the top level of a module are stored in the module’s namespace. In other words, they’re stored in the module’s `.__dict__` attribute.

    ```python
    for a in range(2):
        x = 'global {}'.format(a)


    def outer():
        global global_var
        global_var = 'Global variable is accessable everywhere'

        for b in range(6):
            x = randint(0, 10)
            x = 'x = {}, this value is from {}'.format(x, 'outer(...)')
            y1 = 'from the first for loop'

        def inner():
            x = 4
            x = 'x = 4, this value is from {}'.format('inner(...)')
            y2 = 'form the second for loop'

            print(x, y1, y2, global_var, sep='\n')
        print(x)
        inner()

    outer()
    ```

    #### Name Mangling in Python

    Name mangling in Python is a mechanism for making class attributes more "private" and for avoiding name clashes when subclassing. It involves adding a prefix to an attribute's name to make it harder to access or accidentally override from outside the class. It's a way to provide some level of "name privacy" within a class, although it's not a security feature and can still be bypassed if necessary. Here are the gory details of Python name mangling:

    -   `Double Underscore Prefix (__)`: Name mangling begins when an attribute name in a class is prefixed with a double underscore (e.g., \_\_attribute_name). This is a convention, and it signals to developers that this attribute is intended to be "private" to the class.

    -   `Name Transformation`: When Python encounters an attribute with a double underscore prefix, it transforms the attribute's name. Specifically, it adds a prefix to the attribute name, consisting of an underscore and the name of the class where the attribute is defined. For example, if you have a class called MyClass with a double underscore attribute **\_\_private_var_2**, Python internally renames it to **\_MyClass\_\_private_var_2**.

        ```python
        class MyClass:
            def __init__(self):
                self._private_var_1 = 42
                self.__private_var_2 = 420
        ```

    -   `Accessing Mangled Attributes`: To access a name-mangled attribute from outside the class, you need to use the mangled name, which includes the class name as a prefix:

        ```python
        obj = MyClass()
        print(obj._MyClass__private_var_2)  # Accesses the name-mangled attribute.
        ```

        -   This helps avoid naming conflicts between attributes in different classes and subclasses.

    -   `Name Mangling Is Not Strict Encapsulation`: It's important to note that name mangling is a convention rather than a strict security feature. It does make it less likely for developers to accidentally override or access "private" attributes, but it can still be bypassed. If you know the mangled name, you can access or modify the attribute:

        ```python
        obj._MyClass__private_var_2 = 100 # Modifies the mangled attribute.
        ```

    -   `Use Cases`: Name mangling is often used to indicate to other developers that an attribute is intended to be private and should not be accessed directly from outside the class. It is also used to prevent accidental name clashes when subclassing. It's especially useful when creating library code, where you want to provide a level of encapsulation without preventing users of your library from accessing or modifying attributes when necessary.

    In summary, name mangling in Python involves transforming attribute names with double underscores into names that include the class name as a prefix to avoid naming conflicts. However, it's a convention rather than a strict enforcement of privacy, and developers can still access mangled attributes if they know the mangled names.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Arguments <b style="color:red"> * args </b> and <b style="color:red"> ** kwargs </b></summary>

    In Python, unpacking operators allow you to expand elements from iterable objects, such as lists, tuples, or dictionaries, into individual elements or variables. There are three main unpacking operators: `*` for iterable unpacking, `**` for dictionary unpacking, and `*` in function arguments.

    -   **Iterable Unpacking** (`*`):

        -   Used to unpack elements from an iterable (e.g., list or tuple).
        -   The `*` operator is placed before an iterable variable to unpack its elements.

        ```python
        # Example of iterable unpacking
        original_list = [1, 2, 3]
        unpacked_list = [*original_list, 4, 5]
        print(unpacked_list)  # Output: [1, 2, 3, 4, 5]

        # Unpacking a list into variables
        first, *rest = [1, 2, 3, 4, 5]
        print(first)  # Output: 1
        print(rest)   # Output: [2, 3, 4, 5]
        ```

    -   **Dictionary Unpacking** (`**`):

        -   Used to unpack key-value pairs from a dictionary.
        -   The `**` operator is placed before a dictionary variable to unpack its key-value pairs.

        ```python
        # Example of dictionary unpacking
        original_dict = {'a': 1, 'b': 2}
        unpacked_dict = {**original_dict, 'c': 3}
        print(unpacked_dict)  # Output: {'a': 1, 'b': 2, 'c': 3}

        # Unpacking elements for a function call
        values = [1, 2, 3, 4, 5]
        print(*values)  # Output: 1 2 3 4 5

        # Unpacking a dictionary's keys and values into a function
        person = {'name': 'John', 'age': 30, 'city': 'New York'}
        print(**person)  # Output: name=John age=30 city=New York
        ```

    -   **Function Arguments** (`*`):

        -   Used in function definitions and calls to handle variable numbers of arguments.
        -   The `*` operator in a function definition collects positional arguments into a tuple.
        -   The `*` operator in a function call unpacks elements from an iterable into positional arguments.

        ```python
        # Example of function arguments unpacking
        def example_function(*args):
            print(args)

        elements_to_unpack = [1, 2, 3]
        example_function(*elements_to_unpack)  # Output: (1, 2, 3)
        ```

        -   In this example, *args in the function definition collects the positional arguments into a tuple, and *elements_to_unpack in the function call unpacks the elements from the list into positional arguments.

    Unpacking operators provide a concise and flexible way to work with iterable objects and function arguments in Python.

    #### Variable-Length Arguments and Key-word Arguments

    ##### What does `*args` and `**kwargs` mean?

    `*args` and `**kwargs` are used to pass a variable number of arguments to a function. They provide flexibility when defining functions, allowing them to accept an arbitrary number of positional and keyword arguments, respectively.

    -   **\*args**:

        -   `*args` is a special syntax used in the function definition to pass variable-length arguments.
        -   `*` means variable length and `args` is the name used by convention. You can use any other.

    -   **\*\*kwargs**:

        -   `**kwargs` is a special syntax used in the function definition to pass variable-length keyworded arguments.
        -   Here, also, `kwargs` is used just by convention. You can use any other name.
        -   Keyworded argument means a variable that has a name when passed to a function.
        -   It is actually a dictionary of the variable names and its value.

        ```python
        def test_args(first_arg, *args, **kwargs):
            kwargs = {"_int": 100, **kwargs}
            args = (*args,50)
            print(args[-1])

            if kwargs.get('_int'): kwargs['_int'] = kwargs['_int'] + 10
            if kwargs.get('my_int2'): kwargs['my_int'] = kwargs['my_int'] + 20

            print(first_arg, args, kwargs, sep='\n')


        test_args('test_arg1', 'first_arg', [2]*3, 'test_arg2', _str="kwarg#2", _int=30)
        ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Decorator</summary>

    A decorator is a design pattern that allows you to extend or modify the behavior of a callable object (functions, methods, or classes) without modifying its source code. Decorators are applied using the `@decorator` syntax, where decorator is a function or a class that takes a function as an argument and returns a new function.

    Decorators are commonly used for various purposes, such as logging, authorization, caching, and code instrumentation. They provide a clean and reusable way to extend the functionality of functions or methods. Additionally, Python has some built-in decorators (e.g., `@staticmethod`, `@classmethod`, `@property`) and third-party libraries offer many more for different use cases.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Iterator</summary>


    ##### What are **Iterators** in Python?

    An iterator is an object that provide the mechanics to iterate over a stream of data. Iterators are used to traverse through a sequence of elements, one at a time, and they implement two main methods:

    **\_\_iter\_\_**: This method returns the iterator object itself. It is required for an object to be considered an iterator.

    **\_\_next\_\_**: This method returns the next element from the iterator. When there are no more elements, it should raise the **StopIteration** exception to signal the end of the iteration.

    To create an iterator in Python, you can define a class with the **\_\_iter\_\_** and **\_\_next\_\_** methods. Alternatively, you can use the **iter()** and **next()** functions to create and interact with iterators.

    **Notes**:

    -   It remembers its state i.e., where it is during iteration (see code below to see how)
    -   It is also self-iterable.
    -   Iterators are objects with which we can iterate over iterable objects like lists, strings, etc.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Generator</summary>

    Generators are iterable Python object, like lists or tuples, but they generate values on-the-fly instead of storing them in memory. They are implemented using functions that contain one or more `yield` statements. When a generator function is called, it doesn't get executed immediately. Instead, it returns a generator object, which can be iterated over using a for loop or by using the `next()` function. The key characteristics of generators are:

    -   `Lazy Evaluation`: Generators get lazyly evaluated, meaning they produce values only when requested. Each time a value is requested from the generator, the function execution resumes from where it left off, continuing until it hits the next `yield` statement.

    -   `Memory Efficiency`: Since generators do not store all the values in memory at once, they are memory-efficient, especially when dealing with large datasets or infinite sequences.

    -   `Iteration`: Generators are iterable, and you can loop over them using a for loop. They produce values one at a time during iteration.

    -   `Stateless`: Generators are stateless; they do not retain any information between iterations. Each time you iterate over a generator, it starts execution from the beginning of the iteration.

    -   `Infinite Sequences`: Generators can be used to create infinite sequences or streams of data, where the values are generated on-the-fly as needed.

    ```python
    def fib(n):
        """ Return all the fibonacci numbers less than or equal to n (a given number)"""
        p, q = 0, 1
        while (p <= n):
            yield p
            p, q = q, p + q
    ```

    ##### What is **Generator expression** in Python?

    A **generator expression** is a concise and memory-efficient way to create a generator on-the-fly. It has a similar syntax to a list comprehension, but it returns a generator object instead of a list. Generator expressions are denoted by parentheses `()` instead of square brackets `[]`, which are used for list comprehensions.
    a generator expression is a concise way to create a generator on-the-fly, similar to how list comprehensions create lists. Generator expressions are more memory efficient than list comprehensions because they produce values lazily, only when needed, instead of storing the entire sequence in memory.

    ```python

    def squares_generator(n):
        for i in range(n): yield i**2

    # Print the generator object
    print(squares_generator)  # Output: <function squares_generator at 0x10f0913a0>

    # print(next(squares_generator)) # TypeError: 'function' object is not an iterator

    for square in squares_generator(10): print(square)
    ```

    ```python
    # Create a generator expression to generate squares of numbers from 1 to 5
    squares_generator = (x ** 2 for x in range(1, 6))

    # Print the generator object
    print(squares_generator)  # Output: <generator object <genexpr> at 0x7f0fe5c2e7b0>

    print(next(squares_generator))

    # Iterate over the generator and print each value
    for square in squares_generator: print(square)
    ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Context Manager</summary>

    A context manager in Python is an object that is designed to be used with the **with** statement to <b style="color:green">set up</b> and <b style="color:green">tear down</b> resources, such as opening and closing a file, acquiring and releasing a lock, or connecting and disconnecting from a database. Context managers ensure that certain actions are taken before and after a block of code is executed. It defines two methods `__enter__()` and `__exit__()`. When the **with**-statement is executed, it calls the `__enter__()` method of the context manager, which initializes the setup process of the resources and return it. Then, the block of code inside the **with**-statement is executed. Finally, when the block is exited, the `__exit__()` method is called, which ensures the tear down process of the resources, even if an exception occurred within the block.

    The **with** statement provides a convenient and readable way to work with resources, and it guarantees that the resources are properly acquired and released even if an exception occurs within the block.

    ```python
    with open('file.txt', 'r') as file:
        content = file.read()
        # Perform operations with the file

    # After the block, the file is automatically closed
    ```

    In this example, the `open()` function returns a context manager object that represents the opened file. When the with-statement is executed, it calls the `__enter__()` method of the context manager, which initializes the file and returns it. Then, the block of code inside the with-statement is executed. Finally, when the block is exited, the `__exit__()` method is called, which ensures that the file is closed properly, even if an exception occurred within the block.

    The `contextlib` module provides a decorator `contextmanager` that simplifies the creation of context managers. It allows you to define a generator function with a single **yield** statement, where everything before the **yield** serves as the `__enter__` method, and everything after the **yield** serves as the `__exit__` method.

    ```python
    from contextlib import contextmanager

    @contextmanager
    def open_db(file_name: str):
        conn = sqlite3.connect(file_name)
        try:
            logging.info("Creating connection")
            yield conn.cursor()
        finally:
            logging.info("Closing connection")
            conn.commit()
            conn.close()

    # ====================================================
    def main_decorator_version():
        logging.basicConfig(level=logging.INFO)
        with open_db(file_name=path+"/application.db") as cursor:
            cursor.execute("SELECT * FROM blogs")
            logging.info(cursor.fetchall())
    # =====================================================
    main_decorator_version()
    ```

    #### Asynchronous Context Manager

    An Asynchronous Context Manager in Python is an object that supports asynchronous context management protocol. It allows you to define asynchronous resource management logic using the `async with` statement within asynchronous code (coroutines). Asynchronous context managers are used to acquire and release resources in an asynchronous manner, typically in scenarios where resource acquisition or release involves I/O-bound operations.

    -   An asynchronous context manager is an object that implements `__aenter__()` and `__aexit__()` methods, similar to regular context managers (`__enter__()` and `__exit__()` methods).
    -   When the `async with` statement is encountered, it calls the `__aenter__()` method of the asynchronous context manager object to acquire the resource asynchronously.
    -   The result of `__aenter__()` (if any) is assigned to the <variable> specified in the `async with` statement.
    -   The <statements> within the `async with` block are executed asynchronously.
    -   After the <statements> are executed or if an exception occurs within the block, the `__aexit__()` method of the asynchronous context manager is called to release the acquired resource asynchronously.

    ```python
    import asyncio

    class AsyncResource:
        async def __aenter__(self):
            print("Acquiring resource asynchronously")
            await asyncio.sleep(1)  # Simulating asynchronous resource acquisition
            return "Resource"

        async def __aexit__(self, exc_type, exc_value, traceback):
            print("Releasing resource asynchronously")
            await asyncio.sleep(1)  # Simulating asynchronous resource release

    async def main():
        async with AsyncResource() as resource:
            print("Using resource:", resource)
            # Perform asynchronous operations with resource

    asyncio.run(main())
    ```

    Asynchronous context managers is particularly useful in asynchronous programming when working with resources that need to be acquired and released in an asynchronous manner, such as database connections, network sockets, or file I/O operations. It helps manage resources efficiently while ensuring proper cleanup even in the presence of exceptions.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Metaclass</summary>

    Metaclasses in Python are a powerful feature that allows you to customize the creation of classes and modify their attributes, methods, and behavior dynamically.

    -   **Class of Classes**:
        -   A metaclass is a class whose instances are themselves classes.
        -   It defines how classes behave, just like classes define how instances of those classes behave.
    -   **Customizing Class Creation**:
        -   Metaclasses allow you to customize the creation of classes in Python.
        -   By defining a metaclass, you can control aspects of class creation such as initialization, attribute handling, and method generation.
    -   **Advanced Features**:
        -   Metaclasses are often used for advanced Python features like singleton patterns, method interception, and class validation.
        -   They provide a powerful mechanism for modifying and extending the behavior of classes in Python.
    -   **Use Cases**: Metaclasses are often used for advanced customization and introspection tasks, such as:

        -   Implementing class-level validation or enforcement of constraints.
        -   Automatically generating methods or attributes based on class definitions.
        -   Adding additional behavior or functionality to classes at creation time.
        -   Implementing declarative programming patterns (e.g., defining database models).

    -   **Example**: Enforcing Attribute Presence

        ```python
        class AttributeEnforcer(type):
            def __new__(cls, name, bases, dct):
                print("Creating class:", name)
                dct['created_by'] = 'AttributeEnforcer'
                if 'required_attribute' not in dct:
                    raise TypeError(f"{name} is missing the required 'required_attribute' attribute")
                return super().__new__(cls, name, bases, dct)

        # Use the metaclass to create a new class
        class MyClassEnforced(metaclass=AttributeEnforcer):
            required_attribute = "This is required"

        # This will raise an error
        class MyInvalidClass(metaclass=AttributeEnforcer):
            pass  # Missing 'required_attribute'
        ```

    -   **Dynamic Class Creation**:

        ```python
        # Step 1: Define the class name, base classes, and attributes/methods
        class_name = "Person"
        base_classes = (object,)  # Using `object` as the base class

        # Define the class attributes and methods, including __init__
        class_attributes = {
            '__init__': lambda self, name, age: setattr(self, 'name', name) or setattr(self, 'age', age),
            'greet': lambda self: f'Hello, my name is {self.name} and I am {self.age} years old.'
        }

        # Step 2: Create the class dynamically using `type()`
        Person = type(class_name, base_classes, class_attributes)

        # Step 3: Instantiate the class and access attributes/methods
        person1 = Person("Alice", 30)
        person2 = Person("Bob", 40)

        print(person1.name)       # Output: Alice
        print(person2.age)        # Output: 40
        print(person1.greet())    # Output: Hello, my name is Alice and I am 30 years old.
        ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Module and Function</summary>

    #### Built-in attributes of Python Module.

    In Python, modules are a way to organize code into reusable files. While modules can have various attributes and functions, there are a few built-in attributes that are commonly associated with modules.

    Here are some of the key built-in attributes of a Python module:

    -   `__name__`: This attribute holds the name of the module. If the module is the main program being executed, `__name__` is set to `__main__`. Otherwise, it is set to the module's name.
    -   `__file__`: This attribute holds the path to the source file of the module, if available. It is None for built-in modules and modules that are dynamically generated.
    -   `__dict__`: This attribute holds the dictionary that defines the module's namespace. It maps attribute names to their corresponding values.
    -   `__builtins__`: This attribute holds a reference to the built-in namespace, which contains all the built-in functions, objects, and exceptions.
    -   `__doc__`: This attribute holds the module's documentation (docstring), which is a string containing information about the module's purpose, usage, and more.
    -   `__package__`: This attribute holds the name of the package that the module belongs to. It is None for top-level modules.
    -   `__loader__`: This attribute holds a reference to the module's loader, which is responsible for loading the module. It is used for modules loaded using the importlib machinery.
    -   `__spec__`: This attribute holds a reference to the module's specification, which is an object that encapsulates information about how the module is to be imported. It is used for modules loaded using the importlib machinery.
    -   `__cached__`: This attribute holds the path to the compiled bytecode file of the module, if available. It is used to speed up subsequent imports by avoiding recompilation.
    -   `__package__`: This attribute holds the name of the package that the module belongs to. It is set to None if the module is not part of a package.
    -   `__cached__`: This attribute holds the path to the cached bytecode file associated with the module, if available.
    -   `__path__`: This attribute is a list containing the paths to subdirectories within a package. It is set for packages, not individual modules.

    These built-in attributes provide information about the module's metadata, source file, and other properties. You can access them like any other attribute of the module. Keep in mind that some of these attributes might not be present in all modules, especially in built-in modules or dynamically generated modules.

    ```python
    def dir_help():
        L = []
        print(dir(object))
        print(dir(L))
        print(dir(dict))

    # print(__package__)
    # print(__builtins__)
    # print(__file__)
    # print(__name__)
    # print(__doc__)
    # dir_help()
    ```

    #### Built-in attributes of Python Functions.

    In Python, functions are first-class objects, which means they have special built-in attributes that provide information about the function itself. These attributes are prefixed and suffixed with double underscores (`__`).

    Here are some of the key special built-in attributes of a Python function:

    -   `__name__`: This attribute holds the name of the function as a string.
    -   `__annotations__`: This attribute holds a dictionary containing function annotations, which provide additional information about function parameters and return values.
    -   `__dict__`: This attribute holds the function's attribute dictionary, mapping attribute names to their corresponding values.
    -   `__globals__`: This attribute holds a reference to the dictionary representing the global namespace in which the function was defined.
    -   `__call__`: This attribute defines the behavior of the function when it is called. It allows the function to be callable like any other object.
    -   `__defaults__`: This attribute holds a tuple containing default argument values for the function's parameters. If a parameter has no default value, its corresponding entry in the tuple is set to None.
    -   `__module__`: This attribute holds the name of the module in which the function was defined. If the function is defined in the main program, it is set to "**main**".
    -   `__doc__`: This attribute holds the function's documentation string (docstring), which provides information about the function's purpose, usage, and more.
    -   `__code__`: This attribute holds the code object that represents the compiled function's bytecode.
    -   `__closure__`: This attribute holds a tuple of cell objects representing the closed-over variables used by nested functions. It is None for functions that don't close over any variables.
    -   `__kwdefaults__`: This attribute holds a dictionary containing keyword-only default values for function parameters.
    -   `__qualname__`: This attribute holds the qualified name of the function, including the full module path.

    These special attributes provide introspection capabilities, allowing you to inspect and interact with functions programmatically. They are useful for various purposes, such as creating decorators, documenting functions, and understanding their behavior and context.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Memory Management and Garbage Collection</summary>

    Memory management and garbage collection are essential aspects of Python's runtime environment, ensuring efficient utilization of system resources and automatic cleanup of unused objects.

    **Memory Management**:

    Python's memory management is based on a private heap space, managed by the Python memory manager. This heap space contains all the Python objects and data structures.

    Python uses a technique called "dynamic memory allocation" to allocate memory for objects during runtime. When you create an object (e.g., variables, lists, dictionaries), Python dynamically allocates memory for it on the heap.

    Python's memory manager keeps track of all allocated memory blocks, including the ones that are currently in use and those that have become unused.

    Memory management in Python is automatic and transparent to the programmer. Python handles memory allocation and deallocation internally without explicit intervention from the developer.

    Memory management in Python is primarily handled by the Python memory manager, which is responsible for allocating and deallocating memory for objects, as well as managing memory usage efficiently. Here's how memory management works in Python:

    -   `Object Allocation`: When a new object is created in Python, the memory manager allocates memory to store the object's data and metadata. Each object's memory layout includes space for the object's type information, reference count, and actual data.
    -   `Reference Counting`: Python uses reference counting as its primary mechanism for automatic memory management. Each object in memory has a reference count, which tracks the number of references pointing to it. Whenever an object is referenced by another object, its reference count is incremented. Conversely, when a reference to an object is removed or goes out of scope, its reference count is decremented. When an object's reference count drops to zero, meaning there are no more references to it, the memory manager deallocates the object's memory and frees it up for reuse.
    -   `Garbage Collection`: While reference counting is effective for most cases, it cannot detect and reclaim cyclic garbage, where objects reference each other in a cycle. To handle cyclic garbage, Python employs a secondary garbage collection mechanism called cyclic garbage collection. This mechanism identifies and breaks cyclic references by traversing object graphs and marking objects as garbage if they are part of a cycle.
    -   `Memory Pools`: Python's memory manager utilizes memory pools to improve memory allocation performance. Memory pools preallocate fixed-size blocks of memory for objects of a certain size range, reducing the overhead of allocating and deallocating memory for individual objects. Memory pools are managed by the memory manager and are shared among Python objects.
    -   `Optimizations`: Python's memory manager includes various optimizations to improve memory usage and performance, such as reuse of freed memory blocks, memory compaction to reduce fragmentation, and caching of frequently used objects.

    #### Heap Space in Python

    **Heap Space** refers to the memory area used for dynamic memory allocation. Objects and data structures like lists, dictionaries, and user-defined objects are stored in the heap. The Python memory manager handles this space, allocating and deallocating memory automatically through garbage collection.

    In Python, the "heap" generally refers to the private heap space managed by the Python memory manager. This is where Python objects are allocated and managed during program execution. Understanding the Python heap is crucial for understanding memory management in Python. Here's a detailed explanation:

    -   `Dynamic Memory Allocation`: In Python, memory allocation is dynamic, meaning that memory for objects is allocated as needed during program execution. When you create a new object, such as a variable, list, or class instance, Python allocates memory for that object on the heap.
    -   `Reference Counting`: Python uses a technique called reference counting to manage memory. Each object on the heap has a reference count, which tracks how many references (pointers) exist to that object. When an object's reference count drops to zero, meaning there are no more references to it, the memory occupied by the object is reclaimed.
    -   `Garbage Collection`: In addition to reference counting, Python also employs a garbage collector to reclaim memory for objects with cyclic references or when reference counting alone is insufficient. The garbage collector periodically scans the heap to identify and reclaim unreachable objects, freeing up memory for reuse.
    -   `Memory Fragmentation`: As objects are allocated and deallocated on the heap, memory fragmentation can occur. This is when the heap becomes fragmented with small chunks of memory scattered throughout, making it challenging to allocate contiguous blocks of memory for new objects. Python's memory manager includes mechanisms to address fragmentation and optimize memory allocation.
    -   `Global vs. Per-Thread Heap`: Python's memory manager maintains separate heaps for global objects and per-thread objects. Global objects are accessible from any thread in the program and are stored in the global heap. Per-thread objects, such as thread-local variables, are stored in per-thread heaps, which are managed separately.
    -   `Memory Profiling and Optimization`: Understanding how memory is allocated and managed on the heap is essential for optimizing memory usage and performance in Python programs. Techniques such as memory profiling, identifying memory leaks, minimizing object creation, and optimizing data structures can help improve memory efficiency and performance.
    -   `C Extensions and Memory Management`: When working with C extensions or interacting with external libraries, it's important to be mindful of memory management. Python's memory management system may interact with memory management mechanisms in C code, and improper memory management can lead to memory leaks or undefined behavior.

    **Garbage Collection**:

    Garbage collection is the process of reclaiming memory occupied by objects that are no longer in use, freeing it up for future allocation.

    Python uses a built-in garbage collector to perform automatic memory management. The garbage collector identifies and collects unused objects, which are then deallocated from memory.

    Python's garbage collector uses a reference counting mechanism to track the number of references to each object. When the reference count of an object drops to zero, it means that the object is no longer in use and can be safely deallocated.

    In addition to reference counting, Python's garbage collector also employs a cycle-detecting algorithm to handle more complex scenarios where objects reference each other in circular patterns (e.g., cyclic references).

    The garbage collector runs periodically in the background, scanning the heap for unreachable objects and reclaiming their memory. The frequency and behavior of garbage collection can be influenced by various factors, such as the size of the heap, memory pressure, and the number of objects being created and destroyed.

    Garbage collection is an automated memory management mechanism in Python. It automatically identifies and reclaims memory occupied by objects that are no longer referenced by your program, preventing memory leaks and ensuring efficient memory utilization.

    -   **How Garbage Collection Works in Python**: CPython, the most popular Python implementation, primarily relies on a technique called reference counting for garbage collection. Here's a breakdown of the process:

        -   `Object Creation and Reference Counting`:

            -   Whenever you create an object in Python (e.g., a list, string, or custom class instance), the underlying C object has both a Python type (like list) and a reference count initialized to 1.
            -   This reference count indicates how many different places in your program's code are currently referencing that object.

        -   `Reference Increments and Decrements`:

            -   When you assign an object to a variable or pass it as an argument to a function, the reference count is incremented by 1, signifying another reference to the object exists.
            -   Conversely, when a variable referencing an object goes out of scope (e.g., the function containing the variable finishes execution), or you explicitly delete a reference (using del), the reference count is decremented by 1.

        -   `Garbage Collection Cycle`:

            -   The Python interpreter periodically runs a garbage collection cycle in the background. During this cycle, it identifies objects with a reference count of 0. These objects are considered unreachable as there are no active references to them in your program.

        -   `Memory Reclamation`:

            -   Once an object is identified as unreachable, the garbage collector reclaims the memory occupied by that object, making it available for future object allocations.

    -   **Limitations of Reference Counting**:

        -   `Cyclic References`: Reference counting can't handle cyclic references, where two or more objects reference each other indefinitely. Even though no code directly references these objects anymore, their reference counts remain above 0, preventing garbage collection.
        -   `Hidden References`: In some cases, objects might be indirectly referenced through hidden mechanisms like closures or event listeners, leading to unreachable objects not being collected.

    -   **Additional Considerations**:

        -   Python's garbage collector is not deterministic. The exact timing of garbage collection cycles can vary depending on memory usage and other factors.
        -   While reference counting is the primary mechanism, CPython might also employ other techniques like generational garbage collection for better efficiency, especially for long-running applications.

    #### Core API functions to work upon the garbage collection in Python?

    Python provides several core API functions and modules for working with garbage collection, allowing you to control and manage the process of reclaiming memory occupied by objects that are no longer referenced. Here are some of the core API functions and modules related to garbage collection in Python:

    -   **gc Module**: The gc module provides a high-level interface to Python's garbage collection mechanism. It includes functions for manual garbage collection control, as well as utilities for inspecting the garbage collector's behavior and statistics.

        -   `gc.collect([generation])`: Manually triggers garbage collection. By default, it collects all generations, but you can specify a generation to collect (0 for the youngest generation, 2 for the oldest).
        -   `gc.get_count()`: Returns a tuple containing the current collection counts for each generation. These counts represent the number of objects that have been allocated since the last collection.
        -   `gc.get_stats()`: Returns a list of dictionaries containing information about the garbage collector's behavior and statistics, including the number of collections, memory usage, and more.
        -   `gc.set_debug(flags)`: Enables or disables debugging output from the garbage collector. The flags argument is a bitmask representing the debugging options to enable.
        -   `gc.get_objects()`: Returns a list of all objects tracked by the garbage collector. This can be useful for debugging and profiling purposes, but it's not recommended for general use due to potential performance overhead.
        -   `gc.get_referents(obj)`: Returns a list of objects that directly reference the given object obj. This function can be used to inspect the references to a specific object in the heap.

    -   **sys** Module: The `sys` module provides access to system-specific parameters and functions, including functions related to memory management. For example, `sys.getsizeof()` can be used to determine the size of an object in memory, and `sys.getrefcount()` can be used to get the reference count of an object.
    -   **resource** Module: On Unix-based systems, the `resource` module provides functions for querying and modifying system resource limits, including memory limits. Functions like `resource.getrusage()` can be used to get information about resource usage, including memory usage.
    -   **tracemalloc** Module: The `tracemalloc` module allows tracing memory allocations and retrieving information about memory blocks allocated by Python. Functions like `tracemalloc.start()` and `tracemalloc.stop()` can be used to start and stop tracing, and `tracemalloc.get_traced_memory()` can be used to retrieve information about traced memory allocations.

    In summary, garbage collection in Python is an essential feature that helps manage memory automatically. Understanding how it works can be beneficial for writing memory-efficient Python code and avoiding potential memory-related issues. However, it's generally not necessary to directly interfere with the garbage collector. Focus on writing clean code and avoiding unnecessary object references for optimal performance.

    **Memory Optimization Techniques**:

    -   While Python's automatic memory management and garbage collection are convenient, they may not always be optimal for certain use cases.
    -   Developers can optimize memory usage in Python by:
        -   Minimizing the creation of unnecessary objects, especially in performance-critical code.
        -   Reusing objects whenever possible to reduce memory churn.
        -   Using data structures and algorithms that are memory-efficient.
        -   Explicitly deleting references to objects when they are no longer needed, although this is generally unnecessary due to Python's garbage collection mechanism.

    Overall, Python's memory management and garbage collection mechanisms provide a balance between convenience and performance, allowing developers to focus on writing high-level code without worrying too much about memory management details. However, understanding how memory management works under the hood can help developers write more efficient and optimized Python code.

    </details>

</details>

---

<details><summary style="font-size:30px;color:White">Concurrency vs Parallelism</summary>

-   [AsyncIO, await, and async - Concurrency in Python](https://www.youtube.com/watch?v=K56nNuBEd0c)
-   [mCoding: Unlocking your CPU cores in Python (multiprocessing)](https://www.youtube.com/watch?v=X7vBbelRXn0&t=572s)
-   [mCoding: Intro to async Python | Writing a Web Crawler](https://www.youtube.com/watch?v=ftmdDlwMwwQ&t=33s)
-   [ArjanCodes: How To Easily Do Asynchronous Programming With Asyncio In Python](https://www.youtube.com/watch?v=2IW-ZEui4h4&t=69s)
-   [ArjanCodes: Next-Level Concurrent Programming In Python With Asyncio](https://www.youtube.com/watch?v=GpqAQxH1Afc)

<details><summary style="font-size:20px;color:Red">Lock</summary>

A lock in a database or a programming language is a mechanism used to control access to a resource in a concurrent environment, ensuring data integrity and preventing conflicts when multiple processes or threads attempt to access and modify the same resource simultaneously.

-   **Locks in Databases**: In databases, locks are crucial for maintaining consistency and integrity of the data when multiple transactions are being executed concurrently. They are used to manage concurrent access to data items (such as rows, tables, or databases).

    1. `Shared Lock (S)`: Allows multiple transactions to read a resource but not modify it. Shared locks are compatible with other shared locks but not with exclusive locks.
    2. `Exclusive Lock (X)`: Allows a transaction to both read and modify a resource. Exclusive locks are not compatible with any other locks, ensuring that only one transaction can access the resource at a time.
    3. `Update Lock (U)`: Used when a transaction intends to update a resource. It is compatible with shared locks but not with other update or exclusive locks.
    4. `Intent Lock (IS, IX)`: Indicates that a transaction intends to acquire a shared or exclusive lock on some lower-level resource in the hierarchy. Intent locks help prevent deadlocks and improve lock management efficiency.

-   **Locks in Programming Languages**: In programming, locks are used to control access to shared resources, such as variables, data structures, or I/O devices, by multiple threads or processes.

    1. `Mutex (Mutual Exclusion)`: A basic lock that ensures only one thread can access a resource at a time. Mutexes are often used to prevent race conditions.
    2. `Spinlock`: A type of lock where the thread waits in a loop ("spins") while checking if the lock is available. Spinlocks are efficient for short wait times but can waste CPU cycles if held for long periods.
    3. `Read-Write Lock`: Allows multiple readers or a single writer to access a resource. This lock type is useful when reads are more frequent than writes.
    4. `Semaphore`: A signaling mechanism that can be used to control access to a pool of resources. Semaphores can allow multiple threads to access the resource up to a specified limit.
    5. `Reentrant Lock (Recursive Lock)`: A lock that can be acquired multiple times by the same thread without causing a deadlock. It keeps track of the number of acquisitions and requires the same number of releases.

Locks are essential for managing concurrency and ensuring data integrity in databases and programming languages. They control access to shared resources and prevent conflicts and inconsistencies that can arise from concurrent operations. Understanding and correctly implementing locks is crucial for developing reliable and efficient concurrent systems.

</details>

#### Global Interpreter Lock (GIL)

The Global Interpreter Lock (GIL) is a mechanism widely used in CPython that ensures only one thread executes Python bytecode at a time in a single process, even on multi-core processors. It is a mutex (mutual exclusion) that protects access to Python objects, preventing multiple threads from executing Python bytecode concurrently. This means that, by default, Python cannot fully utilize the processing power of multi-core CPUs for CPU-bound tasks.

Python's standard implementation (CPython) employs a mechanism called the Global Interpreter Lock (GIL). The GIL essentially acts as a mutex (mutual exclusion) that only allows one thread to execute Python bytecode at a time. While this ensures thread safety for built-in data structures and prevents memory corruption, it also limits true parallel execution on multi-core processors for CPU-bound tasks.

It is important to note that the GIL is specific to CPython, and other implementations of Python (such as Jython, IronPython, or PyPy) may not have a GIL or may have different mechanisms for handling concurrent execution.

In simple terms, the GIL ensures that Python's memory management is thread-safe, preventing conflicts that can arise when multiple threads modify data structures. But it also limits Python's ability to perform true parallel processing. While this can be a limitation for CPU-bound tasks, Python remains an excellent choice for I/O-bound tasks, thanks to its asynchronous programming capabilities and third-party libraries that help bypass the GIL when necessary.

-   `Purpose`:

    -   The primary purpose of the `GIL` is to serialize access to Python objects, preventing multiple native threads from executing Python bytecodes in parallel.
    -   It ensures that only one thread can execute Python code in the interpreter at any given time.

-   `Why the `GIL` Exists`:

    -   CPython, the reference implementation of Python, uses reference counting to manage memory. The `GIL` simplifies memory management by eliminating the need for complex and expensive locking mechanisms to protect against memory management issues.
    -   The `GIL` also ensures thread safety for Python's built-in data structures, making it easier to write and maintain Python's standard library.

-   `Impact on Multithreaded Programs`:

    -   Due to the `GIL`, multithreaded Python programs may not achieve true parallelism, especially for CPU-bound tasks. This means that multiple threads running Python code cannot utilize multiple CPU cores simultaneously.
    -   For I/O-bound tasks (e.g., network operations, file I/O), the `GIL` is less of a concern because Python threads can release the `GIL` while waiting for I/O operations to complete. This allows multiple threads to make progress concurrently in such cases.

#### What is bytecode in python?

Bytecode in Python is an intermediate representation of Python code that is generated by the Python interpreter when you run a Python script or module. It's not the low-level machine code that your computer's CPU executes directly, but rather a platform-independent set of instructions that the Python interpreter can execute.

#### I/O-bound vs CPU-bound Operations

-   **I/O-bound Operations**: The term "bound" implies that the operation's progress or performance is restricted or limited by a particular factor. In the case of I/O bound operations, that limiting factor is the speed at which data can be transferred between the computer's memory (or CPU) and external devices such as disks, networks, or user input/output devices.

    -   `Bottleneck`: The bottleneck of I/O bound operations is typically the speed at which data can be transferred between the computer's memory or processor and external devices. Several factors contribute to this bottleneck:

        -   `Hardware Limitations`: The hardware components involved in I/O operations, such as disk drives, network interfaces, and input/output devices, have finite capacities and speeds. For example, traditional hard disk drives (HDDs) have slower read/write speeds compared to solid-state drives (SSDs), and network bandwidth can limit the rate of data transfer over a network connection.
        -   `Data Transfer Protocols`: The protocols used for transferring data, such as SATA for disk drives or TCP/IP for network communication, introduce overhead and latency that can slow down data transfer rates. These protocols define how data is formatted, transmitted, and received, and inefficient implementations or network congestion can exacerbate the bottleneck.
        -   `Operating System Overhead`: The operating system manages I/O operations and mediates access to hardware resources. However, this management introduces overhead in the form of context switches, scheduling, and device driver interactions, which can affect the overall speed of I/O operations.

    -   `Characteristics`:
        -   These operations spend a significant amount of time waiting for I/O operations to complete.
        -   Examples include reading from or writing to disk, network communication, user input/output, database operations, and file operations.
        -   The CPU often idles or performs minimal computation while waiting for I/O operations to finish.

-   **CPU-bound Operations**: CPU-bound operations are tasks where the performance is primarily constrained by the computational power of the central processing unit (CPU). In these operations, the CPU is heavily utilized to perform complex calculations, execute algorithms, or process large amounts of data. Here's a detailed breakdown:

    -   `Bottleneck`: The bottleneck in CPU-bound operations is the processing capacity of the CPU itself. As the CPU reaches its computational limits, the performance of the operation becomes constrained, and additional computational tasks may experience delays or slowdowns.
    -   `Characteristics`:
        -   These operations spend the majority of their time executing instructions on the CPU.
        -   Examples include mathematical computations, sorting algorithms, cryptographic operations, image/video processing, scientific simulations, and rendering tasks.
        -   The CPU is fully utilized during these operations, and other system resources such as memory or I/O may not be fully utilized.

#### Multitasking

Multitasking is the ability to execute multiple tasks or processes at the same time, improving efficiency and performance by utilizing threading, multiprocessing, or asynchronous programming techniques. This can be achieved in several ways:

-   `Preemptive Multitasking`: The operating system divides CPU time into small time slices and allocates these slices to different processes. If a process exceeds its time slice, it's preempted (paused) to allow another process to run. The CPU scheduler ensures fair access to the CPU.

-   `Cooperative Multitasking`: In this model, processes voluntarily yield control of the CPU. Each process must explicitly release control to allow other processes to run. This approach requires more cooperation among processes and can be less robust.

-   `Multithreading`: Multithreading is a form of multitasking where a single program is divided into multiple threads. Threads share the same memory space, which can lead to more efficient communication and data sharing. They are suitable for tasks like handling multiple connections or parallelizing computation within a program.

-   `Time-Sharing`: Time-sharing systems were among the first to introduce true multitasking. They divided CPU time into small slices, allowing multiple users to interact with a computer concurrently via terminals. Each user's commands were processed during their allocated time slice.

#### Concurrency vs Parallelism

Concurrency and parallelism are two related but distinct concepts in Python, as well as in many other programming languages. They both deal with executing multiple tasks simultaneously, but they achieve this in different ways and serve different purposes. While both concurrency and parallelism involve the execution of multiple tasks simultaneously, concurrency is more about structuring your code to efficiently manage tasks, especially those that may block, while parallelism is about actually executing tasks in parallel to improve performance by utilizing multiple CPU cores or processors. The choice between concurrency and parallelism depends on the nature of the tasks you need to perform and the performance goals of your application.

-   **Concurrency**: Concurrency is a design principle that allows you to structure your code in a way that it can handle multiple tasks or operations simultaneously without necessarily running them in parallel. It's more about managing and organizing tasks efficiently, especially when dealing with tasks that may block, such as I/O operations (e.g., reading from files, making network requests). In Python, you can achieve concurrency using various techniques and libraries, including:

    -   `Threading`: Python's threading module allows you to create and manage threads. Threads can run concurrently within the same process. However, due to Python's Global Interpreter Lock (GIL), true parallelism is often limited, and threads may not take full advantage of multiple CPU cores.

    -   `Asyncio`: Python's asyncio library provides support for asynchronous programming using coroutines. It allows you to write non-blocking code that can efficiently manage and switch between multiple tasks, such as handling multiple I/O-bound operations concurrently.

-   **Parallelism**: Parallelism, on the other hand, is the actual simultaneous execution of multiple tasks on multiple CPU cores or processors, with the goal of improving performance and reducing execution time. It's often used for tasks that can be divided into smaller, independent subtasks that can run in parallel. In Python, you can achieve parallelism using:

    -   `Multiprocessing`: The multiprocessing module enables you to create multiple processes, each with its own Python interpreter and memory space. This allows for true parallelism, as each process can run on a separate CPU core.

    -   `Third-Party Libraries`: Python has several third-party libraries, such as `concurrent.futures`, that provide high-level interfaces for concurrent and parallel programming, making it easier to write code that can take advantage of multiple cores.

<details><summary style="font-size:25px;color:Orange">Threading (Thread-Based Concurrency)</summary>

Threads are lightweight units of execution within a process that share the same memory space.

Threading refers to the capability of a Python script to run multiple threads concurrently within a single process. Each thread represents a separate flow of execution within the same program, allowing for concurrent execution of tasks. Threading is a technique used to improve the performance of applications by managing blocking operations more efficiently.

In Python, threading is implemented through the `threading` and `concurrent.futures` module, which provides a high-level interface for creating and managing threads.

-   `Use Cases`:

    -   Well-suited for I/O-bound tasks (e.g., file I/O, network requests) where threads can release the Global Interpreter Lock (GIL) during blocking operations.
    -   Not ideal for CPU-bound tasks because Python's GIL can limit true parallelism, causing threads to compete for CPU time rather than running in parallel.

-   `Advantages`:

    -   Relatively lightweight compared to processes, making it efficient for managing many concurrent I/O-bound tasks.
    -   Easier communication and data sharing between threads since they share memory.

-   `Drawbacks`:

    -   Limited parallelism for CPU-bound tasks due to the GIL.
    -   Thread safety concerns when multiple threads access shared data simultaneously.

-   **Process of Multithreading in CPython**:

    -   `Thread Execution`: When a native thread in CPython starts executing Python bytecode, it must acquire the GIL first. This ensures exclusive access to Python objects and prevents multiple threads from manipulating them concurrently.
    -   `GIL Release on Blocking Operations`: The GIL is released when a thread is engaged in a blocking I/O operation. During these blocking periods, other threads can acquire the GIL and continue executing Python bytecode.
    -   `Implications for CPU-Bound Tasks`: In scenarios where a task is CPU-bound and requires significant computation performance, the GIL prevents true parallelism. Only one thread can execute Python bytecode at a time, limiting the benefits of multiple native threads.
    -   `Usefulness for I/O-Bound Tasks`: While the GIL presents challenges for CPU-bound tasks, it has less impact on I/O-bound tasks. In I/O-bound scenarios, threads can release the GIL during waiting periods, allowing other threads to execute Python bytecode.
    -   `Example`:

        ```python
        import threading
        start = time.perf_counter()

        def do_something(seconds=1):
            print(f'Sleeping {seconds} second(s)...')
            time.sleep(seconds)
            return f'Done Sleeping...{seconds}'

        t1 = threading.Thread(target=do_something)
        t2 = threading.Thread(target=do_something)

        t1.start()
        t2.start()

        t1.join()
        t2.join()

        finish = time.perf_counter()
        print(f'Finished in {round(finish-start, 2)} second(s)')

        #==============================================================================
        # VERSION 1: Using `threading` module
        #==============================================================================

        start = time.perf_counter()
        threads = []

        for _ in range(10):
            t = threading.Thread(target=do_something, args=[1.5])
            t.start()
            threads.append(t)

        for thread in threads:
            thread.join()


        finish = time.perf_counter()
        print(f'Finished in {round(finish-start, 2)} second(s)')

        #==============================================================================
        # VERSION 2: Using `concurrent.futures` module
        #==============================================================================

        import concurrent.futures
        start = time.perf_counter()

        with concurrent.futures.ThreadPoolExecutor() as executor:
            secs = [5, 4, 3, 2, 1]
            results = [executor.submit(do_something, sec) for sec in secs]

            for f in concurrent.futures.as_completed(results):
                print(f.result)

        finish = time.perf_counter()
        print(f'Finished in {round(finish-start, 2)} second(s)')

        #==============================================================================
        # VERSION 3: Using `concurrent.futures` module
        #==============================================================================
        start = time.perf_counter()

        with concurrent.futures.ThreadPoolExecutor() as executor:
            secs = [5, 4, 3, 2, 1]
            results = executor.map(do_something, secs)

            for result in results:
                print(result)

        finish = time.perf_counter()
        print(f'Finished in {round(finish-start, 2)} second(s)')
        ```

</details>

<details><summary style="font-size:25px;color:Orange">Asynchronous Programming (Async/Await)</summary>

Asynchronous programming is a form of multitasking that enables the concurrent execution of multiple tasks without the need for parallel threads or processes. It uses a single thread to manage multiple tasks that may involve I/O-bound operations. It allows tasks to yield control back to the event loop when waiting for I/O, rather than blocking the entire thread.

Asynchronous programming in Python, using the `async` and `await` keywords along with the `asyncio` module, allows developers to write concurrent code that appears to run in parallel, even within a single thread. This is achieved through an event-driven and cooperative multitasking model, which is different from traditional threading or multiprocessing. Here's how asynchronous programming manages multitasking in a single thread:

```python
import asyncio
import time

iteration_times = [1, 3, 2, 4]

async def sleeper(seconds, i=-1):
    start_time = time.time()
    if i != -1:
        print(f"{i}\t{seconds}s")
    await asyncio.sleep(seconds)
    return time.time() - start_time

run_time = 0
total_compute_run_time = 0
async def main(): # coroutine
    global run_time
    global total_compute_run_time
    # await sleeper(1, i=0)
    tasks = []
    for i, second in enumerate(iteration_times):
        tasks.append(asyncio.create_task(sleeper(second, i=i)))

    results = await asyncio.gather(*tasks)
    for run_time_result in results:
        total_compute_run_time += run_time_result
        if run_time_result > run_time:
            run_time = run_time_result

# main()
asyncio.run(main())
print(f"Ran for {run_time} seconds, with a total of {total_compute_run_time} and {run_time / total_compute_run_time }")
```

-   **Key Terms & Concepts**:

    -   `Event Loop`: The event loop is a mechanism that efficiently manages and dispatches events or messages in a program. It is a construct that allows for the execution of multiple tasks concurrently within a single thread. It continuously monitors various events, such as I/O operations completing, timers expiring, or signals being received, and dispatches these events to appropriate event handlers.
    -   `Coroutines`: Coroutines are special functions or methods that can be paused and resumed during execution. In Python, coroutines are defined using the `async def` syntax. They allow tasks to voluntarily `yield` control back to the event loop, enabling other tasks to run in the meantime. Coroutines are fundamental building blocks for asynchronous programming in Python.

-   **Process of Asynchronous Execution**: In asynchronous programming, the event loop is responsible for coordinating the execution of asynchronous tasks, ensuring that they run concurrently and efficiently. Here's how it typically works:

    -   `Task Queue`: The event loop maintains a queue of tasks that need to be executed. These tasks are usually represented as coroutines, which are special functions or methods defined using the `async def` syntax.
    -   `Task Scheduling`: When the event loop is idle, it selects the next task from the task queue and executes it. The task runs until it completes or encounters an asynchronous operation that requires waiting.
    -   `Non-Blocking I/O`: When a task encounters an asynchronous I/O operation (e.g., reading from a file, making a network request), it doesn't block the entire program. Instead, the task yields control back to the event loop, allowing other tasks to continue executing in the meantime.
    -   `Event Handling`: The event loop continuously monitors for events, such as I/O operations completing or timers expiring. When an event occurs, the event loop dispatches it to the appropriate event handler, which may be a callback function or a coroutine.
    -   `Concurrency`: By interleaving the execution of multiple tasks and efficiently managing I/O operations, the event loop enables asynchronous tasks to run concurrently within a single thread. This cooperative multitasking model avoids the overhead of managing multiple threads and ensures that the program remains responsive even under heavy loads.
    -   `Task Resumption`: When an asynchronous operation completes, the event loop schedules the corresponding task to resume execution. The task picks up from where it left off, processing the result of the asynchronous operation or performing any necessary follow-up actions.
    -   `Error Handling`: The event loop also handles errors and exceptions raised during the execution of asynchronous tasks. It ensures that errors are propagated to appropriate error handlers, allowing applications to handle and recover from errors gracefully.

-   **Advantages**:

    -   `Efficient I/O Operations`: Asynchronous programming is well-suited for I/O-bound tasks where tasks can yield control while waiting for external resources.
    -   `Single-Threaded Resource Usage`: Since only one task is executing at a time, asynchronous programming can be more memory-efficient compared to traditional multithreading.
    -   `Scalability`: Asyncio allows developers to write highly concurrent code without managing multiple threads or processes, making it easier to scale applications.

-   **Considerations**:

    -   Asynchronous programming requires cooperation from libraries, and not all libraries are designed to work seamlessly with asyncio.
    -   Asynchronous programming is commonly used in web servers and APIs to handle multiple concurrent connections efficiently. It allows the server to continue processing requests while waiting for I/O operations.
    -   Excellent for I/O-bound tasks where waiting for external resources (e.g., web requests, database queries) is common.
    -   Not ideal for CPU-bound tasks because a single thread cannot take full advantage of multiple CPU cores.
    -   Limited parallelism for CPU-bound tasks, as it uses a single thread.
    -   Requires adherence to asynchronous programming principles and may involve a learning curve.

In summary, asynchronous programming in Python, using the async and await keywords with asyncio, enables the efficient handling of I/O-bound tasks and the appearance of concurrent execution in a single thread through the use of coroutines and an event loop. It's a powerful paradigm for building scalable and responsive applications.

</details>

<details><summary style="font-size:25px;color:Orange">Multiprocessing (Process-Based Concurrency)</summary>

-   `Concurrency Model`: Multiprocessing uses multiple separate processes, each with its own Python interpreter and memory space. These processes can run in parallel on multi-core CPUs.

-   `Use Cases`:

    -   Ideal for CPU-bound tasks where true parallelism is required because each process runs independently on a separate core.
    -   Suitable for I/O-bound tasks as well, but processes have more overhead than threads.

-   `Advantages`:

    -   Achieves true parallelism, making it suitable for multi-core systems.
    -   Each process has its own memory space, reducing concerns about shared data and thread safety.

-   `Drawbacks`:

    -   Higher memory and resource overhead compared to threads.
    -   Inter-process communication (IPC) can be more complex than thread communication.

Multiprocessing allows you to create and manage multiple processes, each running independently to perform tasks in parallel, thereby improving the efficiency of CPU-bound operations.

</details>

---

The choice among these concurrency approaches depends on your specific application requirements, the nature of the tasks you're performing, and the available hardware resources. In some cases, a combination of these techniques may be appropriate to achieve the desired level of concurrency and performance.

-   **Threading**: Used when tasks are I/O-bound and you need to maintain a shared state between threads.
-   **Asynchronous Programming**: Used for I/O-bound tasks where you want to avoid blocking and efficiently manage many concurrent tasks.
-   **Multiprocessing**: Used for CPU-bound tasks to leverage multiple CPU cores without being limited by the GIL.

#### CPU vs Process vs Thread:

-   `CPU (Central Processing Unit)`:

    -   The CPU is the primary processing unit of a computer. It performs all the arithmetic, logic, and control operations required to execute instructions.
    -   Modern PCs typically have multi-core CPUs, which means there are multiple processing units (cores) on a single chip.
    -   Each core can execute instructions independently, allowing for parallel processing of tasks.

-   `Process`:

    -   A process is an independent program or application running on a computer. It includes its own memory space, system resources, and execution environment.
    -   Each process has its own program counter, registers, and stack.
    -   Multiple processes can run concurrently on a multi-core CPU, allowing for parallelism and multitasking.

-   `Thread`:

    -   A thread is a lightweight unit of execution within a process. Threads share the same memory space and resources as the process they belong to.
    -   Threads within a process can run concurrently and share data, which makes them suitable for tasks that require coordination and communication.
    -   Multithreading allows for concurrency within a single process and can take advantage of multi-core CPUs.

-   <b style="color:#C71585">Can multiple process run on a single core?</b>

    -   No, multiple processes cannot run simultaneously on a single core of a CPU. A core can execute instructions for one process at a time. However, modern operating systems and processors support multitasking and time-sharing, which gives the illusion that multiple processes are running concurrently. In reality, the CPU rapidly switches between processes, giving each a small time slice for execution.
    -   This concept is known as time-sharing or multitasking, and it allows multiple Thread to run on a single core. The operating system's scheduler allocates CPU time to each process in a way that makes it appear as though they are running simultaneously, but they are actually taking turns.
    -   In contrast, on multi-core processors, each core can handle the execution of a separate process at the same time, providing true parallelism and better performance for multithreaded and multiprocessing applications.

-   <b style="color:#C71585">How multiple application gets run on a single Core?</b>
    -   Multiple applications running on a single core are managed by the operating system's process scheduler. The operating system employs a scheduling algorithm that allocates CPU time to different processes, allowing them to share the core efficiently. This mechanism is known as multitasking or time-sharing.

</details>

</details>

---

<details><summary style="font-size:30px;color:White">Programming Terminology</summary>

-   **Syntex**: Syntax is like the rules of a language - how to write valid code using the correct keywords, punctuation, and structure. Imagine writing a sentence in English, Syntax ensures your sentence follows grammatical rules (subject-verb agreement, proper punctuation).
-   **Sementics**: Semantics goes beyond syntax and asks what the code actually does. It's about the intended behavior or computation that the code defines.Imagine writing a sentence in English, Semantics conveys the actual meaning you're trying to express with the sentence. Semantic errors typically arise during runtime (when the program is actually running) because the code is syntactically correct but doesn't produce the intended outcome. For example, dividing by zero might be syntactically valid in some languages but would cause a semantic error at runtime.

<details><summary style="font-size:25px;color:Orange;text-align:left">Function Classifications</summary>

#### First-Class Object:

-   In a programming language, a first-class object (or first-class citizen) refers to entities that can be treated like any other object in the language. This means that they can be:

    -   Assigned to variables.
    -   Passed as arguments to functions.
    -   Returned from functions.
    -   Stored in data structures like lists or dictionaries.

-   In a language with support for first-class objects, functions are treated as first-class objects, and they can be used just like any other data type, such as integers, strings, or lists.

-   In Python, functions are first-class objects, which means you can perform all the above operations on functions. This feature allows for the use of higher-order functions and the creation of closures, among other powerful programming techniques.

-   Example of functions as first-class objects:

    ```python
    def add(a, b):
        return a + b

    def multiply(a, b):
        return a * b

    # Assigning functions to variables
    operation = add
    result = operation(3, 5)  # Result: 8

    operation = multiply
    result = operation(3, 5)  # Result: 15

    # Passing functions as arguments to other functions
    def apply_operation(operation, a, b):
        return operation(a, b)

    result = apply_operation(add, 3, 5)       # Result: 8
    result = apply_operation(multiply, 3, 5)  # Result: 15

    # Returning functions from other functions
    def get_operation(type):
        if type == 'add':
            return add
        elif type == 'multiply':
            return multiply

    operation = get_operation('add')
    result = operation(3, 5)  # Result: 8
    ```

In summary, pure functions are functions that produce consistent outputs with no side effects, higher-order functions treat functions as first-class objects, and first-class objects are entities that can be used just like any other data type in the language. Python's support for first-class functions allows for more expressive and flexible code, enabling powerful programming paradigms like functional programming.

#### Higher-Order Function:

-   A higher-order function is a function that takes one or more functions as arguments and/or returns a function as its result. In other words, it treats functions as first-class citizens, enabling them to be manipulated and passed around like any other data type.

-   Higher-order functions are a fundamental concept in functional programming and allow for more flexible and modular code.

-   Example of a higher-order function:

    ```python
    def apply_operation(operation, a, b):
        return operation(a, b)

    def add(a, b):
        return a + b

    def multiply(a, b):
        return a * b

    result = apply_operation(add, 3, 5)       # Result: 8
    result = apply_operation(multiply, 3, 5)  # Result: 15
    ```

In this example, apply_operation is a higher-order function that takes another function (add or multiply) as an argument and applies it to the provided arguments a and b.

#### Closures

-   [Closures - How to Use Them and Why They Are Useful](https://www.youtube.com/watch?v=swU3c34d2NQ)

A closure is a powerful concept in programming languages like Python that support first-class functions. In simple terms, a closure is a function that remembers the environment in which it was created. It retains access to variables, bindings, and other references from the enclosing scope, even after the outer function has finished executing. This allows the inner function to "close over" and capture the state of its surrounding environment. Let's break down the components and behavior of closures in more detail:

-   **Function Definitions and Nested Functions**: In Python, functions can be defined inside other functions, creating what is known as nested functions or inner functions. These inner functions have access to the variables and parameters of the enclosing (outer) function.

    ```python
    def outer_function(x):
        def inner_function(y):
            return x + y
        return inner_function
    ```

-   **Returning Functions**: Closures are often used when a function returns another function. In the example above, the outer_function returns the inner_function. When the inner function is returned, it still has access to the variable x from the outer_function, even though the outer_function has already finished executing.

-   **Accessing Variables from the Enclosing Scope**: The inner function can access and "close over" the variables and parameters from its enclosing scope (the scope of the outer function). This is possible because the closure retains a reference to the environment in which it was defined.

    ```python
    add_five = outer_function(5)
    result = add_five(10)  # Calling the inner function with y=10 and x=5 from the enclosing scope
    print(result)          # Output: 15
    ```

-   **Use Cases for Closures**:

    -   `Function Factories`: Closures are often used to create function factories, where a higher-order function returns specialized functions based on the parameters passed.
    -   `Data Hiding`: Closures can be used to hide variables or data within a function, encapsulating state and protecting it from direct access or modification from outside the function.
    -   `Callbacks`: Closures are commonly used for callback functions in event handling, where a function is passed as an argument to be called later, often with access to certain context-specific variables.
    -   `Lifetime of Closures`: Closures remain in memory as long as they are referenced by other objects. When a closure is returned by a function and assigned to a variable or passed as an argument to another function, the closure will continue to exist in memory. If there are no references to the closure anymore, it will be garbage collected like any other object.

-   **Mutable Closures and Gotchas**: When using mutable variables in closures (e.g., lists or dictionaries), you need to be cautious about the "late binding" behavior. Late binding means that the inner function can change the value of a variable in the enclosing scope even after the closure is created. This can lead to unexpected behavior and is something to keep in mind when working with mutable closures.

    ```python
    def create_multiplier():
        factor = 2

        def multiplier(x):
            return x * factor

        factor = 10  # Changing the value of 'factor'
        return multiplier

    multiply = create_multiplier()
    print(multiply(5))  # Output: 50 (not 10, because the closure remembers the latest value of 'factor')
    ```

In conclusion, closures in Python are a powerful mechanism that allows functions to retain access to the variables and context of their enclosing scope. This feature is extensively used to create flexible and reusable code, particularly in functional programming and other advanced programming paradigms.

A closure is a powerful concept in programming languages that support first-class functions, like Python. In simple terms, a closure is a function that remembers the environment in which it was created. It retains access to variables, bindings, and other references from the enclosing scope, even after the outer function has finished executing. This allows the inner function to "close over" and capture the state of its surrounding environment.

#### Pure Function:

A pure function is a function that has two main characteristics:

-   **Deterministic**: For the same input, a pure function will always produce the same output, regardless of the external state or context. It does not rely on any external variables or mutable state.
-   **No Side Effects**: A pure function does not modify any external state or produce observable side effects, such as changing global variables, modifying input parameters, or performing I/O operations like reading or writing files.
-   **Advantages**:

    -   They are easy to reason about and test since their behavior is predictable and isolated.
    -   They can be optimized and memoized more effectively since their output is solely determined by their inputs.
    -   They facilitate parallel and concurrent programming as they do not share data between different executions.
    -   Example of a pure function:

        ```python
        def add(a, b):
            return a + b
        ```

</details>

<details><summary style="font-size:25px;color:Orange;text-align:left">Programming Paradigm</summary>

#### Imperative Programming:

Imperative Programming is a programming paradigm that focuses describing a sequence of steps or commands to be executed by the computer to achieve a desired outcome. This style of programming is closer to how humans think and describe processes. The emphasis is on the `how` of achieving a task. Key characteristics of imperative programming:

-   Code consists of a series of statements that change the program's state.
-   Developers specify detailed step-by-step instructions for solving a problem.
-   Control structures like loops and conditionals are used extensively.
-   Mutable state is common, where variables are assigned new values over time.
-   Examples of imperative programming languages include C, C++, Java, and Python (to some extent).

#### Procedural Programming (PP):

Procedural programming is a subset of imperative programming and is a specific programming style.

-   `Step-by-Step`: PP follows a step-by-step, linear approach to problem-solving. It emphasizes breaking a problem into smaller procedures or functions.
-   `Mutable Data`: PP typically uses mutable data structures, where data can be modified in place. It may involve updating variables and changing the program's state.
-   `Stateful`: PP often uses shared state between procedures, which can lead to unexpected side effects and make code harder to reason about.
-   `Loops`: Loops, such as for and while, are commonly used for iteration and control flow.
-   `Procedures`: PP revolves around procedures or functions that perform specific tasks or operations. These procedures are called sequentially to solve a problem.
-   `Efficiency`: Procedural code can be highly efficient, as it often focuses on low-level optimization and direct manipulation of data.
-   `Imperative`: PP code tends to be more imperative, specifying how a task should be accomplished through a series of instructions.

#### Declarative Programming:

Declarative Programming is a programming paradigm that focuses on specifying the desired outcome or properties of a computation without explicitly detailing the steps to achieve it. It describe what should be accomplished rather than how it should be accomplished. Developers specify the desired outcome or goal, and the program's logic takes care of determining the best way to achieve it. The emphasis is on the `what` of a task. Key characteristics of declarative programming:

-   Code expresses high-level abstractions and relationships.
-   Developers describe the problem and its solution using expressions and statements.
-   Control structures are abstracted and hidden, often through built-in functions or methods.
-   Immutable data structures are favored to avoid side effects.
-   Examples of declarative programming languages include SQL, HTML, CSS, and functional programming languages like Haskell and Lisp.

Functional Programming (FP) and Procedural Programming (PP) are two different paradigms for writing computer programs. Here's a comparison of the two:

#### Functional Programming (FP):

Functional Programming is a programming paradigm that emphasizes the use of pure functions, which means that functions produce the same output for a given input and have no side effects. It is based on the principles of mathematical functions and immutability. Here functions are treated as first-class citizens and can be passed as arguments, returned from other functions, and stored in data structures. Functions in functional programming don't have side effects and do not modify state; they take input and produce output.

-   `Abstraction`: FP focuses on using functions as first-class citizens, allowing functions to be passed as arguments, returned as values, and assigned to variables. It emphasizes a higher level of abstraction.
-   `Immutability`: Data is immutable, meaning that once it's created, it cannot be changed. Instead of modifying existing data in place, functional programming encourages creating new data structures through transformations.
-   `Statelessness`: FP encourages writing stateless functions, which makes code more predictable and easier to reason about. Functions have no side effects on external state.
-   `Pure Functions`: FP promotes pure functions, which always produce the same output for the same input and have no side effects. This predictability enhances testability and maintainability.
-   `Recursion`: Recursion is often favored over loops for iteration. Tail recursion is commonly used, and it can replace traditional loop constructs.
-   `Higher-Order Functions`: FP leverages higher-order functions, such as map, filter, and reduce, for processing collections and performing data transformations.
-   `Concurrency`: FP can simplify concurrent and parallel programming by minimizing shared state and mutable data.
-   `Declarative`: FP code tends to be more declarative, focusing on what should be done rather than how it should be done.

</details>

#### Shallow Copy / Deep Copy

In Python, "shallow copy" and "deep copy" are two different methods used to create copies of objects, especially when dealing with complex data structures like lists, dictionaries, or custom objects. The key difference between them lies in how they handle nested objects (objects within objects) during the copy process.

-   **Shallow Copy**:

    A shallow copy creates a new object, but it does not create new copies of nested objects. Instead, it references the original nested objects in the new container. In other words, a shallow copy is a copy of the top-level container object, but the elements inside that container are still shared between the original object and the copied object.
    To create a shallow copy in Python, you can use the copy module's copy() function or the object's own copy() method.

    ```python
    import copy

    original_list = [1, 2, [3, 4]]
    shallow_copied_list = copy.copy(original_list)

    # Modify the nested list in the shallow copy
    shallow_copied_list[2][0] = 99

    print(original_list)          # Output: [1, 2, [99, 4]]
    print(shallow_copied_list)    # Output: [1, 2, [99, 4]]
    ```

    As you can see, when we modify the nested list in the shallow copied list, the change is also reflected in the original list because they share the same reference to the nested list.

-   **Deep Copy**:

    A deep copy, on the other hand, creates a completely independent copy of the original object along with all its nested objects. It recursively creates new copies of all the objects found in the original object, including all nested objects. This means that changes made to nested objects in the deep copy won't affect the original object or vice versa.
    To create a deep copy in Python, you can use the copy module's deepcopy() function.

    ```python
    import copy

    original_list = [1, 2, [3, 4]]
    deep_copied_list = copy.deepcopy(original_list)

    # Modify the nested list in the deep copy
    deep_copied_list[2][0] = 99

    print(original_list)          # Output: [1, 2, [3, 4]]
    print(deep_copied_list)       # Output: [1, 2, [99, 4]]
    ```

    In this case, the modification to the nested list in the deep copied list does not affect the original list because they are now independent copies.

-   **When to use Shallow Copy and Deep Copy**:

    -   `Shallow Copy`:

        -   Use a shallow copy when you want to create a new container object, but you want to keep the references to the nested objects intact (i.e., you want to share the nested objects between the original and copied objects).
        -   Shallow copies are generally faster and more memory-efficient since they only copy references to objects and not the objects themselves.

    -   `Deep Copy`:
        -   Use a deep copy when you need a completely independent copy of the original object and all its nested objects. This ensures that changes to the copied object won't affect the original object or any of its nested objects.
        -   Deep copies are slower and consume more memory, especially for complex data structures, since they recursively copy all nested objects.

    ```python
    from copy import copy, deepcopy

    list_1 = [1, 2, [3, 5], 4]

    ## shallow copy

    list_2 = copy(list_1)
    list_2[3] = 7
    list_2[2].append(6)

    list_2 # output => [1, 2, [3, 5, 6], 7]

    list_1 # output => [1, 2, [3, 5, 6], 4]

    ## deep copy

    list_3 = deepcopy(list_1)
    list_3[3] = 8
    list_3[2].append(7)

    list_3 # output => [1, 2, [3, 5, 6, 7], 8]

    list_1 # output => [1, 2, [3, 5, 6], 4]
    ```

#### Duck Typing

-   [Duck Typing and Asking Forgiveness, Not Permission (EAFP)](https://www.youtube.com/watch?v=x3v9zMX1s4s)

The term "duck typing" comes from the saying, "If it looks like a duck, swims like a duck, and quacks like a duck, then it probably is a duck." In the context of Python, it means that the type or the class of an object is determined by its behavior rather than its explicit type.

-   In languages with static typing, you usually need to declare the type of a variable explicitly, and the compiler enforces that the variable must always be of that specific type. In contrast, Python uses dynamic typing, and variables can hold values of any type at runtime. Duck typing takes advantage of this dynamic nature, allowing Python to be more flexible and concise in handling different types of objects.

-   In Python, you can perform operations on objects without worrying about their specific type, as long as they support the required methods or behavior. If an object supports the required methods, it is considered to be of the necessary type for that particular operation, regardless of its actual class.

```python
class Duck:
    def quack(self):
        print("Quack!")

class Dog:
    def quack(self):
        print("Dog does not quack but makes a different sound.")

class Robot:
    def beep(self):
        print("Beep!")

def make_sound(animal):
    animal.quack()

duck = Duck()
dog = Dog()
robot = Robot()

make_sound(duck)  # Output: Quack!
make_sound(dog)   # Output: Dog does not quack but makes a different sound.
# make_sound(robot)  # Throws an AttributeError since Robot doesn't have a 'quack' method.
```

-   In this example, we define three different classes Duck, Dog, and Robot. Each class has its own quack or beep method. The make_sound function takes an argument animal and calls the quack method on it. Even though the make_sound function doesn't know the exact type of the animal, it still works as long as the object passed to it has a quack method.

Duck typing is a powerful concept that allows Python code to be more generic, extensible, and easy to maintain. However, it also comes with some trade-offs. Since the type of an object is determined at runtime, there is less compile-time safety, and errors related to incorrect method calls might only be discovered during runtime. Careful documentation and testing are important to ensure the correct behavior of the code.

</details>

---

<details><summary style="font-size:30px;color:White">MISC</summary>

---

<details><summary style="font-size:25px;color:Orange;text-align:left">What are the Python stub files?</summary>

Python **stub files** (files with the `.pyi` extension) are special files used to define **type information** for Python modules, functions, classes, and variables. They are not executed at runtime but are designed to work with **type checkers** (like `mypy`) and IDEs for **static type checking** and better code completion.

-   **Key Features of Stub Files (`.pyi`):**

    1. **Type Hints Without Execution**:
       Stub files define the type signatures of a module or library without including the actual implementation. They allow you to separate type definitions from your code.

    2. **Complement Python's Dynamic Nature**:
       Since Python is dynamically typed, type information is optional. Stub files provide a way to statically define these types for tools to analyze the code more effectively.

    3. **Used by Type Checkers**:
       Tools like **mypy**, **PyCharm**, and **VSCode** rely on `.pyi` files for:

        - Understanding the expected types of functions, classes, and variables.
        - Checking type correctness in your codebase.

    4. **Runtime Ignorance**:
       The Python interpreter does not execute `.pyi` files. They exist solely for tooling purposes.

-   **Purpose of Stub Files**

    -   To add type information for **third-party libraries** or **C-extension modules** that don't have native type annotations.
    -   To define types for **compiled code** or prebuilt binaries, like `numpy` or `pandas`.
    -   To allow type hinting without modifying the original source code.
    -   To provide type definitions for a library without sharing its implementation (e.g., distributing closed-source code with stubs).

-   **How Stub Files Are Used**

    1. **Static Analysis**:
       Stub files allow tools like `mypy` to analyze code for type correctness. For example:

        ```python
        from example import add

        result = add(1, "string")  # Type checker will report an error because 'b' should be an int
        ```

    2. **Code Completion**:
       IDEs (like PyCharm or VSCode) use stub files to improve code completion and suggest accurate parameter types.

    3. **Providing Types for External Libraries**:
       If a library does not include type hints, you can manually or automatically generate `.pyi` files to add them.

-   **Writing Stub Files**
    The syntax of a stub file is similar to Python, but:

    -   Implementation is replaced by `...` (ellipsis) or `pass`.
    -   Only type annotations are included.

    -   **Example: Functions**

        ```python
        def my_function(a: int, b: str) -> bool: ...
        ```

    -   **Example: Classes**

        ```python
        class MyClass:
           def method(self, arg: int) -> None: ...
           attribute: str
        ```

    -   **Example: Variables**

        ```python
        PI: float
        MAX_SIZE: int
        ```

    -   **Example: Imports**

        ```python
        from typing import List

        def process_items(items: List[int]) -> None: ...
        ```

-   **Stub Files for Libraries**
    Stub files are especially useful for libraries without built-in type hints. For example:

    1. If you're using a library written in C (like `numpy`), `.pyi` files allow you to describe the types of its functions and objects.
    2. Many libraries distribute `.pyi` files alongside the main codebase (e.g., `mypy` reads stubs automatically).

-   **Generating Stub Files Automatically**
    You can generate `.pyi` files for existing modules using **stubgen**, which is part of `mypy`:

    ```bash
    stubgen my_module.py
    ```

    This generates stub files by inspecting the module's functions, classes, and docstrings.

-   **Where Are Stub Files Used?**
    -   **In Python's Type Hinting Ecosystem**:
        -   Type checkers like `mypy`
        -   IDEs for code intelligence
        -   Tools to enforce type safety in large projects
    -   **In Python Standard Library**:
        Stub files are used to add types to modules in Python's standard library, such as `os.pyi` or `sys.pyi`.

</details>

</details>
