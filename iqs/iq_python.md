<details><summary style="font-size:18px;color:#C71585">what is the difference between <b>Hashmap</b> and <b>Hashset</b>?</summary>

-   **HashMap**: A HashMap is a data structure in programming that stores key-value pairs and provides efficient retrieval based on keys. It uses a technique called hashing to map keys to corresponding values, allowing for fast lookup times. In a HashMap, each key must be unique, but values can be duplicated.

    -   A HashMap is a data structure that stores key-value pairs.
    -   It uses hashing to efficiently store and retrieve elements based on their keys.
    -   Each key in a HashMap must be unique, but values can be duplicated.
    -   HashMap provides methods for adding, removing, and retrieving elements by their keys.
    -   Examples of HashMap implementations in different programming languages include Java's `HashMap`, Python's `dict`, and JavaScript's `Map`.

-   **HashSet**: A HashSet is a data structure in programming that stores a collection of unique elements. It uses hashing to ensure that elements are stored in such a way that there are no duplicates. HashSet does not preserve the order of elements and does not allow duplicate elements to be added. HashSet is commonly used for tasks such as removing duplicates from a collection or checking for the presence of an element in a set.

    -   A HashSet is a data structure that stores unique elements.
    -   It uses hashing to ensure that elements are stored in such a way that there are no duplicates.
    -   HashSet does not store key-value pairs; it only stores elements.
    -   HashSet provides methods for adding, removing, and checking the presence of elements.
    -   Examples of HashSet implementations in different programming languages include Java's `HashSet`, Python's `set`, and JavaScript's `Set`.

</details>

<details><summary style="font-size:18px;color:#C71585">Pass by value vs pass by reference in Python</summary>

The concepts of **pass by value** and **pass by reference** are often discussed in the context of programming languages and how they handle the passing of arguments to functions. In Python, these concepts don't strictly apply because Python uses a different mechanism known as **pass by object reference** or **pass by assignment**. Let's delve into why traditional "pass by value" and "pass by reference" are considered irrelevant in Python and how Python's argument passing works.

##### Pass by Value vs. Pass by Reference

-   **Pass by Value**: In languages that use pass by value, a copy of the actual value is passed to the function. This means that modifications to the parameter inside the function do not affect the original value outside the function.
-   **Pass by Reference**: In languages that use pass by reference, a reference to the actual memory location of the variable is passed to the function. This means that modifications to the parameter inside the function do affect the original value outside the function.

##### Python's Argument Passing

Python's argument passing mechanism is often described as **pass by object reference** or **pass by assignment**. Here's how it works:

-   **Pass by Object Reference** (or **Pass by Assignment**):
    -   When you pass an argument to a function, Python passes the reference to the object, not the actual object itself.
    -   If you pass a mutable object (e.g., a list or a dictionary), the function can modify the contents of the object, and these changes will be reflected outside the function.
    -   If you pass an immutable object (e.g., an integer, a string, or a tuple), the function cannot modify the original object itself. Any modifications result in the creation of a new object.

The concepts of `pass by value` and `pass by reference` can be a bit misleading because the behavior is determined by whether the object being passed is mutable or immutable. In Python, arguments are passed by object reference, but the distinction between mutable and immutable objects affects the way they are modified inside a function.

-   **Immutable Objects (Pass by Value-Like)**:
    -   Immutable objects (e.g., integers, strings, tuples) cannot be modified in place.
    -   When you pass an immutable object to a function, any changes made to the object inside the function create a new object, and the original object remains unchanged.
-   **Mutable Objects (Pass by Reference-Like)**:
    -   Mutable objects (e.g., lists, dictionaries) can be modified in place.
    -   When you pass a mutable object to a function and modify it inside the function, the changes affect the original object.
-   **Conclusion**:
    -   The key distinction in Python is between mutable and immutable objects. - Immutable objects behave more like "pass by value," as modifications create new objects. - Mutable objects behave more like "pass by reference," as modifications are reflected outside the function.

</details>

<details><summary style="font-size:18px;color:#C71585">When you prefer list over dict and vice-versa in Python</summary>

The choice between using a list and a dictionary (dict) in Python depends on the specific requirements of your program and the type of data you need to store. Here are some considerations for when to prefer a list over a dict and vice versa:

-   **list**: list is a data structure that represents an ordered collection of elements. Lists are mutable, meaning their elements can be modified after creation. Each element in a list is indexed by a sequential integer starting from zero, allowing for easy access and manipulation of elements. Lists can contain elements of any data type, including other lists and objects. Lists are created using square brackets **[ ]** or the **list()** constructor. Lists are commonly used for storing and organizing data in sequential order, such as arrays or lists in other programming languages.

    -   `Ordered Collection`: If the order of elements matters, and you want to maintain the sequence in which elements were added, use a list.
    -   `Index-Based Access`: When you need to access elements by their position or index, a list is suitable. Lists support integer indexing.
    -   `Homogeneous Elements`: If the elements you are storing are of the same type or have a similar structure, a list is appropriate.
    -   `Iterative Processing`: Lists are good for looping through elements sequentially using constructs like for item in my_list.
    -   `Mutable Content`: Lists are mutable, meaning you can modify, add, or remove elements after the list is created.

-   **dict**: dictionary (or dict) is a data structure that represents an unordered collection of key-value pairs. Each key in a dictionary is unique and associated with a corresponding value. Dictionaries are mutable, meaning their key-value pairs can be modified after creation. Keys in a dictionary can be of any immutable type, such as strings, integers, or tuples, while values can be of any data type, including other dictionaries and objects. Dictionaries are created using curly braces **{ }** or the **dict()** constructor. They are commonly used for mapping keys to values and for fast lookup operations based on keys.

    -   `Key-Value Pairs`: If you have data that naturally fits into key-value pairs, where each value is associated with a unique key, use a dictionary.
    -   `Fast Lookup by Key`: Dictionaries offer constant-time average lookup, making them efficient for retrieving values based on keys.
    -   `Unordered Collection`: If the order of elements doesn't matter, and you're interested in quick lookups by key, a dictionary is a better choice.
    -   `Associative Relationships`: When you want to represent relationships between entities, such as mapping user IDs to user names.
    -   `Immutable Keys`: Keys in dictionaries must be immutable (e.g., strings, numbers, tuples). If your data fits this constraint, a dictionary may be suitable.
    -   `Flexibility with Data Types`: Dictionaries allow you to have values of different data types associated with different keys.

</details>

<details><summary style="font-size:18px;color:#C71585">How to define abstract class in Python3?</summary>

In Python 3, abstract classes are located in the abc module, which stands for "Abstract Base Classes." This module provides the infrastructure for defining abstract base classes in Python. You can import it using the following statement:

```python
import abc

class AbstractClass(abc.ABC):
    @abstractmethod
    def abstract_method(self):
        pass  # Placeholder for the method implementation in subclasses

class Subclass(AbstractClass):
    def abstract_method(self):
        # Concrete implementation of the abstract method
        print("This method is implemented in the subclass")

# This will work because Subclass implements the abstract method
my_subclass = Subclass()
my_subclass.abstract_method()

# This will raise a NotImplementedError because AbstractClass is abstract
# abstract_instance = AbstractClass()  # This line will cause an error
```

The ABC class serves as the base class for defining abstract classes, and the abstractmethod decorator is used to mark abstract methods within those classes. By subclassing ABC and decorating methods with abstractmethod, you can define abstract classes and enforce that concrete subclasses implement certain methods.

</details>

<details><summary style="font-size:18px;color:#C71585">how to use <b>del</b> keyword in Python?</summary>

In Python, the **del** keyword is used to remove an item from a list, delete a variable, or delete an attribute from an object. Here are some common use cases:

-   `Removing an item from a list`:

    ```python
    my_list = [1, 2, 3, 4, 5]
    del my_list[2]  # Removes the item at index 2 (value 3)
    print(my_list)  # Output: [1, 2, 4, 5]
    ```

    -   You cannot use **del** to delete elements from immutable objects like strings or tuples themselves (as the entire object cannot be modified). You can only delete slices to create a new modified version.

-   `Deleting a variable`: You can use **del** to remove a variable's reference to an object. This doesn't necessarily destroy the object itself, but it makes the object unreachable from your code through that specific variable name.

    ```python
    x = 5
    del x  # Deletes the variable 'x'
    # print(x)  # This would raise a NameError because 'x' no longer exists
    ```

-   `Deleting an attribute from an object`:

    ```python
    class MyClass:
        def __init__(self):
            self.attr = 10

    obj = MyClass()
    print(obj.attr)  # Output: 10

    del obj.attr  # Deletes the attribute 'attr' from the object
    # print(obj.attr)  # This would raise an AttributeError because 'attr' no longer exists
    ```

Keep in mind that using **del** to remove an item from a list modifies the list in-place, while using it to delete a variable or attribute removes the reference to the object, potentially allowing the garbage collector to reclaim the memory if there are no other references to the object.

</details>

<details><summary style="font-size:18px;color:#C71585">how <b>del</b> keyword and <b>__del__()</b> special method in python are related?</summary>

The del keyword and the `__del__()` special method in Python are related in the sense that they both deal with the deletion or destruction of objects, but they serve different purposes and operate at different levels of the Python language.

-   **del** keyword: The **del** keyword in Python is used to delete references to objects. It can be used to delete names (variables, attributes, functions), which may lead to the deallocation of memory associated with the object if there are no other references to it. When **del** is used to delete a reference to an object, it decrements the object's reference count. If the reference count drops to zero, indicating that there are no more references to the object, the object may be garbage collected and its memory reclaimed.

    ```python
    x = 42  # Create an object (integer 42) and assign it to the variable x
    del x   # Delete the reference to the object
    def square(x): return x*x

    b = square(5)
    print(b)  ## 25
    del square
    c = square(2) ## NameError: name 'square' is not defined
    ```

-   **\_\_del\_\_()** special method: The `__del__()` method is a special method in Python classes that gets called when an object is about to be destroyed or garbage collected. It serves as a **finalizer** or **cleanup handler** for an object. Unlike the `del` keyword, which deals with deleting references to objects, the `__del__()` method deals with the cleanup of resources associated with an object when it is no longer needed.

    ```python
    class MyClass:
        def __del__(self):
            print("Destructor called, object destroyed")

    obj = MyClass()  # Create an object of MyClass
    del obj          # Delete the reference to the object, `__del__()` may be called
    ```

It's important to note that the `__del__()` method is not guaranteed to be called promptly when an object is deleted or goes out of scope. The timing of when `__del__()` is called is determined by Python's garbage collector, which operates asynchronously.

In summary, while both **del** and `__del__()` are involved in the process of object destruction in Python, they serve different purposes: **del** is used to delete references to objects, while `__del__()` is a special method used for cleanup and finalization tasks when an object is about to be destroyed.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain destructor in context of Python</summary>

In Python, unlike C++, there are no explicit destructors like the ones defined with the `~ClassName()` syntax. Instead, Python relies on automatic garbage collection to reclaim memory and clean up resources when objects are no longer in use.

Python uses a mechanism called **reference counting** along with a **cycle-detecting** garbage collector to manage memory and automatically reclaim memory when objects are no longer referenced. When an object's reference count drops to zero, meaning there are no more references to the object, Python's garbage collector automatically frees the memory associated with that object.

However, Python does provide a special method called `__del__()` that can be defined in a class to act as a finalizer or a cleanup handler. While this method is called a destructor in Python, it's important to note that it's not guaranteed to be called when an object is destroyed, and its use is generally discouraged for cleanup tasks due to some limitations and unpredictability:

-   `Unpredictable Timing`: The `__del__()` method is called by the garbage collector when there are no more references to an object. However, the timing of when this happens is not guaranteed and can vary between different Python implementations. Therefore, you can't rely on `__del__()` for critical cleanup tasks.
-   `Circular References`: If objects refer to each other in a circular manner, they may not be garbage collected even if there are no external references to them. This can prevent the `__del__()` method from being called, leading to resource leaks.
-   `Resource Management`: Using `__del__()` for resource cleanup, such as closing files or releasing network connections, can be risky. If an exception occurs during the object's destruction, the `__del__()` method may not execute properly, leaving resources open or not properly released.
-   `No Guaranteed Order`: The order in which `__del__()` methods are called during interpreter shutdown or when objects are collected is not guaranteed. Therefore, it's not safe to rely on `__del__()` for cleanup tasks that depend on specific orderings.
-   `Potential Pitfalls`: Using `__del__()` can introduce subtle bugs and resource leaks, especially when dealing with circular references or objects that manage external resources like file handles or database connections.

Given these limitations, Python developers are encouraged to use Context Managers for resource management and cleanup tasks. Context Managers provide a more predictable and reliable way to ensure that resources are properly managed and released, even in the presence of exceptions or early returns.

In summary, while Python does support a `__del__()` method that can serve as a destructor-like mechanism, it's not a true destructor in the same sense as in languages like C++. Developers should prefer more reliable and deterministic approaches to resource management, such as context managers and the `with` statement, for cleanup tasks in Python.

#### "Finalizer" or "Finalization" in Java:

In Java, finalization refers to the process of cleaning up resources associated with an object before it is garbage collected. Finalization is primarily achieved through the use of finalizers, which are special methods defined within a class that are automatically invoked by the Java Virtual Machine (JVM) before an object is reclaimed by the garbage collector.

-   `Finalizer Method`: To enable finalization for an object, you can define a special method called the finalizer method. This method is named `finalize()` and is defined within the class of the object that needs finalization.
-   `Cleanup Operations`: Inside the `finalize()` method, you can include cleanup code to release any resources associated with the object, such as closing files, releasing network connections, or releasing other system resources. Finalization is commonly used for tasks that are not handled by Java's automatic memory management, such as releasing native resources or managing external system resources.

</details>

<details><summary style="font-size:18px;color:#C71585">What are global, protected and private attributes in Python?</summary>

There are conventions for indicating the accessibility of attributes and methods within a class. These conventions are not enforced by the language itself, but they serve as a guideline for developers to indicate the intended usage of class members. Here are the commonly used conventions for attribute accessibility:

-   **Public Attributes**: Public attributes are those that can be accessed from outside the class without any restrictions. By convention, attributes that start with an underscore (\_) or do not have any leading underscores are considered public.

    ```python
    class MyClass:
        def __init__(self):
            self.public_attribute = 10
    ```

    In the example above, public_attribute is a public attribute that can be accessed directly from outside the MyClass class.

-   **Protected Attributes**: Protected attributes are those that should not be accessed directly from outside the class, but can still be accessed if needed. By convention, attributes that start with a single underscore (\_) are considered protected.

    ```python
    class MyClass:
        def __init__(self):
            self._protected_attribute = 20
    ```

    In the example above, \_protected_attribute is a protected attribute. While it can be accessed from outside the class, it is generally considered an implementation detail and should be used with caution.

-   **Private Attributes**: Private attributes are those that should not be accessed or modified directly from outside the class. By convention, attributes that start with double underscores (\_\_) are considered private.

    ```python
    class MyClass:
        def __init__(self):
            self.__private_attribute = 30
    ```

    In the example above, **private_attribute is a private attribute. It is name-mangled to \_MyClass**private_attribute, making it less accessible from outside the class. However, it can still be accessed using the mangled name.

It's important to note that these conventions are not enfo

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between `.py` and `.pyc` files?</summary>

The main difference between `.py` and .pyc files in Python is their purpose and how they are used:

-   **.py Files (Python Source Files)**:

    -   `.py` files are Python source code files.
    -   They contain human-readable Python code that is written by developers.
    -   These files are meant to be edited and maintained by developers.
    -   When a Python script is executed, the Python interpreter directly interprets and executes the code in the `.py` file.

-   **.pyc Files (Compiled Python Bytecode Files)**: The Python interpreter typically creates a `.pyc` file the first time it encounters a `.py` file. This involves compiling the source code in the `.py` file into bytecode and storing it in the `.pyc` file with the same name but a `.pyc` extension (located in the same directory).

    -   When you run a Python script (`.py` file) directly, the interpreter checks for a corresponding `.pyc` file. However, for modules imported within another script, `.pyc` files might not be created unless specifically imported for the first time at the module level (using import module_name).
    -   These files store the compiled bytecode of a Python program. Bytecode is a low-level intermediate representation of the code, generated by the Python interpreter when it first encounters a `.py` file.
    -   They are created when a `.py` file is imported or executed for the first time.
    -   The bytecode is platform-independent and is optimized for execution by the Python interpreter.
    -   `.pyc` files are used to speed up the loading and execution of Python scripts.
    -   If a `.pyc` file exists and is up-to-date with its corresponding `.py` file, Python will load and execute the `.pyc` file instead of recompiling the source code.
    -   `.pyc` files are generally not meant to be edited by developers and are created and managed by the Python interpreter.

In summary, `.py` files contain human-readable Python source code, while `.pyc` files contain compiled bytecode generated by the Python interpreter for faster execution. Developers work with `.py` files, while `.pyc` files are automatically generated and used by the Python interpreter to optimize script execution.

</details>

<details><summary style="font-size:18px;color:#C71585">What are Python namespaces? Why are they used?</summary>

In Python, a namespace is a mapping from names (identifiers) to objects. It's essentially a dictionary where the keys are the names of variables, functions, classes, etc., and the values are the corresponding objects.

Namespaces are used to organize and manage the names used in a Python program. They help avoid naming conflicts and provide a way to encapsulate names within different scopes.

-   **Python has several types of namespaces**:

    -   `Global Namespace`: This namespace contains names defined at the top level of a module or script. It is accessible from anywhere within the module or script.

    -   `Local Namespace`: This namespace contains names defined within a function. It is created when the function is called and destroyed when the function exits. Each function call creates its own local namespace.

    -   `Enclosing Namespace`: This namespace is used in nested functions. It contains names defined in the enclosing function (but not global names or names defined in other enclosing functions).

    -   `Built-in Namespace`: This namespace contains names of built-in functions, exceptions, and other objects that are available by default in Python. It is automatically loaded when Python starts.

    -   `Module Namespace`: Each module in Python has its own namespace, containing the functions, classes, and variables defined within that module.

-   **Accessing Names from Other Namespaces**:

    -   To use a name from another namespace, you need to import the module containing the definition and then prefix the name with the module name (dot notation).

</details>

<details><summary style="font-size:18px;color:#C71585">What is Scope Resolution in Python?</summary>

Scope resolution in Python refers to the process of determining the value of a variable or the definition of a function based on its location within the code. Python follows a set of rules to determine the scope of variables and functions.

There are four types of scopes in Python:

-   `Local Scope`: Variables defined within a function have local scope. They can only be accessed within that function.

-   `Enclosing Scope (or Nonlocal Scope)`: This scope is applicable to nested functions. Variables defined in the outer function can be accessed by the inner function.

-   `Global Scope`: Variables defined at the top level of a module have global scope. They can be accessed from any part of the module.

-   `Built-in Scope`: Python provides a set of built-in functions and exceptions that are available globally. These are part of the built-in scope.

</details>

<details><summary style="font-size:18px;color:#C71585">What are decorators in Python?</summary>

</details>

<details><summary style="font-size:18px;color:#C71585">What are Dict and List comprehensions?</summary>

<details><summary style="font-size:18px;color:#C71585">What is Generator Expression?</summary>

A generator expression in Python is a concise way to create a generator, which is an iterator that generates items one at a time and on demand. It is similar to a list comprehension but uses parentheses instead of square brackets.

</details>

A list comprehension in Python is a concise way to create lists. It allows you to generate a new list by applying an expression to each item in an existing iterable, optionally filtering items with a condition.

Dict and List comprehensions are concise and expressive ways to create dictionaries and lists, respectively, in Python. They allow you to create these data structures using a compact syntax, often in a single line of code.

</details>

<details><summary style="font-size:18px;color:#C71585">What is lambda in Python? Why is it used?</summary>

A lambda function in Python is an anonymous, inline function defined using the lambda keyword. It can take any number of arguments but can only have one expression. It is typically used for small, simple operations.

</details>

<details><summary style="font-size:18px;color:#C71585">How do you copy an object in Python?</summary>

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between xrange and range in Python?</summary>

</details>

<details><summary style="font-size:18px;color:#C71585">What is pickling and unpickling?</summary>

Pickling and unpickling are processes in Python used for serializing and deserializing objects, respectively. These processes are commonly used for saving Python objects to a file or transmitting them over a network.

-   **Pickling**:

    -   Pickling is the process of converting a Python object into a byte stream.
    -   This byte stream can then be stored in a file or transmitted over a network.
    -   It is achieved using the pickle module in Python.
    -   Pickling allows you to save the state of Python objects, including their data and structure, to be used later.

-   **Unpickling**:

    -   Unpickling is the process of converting a byte stream back into a Python object.
    -   This allows you to reconstruct the original object from the byte stream.
    -   It is achieved using the pickle module in Python.
    -   Unpickling allows you to retrieve the state of Python objects that were previously pickled.

</details>

<details><summary style="font-size:18px;color:#C71585">What is python interpretor?</summary>

A Python interpreter is a program that reads and executes Python code. It translates Python code into bytecode and then executes it on the Python runtime environment. The interpreter is responsible for parsing the Python code, checking for syntax errors, and executing the instructions one by one.

-   **CPython**: Python comes with a default interpreter called CPython, which is implemented in the C programming language. CPython is the most widely used Python interpreter and serves as the reference implementation for the Python language. It provides a command-line interface (CLI) where users can interactively execute Python code or run Python scripts stored in files. Apart from CPython, there are other Python interpreters available, each with its own unique features and optimizations. Some examples include:
-   **Jython**: An implementation of Python that runs on the Java Virtual Machine (JVM), allowing Python code to interact with Java libraries and frameworks.
-   **IronPython**: A Python interpreter for the .NET framework, enabling Python code to integrate with the .NET ecosystem and use .NET libraries.

</details>

<details><summary style="font-size:18px;color:#C71585">How Python is interpreted?</summary>

Python is an interpreted language, which means that the Python code is executed line by line by the Python interpreter. Here's how Python interpretation typically works:

-   **Source Code**: Python programs are written in human-readable source code files with a .py extension.
-   **Lexical Analysis (Tokenization)**: When you run a Python script, the Python interpreter first performs lexical analysis, also known as tokenization. In this phase, the source code is broken down into a sequence of tokens such as keywords, identifiers, operators, and literals.
-   **Parsing**: After tokenization, the Python interpreter parses the token stream to build a parse tree or abstract syntax tree (AST). This process involves analyzing the structure of the code to ensure it conforms to the syntax rules of the Python language.
-   **Bytecode Generation**: Once the parsing is complete and the syntax is validated, the Python interpreter generates bytecode instructions from the AST. Bytecode is a low-level representation of the Python code that is platform-independent.
-   **Execution**: The generated bytecode is then executed by the Python Virtual Machine (PVM). The PVM is responsible for interpreting and executing the bytecode instructions. During execution, the PVM interacts with the system's hardware and operating system to perform tasks such as memory management, I/O operations, and exception handling.
-   **Dynamic Typing**: Python is dynamically typed, meaning that variable types are determined at runtime. As the code is executed, the Python interpreter automatically infers the types of variables and performs type checking dynamically.
-   **Garbage Collection**: Python's memory management system includes automatic garbage collection. The interpreter periodically scans the memory to identify and reclaim memory occupied by objects that are no longer referenced by the program. This helps to prevent memory leaks and ensures efficient memory usage.

Overall, Python's interpreted nature allows for quick development and testing cycles, as changes to the code can be immediately executed without the need for compilation. However, it may also result in slower execution speed compared to compiled languages.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the use of <b>help()</b> and <b>dir()</b> functions?</summary>

-   **help()** Function:

    -   The `help()` function is used to get documentation and information about objects, modules, functions, classes, and methods in Python.
    -   When you pass an object or function as an argument to `help()`, it displays a help page or documentation string (docstring) associated with that object or function.
    -   If no argument is provided, `help()` starts an interactive help session.
    -   It is particularly useful for learning about the usage and functionality of various Python features and libraries.

-   **dir()** Function:

    -   The `dir()` function returns a list of attributes and methods associated with an object.
    -   When you call `dir()` without any arguments, it returns a list of names in the current local scope.
    -   When you pass an object as an argument to `dir()`, it returns a list of valid attributes and methods for that object.

</details>

<details><summary style="font-size:18px;color:#C71585">What does <b>*args</b> and <b>**kwargs</b> mean?</summary>

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

<details><summary style="font-size:18px;color:#C71585">What is a dynamically typed language?</summary>

A dynamically typed language is a programming language where variable types are determined at runtime rather than at compile time. In dynamically typed languages, variables can hold values of any type, and their types can change during the execution of the program. This flexibility allows for more concise and flexible code, as programmers do not need to explicitly declare variable types. Examples of dynamically typed languages include Python, JavaScript, Ruby, and PHP. In contrast, statically typed languages require variable types to be explicitly declared and checked at compile time, which can catch certain types of errors earlier in the development process but may require more verbose code.

</details>

<details><summary style="font-size:18px;color:#C71585">What is an Interpreted language?</summary>

An interpreted language is a programming language where code is executed line by line by an interpreter at runtime, rather than being compiled into machine code before execution. In interpreted languages, the source code is directly executed by the interpreter without the need for an intermediate compilation step.
In interpreted languages like Python, source code is translated into intermediate code or bytecode, which is then executed by the interpreter at runtime.

</details>

<details><summary style="font-size:18px;color:#C71585">What is <b>pass</b> in Python?</summary>

In Python, **pass** is a null statement, which means it does nothing when executed. It is used as a placeholder when a statement is syntactically required, but no action needs to be performed.

The **pass** statement is often used in situations where the syntax requires a statement, but the program logic does not yet require any action to be taken.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between Python Arrays and lists?</summary>

The array module in Python provides an efficient way of working with arrays of homogeneous data types. Unlike Python lists, which can store elements of different data types, arrays in the array module are designed to store elements of a homogeneous data type, such as integers or floats. This makes them more memory-efficient for certain types of data.

```python
import array

a = array.array('i', [1, 2, 3]) # 'i' specifies the integer data type
```

```txt
class array(builtins.object)
    array(typecode [, initializer]) -> array

    Return a new array whose items are restricted by typecode, and
    initialized from the optional initializer value, which must be a list,
    string or iterable over elements of the appropriate type.

    Arrays represent basic values and behave very much like lists, except
    the type of objects stored in them is constrained. The type is specified
    at object creation time by using a type code, which is a single character.
    The following type codes are defined:

        Type code   C Type             Minimum size in bytes
        'b'         signed integer     1
        'B'         unsigned integer   1
        'u'         Unicode character  2 (see note)
        'h'         signed integer     2
        'H'         unsigned integer   2
        'i'         signed integer     2
        'I'         unsigned integer   2
        'l'         signed integer     4
        'L'         unsigned integer   4
        'q'         signed integer     8 (see note)
        'Q'         unsigned integer   8 (see note)
        'f'         floating point     4
        'd'         floating point     8

    NOTE: The 'u' typecode corresponds to Python's unicode character. On
    narrow builds this is 2-bytes on wide builds this is 4-bytes.

    NOTE: The 'q' and 'Q' type codes are only available if the platform
    C compiler used to build Python supports 'long long', or, on Windows,
    '__int64'.

    Methods:

    append() -- append a new item to the end of the array
    buffer_info() -- return information giving the current memory info
    byteswap() -- byteswap all the items of the array
    count() -- return number of occurrences of an object
    extend() -- extend array by appending multiple elements from an iterable
    fromfile() -- read items from a file object
    fromlist() -- append items from the list
    frombytes() -- append items from the string
    index() -- return index of first occurrence of an object
    insert() -- insert a new item into the array at a provided position
    pop() -- remove and return item (default last)
    remove() -- remove first occurrence of an object
    reverse() -- reverse the order of the items in the array
    tofile() -- write all items to a file object
    tolist() -- return the array converted to an ordinary list
    tobytes() -- return the array converted to a string
```

</details>

<details><summary style="font-size:18px;color:#C71585">What is PEP 8 and why is it important?</summary>

PEP 8 is a style guide for Python code written by Guido van Rossum, Barry Warsaw, and Nick Coghlan. PEP stands for Python Enhancement Proposal, and PEP 8 specifically addresses the coding conventions and style guidelines for writing Python code.

PEP 8, sometimes spelled PEP8 or PEP-8, stands for Python Enhancement Proposal 8. It's a style guide, not a strict rulebook, that provides recommendations for how to write clean and consistent Python code.

</details>

---

<details><summary style="font-size:18px;color:#C71585">Define PYTHONPATH.</summary>
In the realm of Python, PYTHONPATH is an environment variable that acts as a roadmap for the Python interpreter when searching for modules (reusable blocks of code) during program execution. It essentially defines a list of directories where the interpreter should look for modules beyond the standard library locations.

-   **Understanding the Search Path**: When you import a module in your Python code (using import module_name), the interpreter follows a specific search path to locate it:

    -   `Current Directory`: The interpreter first checks the current working directory (the directory from where you execute your script) for the module.
    -   `Built-in Libraries`: If not found there, it searches for the module in the standard library locations, which are pre-installed directories containing Python's core modules.
    -   `PYTHONPATH Directories`: Finally, the interpreter consults the directories listed in the PYTHONPATH environment variable, searching for the module in each directory (in the order they appear in the path).

-   **Setting PYTHONPATH**: There are several ways to set PYTHONPATH:

    -   `System-wide`: You can modify system environment variables to set PYTHONPATH globally, but this approach is generally discouraged as it can affect other Python environments or users on the system.
    -   `User-specific`: Setting PYTHONPATH in your shell configuration files (e.g., .bashrc or .zshrc) can make it persistent for your user sessions.
    -   `Virtual Environments`: The recommended approach is to use virtual environments, which isolate project dependencies and avoid conflicts. Virtual environments often manage their own PYTHONPATH within the activated environment.
    -   `Command-line Argument`: You can temporarily set PYTHONPATH for a single script execution using the -I or --interactive flag with the Python interpreter: `$ python -I /path/to/custom/modules my_script.py`

</details>

<details><summary style="font-size:18px;color:#C71585">Define PIP</summary>

`PIP`: PIP is the package manager for Python. It's a command-line tool that allows you to easily install, uninstall, and manage additional software libraries (packages) for your Python projects.

In the context of Python, PIP doesn't actually have a specific official meaning as an acronym. It's considered a recursive acronym, meaning its meaning is derived from its function. Here are some common interpretations:

-   **Preferred Installer Program**
-   **Packages Installed from PyPI** (referencing the Python Package Index)
-   **Packages Install Packages**

</details>

<details><summary style="font-size:18px;color:#C71585">Differentiate between deep and shallow copies.</summary>

Deep and shallow copies are two ways of creating copies of objects in Python, particularly when dealing with complex data structures like lists, dictionaries, or custom objects containing nested objects. The difference lies in how the nested objects are handled during the copying process.

-   **Shallow Copy**:

    -   A shallow copy creates a new object but inserts references to the nested objects found in the original object.
    -   The top-level objects are copied, but the nested objects are shared between the original and copied objects.
    -   Changes to the nested objects in the copied structure will be reflected in the original structure, and vice versa.
    -   Shallow copies can be created using the `copy()` method or the copy module's `copy()` function.

    ```python
    import copy

    original_list = [1, [2, 3], 4]
    shallow_copy = copy.copy(original_list)

    shallow_copy[1][0] = 'a'  # Modify nested object in shallow copy
    print(original_list)  # Output: [1, ['a', 3], 4] - original list is affected
    ```

-   **Deep Copy**:

    -   A deep copy creates a new object and recursively copies all nested objects found in the original object.
    -   Both the top-level objects and all nested objects are copied, resulting in completely independent objects.
    -   Changes to the nested objects in the copied structure will not affect the original structure, and vice versa.
    -   Deep copies can be created using the `copy()` method or the copy module's `deepcopy()` function.

    ```python
    import copy

    original_list = [1, [2, 3], 4]
    deep_copy = copy.deepcopy(original_list)

    deep_copy[1][0] = 'a'  # Modify nested object in deep copy
    print(original_list)  # Output: [1, [2, 3], 4] - original list remains unchanged
    ```

</details>

<details><summary style="font-size:18px;color:#C71585">What is main function in python? How do you invoke it?</summary>

Unlike many other programming languages, Python doesn't have a mandatory main function that serves as the automatic entry point for your program. The interpreter executes code line by line, starting from the top-level statements in your Python source file (.py file).
However, there are well-established conventions for defining a starting point in Python for your program's execution, often mimicking the behavior of the main function found in other languages. Common Practices for Defining a Starting Point:

-   **Using a Top-Level Function**:

    -   Define a function at the top level of your script with a descriptive name like main or run.
    -   Place your program's core logic and functionalities within this function.
    -   Call this function at the end of your script to execute it.

    ```python
    def main():
        # Your program's logic here
        print("Hello, world!")

    if __name__ == "__main__":
        main()
    ```

-   **if \_\_name\_\_ == \"\_\_main\_\_\:"**

    -   This conditional block ensures the code within the block is only executed when the script is run directly (not when imported as a module).
    -   The **\_\_name\_\_** special variable holds the name of the current module. When the script is executed directly, **\_\_name\_\_** is set to "**\_\_main\_\_**".

    ```python
    # Your program's functions here

    if __name__ == "__main__":
        # Call your functions or execute the main logic here
        print("This code executes only when the script is run directly")
    ```

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between Package and Module in Python?</summary>

In Python, the terms "module" and "package" refer to different concepts related to organizing and managing code. Here's a detailed explanation of the differences between them:

-   **Module**

    -   `Definition`: A module is a single file containing Python code. This file can define functions, classes, and variables, and can also include runnable code.
    -   `File Extension`: Modules are Python files with a .py extension.
    -   `Usage`: Modules are used to organize related code into a single file, making it easier to maintain and reuse.

-   **Package**

    -   `Definition`: A package is a collection of related modules organized in a directory hierarchy. A package must contain a special file named **init**.py, which can be empty, but its presence signals to Python that the directory should be treated as a package.
    -   `Directory Structure`: A package is a directory that contains a set of modules and sub-packages. Each directory within the package must have an **init**.py file.
    -   `Usage`: Packages are used to organize and manage larger collections of modules. They help in structuring your project logically.

</details>

<details><summary style="font-size:18px;color:#C71585">What are some of the most commonly used built-in modules in Python?</summary>

-   `os`: This module provides functions for interacting with the operating system, such as creating files and directories, managing file paths, and running external commands.
-   `sys`: This module provides access to system parameters and functions, such as command-line arguments, standard streams (stdin, stdout, stderr), and platform information.
-   `math`: This module provides mathematical functions, constants, and classes, such as trigonometric functions, logarithms, and mathematical constants like pi and e.
-   `datetime`: This module provides classes and functions for working with dates and times, including creating date and time objects, formatting them, and performing arithmetic operations on them.
-   `random`: This module provides functions for generating random numbers, shuffling sequences, and selecting random elements from a list.
-   `collections`: This module provides powerful container data types like namedtuple, deque, Counter, and OrderedDict that extend the functionality of built-in lists, dictionaries, and tuples.
-   `re`: This module provides regular expression support for searching, matching, and manipulating text strings.
-   `json`: This module provides functions for encoding and decoding JSON (JavaScript Object Notation) data, which is a popular format for data interchange between applications.
-   `itertools`: This module provides functions for creating iterators and working with iterables, such as generating combinations, permutations, and filtering elements.
-   `subprocess`: This module provides functions for spawning new processes and managing their execution.

</details>

<details><summary style="font-size:18px;color:#C71585">What are the differences between pickling and unpickling?</summary>

</details>

<details><summary style="font-size:18px;color:#C71585">List out the tools for identifying bugs and performing static analysis in python?</summary>

There are several tools available for identifying bugs and performing static analysis in Python. These tools help ensure code quality, detect potential issues, and enforce coding standards. Here are some of the most popular ones:

Bug Identification and Static Analysis Tools

-   **Pylint**: Pylint is a static code analysis tool that checks for programming errors, enforces a coding standard, and looks for code smells.

    -   Usage: `$ pylint my_module.py`

-   **Flake8**: Flake8 is a wrapper around PyFlakes, pycodestyle, and Ned Batchelder's McCabe script. It checks the style and quality of Python code.

    -   Usage: `$ flake8 my_module.py`

-   **PyLint**: PyLint analyzes code for potential errors and enforces coding standards. It is highly configurable and can be integrated into various development environments.

    -   Usage: `$ pylint my_module.py`

-   **Pyflakes**: Pyflakes analyzes programs and detects various errors. It is focused on finding errors quickly without bothering with style issues.

    -   Usage: `$ pyflakes my_module.py`

-   **Mypy**: Mypy is a static type checker for Python. It helps catch type-related errors in your code by checking type hints.

    -   Usage: `$ mypy my_module.py`

-   **Bandit**: Bandit is a tool designed to find common security issues in Python code. It scans code for known vulnerabilities.

    -   Usage: `$ bandit -r my_project/`

-   **Pyright**: Pyright is a fast type checker for Python, designed to work with VS Code and other editors that support the Language Server Protocol (LSP).

    -   Usage: `$ pyright my_module.py`

-   **Prospector**: Prospector is a tool to analyze Python code and output information about errors, potential problems, convention violations, and complexity. It aggregates results from multiple analysis tools.

    -   Usage: `$ prospector`

-   **Pydocstyle**: Pydocstyle checks compliance with Python docstring conventions. It can ensure that docstrings are present and correctly formatted.

    -   Usage: `$ pydocstyle my_module.py`

-   **Radon**: Radon is a tool for computing various metrics from the source code, including cyclomatic complexity, raw metrics, and maintainability index.

    -   Usage: `$ radon cc my_module.py`

-   **Vulture**: Vulture finds unused code in Python programs. This can help identify dead code that can be removed to improve maintainability.

    -   Usage: `$ vulture my_module.py`

-   **Integrated Development Environment (IDE) Support**
    Many of these tools are supported by popular IDEs such as PyCharm, Visual Studio Code, and others. They can be configured to run automatically as part of the development process, providing real-time feedback and integration into continuous integration (CI) pipelines.

-   **Example of Combining Tools in a CI Pipeline**
    Combining multiple tools can provide comprehensive coverage. For example, you might set up a CI pipeline with tools like Flake8 for style checks, Mypy for type checks, and Bandit for security checks.

    Here’s an example of how you might configure a .travis.yml file for a Travis CI pipeline:

    ```yaml
    language: python
    python:
        - "3.8"
    install:
        - pip install flake8 mypy bandit
    script:
        - flake8 my_module.py
        - mypy my_module.py
        - bandit -r my_project/
    ```

This setup will run Flake8, Mypy, and Bandit checks on every commit, helping ensure that code quality is maintained throughout the development process.

</details>

---

<details><summary style="font-size:18px;color:#C71585">How is memory managed in Python?</summary>

Memory management in Python is automatic and primarily handled by the Python memory manager, which is responsible for allocating and deallocating memory for objects. As a programmer, you don't need to manually allocate or deallocate memory for objects in your code.

The garbage collector is a core component of this memory management system.

Garbage collection is an automated memory management mechanism and a crucial component of the memory manager in Python 3. It automatically identifies and reclaims memory occupied by objects that are no longer referenced by your program, preventing memory leaks and ensuring efficient memory utilization.

Python's garbage collector is not deterministic. The exact timing of garbage collection cycles can vary depending on memory usage and other factors.

-   **How Garbage Collection Works**: The Python interpreter periodically runs a garbage collection in the background. In CPython, the most popular Python implementation, the Garbage Collection relies on two technique called Reference Counting and Cyclic Refferences to identify the garbages. Here's a breakdown of the process:

    -   `Reference Counting`:

        -   Whenever you create an object in Python, a reference count on the memory Heap initialized to 1 and it keeps track of how many different times that object are refferenced in your program.
        -   When you assign an object to a variable or pass it as an argument to a function, the reference count is incremented by 1, signifying another reference to the object exists.
        -   Conversely, when a variable referencing an object goes out of scope (e.g., the function containing the variable finishes execution), or you explicitly delete a reference (using del), the reference count is decremented by 1.
        -   During the pariodic run of garbage collection, it identifies objects with a reference count of 0. These objects are considered unreachable as there are no active references to them in your program.

    -   `Cyclic References`: Reference counting can't handle cyclic references, where two or more objects reference each other indefinitely. Even though no code directly references these objects anymore, their reference counts remain above 0, preventing garbage collection. The cyclic garbage collection addresses a the limitation.

        -   `Detection`: Python's cyclic garbage collector employs a more sophisticated approach to identify unreachable objects, even if they're involved in circular references.
        -   `Marking Phase`: The collector traverses the memory space, starting from root objects (objects directly accessible from your program's global scope or persistent references like open files). It marks reachable objects as it goes.
        -   `Reachability Check`: Once the marking phase is complete, objects that remain unmarked are considered unreachable, even if their reference count might be non-zero due to circular references.
        -   `Collection`: These unmarked objects are then candidates for garbage collection, and their memory is reclaimed.

    -   `Memory Reclamation`: Once an object is identified as unreachable, the garbage collector reclaims the memory occupied by that object, making it available for future object allocations.

#### Heap Space in Python

In Python, the "heap" generally refers to the private heap space managed by the Python memory manager. This is where Python objects are allocated and managed during program execution. Understanding the Python heap is crucial for understanding memory management in Python. Here's a detailed explanation:

-   `Dynamic Memory Allocation`: In Python, memory allocation is dynamic, meaning that memory for objects is allocated as needed during program execution. When you create a new object, such as a variable, list, or class instance, Python allocates memory for that object on the heap.
-   `Reference Counting`: Python uses a technique called reference counting to manage memory. Each object on the heap has a reference count, which tracks how many references (pointers) exist to that object. When an object's reference count drops to zero, meaning there are no more references to it, the memory occupied by the object is reclaimed.
-   `Garbage Collection`: In addition to reference counting, Python also employs a garbage collector to reclaim memory for objects with cyclic references or when reference counting alone is insufficient. The garbage collector periodically scans the heap to identify and reclaim unreachable objects, freeing up memory for reuse.
-   `Memory Fragmentation`: As objects are allocated and deallocated on the heap, memory fragmentation can occur. This is when the heap becomes fragmented with small chunks of memory scattered throughout, making it challenging to allocate contiguous blocks of memory for new objects. Python's memory manager includes mechanisms to address fragmentation and optimize memory allocation.
-   `Global vs. Per-Thread Heap`: Python's memory manager maintains separate heaps for global objects and per-thread objects. Global objects are accessible from any thread in the program and are stored in the global heap. Per-thread objects, such as thread-local variables, are stored in per-thread heaps, which are managed separately.
-   `Memory Profiling and Optimization`: Understanding how memory is allocated and managed on the heap is essential for optimizing memory usage and performance in Python programs. Techniques such as memory profiling, identifying memory leaks, minimizing object creation, and optimizing data structures can help improve memory efficiency and performance.
-   `C Extensions and Memory Management`: When working with C extensions or interacting with external libraries, it's important to be mindful of memory management. Python's memory management system may interact with memory management mechanisms in C code, and improper memory management can lead to memory leaks or undefined behavior.

</details>

<details><summary style="font-size:18px;color:#C71585">What is garbage collection? How it works in Python?</summary>

Garbage collection is an automated memory management mechanism and a crucial component of the memory manager in Python 3. It automatically identifies and reclaims memory occupied by objects that are no longer referenced by your program, preventing memory leaks and ensuring efficient memory utilization.

Python's garbage collector is not deterministic. The exact timing of garbage collection cycles can vary depending on memory usage and other factors.

-   **How Garbage Collection Works**: The Python interpreter periodically runs a garbage collection in the background. In CPython, the most popular Python implementation, the Garbage Collection relies on two technique called Reference Counting and Cyclic Refferences to identify the garbages. Here's a breakdown of the process:

    -   `Reference Counting`:

        -   Whenever you create an object in Python, a reference count on the memory Heap initialized to 1 and it keeps track of how many different times that object are refferenced in your program.
        -   When you assign an object to a variable or pass it as an argument to a function, the reference count is incremented by 1, signifying another reference to the object exists.
        -   Conversely, when a variable referencing an object goes out of scope (e.g., the function containing the variable finishes execution), or you explicitly delete a reference (using del), the reference count is decremented by 1.
        -   During the pariodic run of garbage collection, it identifies objects with a reference count of 0. These objects are considered unreachable as there are no active references to them in your program.

    -   `Cyclic References`: Reference counting can't handle cyclic references, where two or more objects reference each other indefinitely. Even though no code directly references these objects anymore, their reference counts remain above 0, preventing garbage collection. The cyclic garbage collection addresses a the limitation.

        -   `Detection`: Python's cyclic garbage collector employs a more sophisticated approach to identify unreachable objects, even if they're involved in circular references.
        -   `Marking Phase`: The collector traverses the memory space, starting from root objects (objects directly accessible from your program's global scope or persistent references like open files). It marks reachable objects as it goes.
        -   `Reachability Check`: Once the marking phase is complete, objects that remain unmarked are considered unreachable, even if their reference count might be non-zero due to circular references.
        -   `Collection`: These unmarked objects are then candidates for garbage collection, and their memory is reclaimed.

    -   `Memory Reclamation`: Once an object is identified as unreachable, the garbage collector reclaims the memory occupied by that object, making it available for future object allocations.

#### Core API functions to work upon the garbage collection in Python?

Python provides several core API functions and modules for working with garbage collection, allowing you to control and manage the process of reclaiming memory occupied by objects that are no longer referenced. Here are some of the core API functions and modules related to garbage collection in Python:

-   **gc Module**: The gc module provides a high-level interface to Python's garbage collection mechanism. It includes functions for manual garbage collection control, as well as utilities for inspecting the garbage collector's behavior and statistics.
    -   `gc.collect([generation])`: Manually triggers garbage collection. By default, it collects all generations, but you can specify a generation to collect (0 for the youngest generation, 2 for the oldest).
    -   `gc.get_count()`: Returns a tuple containing the current collection counts for each generation. These counts represent the number of objects that have been allocated since the last collection.
    -   `gc.get_stats()`: Returns a list of dictionaries containing information about the garbage collector's behavior and statistics, including the number of collections, memory usage, and more.
    -   `gc.set_debug(flags)`: Enables or disables debugging output from the garbage collector. The flags argument is a bitmask representing the debugging options to enable.
    -   `gc.get_objects()`: Returns a list of all objects tracked by the garbage collector. This can be useful for debugging and profiling purposes, but it's not recommended for general use due to potential performance overhead.
    -   `gc.get_referents(obj)`: Returns a list of objects that directly reference the given object obj. This function can be used to inspect the references to a specific object in the heap.
    -   `gc.get_referrers(obj)`: Returns a list of objects that directly reference the given object obj. This function can be used to inspect the objects that reference a specific object in the heap.
-   **sys** Module: The `sys` module provides access to system-specific parameters and functions, including functions related to memory management. For example, `sys.getsizeof()` can be used to determine the size of an object in memory, and `sys.getrefcount()` can be used to get the reference count of an object.
-   **resource** Module: On Unix-based systems, the `resource` module provides functions for querying and modifying system resource limits, including memory limits. Functions like `resource.getrusage()` can be used to get information about resource usage, including memory usage.
-   **tracemalloc** Module: The `tracemalloc` module allows tracing memory allocations and retrieving information about memory blocks allocated by Python. Functions like `tracemalloc.start()` and `tracemalloc.stop()` can be used to start and stop tracing, and `tracemalloc.get_traced_memory()` can be used to retrieve information about traced memory allocations.

In summary, garbage collection in Python is an essential feature that helps manage memory automatically. Understanding how it works can be beneficial for writing memory-efficient Python code and avoiding potential memory-related issues. However, it's generally not necessary to directly interfere with the garbage collector. Focus on writing clean code and avoiding unnecessary object references for optimal performance.

</details>

<details><summary style="font-size:18px;color:#C71585">What is Memory Leaks in Python?</summary>

A Memory Leak is a situation where objects that are no longer needed by your program are not properly deallocated by the garbage collector. This can lead to a gradual increase in memory usage over time, potentially impacting your program's performance or even causing crashes. This can eventually cause the program to consume all available memory, resulting in slow performance or crashes. Memory leaks are often caused by references to objects that are no longer needed but cannot be freed by the garbage collector because references to them still exist.

-   **Causes of Memory Leaks**:

    -   `Lingering References`: Objects that are no longer needed but still referenced somewhere in the code, such as in global variables, closures, or data structures.
    -   `Circular References`: A situation where two or more objects reference each other, preventing the garbage collector from deallocating them. Although Python's garbage collector can handle simple circular references, complex ones can still cause issues.
    -   `Caching`: Keeping unnecessary references in caches that grow indefinitely, such as lists, dictionaries, or custom caching mechanisms.
    -   `Incorrect Use of Data Structures`: Data structures that hold references to objects that are no longer needed, such as lists or dictionaries where old entries are not properly removed.

-   **Preventing Memory Leaks**:

    -   `Break Circular References`: Refactor code to avoid objects referencing each other indefinitely. Consider using weak references or setting references to None when objects are no longer needed.
    -   `Close Resources Properly`: Ensure you close external resources like files, network connections, and databases using close() or context managers like with.
    -   `Implement Caching Strategies`: Establish clear policies for cache invalidation or eviction to prevent them from holding onto unnecessary data.
    -   `Be Cautious with Global Variables`: Limit the use of global variables and consider alternatives like dependency injection or class attributes if appropriate.

</details>

<details><summary style="font-size:18px;color:#C71585">What is Weak Reference in Python?</summary>

In Python, a weak reference is a special type of reference that doesn't prevent an object from being garbage collected. It allows you to hold a reference to an object without artificially increasing its reference count.

-   **Regular References and Garbage Collection**

    -   When you create an object in Python, the interpreter keeps track of how many variables (references) point to it using a reference count.
    -   As long as the reference count is greater than zero, the object remains in memory, even if your code doesn't explicitly use it anymore.
    -   The garbage collector only reclaims objects with a reference count of zero.

-   **Weak References: No Impact on Garbage Collection**

    -   A weak reference holds a reference to an object, but it doesn't contribute to its reference count.
    -   This means that even if the only reference to an object is a weak reference, the garbage collector can still reclaim the object's memory when it's no longer needed by your program.

-   **Creating Weak References**: The weakref module provides functions for creating different types of weak references:

    -   `weakref.proxy`: Creates a proxy object that behaves like the original object but allows the original object to be garbage collected.
    -   `weakref.ref`: Creates a weak reference object that holds a reference to the original object but doesn't provide access to it directly.

    ```python
    from weakref import WeakKeyDictionary

    class ExpensiveObject:
        # ... (represents a large object)

    class Cache:
        def __init__(self):
            self.cache = WeakKeyDictionary()  # Use WeakKeyDictionary for weak references to keys

        def get(self, key):
            return self.cache.get(key)

        def set(self, key, value):
            self.cache[key] = value

    # Usage
    cache = Cache()
    obj = ExpensiveObject()
    cache.set(obj, "data")

    # If 'obj' is no longer referenced elsewhere, it can be garbage collected
    # even though it's still in the cache (weak reference)
    ```

</details>

<details><summary style="font-size:18px;color:#C71585">What is Python's memory management system?</summary>

Answer: Python's memory management system involves a private heap containing all Python objects and data structures. The management of this private heap is ensured internally by the Python memory manager. The core API provides access to some tools for the programmer to code and manage memory. Python uses automatic memory management, which includes reference counting and garbage collection.

</details>

<details><summary style="font-size:18px;color:#C71585">What is reference counting in Python?</summary>

Answer: Reference counting is a memory management technique where each object maintains a count of references to it. When the reference count drops to zero, the object is deallocated. Python uses reference counting as one of its methods for memory management.

</details>

<details><summary style="font-size:18px;color:#C71585">What is garbage collection in Python?</summary>

Answer: Garbage collection is a mechanism to reclaim memory occupied by objects that are no longer in use by the program. In Python, garbage collection complements reference counting by handling cyclic references (objects referencing each other) that reference counting alone cannot clean up. Python's garbage collector is part of the gc module.

</details>

<details><summary style="font-size:18px;color:#C71585">How does Python's garbage collector handle cyclic references?</summary>

Answer: Python's garbage collector identifies cyclic references by using a graph traversal algorithm. When it detects objects that reference each other but are not reachable from any active scope, it collects and deallocates them to free up memory.

</details>

<details><summary style="font-size:18px;color:#C71585">What are some common strategies to manage memory usage in Python?</summary>

Answer:

-   `Minimize global variables`: They persist for the lifetime of the program, consuming memory.
-   `Use local variables`: Local variables are cleaned up after the function call ends.
-   `Weak references`: Use the weakref module to create references that do not increase the reference count.
-   `Del keyword`: Use del to manually remove references to objects.
-   `Custom data structures`: Use more memory-efficient data structures like array instead of lists when dealing with large datasets.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the role of the `__del__` method in memory management?</summary>

Answer: The `__del__` method in Python is a special method that acts as a destructor. It is called when an object's reference count reaches zero, right before the object is deallocated. It's generally used for cleanup actions like closing files or releasing network resources. However, reliance on `__del__` is discouraged due to potential issues with reference cycles and the timing of its invocation.

</details>

<details><summary style="font-size:18px;color:#C71585">How can you manually trigger garbage collection in Python?</summary>

Answer: You can manually trigger garbage collection using the gc module:

```python
import gc
gc.collect()
```

</details>

<details><summary style="font-size:18px;color:#C71585">What is profiling? How can you profile memory usage in a Python program?</summary>

Profiling in programming refers to the process of analyzing a program to measure its performance, including how much time and memory are consumed during its execution. The primary goal of profiling is to identify bottlenecks, optimize resource usage, and improve efficiency.

You can profile memory usage using tools like memory_profiler and tracemalloc. Here’s an example with memory_profiler:

```python
from memory_profiler import profile

@profile
def my_function():
    # Your code here
    pass

if __name__ == "__main__":
    my_function()
```

</details>

<details><summary style="font-size:18px;color:#C71585">What is tracemalloc, and how is it used?</summary>

Answer: tracemalloc is a module in Python's standard library for tracing memory allocations. It helps you understand memory usage and track memory leaks. Here’s how you can use it:

```python
import tracemalloc

tracemalloc.start()

# Your code here

snapshot = tracemalloc.take_snapshot()
top_stats = snapshot.statistics('lineno')

for stat in top_stats[:10]:
    print(stat)
```

</details>

<details><summary style="font-size:18px;color:#C71585">What are weak references and when would you use them?</summary>

Answer: Weak references allow you to reference an object without increasing its reference count. This can be useful in caching mechanisms where you want to allow objects to be garbage-collected if they are no longer in use elsewhere in the program. The weakref module provides support for weak references.

```python
import weakref

class MyClass:
    pass

obj = MyClass()
weak_ref = weakref.ref(obj)

print(weak_ref())  # Outputs: <__main__.MyClass object at 0x...>
del obj
print(weak_ref())  # Outputs: None
```

</details>

<details><summary style="font-size:18px;color:#C71585">Explain memory fragmentation and how Python handles it.</summary>

Answer: Memory fragmentation occurs when free memory is split into small blocks and scattered throughout the heap, making it difficult to allocate large contiguous blocks of memory. Python mitigates memory fragmentation through its memory allocator, which uses pools of fixed-size blocks to manage small objects and reduces fragmentation by allocating larger objects directly from the system heap.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the role of sys.getsizeof() in Python?</summary>

Answer: sys.getsizeof() returns the size of an object in bytes. This can be useful for understanding the memory footprint of an object.

```python
import sys

my_list = [1, 2, 3]
print(sys.getsizeof(my_list))  # Outputs the size of the list object in bytes
```

</details>

---

<details><summary style="font-size:18px;color:#C71585">Define Concurrency and Parallelism. How do they differ?</summary>

Concurrency is the ability of a program to make progress on multiple tasks simultaneously, usually by interleaving their execution. Parallelism, on the other hand, is the ability to execute multiple tasks simultaneously, typically on multiple processors or cores.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain how Python handles concurrency. What modules or constructs are commonly used?</summary>

Python handles concurrency through threading, asyncio, and multiprocessing. Commonly used modules include threading for threads, asyncio for asynchronous I/O, and multiprocessing for parallel processes.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the Global Interpreter Lock (GIL) in Python? How does it affect concurrency and parallelism?</summary>

The GIL stands for Global Interpreter Lock. It is a mutex (or lock) that allows only one thread to execute Python bytecode at a time, even on multi-core systems. The presence of the GIL has significant implications for Python's concurrency model.Here are some key points about the GIL in Python:
The GIL is a mutex that protects access to Python objects, preventing multiple threads from executing Python bytecodes simultaneously in a single process. It affects concurrency by making multi-threaded programs effectively single-threaded in terms of CPU-bound tasks. For parallelism, Python's multiprocessing module can be used to bypass the GIL by using separate processes.

-   **Single-threaded Python**: Despite Python's support for multiple threads, due to the GIL, only one thread can execute Python bytecode at a time. This means that Python threads cannot fully utilize multiple CPU cores for CPU-bound tasks.
-   **Designed for CPython**: The GIL is specific to the CPython interpreter, the most widely used implementation of Python. Other implementations, such as Jython and IronPython, do not have a GIL.
-   **Impact on CPU-bound tasks**: While the GIL allows Python to be thread-safe by preventing race conditions, it can hinder performance for CPU-bound tasks because it limits parallelism.
-   **Does not affect I/O-bound tasks**: For I/O-bound tasks (e.g., network I/O, disk I/O), where threads spend most of their time waiting for external resources, the GIL does not significantly impact performance because threads release the GIL while waiting.
-   **Alternatives for concurrency**: To achieve parallelism for CPU-bound tasks, developers can use multiprocessing, asynchronous I/O (e.g., asyncio), or extension modules written in languages like C or Cython that release the GIL for performance-critical operations.
-   **Discussion and debates**: The GIL has been a subject of much discussion and debate in the Python community. While it simplifies CPython's internal memory management and makes it easier to write C extensions, it also poses challenges for concurrency.

In summary, the GIL in Python restricts concurrent execution of Python bytecode by multiple threads in the CPython interpreter, which can impact performance for CPU-bound tasks. Developers must consider alternatives for achieving parallelism when dealing with such tasks.

</details>

<details><summary style="font-size:18px;color:#C71585">How does the threading module work in Python? Provide a simple example.</summary>

The threading module provides a way to create and manage threads. Here's a simple example:

```python
import threading

def print_numbers():
    for i in range(5):
        print(i)

thread = threading.Thread(target=print_numbers)
thread.start()
thread.join()
```

</details>

<details><summary style="font-size:18px;color:#C71585">Discuss the limitations of using threads for parallelism in Python.</summary>

Due to the GIL, threads in Python cannot achieve true parallelism for CPU-bound tasks. They are better suited for I/O-bound tasks where the GIL is released during I/O operations.

</details>

<details><summary style="font-size:18px;color:#C71585">What is asyncio in Python, and how does it enable concurrency?</summary>

asyncio is a library to write concurrent code using the async/await syntax. It is suitable for I/O-bound and high-level structured network code. It enables concurrency by running coroutines in an event loop, allowing tasks to be paused and resumed efficiently.
Provide a simple example of an asyncio coroutine.

Answer:

```python
import asyncio

async def say_hello():
    await asyncio.sleep(1)
    print("Hello")

asyncio.run(say_hello())
```

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the difference between asyncio coroutines and threads.</summary>

asyncio coroutines are cooperative, meaning they yield control to the event loop, allowing other tasks to run. Threads are preemptive, meaning the operating system can interrupt them at any time to switch execution to another thread. Coroutines are more lightweight than threads and can provide better performance for I/O-bound tasks.

</details>

<details><summary style="font-size:18px;color:#C71585">How does the multiprocessing module achieve parallelism in Python?</summary>

The multiprocessing module creates separate processes, each with its own Python interpreter and memory space, allowing true parallelism by leveraging multiple CPU cores. This bypasses the GIL, making it suitable for CPU-bound tasks.
Provide a simple example using the multiprocessing module.

Answer:

```python
from multiprocessing import Process

def print_numbers():
    for i in range(5):
        print(i)

process = Process(target=print_numbers)
process.start()
process.join()
```

</details>

<details><summary style="font-size:18px;color:#C71585">What are some common pitfalls when using concurrency and parallelism in Python?</summary>

Common pitfalls include race conditions, deadlocks, and the impact of the GIL. Developers need to ensure proper synchronization when using threads and be aware of the overhead of inter-process communication when using multiple processes.

</details>

<details><summary style="font-size:18px;color:#C71585">How can you mitigate the impact of the GIL for CPU-bound tasks in Python?</summary>

For CPU-bound tasks, you can use the multiprocessing module to create separate processes. Alternatively, using libraries like numba or cython to optimize performance-critical sections of code can also help mitigate the impact of the GIL.

</details>

<details><summary style="font-size:18px;color:#C71585">Describe a scenario where asyncio is more appropriate than threading or multiprocessing.</summary>

asyncio is more appropriate for I/O-bound tasks that involve waiting for network or disk I/O, such as web scraping, handling multiple web requests in a web server, or performing asynchronous file operations. It is less suitable for CPU-bound tasks which benefit more from parallelism provided by multiprocessing.

</details>

<details><summary style="font-size:18px;color:#C71585">How do you handle exceptions in asyncio coroutines?</summary>

Exceptions in asyncio coroutines can be handled using try/except blocks within the coroutine. Additionally, when using tasks, you can attach an exception handler or check for exceptions after the task completes.

```python
import asyncio

async def faulty_coroutine():
    raise ValueError("An error occurred")

async def main():
    try:
        await faulty_coroutine()
    except ValueError as e:
        print(f"Caught an exception: {e}")

asyncio.run(main())
```

</details>

---

#### OOP

<details><summary style="font-size:18px;color:#C71585">Define `.whl` and `.egg` files. What is the difference between them</summary>

In Python, `.whl` (wheel) and `.egg` are both packaging formats used for distributing libraries or applications, but they have important differences in structure, usage, and support.

-   **`.egg` Files**:

    -   **Introduced By**: Setuptools.
    -   **Purpose**: One of the earlier formats for distributing Python packages.
    -   **Structure**: An `.egg` file is essentially a zip-compressed archive containing the package's code, metadata, and any dependencies.
    -   **Installation**: Can be installed using `easy_install`, a tool that comes with `setuptools`.
    -   **Disadvantages**: - Limited metadata storage.
        -   Difficult to manage cross-platform compatibility.
        -   Not the standard anymore, considered outdated.

-   **`.whl` Files**:

    -   **Introduced By**: The Python Packaging Authority (PyPA).
    -   **Purpose**: A newer format meant to replace `.egg` and is the current standard for packaging and distribution.
    -   **Structure**: A wheel file is also a zip-compressed archive but with a more standardized file structure. It includes the package code and metadata (like version, dependencies) in a consistent and flexible way.
    -   **Installation**: Installed using `pip`, which is now the standard Python package manager.
    -   **Advantages**:
        -   Supports platform-specific builds and metadata.
        -   Easier to handle dependencies and metadata for various environments.
        -   More widely adopted and supported by the Python community and tools like `pip`.

-   Key Differences:
    -   **Adoption**: `.whl` is the modern and preferred format, while `.egg` is largely considered outdated.
    -   **Tooling**: `.whl` is installed via `pip`, whereas `.egg` was primarily used with `easy_install`.
    -   **Cross-Platform**: `.whl` files have better support for cross-platform compatibility through detailed metadata.
    -   **Standardization**: `.whl` follows a more standardized structure, while `.egg` files have inconsistencies in how metadata and dependencies are handled.

</details>

<details><summary style="font-size:18px;color:#C71585">What is metaclass in Python?</summary>

A metaclass is a class of a class that defines how a class behaves. Just as a class defines how instances of the class behave, a metaclass defines how classes themselves behave. Metaclasses are an advanced and powerful feature in Python that can be used to customize class creation.You define a metaclass by inheriting from type and can override methods like `__new__` and `__init__`.

**Customizing Class Creation**: By using metaclasses, you can control several aspects of class creation. It can be used to enforce class invariants, modify class attributes, implement singletons, track class registration, and more.

-   `Modifying Class Attributes`: You can modify or add class attributes during class creation.
-   `Validating Class Definitions`: You can enforce rules on how classes should be defined. For example, ensuring certain methods or attributes are present.
-   `Class Registry`: You can automatically register classes in some registry for later use or tracking.

**Example**: Enforcing Attribute Presence

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

**Dynamic Class Creation**:

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
person_instance = Person("Alice", 30)
```

</details>

<details><summary style="font-size:18px;color:#C71585">How do you access parent members in the child class?</summary>

In Python, you can access members (attributes and methods) of the parent class from a child class using the super() function or by directly referencing the parent class name. Here's how you can do it:

**Using super()**: The `super()` function returns a proxy object that allows you to access methods and attributes of the parent class. You can use it to call the parent class constructor (**init**) or any other method.

```python
Copy code
class Parent:
    def __init__(self, name):
        self.name = name

class Child(Parent):
    def __init__(self, name, age):
        super().__init__(name)  # Call parent class constructor
        self.age = age

child = Child("Alice", 10)
print(child.name)  # Accessing parent attribute
```

**Using Dot Notation:**: You can also directly reference the parent class name to access its members using dot notation.

```python
Copy code
class Parent:
    def __init__(self, name):
        self.name = name

class Child(Parent):
    def __init__(self, name, age):
        Parent.__init__(self, name)  # Call parent class constructor
        self.age = age

child = Child("Alice", 10)
print(child.name)  # Accessing parent attribute
```

Both approaches achieve the same result, but using super() is preferred as it provides a more flexible and maintainable way to access parent class members, especially in cases of multiple inheritance.

</details>

<details><summary style="font-size:18px;color:#C71585">Is it possible to call parent class without its instance creation in Python?</summary>

Yes, it is possible to call a parent class method without creating an instance of the parent class in Python. This can be achieved using the following methods:

-   **Using the class name directly**: If you need to call a class method or a static method from the parent class, you can do so by using the class name directly.

-   Using **super()**: If you are within an instance method of a subclass, you can use super() to call methods from the parent class.

-   **Example with Class Methods and Static Methods**

    Here's an example that demonstrates how to call class methods and static methods from a parent class without creating an instance of the parent class:

    ```python
    class Parent:
        @classmethod
        def class_method(cls):
            print(f"Class method called from {cls.__name__}")

        @staticmethod
        def static_method():
            print("Static method called from Parent")

    class Child(Parent):
        pass

    # Calling the class method and static method from the parent class directly
    Parent.class_method()  # Output: Class method called from Parent
    Parent.static_method()  # Output: Static method called from Parent

    # Calling the class method and static method from the parent class using the subclass
    Child.class_method()  # Output: Class method called from Child
    Child.static_method()  # Output: Static method called from Parent
    ```

-   **Example with Instance Methods Using super()**

    If you are within an instance method of a subclass and want to call an instance method from the parent class, you can use super():

    ```python
    class Parent:
        def instance_method(self):
            print("Instance method called from Parent")

    class Child(Parent):
        def instance_method(self):
            print("Instance method called from Child")
            super().instance_method()  # Calls the instance method from the parent class

    # Creating an instance of Child and calling the instance method
    child_instance = Child()
    child_instance.instance_method()
    # Output:
    # Instance method called from Child
    # Instance method called from Parent
    ```

-   **Example with Class Methods Using super()**

    If you are within a class method of a subclass and want to call a class method from the parent class, you can use super():

    ```python
    class Parent:
        @classmethod
        def class_method(cls):
            print(f"Class method called from {cls.__name__}")

    class Child(Parent):
        @classmethod
        def class_method(cls):
            print(f"Class method called from {cls.__name__} (Child)")
            super().class_method()  # Calls the class method from the parent class

    # Calling the class method from the Child class
    Child.class_method()
    # Output:
    # Class method called from Child (Child)
    # Class method called from Child
    ```

**Summary**:

-   `Class Methods and Static Methods`: Can be called using the class name directly.
-   `Instance Methods`: Within an instance method of a subclass, use super() to call instance methods of the parent class.
-   `Class Methods`: Within a class method of a subclass, use super() to call class methods of the parent class.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain different types of inheritance in Python</summary>

inheritance is a mechanism that allows a class (called the subclass or derived class) to inherit properties and behavior from another class (called the superclass or base class). There are different types of inheritance supported in Python:

-   **Single Inheritance**:

    -   In single inheritance, a subclass inherits from only one superclass.
    -   It forms a one-to-one parent-child relationship between classes.

    -   Example:

        ```python
        class Parent:
            def parent_method(self):
                print("Parent method")

        class Child(Parent):
            def child_method(self):
                print("Child method")

        child = Child()
        child.parent_method()  # Output: Parent method
        child.child_method()   # Output: Child method
        ```

-   **Multiple Inheritance**:

    -   In multiple inheritance, a subclass inherits from more than one superclass.
    -   It allows a subclass to inherit properties and behavior from multiple parent classes.

    -   Example:

        ```python
        class Parent1:
            def parent1_method(self):
                print("Parent 1 method")

        class Parent2:
            def parent2_method(self):
                print("Parent 2 method")

        class Child(Parent1, Parent2):
            def child_method(self):
                print("Child method")

        child = Child()
        child.parent1_method()  # Output: Parent 1 method
        child.parent2_method()  # Output: Parent 2 method
        child.child_method()    # Output: Child method
        ```

-   **Multilevel Inheritance**:

    -   In multilevel inheritance, a subclass inherits from a superclass, and another subclass inherits from the subclass.
    -   It forms a chain of inheritance.

    -   Example:

        ```python
        class GrandParent:
            def grandparent_method(self):
                print("Grandparent method")

        class Parent(GrandParent):
            def parent_method(self):
                print("Parent method")

        class Child(Parent):
            def child_method(self):
                print("Child method")

        child = Child()
        child.grandparent_method()  # Output: Grandparent method
        child.parent_method()       # Output: Parent method
        child.child_method()        # Output: Child method
        ```

-   **Hierarchical Inheritance**:

    -   In hierarchical inheritance, multiple subclasses inherit from the same superclass.
    -   It forms a tree-like structure.

    -   Example:

        ```python
        class Parent:
            def parent_method(self):
                print("Parent method")

        class Child1(Parent):
            def child1_method(self):
                print("Child 1 method")

        class Child2(Parent):
            def child2_method(self):
                print("Child 2 method")

        child1 = Child1()
        child1.parent_method()   # Output: Parent method
        child1.child1_method()   # Output: Child 1 method

        child2 = Child2()
        child2.parent_method()   # Output: Parent method
        child2.child2_method()   # Output: Child 2 method
        ```

-   **Hybrid Inheritance**:

    -   Hybrid inheritance is a combination of multiple inheritance and other types of inheritance.
    -   It can involve a mix of single, multiple, multilevel, or hierarchical inheritance.

    -   Example:

        ```python
        class A:
            def method_a(self):
                print("Method A")

        class B(A):
            def method_b(self):
                print("Method B")

        class C(A):
            def method_c(self):
                print("Method C")

        class D(B, C):
            def method_d(self):
                print("Method D")

        obj = D()
        obj.method_a()  # Output: Method A
        obj.method_b()  # Output: Method B
        obj.method_c()  # Output: Method C
        obj.method_d()  # Output: Method D
        ```

</details>

<details><summary style="font-size:18px;color:#C71585">Differentiate between new and override modifiers.</summary>

In Python, there are no explicit "new" or "override" modifiers like in some other languages such as Java. However, in the context of object-oriented programming, we can discuss concepts similar to "new" and "override" in Python:

-   **Overriding**:

    -   In Python, overriding refers to the ability to define a method in a subclass that has the same name as a method in its superclass.
    -   When a method is called on an instance of the subclass, Python looks for the method in the subclass first. If it's not found, it looks for the method in the superclass.
    -   If the method is found in the subclass, it overrides the method with the same name in the superclass. This allows subclasses to provide specialized implementations of methods inherited from the superclass.

-   **New Method**:

    -   In Python, there's no direct equivalent of the "new" modifier as seen in languages like Java.
    -   However, you can define a method with the same name as an existing method in the superclass. This doesn't override the existing method; instead, it creates a new method with the same name in the subclass.
    -   This effectively hides the method from the superclass, but the superclass's method remains intact and can still be accessed through instances of the superclass.

</details>

<details><summary style="font-size:18px;color:#C71585">What is `__init__()` method in python?</summary>

</details>

<details><summary style="font-size:18px;color:#C71585">How is an empty class created in python?</summary>

</details>

<details><summary style="font-size:18px;color:#C71585">How does inheritance work in python? Explain it with an example.</summary>

</details>

<details><summary style="font-size:18px;color:#C71585">Are access specifiers used in python?</summary>

</details>

<details><summary style="font-size:18px;color:#C71585">How will you check if a class is a child of another class?</summary>

</details>

#### Pandas

1. What do you know about pandas?
2. Define pandas dataframe.
3. How will you combine different pandas dataframes?
4. Can you create a series from the dictionary object in pandas?
5. How will you identify and deal with missing values in a dataframe?
6. What do you understand by reindexing in pandas?
7. How to add new column to pandas dataframe?
8. How will you delete indices, rows and columns from a dataframe?
9. Can you get items of series A that are not available in another series B?
10. How will you get the items that are not common to both the given series A and B?
11. While importing data from different sources, can the pandas library recognize dates?

#### Numpy

1. What do you understand by NumPy?
2. How are NumPy arrays advantageous over python lists?
3. What are the steps to create 1D, 2D and 3D arrays?
4. You are given a numpy array and a new column as inputs. How will you delete the second column and replace the column with a new column value?
5. How will you efficiently load data from a text file?
6. How will you read CSV data into an array in NumPy?
7. How will you sort the array based on the Nth column?
8. How will you find the nearest value in a given numpy array?
9. How will you reverse the numpy array using one line of code?
10. How will you find the shape of any given NumPy array?
