```mermaid

    graph TD
        A[Trigger] --> B{Type}
        B -->|On Demand| C[Job Start]
        B -->|Scheduled| D[Time Check]
        C --> E[Job Execution]
        E --> F[Completion Status]
        D --> F
        F --> G{Status}
        G -->|Success| H[Next Trigger]
        G -->|Failure| I[Error Handling]

```

<pre><code class="language-yaml">

    name: example
    version: 1.0
    dependencies:
    - python: ">=3.8"
    - flask: "^2.0"

</code></pre>

<pre> ```yaml name: example version: 1.0 dependencies: - python: ">=3.8" - flask: "^2.0" ``` </pre>

<div style="text-align: center;">
  <pre><code class="language-yaml">
name: example
version: 1.0
  </code></pre>
</div>
