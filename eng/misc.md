
-   <details><summary style="font-size:25px;color:Orange">MISC</summary>

    -   **False Positive** | **True Positive** | **False Negative** | **True Negative**: are commonly used in the context of classification, machine learning, cybersecurity, medical testing, etc. They describe the outcomes of a binary classification (yes/no, positive/negative) and help evaluate how accurate a system is.

    -   ✅ 1. **True Positive (TP)**

        -   The system **correctly identifies** a positive condition.

        -   Example:

            -   **Medical Test**: A patient **has a disease**, and the test correctly says **positive**.
            -   **Security (WAF)**: An attack occurs, and the WAF **correctly blocks** it as a threat.

    -   ❌ 2. **False Positive (FP)**

        -   The system **incorrectly identifies** a negative condition as positive.

        -   Example:

            -   **Medical Test**: A patient is **healthy**, but the test wrongly says **positive**.
            -   **Security (WAF)**: A normal user request is **blocked** by WAF thinking it’s an attack (but it's not).
            -   **Spam Filter**: A legitimate email goes to the **spam folder**.

    -   ❌ 3. **False Negative (FN)**

        -   The system **misses** a positive condition — fails to detect it.

        -   Example:

            -   **Medical Test**: A patient **has a disease**, but the test wrongly says **negative**.
            -   **Security (WAF)**: A malicious request **passes through** the WAF undetected.
            -   **Email Security**: A phishing email is marked as **safe** and lands in the inbox.

    -   ✅ 4. **True Negative (TN)**

        -   The system **correctly identifies** a negative condition.

        -   Example:

            -   **Medical Test**: A patient is **healthy**, and the test correctly says **negative**.
            -   **Security (WAF)**: A normal request is **allowed** through (correctly classified as safe).

    -   🧠 Quick Visual (Confusion Matrix Perspective):

        |                        | **Actual Positive**   | **Actual Negative**   |
        | ---------------------- | --------------------- | --------------------- |
        | **Predicted Positive** | ✅ True Positive (TP)  | ❌ False Positive (FP) |
        | **Predicted Negative** | ❌ False Negative (FN) | ✅ True Negative (TN)  |

    </details>

---
