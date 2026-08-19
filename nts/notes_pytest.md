-   <details><summary style="font-size:25px;color:Orange">QA Testing</summary>

    Software testing encompasses various types and approaches, each serving specific purposes in verifying, validating, and improving software quality.
    Each type of testing is chosen based on the specific phase of development, goals, and the criticality of software requirements. Here are the main types:

    #### Functional Testing

    -   **Unit Testing**: Testing individual components or functions of a program, typically done by developers. It ensures that each unit performs as expected.

        The unittest library in Python is a built-in testing framework that provides a standardized way to write and execute test cases for your code. It's inspired by the JUnit framework and follows the xUnit style of testing. Here are some key terms and concepts related to the unittest library:

        -   `setUp`: The setUp method is an instance method that is used to set up resources or perform actions that are required for a specific test method. This method is executed before each test method in the test case class is run. It's commonly used to initialize objects, create instances, or set up any other conditions necessary for the test to run successfully.
        -   `tearDown`: The tearDown method is an instance method that is used to perform cleanup or teardown operations after a specific test method has been run. This method is executed after each test method in the test case class has completed. It's commonly used to release resources, close connections, or perform any necessary cleanup actions.
        -   `setUpClass`: The setUpClass method is a class-level method that is used to set up resources or perform actions that are shared among all test methods within a test case class. This method is executed once before any of the test methods in the class are run. It's commonly used to create connections, set up databases, or initialize objects that will be used by multiple test methods.
        -   `tearDownClass`: The tearDownClass method is a class-level method that is used to perform cleanup or teardown operations after all the test methods within a test case class have been run. This method is executed once after all the test methods in the class have been completed. It's commonly used to close connections, release resources, or perform cleanup actions that need to happen after all the tests are finished.
        -   `Test Case`: A test case is a class that defines individual test methods. Each test method within a test case tests a specific aspect of your code.
        -   `Test Fixture`: A test fixture is the preparation needed for running a test, including setup and cleanup. In unittest, this is often handled using setUp and tearDown methods.
        -   `Test Runner`: The test runner is responsible for discovering and running test cases. In unittest, the TextTestRunner and other runners execute your tests and display the results.
        -   `Test Suite`: A test suite is a collection of test cases that are grouped together. You can create suites to organize and run multiple test cases.
        -   `Test Discovery`: The process of finding and collecting test cases within your codebase. unittest can automatically discover and run tests using various naming conventions and patterns.
        -   `Assertions`: Assertions are statements that validate the expected behavior of your code. In unittest, you can use various assertion methods like assertEqual, assertTrue, assertFalse, etc.
        -   `Test Result`: After running the tests, you get a test result that indicates which tests passed, failed, or were skipped. The result includes detailed information about the outcomes.
        -   `Test Fixtures Sharing`: You can share fixtures between multiple test methods by using class-level attributes like cls.setUpClass and cls.tearDownClass.
        -   `Test Skipping`: You can use decorators like @unittest.skip and @unittest.skipIf to mark tests that should be skipped during execution.
        -   `Expected Failure`: You can use the @unittest.expectedFailure decorator to mark tests that are expected to fail, but you still want them to run and report the failure.
        -   `SubTest`: The unittest.subTest context manager allows you to run multiple assertions within a single test method, even if one assertion fails.
        -   `Test Discovery and Execution`: You can run tests using the unittest command-line interface, specifying the module, class, or method names to execute.
        -   `Test Report`: unittest provides basic text-based test reports, showing the outcomes of individual tests.
        -   `Extensibility`: The unittest framework is extensible, allowing you to create custom test runners, result reporters, and plugins.

    -   **Integration Testing**: Integration Testing focuses on verifying the interactions and data flow between integrated components or systems. It ensures that individual modules or services work together as intended.

        -   `Purpose`:

            -   To test the interfaces and interactions between different modules or systems.
            -   To identify defects in communication and data transfer between components.

        -   `When Performed`: After Unit Testing and before System Testing.

        -   `Types of Integration Testing`:

            -   **Big Bang Approach**: All modules are integrated simultaneously, and the system is tested as a whole.
            -   **Incremental Approach**: Modules are integrated and tested one by one.

        -   `Tools Used`: Jenkins (CI/CD), Postman (API Testing), JUnit, Pytest.

    -   **System Testing**: System Testing evaluates the complete and fully integrated system to ensure it meets the specified requirements. It validates both functional and non-functional aspects of the system.

        -   `Purpose`:

            -   To test the entire application as a unified system.
            -   To verify that the system functions correctly in all intended environments.

        -   `When Performed`: After Integration Testing and before UAT.

        -   `Types of System Testing`:

            1. **Functional Testing**: Validates that the system performs as per the functional requirements (e.g., form submissions, user logins).

            2. **Non-Functional Testing**: Focuses on aspects like performance, reliability, scalability, and security.
                - _Performance Testing_: Load testing, stress testing, etc.
                - _Security Testing_: Ensures protection against threats.
                - _Usability Testing_: Evaluates user-friendliness.

        -   `Tools Used`: Selenium, JMeter, LoadRunner, TestComplete.

        -   `Key Considerations`: System Testing involves end-to-end testing in environments that simulate production to uncover integration and environment-related issues.

    -   **User Acceptance Testing (UAT)**: UAT is the final phase of testing, where the end-users or business stakeholders validate the system to ensure it meets their requirements and is ready for deployment.

        -   `Purpose`:

            -   To confirm that the software delivers value to the business.
            -   To verify that the system meets real-world use cases and expectations.

        -   `When Performed`: After System Testing and before deployment.

        -   `Types of UAT`:

            1. **Alpha Testing**:

                - Conducted by internal teams or a limited group of users in a controlled environment.
                - Typically done at the developer's site.

            2. **Beta Testing**:

                - Conducted by a broader user base in the actual production environment.
                - Provides feedback on real-world usage and identifies last-minute bugs.

        -   `Key Activities in UAT`:

            -   Test case creation based on business requirements.
            -   Executing test scenarios and reporting issues.
            -   Signing off on the system readiness for deployment.

        -   `Tools Used`: stRail, Jira, Trello.

    #### Control Testing

    -   **Control Testing** is the process of evaluating the effectiveness and efficiency of internal controls within an organization. It ensures that controls are properly designed, implemented, and operating as intended to mitigate risks, prevent fraud, and ensure compliance with regulations.
    -   **Control Testing** is widely used in **IT security**, **finance**, **auditing**, and **risk management** to maintain trust and operational integrity.

    -   **Types of Control Testing**:

        1. `Design Effectiveness Testing`

            - Assesses whether the control is **properly designed** to address specific risks.
            - Example: Checking if an approval workflow exists for financial transactions.

        2. `Operating Effectiveness Testing`

            - Determines if the control is **working as intended** in real-world operations.
            - Example: Reviewing audit logs to confirm that approvals are actually enforced.

        3. `Preventive vs. Detective Control Testing`
            - **Preventive Controls**: Designed to stop errors or fraud before they happen.
                - Example: Enforcing multi-factor authentication (MFA) for system access.
            - **Detective Controls**: Identify and report issues after they occur.
                - Example: Reviewing financial reconciliation reports.

    -   **Methods of Control Testing**:

        -   `Inquiry`: Interviewing employees to understand control processes.
        -   `Observation`: Watching the control in action to ensure compliance.
        -   `Inspection of Documentation`: Reviewing policies, logs, and records to verify adherence.
        -   `Reperformance`: Executing the control process manually to validate its effectiveness.

    -   **Why is Control Testing Important?**:

        -   Ensures compliance with regulatory requirements (e.g., SOX, HIPAA, GDPR).
        -   Detects and mitigates operational risks before they cause harm.
        -   Prevents financial loss due to fraud or human error.
        -   Improves internal processes by identifying weaknesses.

    #### Penatration Testing

    #### Non-Functional Testing

    -   **Performance Testing**: Examines the speed, responsiveness, and stability under a particular workload. Includes:

        -   **Load Testing**: Determines how the system behaves under expected load.
        -   **Stress Testing**: Evaluates the system’s ability to handle heavy or peak loads.
        -   **Scalability Testing**: Tests the ability to scale up or down with demand.
        -   **Volume Testing**: Checks the system’s ability to handle a large amount of data.

    -   **Security Testing**: Identifies vulnerabilities in software to ensure it is protected from unauthorized access and data breaches.
    -   **Usability Testing**: Assesses how easy and intuitive the software is for end-users, focusing on user interface (UI) and experience.
    -   **Compatibility Testing**: Ensures the software works across different devices, browsers, networks, and operating systems.
    -   **Reliability Testing**: Measures the software’s stability and consistency over time under different conditions.
    -   **Compliance Testing**: Verifies that software adheres to industry standards, regulations, and legal requirements.

    #### Maintenance Testing

    -   **Regression Testing**: After changes or updates, regression tests check that existing functionality hasn’t been affected.
    -   **Retesting**: Focuses on verifying if specific defects have been fixed correctly.
    -   **Sanity Testing**: A subset of regression testing to ensure that certain functions work as expected after minor changes.
    -   **Smoke Testing**: A smoke test, also known as a sanity test or build verification test, is a basic and preliminary type of software testing that aims to verify that the most critical and essential functionalities of a software application are working correctly. The term "smoke test" originates from the electronics industry, where devices were tested to see if they would catch fire or emit smoke during initial power-up.
        -   `Basic Functionality`: It focuses on the core features of the application to confirm they work as expected.
        -   `Quick Check`: It’s a shallow and broad test that covers essential aspects without going into detailed test cases.
        -   `Early Detection`: Smoke testing helps identify major issues early in the development process, saving time and effort for the QA team.
        -   `Build Verification`: It confirms that the software build is stable enough to proceed with more extensive testing.

    #### White-Box vs. Black-Box Testing

    -   **White-Box Testing**: Testers have knowledge of the internal code structure. It’s often used in unit and integration testing.
    -   **Black-Box Testing**: Testers focus on input and output without knowledge of the internal code structure, focusing on functionality and usability.

    #### Automated vs. Manual Testing

    -   **Manual Testing**: Test cases are executed manually by QA testers without the use of automated tools. It’s best for exploratory, usability, and ad-hoc testing.
    -   **Automated Testing**: Uses tools and scripts to run tests repeatedly, which is ideal for regression, performance, and load testing where repetitive tasks can be automated.

    #### A/B Testing

    </details>

---

-   <details open><summary style="font-size:25px;color:Orange">Pytest</summary>

    -   [Arjan Code: How To Write Unit Tests For Existing Python Code // Part 1 of 2](https://www.youtube.com/watch?v=ULxMQ57engo&t=301s)
    -   [Arjan Code: How To Write Unit Tests For Existing Python Code // Part 2 of 2](https://www.youtube.com/watch?v=NI5IGAim8XU)
    -   [Arjan Code: Software Testing](https://www.youtube.com/playlist?list=PLC0nd42SBTaPYSgBqtlltw328zuafaCzA)
    -   [Pytest Tutorial – How to Test Python Code](https://www.youtube.com/watch?v=cHYq1MRoyI0)
    -   [API Reference](https://docs.pytest.org/en/latest/reference/reference.html#)
    -   [Pytest Master Class Full Course](https://www.youtube.com/watch?v=IN4qt-9bMiE)

    -   <details><summary style="font-size:20px;color:#FF1493">Pytest Basics and Configurations</summary>

        -   TERMS & CONCEPTS:

            -   `Test function`: A function that contains test code and is decorated with @pytest.mark.parametrize or @pytest.mark.test. Test functions can be run individually or as part of a test suite.
            -   `Test suite`: A collection of test functions that can be run together using the Pytest runner. Test suites can be organized into directories and files.
            -   `Test fixture`: A function that provides resources or setups for test functions. Fixtures are decorated with `@pytest.fixture` and can be used in test functions or other fixtures.
            -   `Fixtures Discovery`: Pytest discovers fixtures automatically by scanning the test directory and detecting fixtures based on their name or decorator. However, fixtures can also be explicitly imported or defined in configuration files.
            -   `Markers`: Tags that can be applied to test functions to provide additional information or behavior. Markers are defined using `@pytest.mark.marker_name` and can be used to skip tests, mark tests as expected to fail, or select tests to run.
            -   `Parametrization`: A feature that allows you to run a single test function with multiple sets of inputs or arguments. Parametrized tests are decorated with `@pytest.mark.parametrize`.
            -   `Assertion`: A statement that checks if a condition is true or false. Assertions are used to verify the expected behavior of a program or function.
            -   `Plugins`: Extensions that provide additional functionality to Pytest. Plugins can be used to add new fixtures, modify test discovery behavior, or provide custom test reporting.

        -   CLI:

            -   `$ pytest -h`
            -   `$ pytest -k EXPRESSION` → Run tests by keyword expressions

            -   `$ pytest -m MARKEXPR` → Run tests by marker expressions
            -   `$ pytest --markers` → show markers (builtin, plugin and per-project ones).
            -   `$ pytest --disable-warnings`, `--disable-pytest-warnings` → Disable warnings summary
            -   `$ pytest -s` Shortcut for `--capture=no`
            -   `$ pytest --runxfail` → Report the results of xfail tests as if they were not marked
            -   `$ pytest --lf`, `--last-failed` → Rerun only the tests that failed at the last run (or all if none failed)
            -   `$ pytest --ff`, `--failed-first` → Run all tests, but run the last failures first. This may re-order tests and thus lead to repeated fixture setup/teardown.
            -   `$ pytest --nf`, `--new-first` → Run tests from new files first, then the rest of the tests sorted by file mtime

            -   `$ pytest --log-level=LEVEL` → Level of messages to catch/display. Not set by default, so it depends on the root/parent log handler's effective level, where it is "WARNING" by default.
            -   `$ pytest --log-format=LOG_FORMAT` → Log format used by the logging module
            -   `$ pytest --log-date-format=LOG_DATE_FORMAT` → Log date format used by the logging module

        -   [API Reference](https://docs.pytest.org/en/stable/reference/reference.html)

        -   `$ pytest --version` → shows where pytest was imported from
        -   `$ pytest --fixtures` → show available builtin function arguments

        #### conftest.py

        `conftest.py` is a special file used in pytest, a popular testing framework for Python. The purpose of `conftest.py` is to define fixtures and configuration options that can be shared across multiple test modules or packages within a pytest project.

        **By defining fixtures in `conftest.py`, they become available to all test modules without the need for import statements or duplicating code**.

        Here are the key aspects of `conftest.py`:

        -   `Fixture Definitions`: `conftest.py` can define one or more fixtures using the `@pytest.fixture` decorator. These fixtures are functions or methods that perform setup actions and return a value or resource to be used by tests. Fixtures can be parameterized to provide different values or variations for tests.
        -   `Scope`: Fixtures defined in `conftest.py` can have different scopes, such as function, module, class, or session scope. The scope determines how often the fixture function is invoked during testing.
        -   `Discovery and Sharing`: pytest automatically discovers `conftest.py` files in the project directory and its subdirectories. Any fixtures defined in `conftest.py` are shared across all test modules within the same directory and its subdirectories. This allows for the reuse of fixtures and consistent setup across tests.
        -   `Configuration Options`: `conftest.py` can also define configuration options and hooks that affect pytest's behavior. For example, it can specify custom command-line options, configure logging, or define pytest hooks to customize test execution.

        ##### How to Run Tests

        -   [How to invoke pytest](https://docs.pytest.org/en/stable/how-to/usage.html)

        -   `$ pytest test_mod.py` → Run tests in a module
        -   `$ pytest testing/` → Run tests in a directory
        -   `$ pytest -k EXPRESSION` → Run tests by keyword expressions
        -   `$ pytest -k "MyClass and not method"` → Run tests by keyword expressions
        -   `$ pytest -m MARKEXPR` → Run tests by marker expressions
        -   `$ pytest --pyargs pkg.testing` → Run tests from packages. This will import pkg.testing and use its filesystem location to find and run tests from.
        -   `$ pytest test_mod.py::test_func` → To run a specific test function within a module
        -   `$ pytest test_mod.py::TestClass::test_method` → To run a specific test method within a test class.

        -   **Run tests by node ids**

            In Pytest, a node is a representation of a test item (e.g., a test function or a test class) that Pytest has discovered during the test collection phase. Each node in Pytest represents a single test item that can be executed as part of a test run.

            When Pytest is executed, it recursively searches for test modules and test functions in the specified test directories. Once all test items have been discovered, Pytest creates a tree-like structure of nodes that represents the hierarchy of the test items.

            Each node in the Pytest tree represents a test item and contains metadata such as the name of the test item, the file path where it is located, and any markers or attributes that have been associated with the test item. The node also contains information about any fixtures that are required by the test item.

            During the test execution phase, Pytest traverses the tree of nodes and executes each test item in the order specified by the tree structure. This allows Pytest to efficiently execute tests in parallel and to optimize the order in which tests are executed to minimize setup and teardown times.

            Overall, nodes in Pytest provide a flexible and extensible way to represent and execute test items, allowing developers to easily create and run tests for their Python applications.

            Each collected test is assigned a unique nodeid which consist of the module filename followed by specifiers like class names, function names and parameters from parametrization, separated by :: characters.

            -   `$ pytest test_mod.py::test_func` → To run a specific test function within a module

            -   `$ pytest test_mod.py::TestClass::test_method` → To run a specific test method within a test class.

            -   `$ `

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">Fixtures</summary>

        -   [everything you need to know about fixtures](https://www.youtube.com/watch?v=ScEQRKwUePI)

        **Fixtures** are functions or methods that provide a set of resources or data needed for testing. They help in setting up a test environment, preparing test data, or performing other necessary setup actions. Fixtures ensure that the required resources are available to tests, promoting code reuse and making test code more concise and readable. Fixtures are defined as regular Python functions decorated with `@pytest.fixture`. When a test function or method needs access to a fixture, it can simply include the fixture name as an argument. Upon test execution, pytest automatically invokes the fixture function and provides the return value to the test. Here are some key characteristics and benefits of fixtures in pytest:

        -   **Fixture Scope**: Fixtures can have different scopes, which define how long the fixture lives. Common scope options are:

            -   `function`: The default scope. The fixture is created and destroyed for each test function.

            -   `class`: The fixture is shared among all test methods within a test class.

                ```python
                # db_client.py
                class DBServiceClient:
                    def __init__(self, db_url):
                        self.db_url = db_url
                        self.connected = False

                    def connect(self):
                        self.connected = True
                        print(f"[Setup] Connected to DB at {self.db_url}")

                    def disconnect(self):
                        self.connected = False
                        print(f"[Teardown] Disconnected from DB at {self.db_url}")

                    def fetch_user(self, user_id):
                        return {"id": user_id, "name": f"User{user_id}"}

                    def fetch_orders(self, user_id):
                        return [{"id": 1, "user_id": user_id, "total": 99.99}]
                ```

                ```python
                # conftest.py or test_db.py
                import pytest
                from db_client import DBServiceClient

                @pytest.fixture(scope="class")
                def db_service():
                    client = DBServiceClient("postgresql://prod-db")
                    client.connect()
                    yield client
                    client.disconnect()
                ```

                ```python
                # test_user_service.py
                class TestUserService:

                    def test_fetch_user(self, db_service):
                        user = db_service.fetch_user(1)
                        assert user["id"] == 1
                        assert user["name"] == "User1"

                    def test_fetch_orders(self, db_service):
                        orders = db_service.fetch_orders(1)
                        assert isinstance(orders, list)
                        assert orders[0]["user_id"] == 1
                ```

            -   `module`: The fixture is created and destroyed once for the entire test module.
            -   `session`: The fixture is created at the beginning of the test session and destroyed at the end.
            -   `package`:

        -   **Fixture Finalization**: You can include finalization code using the `yield` statement in the fixture function. The code after yield runs after the test function has finished using the fixture.

            ```python
            # conftest.py
            import pytest

            @pytest.fixture
            def database_connection():
                # Setup: Create a database connection
                connection = create_database_connection()

                yield connection  # This is where the test runs

                # Teardown: Close the database connection
                connection.close()
            ```

            ```python
            # test_database_connection.py
            def test_query_database(database_connection):
                query_result = database_connection.execute("SELECT * FROM table")
                assert len(query_result) > 0
            ```

        -   **Setup and Teardown**: Fixtures can perform setup actions before a test runs and teardown actions after the test completes. This helps in preparing the test environment and cleaning up any resources used during testing.

            ```python
            @pytest.fixture(scope="session")
            def db_engine():
                engine = create_engine("sqlite:///:memory:")
                yield engine
                engine.dispose()
            ```

            ```python
            @pytest.fixture
            def api_client():
                client = requests.Session()
                yield client
                client.close()
            ```

            ```python
            import tempfile

            @pytest.fixture
            def temp_file():
                with tempfile.NamedTemporaryFile(delete=False) as f:
                    f.write(b"test")
                yield f.name
                os.remove(f.name)
            ```

        -   **Fixture Parametrization**: Similar to test parametrization, you can also parameterize fixtures to provide different setups for different scenarios.

            1. `Example`:

                ```python
                # conftest.py or test_db.py
                import pytest

                class DBClient:
                    def __init__(self, backend):
                        self.backend = backend
                        self.connected = False

                    def connect(self):
                        self.connected = True
                        return f"Connected to {self.backend}"

                    def disconnect(self):
                        self.connected = False
                        return f"Disconnected from {self.backend}"

                @pytest.fixture(params=["sqlite", "postgresql", "mysql"])
                def db_client(request):
                    client = DBClient(request.param)
                    client.connect()  # setup step
                    yield client       # hand over to the test
                    # teardown step
                    print(client.disconnect())
                ```

                ```python
                ## test_db.py
                def test_db_connection(db_client):
                    result = db_client.connect()
                    assert f"Connected to {db_client.backend}" in result
                ```

            2. `Example`:

                ```python
                import pytest
                import json
                import yaml
                import csv
                import io

                @pytest.fixture(params=["json", "yaml", "csv"])
                def data_loader(request):
                    raw_data = '{"name": "Alice", "age": 25}'
                    if request.param == "json":
                        return json.loads(raw_data)
                    elif request.param == "yaml":
                        return yaml.safe_load(raw_data)
                    elif request.param == "csv":
                        reader = csv.DictReader(io.StringIO("name,age\nAlice,25"))
                        return list(reader)[0]
                ```

                ```python
                ## test_loader.py
                def test_name_in_data(data_loader):
                    assert data_loader["name"] == "Alice"
                ```

            3. `Example`:

                ```python
                ## conftest.py
                import pytest
                import requests

                @pytest.fixture(params=["get", "post", "put", "delete"])
                def http_method(request):
                    return request.param
                ```

                ```python
                ## test_api.py
                def test_status_codes(http_method):
                    url = "https://httpbin.org/" + http_method
                    response = getattr(requests, http_method)(url)
                    assert response.status_code == 200
                ```

        -   **Fixture Composition**: You can use one fixture inside another to build more complex setups. Pytest ensures that the fixtures are resolved in the correct order.

            -   `Dependency Injection`: Fixtures can depend on other fixtures, forming a dependency chain. pytest automatically resolves these dependencies and ensures that fixtures are invoked in the correct order.

            ```python
            @pytest.fixture
            def user_data():
                return {"name": "Alice"}

            @pytest.fixture
            def user_profile(user_data):
                return {**user_data, "active": True}

            def test_user(user_profile):
                assert user_profile["active"] is True
            ```

        -   **Autouse Fixtures**: You can use the `autouse=True` parameter when defining a fixture to automatically use it in all test functions without explicitly requesting it as an argument.

        -   **Creating Fixture Factory**: A **Fixture Factory** refers to a factory-style fixture—a fixture that returns a function which can be called inside a test to dynamically create test data or objects on-demand. This is particularly useful when:

            -   You want to generate multiple variations of test data within a single test.
            -   You need to parameterize object creation with arguments.
            -   You want to avoid global shared state by dynamically constructing objects during test execution.
            -   `Example`:

                ```python
                # students.py
                from datetime import datetime


                class Student:

                    def __init__(self, name, dob, branch, credits):
                        self.name = name
                        self.dob = dob
                        self.branch = branch
                        self.credits = credits

                    def get_age(self):
                        return (datetime.now() - self.dob).days // 365

                    def get_credits(self):
                        return self.credits


                def get_topper(students):
                    return max(students, key=lambda student: student.get_credits())
                ```

                ```python
                # conftest.py
                from datetime import datetime
                import pytest

                @pytest.fixture
                def dummy_student():
                    return Student("nikhil", datetime(2000, 1, 1), "coe", 20)


                @pytest.fixture
                def make_dummy_student():
                    def _make_dummy_student(name, credits):
                        return Student(name, datetime(2000, 1, 1), "coe", credits)

                    return _make_dummy_student
                ```

                ```python
                # test_students
                from datetime import datetime


                def test_student_get_age(dummy_student):
                    dummy_student_age = (datetime.now() - dummy_student.dob).days // 365
                    assert dummy_student.get_age() == dummy_student_age


                def test_student_get_credits(dummy_student):
                    assert dummy_student.get_credits() == 20


                def test_get_topper(make_dummy_student):
                    students = [
                        make_dummy_student("ram", 21),
                        make_dummy_student("shyam", 19),
                        make_dummy_student("ravi", 22)
                    ]

                    topper = get_topper(students)

                    assert topper == students[2]
                ```

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">Mark</summary>

        Pytest mark is a feature of the Pytest testing framework that allows you to attach metadata or attributes to a test function or method. The `@pytest.mark` decorator is used to apply a mark to a test, and it takes one or more arguments that specify the name(s) of the mark(s) to be applied.

        Here are some of the commonly used Pytest marks:

        -   `@pytest.mark.parametrize`: used for parametrizing a test with multiple sets of input values
        -   `@pytest.mark.xfail`: used to mark a test that is expected to fail
        -   `@pytest.mark.skip`: used to mark a test that should be skipped
        -   `@pytest.mark.skipif`: used to mark a test that should be skipped based on a certain condition
        -   `@pytest.mark.timeout`: used to set a time limit for the test to execute
        -   `@pytest.mark.slow`: used to mark a test as slow
        -   `@pytest.mark.smoke`: used to mark a test as a smoke test, i.e., a quick and basic test to check if the application is working
        -   `@pytest.mark.regression`: used to mark a test as a regression test, i.e., a test that checks if a previously fixed issue has resurfaced
        -   `@pytest.mark.flaky`: used to mark a test as flaky, i.e., a test that sometimes fails due to non-deterministic behavior
        -   `@pytest.mark.dependency`: used to specify dependencies between tests.

        #### How to run Pytest Marker?

        -   To run a specific test marker in Pytest, you can use the -m option followed by the marker name. Here's an example command to run all tests marked with "slow"

            -   `$ pytest -m slow`

        -   You can also specify multiple markers by separating them with an "or" (|) operator. For example, to run tests marked with either "slow" or "smoke", you can use:

            -   `$ pytest -m "slow or smoke"`

        -   You can also use the "not" (not) operator to exclude tests with a certain marker. For example, to run all tests except those marked with "skip", you can use:

            -   `$ pytest -m "not skip"`

        -   In addition to running tests with specific markers, you can also use markers to skip tests or to xfail them (expect them to fail). To skip a test with a specific marker, you can use the -k option with the "not" (not) operator. For example, to skip all tests marked with "slow", you can use:

            -   `$ pytest -k "not slow"`

        -   To xfail a test with a specific marker, you can use the `@pytest.mark.xfail` decorator to mark the test and then run Pytest with the -rx option to show the reason for the expected failure. For example:

            ```python
            import pytest

            @pytest.mark.xfail
            def test_foo():
                assert False
            ```

        -   You also can run the test and show that it was xfailed with the reason "Expected failure".
            -   `$ pytest -rx`

        </details>

    -   <details><summary style="font-size:20px;color:#FF1493">Mocking</summary>

        **Mock testing** is a technique used in unit testing to simulate and control the behavior of **external dependencies**, such as databases, APIs, file systems, or third-party services.

        -   [Unit Testing in Python with pytest | Introduction to mock (Part-9)](https://www.youtube.com/watch?v=dw2eNCzwBkk&list=PLyb_C2HpOQSBWGekd7PfhHnb9GnqDgrxS&index=9)
        -   []

        -   In software testing, it is important to isolate the unit of code being tested from other parts of the system in order to ensure that any failures or defects are not the result of interactions with external dependencies. In some cases, external dependencies may not be available or may be difficult to set up for testing, so a mock object is used to simulate the behavior of the external component.
        -   A mock object is a fake object that behaves like the real component but with pre-programmed behavior that can be defined by the tester. The mock object can be used to replace the real component during testing, so that the module or system under test can be tested in isolation, without having to rely on the behavior of the external component.
        -   Mocking can be especially useful in situations where the external component is slow, unreliable, or expensive to use in testing. By simulating the external component with a mock object, testing can be performed more quickly and reliably, without the need for the external component to be present or configured for testing.

        -   demonstrate Ways of applying mock:

            -   decorator
            -   context manager
            -   inline

        -   Tools for Mocking in Pytest

            1. `unittest.mock` – built-in standard library
            2. `pytest-mock` – convenient wrapper around `unittest.mock`. Installation: `pip install pytest-mock`

        -   Python's built-in (`unittest.mock`) library provides a rich set of tools for mocking:

            ```python
            from unittest.mock import Mock, patch, MagicMock
            ```

            | Tool             | Description                                                        |
            | ---------------- | ------------------------------------------------------------------ |
            | `Mock()`         | Basic mock object                                                  |
            | `MagicMock()`    | Like `Mock` but with magic methods (e.g. `__len__`, `__getitem__`) |
            | `patch()`        | Temporarily replaces an object during test                         |
            | `patch.object()` | Patch attributes of a specific object                              |
            | `side_effect`    | Custom behavior or exceptions when calling a mock                  |
            | `return_value`   | Value to return when mock is called                                |

        -   Mocking Classification in Pytest

            | **Type**                         | **Purpose**                                            | **Example Use Case**                             |
            | -------------------------------- | ------------------------------------------------------ | ------------------------------------------------ |
            | **Function/Method Mocking**      | Replace a specific function or method.                 | Mock `requests.get()` to avoid hitting live APIs |
            | **Object/Attribute Mocking**     | Override object attributes or methods.                 | Replace `user.is_admin` to simulate permissions  |
            | **Class Mocking**                | Mock an entire class or constructor.                   | Simulate DB clients like `boto3.client()`        |
            | **Patch Context Manager**        | Mock only inside a `with` block.                       | Mock file operations only during file read tests |
            | **Auto-used Fixtures**           | Apply mocking to all tests without needing decorators. | Patch AWS creds for every test automatically     |
            | **Side Effects / Return Values** | Simulate errors or chained calls.                      | Simulate `raise TimeoutError()` on HTTP call     |

        -   Best Practices

            -   Use `pytest-mock` for concise syntax.
            -   Use **`mocker.patch`** over **`patch()`** where possible.
            -   Use **context managers** for temporary mocking.
            -   Use **autouse fixtures** for global mocking like environment variables or credentials.

        1. **Mocking a Function with Decorator**

            ```python
            import requests
            from unittest.mock import patch

            def fetch_data():
                return requests.get("https://api.example.com/data").json()

            @patch("requests.get")
            def test_fetch_data(mock_get):
                mock_get.return_value.json.return_value = {"status": "ok"}
                assert fetch_data()["status"] == "ok"
            ```

        2. **Mocking a Method with `pytest-mock` Fixture**

            ```python
            # services/user_service.py
            class UserService:
                def is_user_active(self, user_id):
                    return True

            # test_user_service.py
            from services.user_service import UserService

            def test_is_user_active(mocker):
                service = UserService()
                mocker.patch.object(service, "is_user_active", return_value=False)
                assert service.is_user_active(123) is False
            ```

        3. **Mocking a Class Instantiation**

            ```python
            # utils/s3.py
            import boto3

            def upload_to_s3(bucket, key, data):
                s3 = boto3.client("s3")
                return s3.put_object(Bucket=bucket, Key=key, Body=data)

            # test_s3.py
            def test_upload_to_s3(mocker):
                mock_client = mocker.Mock()
                mocker.patch("boto3.client", return_value=mock_client)

                upload_to_s3("my-bucket", "file.txt", b"Hello")
                mock_client.put_object.assert_called_once()
            ```

        4. **Mock with Context Manager (`with` block)**

            ```python
            from unittest.mock import patch

            def read_config(path):
                with open(path, "r") as f:
                    return f.read()

            def test_read_config():
                with patch("builtins.open", mock_open(read_data="foo=bar")) as mock_file:
                    assert read_config("dummy.cfg") == "foo=bar"
            ```

        5. **Mock with Side Effects (Errors, Iterators, Dynamic)**

            ```python
            import requests
            from unittest.mock import patch

            def fetch_weather():
                return requests.get("http://weather.api").json()

            @patch("requests.get")
            def test_fetch_weather_timeout(mock_get):
                mock_get.side_effect = requests.exceptions.Timeout
                try:
                    fetch_weather()
                except requests.exceptions.Timeout:
                    assert True
            ```

        6. **Mock Return Values for Multiple Calls**

            ```python
            @patch("requests.get")
            def test_multiple_responses(mock_get):
                mock_get.side_effect = [
                    Mock(status_code=200, json=lambda: {"ok": True}),
                    Mock(status_code=500)
                ]
                r1 = requests.get("url")
                r2 = requests.get("url")
                assert r1.json()["ok"] is True
                assert r2.status_code == 500
            ```

        7. **Auto-used Fixture to Mock Global State**

            ```python
            # conftest.py
            import pytest

            @pytest.fixture(autouse=True)
            def mock_env_vars(monkeypatch):
                monkeypatch.setenv("AWS_REGION", "us-east-1")
                monkeypatch.setenv("AWS_ACCESS_KEY_ID", "test")
            ```

            - All tests will use the mocked environment variables automatically.

        </details>

    #### Plugins and Extensions:

    -   Pytest has a rich ecosystem of plugins and extensions that can enhance its capabilities. You can install and use plugins to extend Pytest's functionality for reporting, parallel testing, test parameterization, and more.

    ```sh
    # Install and run pytest-cov for code coverage
    pip install pytest-cov
    pip install pytest-xdist
    pytest --cov=src_directory

    ```

    #### Reporting:

    -   Pytest generates detailed test reports, including pass/fail results and any error messages or traceback information. You can view these reports in the console or generate more comprehensive reports in different formats (e.g., HTML, XML, JUnit) using plugins like `pytest-html` or `pytest-xdist`.

    #### Continuous Integration (CI) Integration:

    -   Integrate Pytest with your CI/CD pipelines to automatically run tests whenever code changes are pushed. Most CI/CD platforms like `Jenkins`, `Travis CI`, and `GitHub Actions` support Pytest integration.

    #### Customization:

    -   You can customize Pytest behavior and settings by creating a `pytest.ini` or `pytest.cfg` configuration file in your project directory.

    #### Commands and explanation

    -   ✅ **Basic Test Execution**

        -   `$ pytest` → Run all tests in the current directory and subdirectories.
        -   `$ pytest tests/` → Run tests in the `tests/` folder.
        -   `$ pytest tests/test_example.py` → Run tests in a specific file.
        -   `$ pytest tests/test_example.py::test_function_name` → Run a specific test function in a file.

    -   🔁 **Test Selection / Filtering**

        -   `$ pytest -k "keyword"` → Run tests with names matching the keyword (substring match).
        -   `$ pytest -m "marker"` → Run tests with a specific marker (e.g., `@pytest.mark.slow`).
        -   `$ pytest -x` → Stop after the first failure.
        -   `$ pytest --maxfail=3` → Stop after 3 failures.

    -   🧪 **Test Reporting**

        -   `$ pytest -v` → Verbose output (shows test names).
        -   `$ pytest -q` → Quiet output (minimal info).
        -   `$ pytest --tb=short` → Short traceback format.
        -   `$ pytest --tb=none` → Suppress traceback entirely.
        -   `$ pytest --junitxml=report.xml` → Export test report in JUnit XML format.

    -   💯 **Code Coverage (requires `pytest-cov`)**

        -   `$ pytest --cov=my_package` → Run tests and report coverage for `my_package`.
        -   `$ pytest --cov=my_package --cov-report=html` → Generate an HTML coverage report.
        -   `$ pytest --cov=my_package --cov-branch` → Include branch coverage.

    -   🧹 **Test Clean-up and Caching**

        -   `$ pytest --cache-clear` → Clear pytest’s internal cache.
        -   `$ pytest --lf` → Run only the tests that failed last time (`--last-failed`).
        -   `$ pytest --ff` → Run failed tests first, then the rest (`--failed-first`).

    -   🏷️ **Markers and Customization**

        -   `$ pytest --markers` → List all registered markers.
        -   `$ pytest -m "not slow"` → Run tests not marked as `slow`.
        -   `$ pytest -m "smoke and not db"` → Complex marker filtering.

    -   🛠️ **Setup and Debug**

        -   `$ pytest --setup-show` → Show setup/teardown of fixtures.
        -   `$ pytest --pdb` → Enter debugger on failure.
        -   `$ pytest -s` → Show `print()` statements during test execution.

    -   🔌 **Plugins and Environment**

        -   `$ pytest --fixtures` → Show available fixtures.
        -   `$ pytest --help` → Show all available command-line options.

    -   `$ pytest --junitxml=junit_xml_test_report.xml --cov=ads/ tests --cov-branch --cov-report html`

        -   `pytest` → Runs all test cases using **pytest** from the `tests/` directory.
        -   `--junitxml=junit_xml_test_report.xml` → Generates a **JUnit-style XML test report**, commonly used by CI tools (like Jenkins, GitHub Actions, GitLab CI).
        -   `--cov=ads/` → Measures **code coverage** of the `ads/` directory (presumably your main source code folder).
        -   `tests` → Specifies the **test directory** where pytest should look for test files.
        -   `--cov-branch` → Enables **branch coverage** analysis (i.e., tests that account for `if/else`, try/except branches, etc.), giving deeper insight into which conditional branches are tested.
        -   `--cov-report html` → Produces an **HTML coverage report** saved in a directory named `htmlcov/` by default. You can open `htmlcov/index.html` in a browser to view a visual representation of the coverage.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Interview Question on Pytest</summary>

    1. What is Pytest?
        - Pytest is a testing framework for Python that simplifies writing and executing test cases.
    2. How does Pytest differ from other testing frameworks like unittest?
        - Pytest provides a simpler syntax, fixtures, and powerful features like parameterized testing, making it more concise and expressive than unittest.
    3. What is a fixture in Pytest?

        - A fixture is a function marked with the @pytest.fixture decorator. It allows setup code to be shared across multiple test functions.

    4. Explain the use of the pytest.mark decorator.

        - pytest.mark is used for marking test functions or classes to customize their behavior, like skipping, marking as slow, etc.

    5. How does parameterized testing work in Pytest?
        - Parameterized testing allows running the same test logic with different inputs. It can be achieved using the @pytest.mark.parametrize decorator.
    6. What is the purpose of conftest.py in Pytest?
        - conftest.py is a file that is used to define fixtures, hooks, and plugins that are shared across multiple test modules.
    7. Explain the concept of fixtures in Pytest.

        - Fixtures are functions marked with @pytest.fixture that provide data or set up conditions for test functions. They are called automatically by Pytest.

    8. How can you skip a test in Pytest?
        - You can use the @pytest.mark.skip decorator or pytest.mark.skip(reason="reason for skipping") to skip a test.
    9. What is the purpose of the -k option in Pytest?

        - The -k option allows you to select tests based on their names using substring matching.

    10. Explain the use of the -m option in Pytest.

        - The -m option is used to select tests based on their markers. You can mark tests using @pytest.mark and then run tests based on these markers.

    11. How do you run only failed tests in Pytest?
        - Use the --lf (short for --last-failed) option to run only the tests that failed in the last test run.
    12. What is the purpose of the pytest.fixture(scope="module")?
        - Setting the scope="module" in a fixture ensures that the fixture is only called once per module, sharing the state across all the tests in the module.
    13. Explain the use of the capsys fixture in Pytest.

        - capsys is a built-in fixture in Pytest that captures the output to sys.stdout and sys.stderr during the test.

    14. How do you perform mocking in Pytest?
        - You can use the pytest-mock library or the unittest.mock module for mocking in Pytest.
    15. What is the purpose of the autouse parameter in a fixture?
        - The autouse parameter, when set to True, makes the fixture apply automatically to all tests without explicitly requesting it.

    These questions cover a range of topics related to Pytest, including fixtures, markers, skipping tests, and test organization. Interviewers might also ask you to write sample tests or demonstrate the usage of specific Pytest features.

    </details>

---
