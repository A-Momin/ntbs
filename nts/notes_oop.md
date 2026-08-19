<details><summary style="font-size:20px;color:Orange">OOB Terms and Concepts</summary>

#### Abstraction:

-   Abstraction is the concept of hiding the complex implementation details and showing only the essential features of an object.
-   It focuses on what an object does rather than how it does it, providing a simplified view that facilitates understanding and reduces complexity.
-   Abstraction is often achieved through interfaces or abstract classes.

**Abstraction** in the context of Object-Oriented Programming (OOP) is the concept of **hiding the complex implementation details** of a system and exposing only the essential, relevant features to the user. It allows developers to focus on **what** an object does rather than **how** it does it. Abstraction is achieved through abstract classes and interfaces, where only the necessary functionalities are shown, and unnecessary details are hidden.

In simple terms, abstraction lets you define **high-level behaviors** of objects while keeping the internal workings hidden from the user.

-   **Key Points of Abstraction**:

    -   **Hiding implementation details**: The internal complexity of an object or system is hidden, and only the functionality is exposed.
    -   **Focus on functionality**: Users interact with objects at a high level, knowing what the object can do but not how it performs its tasks.
    -   **Simplifies interactions**: It makes working with objects or systems easier by providing a simplified interface.

-   **How Abstraction Works**:

    -   **Abstract Classes**: A class that cannot be instantiated directly and is used to define a blueprint for other classes. Abstract classes may contain both abstract methods (methods with no implementation) and concrete methods.
    -   **Interfaces**: An interface defines a contract that implementing classes must fulfill, typically by providing method signatures without any implementation.

```python
from abc import ABC, abstractmethod

# Abstract class
class Animal(ABC):
    @abstractmethod
    def sound(self):
        pass  # Abstract method, no implementation

    def sleep(self):
        print(f"{self.__class__.__name__} is sleeping")

# Concrete class - inherits from Animal
class Dog(Animal):
    def sound(self):
        return "Bark"

# Concrete class - inherits from Animal
class Cat(Animal):
    def sound(self):
        return "Meow"

# Example usage
dog = Dog()
cat = Cat()

print(dog.sound())  # Output: Bark
print(cat.sound())  # Output: Meow

dog.sleep()  # Output: Dog is sleeping
cat.sleep()  # Output: Cat is sleeping
```

-   **Explanation**:

    -   **Abstract Class**: `Animal` is an abstract class with an abstract method `sound()`. It defines the common interface for all subclasses (like `Dog` and `Cat`), requiring them to provide their specific implementation of `sound()`.
    -   **Concrete Classes**: `Dog` and `Cat` are concrete subclasses that implement the `sound()` method. The user only knows that a `Dog` barks and a `Cat` meows, without knowing how the sounds are generated internally.
    -   **Simplification**: The internal workings of how the sound is made are abstracted away, so the user interacts with the simplified interface—just calling `sound()`.

-   **Benefits of Abstraction**:

    1. **Reduces complexity**: By hiding unnecessary details, abstraction makes systems easier to use and understand.
    2. **Improves code maintainability**: By separating the interface from implementation, changes can be made internally without affecting the external code.
    3. **Promotes modularity**: Different parts of a system can be developed and maintained independently, making the system more modular.
    4. **Enforces rules**: Abstraction ensures that derived classes implement the necessary methods, making sure that certain functionality is always present.

#### Encapsulation:

-   Encapsulation is the bundling of data (attributes) and methods that operate on the data within a single unit (class).
-   It hides the internal state of an object from the outside world and restricts access to it through well-defined interfaces.
-   Encapsulation helps achieve data abstraction and modularity, enhancing code maintainability and flexibility.

#### Polymorphism:

**Polymorphism** in the context of Object-Oriented Programming (OOP) refers to the ability of different objects to respond to the same method or function call in a way specific to their class or type. It allows one interface (or method name) to be used for different data types or objects, meaning that the same operation can behave differently on different classes or objects.

-   Polymorphism allows objects of different classes to be treated as objects of a common superclass.
-   It enables the same method name to behave differently depending on the object it is called on, based on the object's type.
-   Polymorphism is achieved through method overriding and method overloading.

1. **Compile-time Polymorphism (Static Polymorphism)**:

    - Achieved through **method overloading** or **operator overloading**.
    - Multiple methods can have the same name but different parameters (signature) within the same class.
    - Resolved at compile-time.

    ```python
    class Calculator:
        def add(self, a, b):
            return a + b

        def add(self, a, b, c):
            return a + b + c

    calc = Calculator()
    print(calc.add(2, 3))         # This will raise an error in Python (no compile-time polymorphism).
    print(calc.add(2, 3, 4))      # Python does not directly support method overloading.
    ```

2. **Run-time Polymorphism (Dynamic Polymorphism)**:

    - Achieved through **method overriding** in which a subclass provides a specific implementation of a method that is already defined in its superclass.
    - Resolved at runtime.
    - This is the most common form of polymorphism in OOP.

    ```python
    class Animal:
        def sound(self):
            return "Some generic sound"

    class Dog(Animal):
        def sound(self):
            return "Bark"

    class Cat(Animal):
        def sound(self):
            return "Meow"

    # Run-time polymorphism
    animals = [Dog(), Cat(), Animal()]

    for animal in animals:
        print(animal.sound())
    ```

    - The method `sound()` exists in both the `Animal` class and its subclasses `Dog` and `Cat`.
    - Even though we call the same method (`sound`) on different objects (instances of `Dog`, `Cat`, and `Animal`), the behavior changes according to the specific type of object.
    - This is an example of **run-time polymorphism** or **method overriding**.

-   **Key Concepts of Polymorphism**:

    -   **Method Overriding**: Subclasses provide a specific implementation of a method that is already defined in its superclass, allowing behavior to be dynamically determined at runtime.
    -   **Method Overloading**: Multiple methods with the same name but different parameter types or numbers, allowing different behavior based on the arguments passed (not natively supported in Python).

-   **Benefits of Polymorphism**:
    1. **Code Reusability**: Polymorphism allows developers to write more generic and reusable code.
    2. **Flexibility**: It allows one interface to be used with a variety of data types, improving flexibility.
    3. **Extensibility**: New classes can be added to a system without modifying existing code, as long as they adhere to the expected interface.

#### Inheritance:

In Python's Object-Oriented Programming (OOP), **inheritance** is a powerful concept that allows one class (called the **subclass** or **child class**) to inherit properties and behaviors (methods and attributes) from another class (the **superclass** or **parent class**). This promotes code reuse, as shared functionalities can be implemented once in a parent class and inherited by multiple subclasses. Inheritance also facilitates polymorphism and a hierarchical class structure, making code easier to extend and maintain.

-   Inheritance is a mechanism where a new class (subclass) is created by deriving properties from an existing class (superclass).
-   Subclasses inherit attributes and methods from their superclass and can override or extend them.
-   It promotes code reuse and allows for hierarchical organization of classes.

1. **Single Inheritance**:

    - When a subclass inherits from only one superclass. This is the most straightforward form of inheritance.

    ```python
    class Animal:
        def speak(self):
            return "Some sound"

    class Dog(Animal):
        def bark(self):
            return "Woof!"
    ```

2. **Multiple Inheritance**:

    - When a class inherits from more than one superclass.
    - Python supports multiple inheritance, but it can be complex because of potential method conflicts (which can arise when multiple parent classes have methods with the same name).
    - Python uses the **Method Resolution Order (MRO)** to determine the method call order when multiple inheritance is involved.

    ```python
    class Mammal:
        def breathe(self):
            return "Inhale, exhale"

    class Swimmer:
        def swim(self):
            return "Swim in the water"

    class Dolphin(Mammal, Swimmer):
        pass
    ```

    -`Method Resolution Order (MRO)`: - In cases of multiple inheritance, MRO determines the order in which classes are searched for a method. - Python uses the **C3 linearization algorithm** to establish MRO, which follows a depth-first, left-to-right hierarchy. - You can view a class’s MRO with `ClassName.__mro__` or `ClassName.mro()`.

3. **Multilevel Inheritance**:

    - A class inherits from another class, which in turn inherits from another class, forming a chain.
    - Example:

        ```python
        class LivingBeing:
            def is_alive(self):
                return True

        class Animal(LivingBeing):
            pass

        class Dog(Animal):
            def bark(self):
                return "Woof!"
        ```

4. **Hierarchical Inheritance**:

    - Multiple classes inherit from the same superclass.
    - Example:

        ```python
        class Animal:
            def speak(self):
                return "Animal sound"

        class Cat(Animal):
            def purr(self):
                return "Purr"

        class Dog(Animal):
            def bark(self):
                return "Woof!"
        ```

5. **Hybrid Inheritance**:

    - A combination of two or more types of inheritance.
    - Often used in complex scenarios where various classes are combined in a single design structure.

6. **Overriding Methods**:

    - **Method Overriding** occurs when a subclass provides a specific implementation of a method that is already defined in its superclass.
    - The subclass method overrides the superclass method, and Python calls the overridden method of the subclass.

    ```python
    class Animal:
        def sound(self):
            return "Some generic sound"

    class Dog(Animal):
        def sound(self):  # Overriding the sound method
            return "Woof!"

    dog = Dog()
    print(dog.sound())  # Output: Woof!
    ```

7. **Using `super()` Function**:

    - The `super()` function allows access to methods of the superclass from the subclass.
    - It is commonly used to call the `__init__` method of the superclass to initialize inherited attributes or to reuse superclass methods with additional functionality.

    ```python
    class Animal:
        def __init__(self, name):
            self.name = name

    class Dog(Animal):
        def __init__(self, name, breed):
            super().__init__(name)  # Call the superclass constructor
            self.breed = breed

    dog = Dog("Buddy", "Golden Retriever")
    print(dog.name)  # Output: Buddy
    print(dog.breed)  # Output: Golden Retriever
    ```

8. **Polymorphism in Inheritance**:

    - **Polymorphism** allows objects of different classes to be treated as objects of a common superclass.
    - It enables different classes to use the same interface, which simplifies calling methods across class types without needing to know the specific class.

    ```python
    class Animal:
        def speak(self):
            pass

    class Dog(Animal):
        def speak(self):
            return "Woof!"

    class Cat(Animal):
        def speak(self):
            return "Meow!"

    # Polymorphic function
    def animal_sound(animal):
        print(animal.speak())

    animal_sound(Dog())  # Output: Woof!
    animal_sound(Cat())  # Output: Meow!
    ```

9. **Benefits of Inheritance**:

    1. **Code Reusability**: Common code resides in the superclass, making it reusable across multiple subclasses.
    2. **Enhanced Maintainability**: Changes in the superclass propagate to subclasses, simplifying maintenance.
    3. **Simplifies Code with Polymorphism**: Methods can be called on different subclass instances without needing type checks.
    4. **Improves Readability**: Hierarchical structures organize related classes, improving the readability and structure of code.

10. **Key Points to Remember**:

    - **Inheritance Hierarchies**: Avoid deep inheritance hierarchies as they may introduce complexity. Keep hierarchies simple for easy debugging and maintenance.
    - **Composition over Inheritance**: Sometimes, using **composition** (including instances of other classes as attributes) is preferred over inheritance for more flexibility and modularity.
    - **Multiple Inheritance Caution**: In scenarios where multiple inheritance is unavoidable, be aware of potential method conflicts and rely on MRO to understand method calls.

#### Composition:

**Composition** in Object-Oriented Programming (OOP) is a design principle in which one class contains references to objects of other classes, rather than inheriting their behavior. This allows a class to achieve complex functionality by using or "composing" other objects as attributes, rather than inheriting from them. Composition promotes modular, flexible, and maintainable code, as changes in one component class do not directly impact the others, unlike inheritance.

1. **Has-a Relationship**:

    - Composition represents a **"has-a"** relationship between classes, as opposed to inheritance, which represents an **"is-a"** relationship.
    - For example, a `Car` **has-a** `Engine`, a `House` **has-a** `Door`.

2. **Object Usage**:

    - A class (composite class) contains instances of other classes (component classes) as attributes. This enables it to use the functionalities of the component classes without needing to inherit from them.
    - This way, each component can be developed independently and can be reused across different composite classes.

3. **Flexibility and Reusability**:

    - Composition allows combining objects to achieve complex functionality.
    - It makes code more flexible and reusable, as you can change or replace a component class independently of the composite class.

4. **Better for Some Scenarios than Inheritance**:
    - Composition is preferred over inheritance when a class doesn’t naturally fit into a hierarchy or when the relationship between classes is not strictly hierarchical.

-   **Composition** vs. **Inheritance**: When to Use Which?

    -   `Use Inheritance` when:

        -   The relationship between classes is naturally hierarchical (e.g., `Bird` is a type of `Animal`).
        -   You need to leverage polymorphism, where objects of different subclasses are treated uniformly.

    -   `Use Composition` when:

        -   Classes should be decoupled and independently replaceable.
        -   You need more flexibility to combine behaviors rather than force classes into a strict hierarchy.

-   **Example**: Consider a `Library` class composed of `Book` and `LibraryMember` classes.

    ```python
    class Book:
        def __init__(self, title, author):
            self.title = title
            self.author = author

    class LibraryMember:
        def __init__(self, name):
            self.name = name
            self.borrowed_books = []

        def borrow_book(self, book):
            self.borrowed_books.append(book)
            return f"{self.name} borrowed {book.title} by {book.author}"

    class Library:
        def __init__(self):
            self.books = []
            self.members = []

        def add_book(self, book):
            self.books.append(book)
            return f"Book '{book.title}' added to library."

        def add_member(self, member):
            self.members.append(member)
            return f"Member '{member.name}' added to library."

        def borrow_book(self, member_name, book_title):
            member = next((m for m in self.members if m.name == member_name), None)
            book = next((b for b in self.books if b.title == book_title), None)

            if member and book:
                self.books.remove(book)
                return member.borrow_book(book)
            return "Book or member not found."

    # Create instances and use the Library
    library = Library()
    book1 = Book("1984", "George Orwell")
    member1 = LibraryMember("Alice")

    print(library.add_book(book1))  # Output: Book '1984' added to library.
    print(library.add_member(member1))  # Output: Member 'Alice' added to library.
    print(library.borrow_book("Alice", "1984"))  # Output: Alice borrowed 1984 by George Orwell
    ```

-   **Advantages of Composition**:

    -   `Scalability`: If new types of resources (e.g., `Magazine`) or features are needed, they can be added independently without modifying the `Library` class.
    -   `Maintainability`: The `Library` class does not need to manage the internal details of `Book` or `LibraryMember`; it only uses their public interfaces.
    -   `Decoupling`: Composition leads to decoupled code where each class is responsible for its own behavior, making the code more maintainable and flexible.
    -   `Encapsulation`: By embedding one class within another, composition provides a way to encapsulate different parts of the functionality, allowing you to hide implementation details.
    -   `Reusability`: Components (like `Engine`, `Tire`, `Book`, etc.) are reusable across various classes without duplicating code or forcing inheritance.

#### Method Overriding:

-   Method overriding occurs when a subclass provides a specific implementation of a method that is already defined in its superclass.
-   It allows subclasses to customize or extend the behavior of inherited methods.
-   Overridden methods have the same signature (name and parameters) as the methods they override.

#### Method Overloading:

-   Method overloading refers to defining multiple methods in a class with the same name but different parameters.
-   Python does not support method overloading by default (unlike languages like `Java` or `C++`), but it can be simulated using default parameter values or variable-length argument lists.

</details>

---

<details><summary style="font-size:20px;color:Orange">Relationship in OOB</summary>

In Object-Oriented Programming (OOP), a relationship refers to the connection or association between classes or objects. It defines how classes or objects interact with each other to achieve specific functionalities or behaviors. Relationships are essential for modeling and designing complex systems by representing the connections and dependencies between different parts of a program.

```python
# Inheritance - Base class and derived classes
class Animal:
    def __init__(self, name, species):
        self.name = name
        self.species = species

    def make_sound(self):
        return "Some generic sound"

    def __str__(self):
        return f"{self.name} is a {self.species}"

# Inheritance - Subclasses
class Mammal(Animal):
    def __init__(self, name, species, is_warm_blooded=True):
        super().__init__(name, species)
        self.is_warm_blooded = is_warm_blooded

    def make_sound(self):
        return "Mammal sound"

class Bird(Animal):
    def __init__(self, name, species, can_fly=True):
        super().__init__(name, species)
        self.can_fly = can_fly

    def make_sound(self):
        return "Chirp chirp"

# Composition - Nest cannot exist without Bird
class Nest:
    def __init__(self, material):
        self.material = material

    def __str__(self):
        return f"Nest made of {self.material}"

class BirdWithNest(Bird):
    def __init__(self, name, species, material="sticks"):
        super().__init__(name, species)
        self.nest = Nest(material)  # Nest is part of Bird

# Association - Zoo uses Animals (has a relationship with Animal objects)
# Aggregation - Animals can exist independently of Zoo
class Zoo:
    def __init__(self, name):
        self.name = name
        self.animals = []   # Aggregation: Zoo contains animals but animals can exist outside the zoo.

    def add_animal(self, animal):
        self.animals.append(animal)

    def perform_zookeeper_duties(self, zookeeper):
        for animal in self.animals:
            zookeeper.feed_animal(animal)

# Composition - Zookeeper cannot exist without Zoo
class Zookeeper:
    def feed_animal(self, animal):
        print(f"Zookeeper is feeding the {animal.species}.")

# Dependency - Vet depends on Animals for treatment
class Vet:
    def treat(self, animal):
        print(f"Vet is treating {animal.name}, the {animal.species}")

# Demonstrating the concepts
def main():
    # Inheritance - Mammals and Birds are inherited from Animal
    lion = Mammal("Lion", "Panthera leo")
    eagle = Bird("Eagle", "Aquila chrysaetos")

    # Aggregation - Zoo can contain animals
    zoo = Zoo("City Zoo")
    zoo.add_animal(lion)
    zoo.add_animal(eagle)

    # Showing all animals in the zoo (Aggregation: Zoo has animals)
    zoo.show_animals()

    # Composition - Bird with a nest (Nest cannot exist without Bird)
    sparrow = BirdWithNest("Sparrow", "Passeridae", "grass")
    print(sparrow)
    print(sparrow.nest)

    # Association - Vet treating animals
    vet = Vet()
    vet.treat(lion)  # Dependency: Vet depends on the Animal for treatment

if __name__ == "__main__":
    main()
```

1.  **Association**: Association represents a relationship between two classes, indicating that objects of one class are connected to objects of another class.

    -   It can be a one-to-one, one-to-many, or many-to-many relationship.
    -   Associations can be bidirectional or unidirectional.
    -   It's often represented by a line connecting the associated classes on a class diagram.
    -   Multiplicity notation indicates the number of instances allowed in the relationship.

    ```python
    class Zookeeper:
        def feed_animal(self, animal):
            print(f"Zookeeper is feeding the {animal.species}.")

    # Create instances
    zookeeper = Zookeeper()
    lion = Animal("Lion", "Roar")

    # Association
    zookeeper.feed_animal(lion)
    ```

    -   In this example, the `Zookeeper` class has a method feed_animal, creating an association with the `Animal` class. An instance of `Zookeeper` can interact with instances of Animal, demonstrating a simple form of association.
    -   In another example, the `Zoo` class is associated with the `Animal` class because it uses `Animal` objects. The Zoo does not "own" the animals but can interact with them (association).

2.  **Aggregation**: Aggregation is a special form of association where one class represents the "whole" and another class represents the "part." The part can exist independently of the whole.

    -   Aggregation implies a relationship where one class contains another class, but the contained class can exist on its own.
    -   It's often represented by a diamond shape on the side of the whole class.
    -   Aggregation is less restrictive than composition; the part can be shared among different wholes.

    ```python

    class Zoo:
        def __init__(self, name):
            self.name = name
            self.animals = []

        def add_animal(self, animal):
            self.animals.append(animal)

        def perform_zookeeper_duties(self, zookeeper):
            for animal in self.animals:
                zookeeper.feed_animal(animal)

    # Create instances
    zoo = Zoo("City Zoo")
    lion = Animal("Lion", "Roar")

    # Aggregation
    zoo.add_animal(lion)
    ```

    -   In this example, the `Zoo` class has a list of `Animal` objects. The `Zoo` is the whole, and `Animal` is the part. The `Animal` instances can exist independently, and the `Zoo` class can aggregate multiple `Animal` instances.
    -   The `Zoo` contains a list of `Animal` objects (mammals and birds). The `Zoo` can exist without these specific animals, and the animals can exist independently of the `Zoo`. This is an example of aggregation.

3.  **Composition**: Composition is a stronger form of aggregation where the part cannot exist independently of the whole. If the whole is destroyed, the parts are also destroyed.

    -   It implies a strong ownership relationship. The part is a fundamental component of the whole.
    -   It's often represented by a filled diamond shape on the side of the whole class.
    -   Lifecycle management of the part is controlled by the whole.

    ```python

    class Zoo:
        def __init__(self, name):
            self.name = name
            self.animals = []

        def add_animal(self, animal):
            self.animals.append(animal)

        def perform_zookeeper_duties(self, zookeeper):
            for animal in self.animals:
                zookeeper.feed_animal(animal)

    # Create instances
    zoo = Zoo("City Zoo")
    lion = Animal("Lion", "Roar")
    zookeeper = Zookeeper()

    # Composition
    zoo.add_animal(lion)
    zoo.perform_zookeeper_duties(zookeeper)
    ```

    -   In this example, the `Zoo` class has a method `perform_zookeeper_duties(zookeeper)` that takes a `Zookeeper` instance and performs duties for each animal in the `zoo`. The `Zoo` and `Zookeeper` classes are in a composition relationship because the `Zookeeper` is an integral part of the `Zoo`, and its actions are tightly coupled with the zoo's functionality.
    -   The `BirdWithNest` class contains a `Nest` object, and this is an example of composition because a `Nest` cannot exist without a Bird. If a `BirdWithNest` object is destroyed, the `Nest` object is destroyed as well. In composition, the contained object’s lifecycle is dependent on the container object.

4.  **Inheritance**: Inheritance represents an "is-a" relationship, where a subclass inherits attributes and behaviors from a superclass.

    -   It allows the creation of a new class based on an existing class.
    -   The subclass (derived class) inherits the properties and behaviors of the superclass (base class).
    -   It promotes code reuse and supports the concept of polymorphism.

    ```python
    class Animal:
        def __init__(self, species):
            self.species = species

        def make_sound(self):
            print("Generic animal sound")


    class Dog(Animal):
        def make_sound(self):
            print("Woof!")

    # Inheritance
    dog = Dog("Canine")
    dog.make_sound()  # Outputs: Woof!
    ```

    -   In this example, `Dog` is a subclass of `Animal`. The `Dog` class inherits the species attribute from the `Animal` class and overrides the make_sound method.

5.  **Dependency**: Dependency is a relationship where one class relies on another class, but it is not part of an association, aggregation, or composition. It indicates that a change in one class may affect another class.

    -   Dependency refers to one class depending on another for some operation.
    -   It is a weaker relationship compared to association.
    -   Dependencies are typically represented by a dashed arrow on a class diagram.
    -   Changes in the independent class may require modifications in the dependent class.

    ```python
    # Dependency - Vet depends on Animals for treatment
    class Vet:
        def treat(self, animal):
            print(f"Vet is treating {animal.name}, the {animal.species}")

    # Association - Vet treating animals
    vet = Vet()
    vet.treat(lion)  # Dependency: Vet depends on the Animal for treatment
    ```

    -   The `Vet` class depends on the `Animal` class to perform its operation. The `Vet` class has a treat method that operates on `Animal` objects. If there are no animals, the vet cannot perform any treatment, showing a dependency relationship.

</details>

---

<details><summary style="font-size:20px;color:Orange">OOB in Python</summary>

In Python, class definitions can include various arguments and features. Below is a list of commonly used arguments with examples:

-   **Class Body**: The class body contains attributes and methods.

    ```python
    class MyClass:
        attribute = "value"

        def method(self):
            return "Hello, world!"
    ```

-   **Inheritance**: You can inherit from one or more classes.

    ```python
    class ChildClass(ParentClass):
        pass
    ```

-   **Metaclasses**: You can specify a metaclass for customizing class creation.

    ```python
    class MyClass(metaclass=MyMetaclass):
        pass
    ```

-   **Class Attributes**: Class attributes are shared among all instances of a class.

    ```python
    class MyClass:
        class_attribute = "shared"
    ```

-   **Constructor (\_\_init\_\_)**: The constructor initializes instance attributes.

    ```python
    class MyClass:
        def __init__(self, arg1, arg2):
            self.arg1 = arg1
            self.arg2 = arg2
    ```

-   **Slots**: Slots restrict the attributes a class can have.

    ```python
    class MyClass:
        __slots__ = ("attr1", "attr2")
    ```

-   **Property**: Properties allow you to use methods as attributes.

    ```python
    class MyClass:
        @property
        def my_property(self):
            return "This is a property."
    ```

-   **Docstring**: A docstring provides documentation for the class.

    ```python
    class MyClass:
        """This is a docstring."""
    ```

-   **Decorator**: You can use decorators to modify class behavior.

    ```python
    @my_decorator
    class MyClass:
        pass
    ```

-   **Classmethod**: The `classmethod()` decorator is used to define class methods, which are methods that operate on the class itself rather than instances of the class. Class methods receive the class itself as the first argument (`cls` by convention), rather than the instance (`self`).

    ```python
    class MyClass:
        @classmethod
        def my_class_method(cls):
            return "Class method."
    ```

-   **Staticmethod**: The `staticmethod()` decorator is used to define static methods, which are methods that do not operate on instances or class variables. They are similar to regular functions but are defined within a class for organization purposes.

    ```python
    class MyClass:
        @staticmethod
        def my_static_method():
            return "Static method."
    ```

-   **Abstractmethod**: The `abstractmethod()` decorator is used to define abstract methods within abstract base classes. Abstract methods are methods that must be implemented by concrete subclasses. Abstract base classes cannot be instantiated directly.

    ```python
    from abc import ABC, abstractmethod

    class Shape(ABC):
        @abstractmethod
        def area(self):
            pass

    class Rectangle(Shape):
        def __init__(self, length, width):
            self.length = length
            self.width = width

        def area(self):
            return self.length * self.width

    rect = Rectangle(5, 4)
    print("Area of rectangle:", rect.area())  # Output: 20
    ```

-   **Abstract Classes (abc module)**: Abstract classes define abstract methods that must be implemented by subclasses.

#### Some Important Special Methods

-   **\_\_new\_\_()** Method: The `__new__()` method is a special method in Python that is responsible for creating a new instance of a class. It is a static method that is called before the **\_\_init\_\_()** method during object instantiation. The primary purpose of `__new__()` is to create and return a new instance of the class.

    ```python
    class MyClass:
        def __new__(cls, *args, **kwargs):
            print("Creating a new instance of MyClass")
            instance = super().__new__(cls)  # Create a new instance
            return instance

    # Instantiate MyClass
    obj = MyClass()
    ```

    -   We define a class MyClass with a custom `__new__()` method.
    -   Inside `__new__()`, we print a message to indicate that a new instance is being created.
    -   We call the superclass's `__new__()` method to create the instance.
    -   Finally, we return the newly created instance.

-   **\_\_call\_\_()** Method: The `__call__()` method allows an object to be called as if it were a function. When an object's `__call__()` method is invoked, the object behaves as a callable, similar to a function.

    ```python
    class CallableClass:
        def __call__(self, *args, **kwargs):
            print("CallableClass instance is called")

    # Create an instance of CallableClass
    obj = CallableClass()

    # Call the instance as if it were a function
    obj()
    ```

    -   We define a class CallableClass with a `__call__()` method.
    -   Inside `__call__()`, we print a message to indicate that the instance is being called.
    -   We create an instance obj of CallableClass.
    -   We call the instance obj as if it were a function, which invokes its `__call__()` method.

-   **\_\_annotations\_\_** Attribute: The `__annotations__` attribute is a special attribute that stores annotations associated with function or method arguments and return values. Annotations are optional metadata that can be added to function definitions to provide additional information about the function's parameters and return values.

    ```python
    def add(x: int, y: int) -> int:
        return x + y

    # Access the annotations
    print(add.__annotations__)
    ```

    -   We define a function add that takes two arguments x and y, both of type int, and returns an int.
    -   We add annotations to the function parameters and return value using the : syntax.
    -   We access the `__annotations__` attribute of the function to retrieve the annotations.
    -   The `__annotations__` attribute returns a dictionary containing the annotations for each parameter and the return value.

-   **\_\_new\_\_()** vs **\_\_init\_\_()**:

    -   **\_\_new\_\_()**: The `__new__()` method is responsible for creating a new instance of a class. It returns a new instance of the class. This instance is then passed as the first argument (`self`) to the `__init__` method.

        -   Instance creation refers to the process of creating a new instance of a class, i.e., allocating memory for the object and setting up its initial state.
        -   Instance creation occurs before instance initialization. The `__new__()` method is called first, followed by the `__init__` method.
        -   The `__new__()` method returns the newly created instance, which is then passed to the `__init__` method for initialization.

    -   **\_\_init\_\_()**: The `__init__()` method is responsible for initializing the newly created instance after it has been created by `__new__()`. It is an instance method that is called after the `__new__()` method, with the newly created instance (`self`) as its first argument.
        -   Instance initialization refers to the process of setting up the initial state of the newly created instance, such as initializing instance variables, performing setup tasks, or any other initialization logic.
        -   Instance initialization occurs after instance creation. The `__init__()` method is called after `__new__()` and receives the newly created instance as its first argument (`self`).
        -   Inside the `__init__()` method, you typically perform actions such as initializing instance variables, setting up the object's initial state, or performing any other initialization tasks specific to the object.

</details>
