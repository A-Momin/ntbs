-   <details><summary style="font-size:25px;color:Orange">Notes</a></summary>

    -   To find the XPath of an <iframe> (or any element) within a #shadow-root (Shadow DOM), you need to understand that XPath in browser devtools does not cross shadow DOM boundaries directly

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Selenium Components</a></summary>

    #### 1.1 Selenium WebDriver

    -   **What is it?**  
        Selenium **WebDriver** is the core component that allows interaction with web browsers programmatically.
    -   **Purpose:**
        -   Automates browser actions (click, type, scroll, etc.).
        -   Supports multiple browsers like Chrome, Firefox, Edge, Safari.
        -   Enables execution of JavaScript and handling alerts/popups.
    -   **Example Usage:**
        ```python
        from selenium import webdriver
        driver = webdriver.Chrome()
        driver.get("https://example.com")
        driver.quit()
        ```

    #### 1.2 Selenium IDE

    -   **What is it?**  
        A **record-and-playback tool** used for creating simple Selenium test scripts without coding.
    -   **Purpose:**
        -   No programming needed, best for beginners.
        -   Available as a browser extension.

    #### 1.3 Selenium Grid

    -   **What is it?**  
        A tool used for **running tests in parallel** across multiple browsers and machines.
    -   **Purpose:**
        -   Supports distributed testing.
        -   Runs tests on remote machines or in cloud environments.

    #### 1.4 Selenium Client Libraries (Selenium Bindings)

    -   **What is it?**  
        Selenium supports multiple programming languages: Python, Java, C#, JavaScript, and Ruby.
    -   **Purpose:**
        -   Developers can write test scripts in their preferred language.
        -   Python binding: `selenium.webdriver`

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Key Concepts & Terms in Selenium</a></summary>

    #### 2.1 WebDriver\*\*

    -   **What is it?**  
        WebDriver is the interface used to control the browser programmatically.
    -   **Common WebDriver Classes:**
        -   `webdriver.Chrome()`
        -   `webdriver.Firefox()`
        -   `webdriver.Edge()`

    #### 2.2 WebElements\*\*

    -   **What is it?**  
        WebElements represent HTML elements on a webpage that Selenium interacts with.
    -   **Common WebElement Actions:**
        ```python
        element = driver.find_element(By.ID, "username")
        element.send_keys("testuser")
        element.click()
        element.clear()
        ```

    #### 2.3 Locators in Selenium\*\*

    Locators are used to **find elements on a webpage**.  
    Selenium provides multiple ways to locate elements:

    | **Locator Strategy**     | **Example**                                                 |
    | ------------------------ | ----------------------------------------------------------- |
    | **By.ID**                | `driver.find_element(By.ID, "login-btn")`                   |
    | **By.NAME**              | `driver.find_element(By.NAME, "username")`                  |
    | **By.CLASS_NAME**        | `driver.find_element(By.CLASS_NAME, "btn-primary")`         |
    | **By.TAG_NAME**          | `driver.find_element(By.TAG_NAME, "button")`                |
    | **By.XPATH**             | `driver.find_element(By.XPATH, "//button[text()='Login']")` |
    | **By.CSS_SELECTOR**      | `driver.find_element(By.CSS_SELECTOR, "button.btn-login")`  |
    | **By.LINK_TEXT**         | `driver.find_element(By.LINK_TEXT, "Click here")`           |
    | **By.PARTIAL_LINK_TEXT** | `driver.find_element(By.PARTIAL_LINK_TEXT, "Click")`        |

    #### 2.4 Selenium Actions\*\*

    -   **Clicking on an Element**

        ```python
        button = driver.find_element(By.ID, "submit")
        button.click()
        ```

    -   **Typing into an Input Field**

        ```python
        input_box = driver.find_element(By.NAME, "username")
        input_box.send_keys("testuser")
        ```

    -   **Clearing Input Fields**

        ```python
        input_box.clear()
        ```

    -   **Handling Dropdowns**

        ```python
        from selenium.webdriver.support.ui import Select
        dropdown = Select(driver.find_element(By.ID, "country"))
        dropdown.select_by_visible_text("United States")
        ```

    -   **Handling Alerts & Pop-ups**

        ```python
        alert = driver.switch_to.alert
        alert.accept()  # Clicks OK
        alert.dismiss()  # Clicks Cancel
        ```

    #### 2.5 Selenium Waits (Synchronization)

    Selenium waits allow **waiting for elements** to load before interacting with them.

    -   **Implicit Wait**:

        -   **Waits for a set amount of time before throwing an error.**
        -   **Example:**
            ```python
            driver.implicitly_wait(10)
            ```

    -   **Explicit Wait**:

        -   **Waits for a specific condition before proceeding.**
        -   **Example:**

            ```python
            from selenium.webdriver.support.ui import WebDriverWait
            from selenium.webdriver.support import expected_conditions as EC

            element = WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.ID, "login"))
            )
            ```

    -   **Fluent Wait**:

        -   **Waits with polling intervals and timeout conditions.**
        -   **Example:**
            ```python
            from selenium.webdriver.support.ui import WebDriverWait
            wait = WebDriverWait(driver, 10, poll_frequency=2)
            wait.until(EC.element_to_be_clickable((By.ID, "submit")))
            ```

    #### 2.6 Handling Frames and Windows

    -   **Switching to an iframe**

        ```python
        driver.switch_to.frame("frame_id")
        driver.switch_to.default_content()  # Switch back to the main page
        ```

    -   **Handling Multiple Windows**

        ```python
        main_window = driver.current_window_handle
        windows = driver.window_handles

        for window in windows:
            if window != main_window:
                driver.switch_to.window(window)
        ```

    #### 2.7 Scrolling in Selenium

    ```python
    driver.execute_script("window.scrollTo(0, document.body.scrollHeight);")
    ```

    #### 2.8 Taking Screenshots

    ```python
    driver.save_screenshot("screenshot.png")
    ```

    #### 2.9 Executing JavaScript in Selenium

    Sometimes, JavaScript execution is needed to interact with elements.

    ```python
    driver.execute_script("document.getElementById('login').click();")
    ```

    #### 2.10 Headless Browser Execution

    Run Selenium without opening the browser window:

    ```python
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)
    ```

    #### 2.10 Automating File Uploads

    ```python
    upload_input = driver.find_element(By.ID, "file-upload")
    upload_input.send_keys("C:\\path\\to\\file.txt")
    ```

    #### 2.11 Handling Captchas

    -   Selenium cannot bypass captchas but can **use third-party services** like **2Captcha, Anti-Captcha**.
    -   Alternative: Use **OCR** like **Tesseract** to read captchas.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Running Selenium Tests</a></summary>

    -   **Using pytest**

        ```python
        pytest test_script.py
        ```

    -   **Using unittest**

        ```python
        import unittest

        class TestLogin(unittest.TestCase):
            def test_login(self):
                driver = webdriver.Chrome()
                driver.get("https://example.com")
                self.assertIn("Example", driver.title)
                driver.quit()

        if __name__ == "__main__":
            unittest.main()
        ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">What is UI Framework?</a></summary>

    A UI (User Interface) Framework is a collection of pre-written code, tools, and design guidelines that developers use to build the visual and interactive parts of software applications, particularly web applications. It simplifies and accelerates the development process by providing reusable components and a consistent structure.

    Here's a breakdown of what UI frameworks typically include:

    -   **Pre-built UI Components:**
        -   These are ready-to-use elements like buttons, forms, navigation bars, modal dialogs, and tables.
        -   They save developers from having to write code for these common elements from scratch.
    -   **CSS Styling:**
        -   UI frameworks often include pre-defined CSS styles that give applications a consistent look and feel.
        -   They may also provide a grid system for layout and responsive design capabilities.
    -   **JavaScript Functionality:**
        -   Many UI frameworks include JavaScript libraries that add interactive behavior to UI components.
        -   This can include things like handling user input, animating elements, and making AJAX requests.
    -   **Design Guidelines:**
        -   Some frameworks offer design guidelines that promote consistency in the application's user interface.
        -   This can include things like color palettes, typography, and spacing recommendations.
    -   **Accessibility Features:**
        -   Well-designed UI frameworks often include built-in accessibility features to make applications usable for people with disabilities.
    -   **Responsive Design:**
        -   Most modern UI frameworks are built with responsive design in mind, meaning they adapt well to different screen sizes and devices.

    **Benefits of Using UI Frameworks:**

    -   **Faster Development:** Pre-built components and styles significantly reduce development time.
    -   **Consistency:** UI frameworks promote a consistent look and feel across the application.
    -   **Improved User Experience:** Well-designed frameworks can lead to a better user experience.
    -   **Cross-Browser Compatibility:** Frameworks often handle cross-browser compatibility issues.
    -   **Maintainability:** Using a framework can make the codebase more organized and maintainable.
    -   **Accessibility:** Many frameworks include accessibility features, which is very important.

    **Examples of UI Frameworks:**

    -   **For Web Development:**
        -   Bootstrap
        -   Material UI
        -   React Bootstrap
        -   Tailwind CSS
        -   Angular Material
    -   **For Mobile Development:**
        -   React Native
        -   Flutter
        -   Ionic

    In essence, UI frameworks are powerful tools that help developers create visually appealing, user-friendly, and efficient applications.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Questions</summary>

    -   What is a locator in context of Selenium?
    -   What is a Shadow DOM? How can I identify a Shadow DOM element in a browser devtool?
        -   Shadow DOM is a web standard that enables encapsulation of a component's internal DOM structure and styling. It's part of the Web Components spec and allows developers to keep a component’s logic isolated from the main DOM.
        -   To find the XPath of an <iframe> (or any element) within a #shadow-root (Shadow DOM), you need to understand that XPath in browser devtools does not cross shadow DOM boundaries directly

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">Config and Troublshooting</summary>

    -   `$ chrome://version/` -> Check out the version of Google Chrome is being used.
    -   `$ pip show selenium` -> Check out the version of Selenium is being used.
    -   `$ /Users/am/.cache/selenium/chromedriver/mac-x64/135.0.7049.114 --version` -> Check out the version of chromedriver is being used.
    -   `$ `
    -   `$ `

    </detsils>
