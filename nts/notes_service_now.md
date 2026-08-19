-   Lead Time
-   Release Attestation
-   Risk Rating
-   Change Owner

1. Pre-Implementation Testing
2. Implementation Plan
3. Backout Plan
4. Post Validation Plan

-   
-   

---
---

In ITIL-aligned IT Service Management (ITSM), **Change Management** and **Release Management** are two highly integrated yet fundamentally distinct practices. When configured in ServiceNow, they work together to ensure that infrastructure and application updates happen efficiently while protecting the stability of the production environment.

The fundamental division of responsibilities can be summarized as:

* **Change Management:** Governs the *risk, impact, and authorization* of an modification. It answers: *"Should we do this, are the risks mitigated, and do we have permission?"*
* **Release Management:** Governs the *building, testing, packaging, and actual deployment* of a set of changes. It answers: *"How do we build and bundle this software/hardware solution, verify it works, and push it out securely?"*

---

## ServiceNow Change Management

The core goal of Change Management (`change_request`) in ServiceNow is to minimize business risk and avoid outages while enabling rapid infrastructure and code updates.

### The Three ITIL Change Types in ServiceNow

The type of change determines the specific state model (workflow path) and mandatory approval gates invoked in ServiceNow:

1. **Standard Change**: Low-risk, routine, and highly repetitive changes that follow a proven, pre-approved procedure.
    * **Workflow:** Bypasses peer review and the Change Advisory Board (CAB). It goes straight from **New** to **Scheduled** or **Implement**.
    * **ServiceNow Mechanism:** Managed via the *Standard Change Catalog*. Teams propose templates; once the Change Manager approves the template, it is published to the catalog for anyone to request.


2. **Normal Change**: Any non-emergency change that requires custom evaluation because it lacks a pre-approved template.
    * **Workflow:** Follows the full prescriptive lifecycle: Requires peer/technical review, automated risk scoring, and CAB approval.
    * **Scheduling:** Must be scheduled outside defined Blackout Windows and inside designated Maintenance Windows on the change calendar.


3. **Emergency Change**: Highly urgent modifications triggered by a major incident or an imminent security vulnerability (e.g., critical zero-day patching).
    * **Workflow:** Bypasses standard review stages to optimize speed.
    * **Approval:** Routes directly to the **Emergency CAB (eCAB)**, a stripped-down, agile authorization group that can review and sign off via mobile or platform alerts within minutes.



### The Lifecycle States of a Normal Change Request

```
[ New ] ➔ [ Assess ] ➔ [ Authorize ] ➔ [ Scheduled ] ➔ [ Implement ] ➔ [ Review ] ➔ [ Closed ]

```

* **New / Draft:** The Change Coordinator populates the record, defining the affected Configuration Items (CIs), scheduling window, implementation plan, validation steps, and fallback (backout) plan.
* **Assess:** Technical peer review occurs. ServiceNow triggers **Conflict Detection** to ensure no other team is touching the same infrastructure, and evaluates **Risk Intelligence** based on past success scores and CMDB relationships.
* **Authorize:** The change is routed to managers and the CAB. High-risk changes populate the **CAB Workbench**, an interactive portal where CAB members review schedules, dependencies, and grant approvals.
* **Scheduled:** Approvals are complete. The change sits on the Change Calendar awaiting its designated execution window.
* **Implement:** Execution takes place. ServiceNow automatically generates underlying **Change Tasks (CTASKs)** for different execution teams (e.g., Network, Database, Security) that must be completed and closed in sequence.
* **Review:** Post-Implementation Review (PIR). The team documents whether the change succeeded, failed, or was rolled back.
* **Closed:** Locked out from further edits to maintain strict audit compliance.

In ServiceNow, the **Normal Change Request** form (`change_request`) is designed to capture everything required to assess risk, secure approvals, and safely implement modifications to the IT environment.

Out-of-the-box (OOTB), the form is divided into a top **Header/Details area** and a series of organized **Tabs (sections)** across the bottom. Here is an item-by-item breakdown of the fields you will interact with.

1. **Top Section: Core Ticket Details**: These fields establish the structural identity, ownership, and current state of the change request.

   * **Number:** A unique, system-generated identifier (e.g., `CHG0012345`).
   * **Requested by:** The person or system initiating the change request.
   * **Category:** The broad domain of infrastructure affected (e.g., *Hardware, Software, Network, Telecom, System Software*).
   * **Type:** Hard-coded as **Normal** (as opposed to Standard or Emergency), invoking the full, multi-gate workflow.
   * **State:** Tracks the current phase of the record's lifecycle (*New, Assess, Authorize, Scheduled, Implement, Review, Closed, Canceled*).
   * **Configuration Item (CI):** The specific asset in the CMDB being altered (e.g., a specific database instance, a firewall cluster, or a mid-tier application service).
   * **Service / Service Offering:** The high-level business or technical service impacted by this change (e.g., *Retail Mobile Banking*). This maps dependencies so you know who gets disrupted if things go wrong.
   * **Assignment Group:** The specific engineering group responsible for configuring and implementing the change.
   * **Assigned to:** The individual engineer within the Assignment Group executing the work.
   * **Priority:** The business priority, automatically calculated based on the combined matrix of **Impact** (scope of the business affected) and **Urgency** (how long the business can wait).
   * **Risk:** The level of danger the change poses to environment stability (*Low, Moderate, High, Very High*). It initializes as `None` or a default value, then updates dynamically after you complete the Risk Assessment quiz or via built-in system evaluation rules.

2. **Planning Tab**: This section forces the creator to thoroughly detail the technical plan and safety nets. Approvers and the Change Advisory Board (CAB) review this section most carefully.

   * **Justification:** The business or technical reason why this change is necessary (e.g., "Fixes a memory leak patch identified in vendor release note v2").
   * **Implementation Plan:** A step-by-step technical guide detailing how the engineering team will execute the change.
   * **Risk and Impact Analysis:** A detailed description of what could break if the deployment fails, and the potential blast radius.
   * **Backout Plan:** The comprehensive "rollback" procedure. If the change fails or causes an outage during the window, this explains precisely how to revert the environment to its exact pre-change state.
   * **Test Plan:** The verification criteria proving the change was tested successfully in a staging environment prior to production, as well as the post-implementation tests to run once deployed.

3. **Schedule Tab**: This section manages timeframes, calendar alignment, and automated conflict detection.

   * **Planned Start Date:** The exact date and time the implementation window is scheduled to begin.
   * **Planned End Date:** The exact date and time the implementation window must conclude.
   * **Actual Start Date:** Populated automatically (or manually by the engineer) when the ticket is officially moved into the `Implement` state.
   * **Actual End Date:** Populated when the execution concludes and the ticket moves to `Review`.
   * **Conflict Status:** A read-only field indicating whether ServiceNow's **Conflict Detection Engine** found overlapping changes targeting the same CI, or a violation of a predefined **Blackout Window** or **Maintenance Window**.
   * **Conflict Last Run:** The timestamp showing when the system last audited schedule conflicts for this change record.
   * **CAB Required:** A checkbox indicating if this change must go before the full Change Advisory Board for live review.
   * **CAB Recommendation / Delegate:** Notes or the name of the representative presenting the change during the CAB block.

4. **Notes Tab**: This section handles communication and internal collaboration logs.

   * **Watch List:** A list of users (such as business stakeholders or project managers) who should receive automated email notifications whenever public updates are made.
   * **Work Notes List:** A list of technical team members who receive notifications specifically when internal work notes are updated.
   * **Additional Comments (Customer Visible):** Communication that goes out to the broader audience or business owners regarding the status of the change.
   * **Work Notes:** An internal, technical log ledger visible only to IT agents, used to document real-time deployment progress or technical hurdles.

5. **Closure Information Tab**: Locked until the execution phase completes, this section logs final outcomes for auditing.

   * **Close Code:** A dropdown selection indicating the final status of the execution:
   * *Successful*
   * *Successful with issues*
   * *Unsuccessful*


   * **Close Notes:** A summary of how the implementation finished, documenting any issues encountered or variances from the original plan.
   * **PIR (Post-Implementation Review) Required:** Dynamically triggered if a change fails (`Unsuccessful`) or causes a major incident. It mandates a formal root-cause analysis workflow before the ticket can fully transition to `Closed`.

---

## ServiceNow Release Management

Release Management (`rm_release`) focuses on the engineering and product rollout lifecycle, transforming abstract requirements, enhancements, or bug fixes into concrete, usable software packages. It is structurally aligned with Product Management and DevOps frameworks.

### The Release Hierarchy Architecture

ServiceNow structures the release lifecycle into a hierarchical parent-child framework to track development progression cleanly:

* **Product (`rm_product`):** The highest-level entity. Represents a discrete software application, system, or service being managed (e.g., "JPMC Retail Banking Mobile App").
* **Release (`rm_release`):** A specific version or major boundary of that product (e.g., "Release v4.2.0"). This serves as the overarching container for everything moving into production.
* **Release Phase (`rm_phase`):** Sub-stages within a specific release to track milestone progressions. Standard OOB phases include *Requirements Gathering, Design, Development, Testing (QA/UAT), and Deployment*.
* **Release Task (`rm_task`):** The individual actionable assignments inside a phase, tracked by specific engineers (e.g., "Set up QA automated test suites", "Configure load balancers in staging").

---

## 3. How They Intersect: The DevOps Pipeline

In modern, mature enterprise IT pipelines, Change and Release Management do not run in silos. They intersect directly when moving assets from non-production environments into the live Production environment.

The typical end-to-end integration flow looks like this:

```
[Release Planning] ➔ [Dev & QA Phases] ➔ [Release Deployment Phase]
                                                  │
                                        (Triggers & Links to)
                                                  ▼
[Closed] ◀── [Review] ◀── [Implement] ◀── [Change Request Created]

```

### The Integration Flow

1. **Release Bundling:** The Release Manager creates a master Release record for `v4.2.0`, linking various features, enhancements, and bug fixes coming out of the Agile/Jira/ServiceNow DevOps workspace.
2. **Phase Execution:** Developers build the features, and QA teams execute testing within the designated **Release Phases**.
3. **The Change Gate:** When the Release reaches the final "Deployment" phase and is ready to touch the production environment, a **Change Request (CR)** is generated and linked directly to the parent Release record.
4. **Operational Review:** The CR pulls in the specific Configuration Items (CIs) from the Release profile, allowing the Change Management team to run risk assessments and ensure the deployment won't disrupt ongoing live operations.
5. **Execution & Closure:** Once the Change Request moves to **Approved / Scheduled**, the Release deployment scripts execute (often integrated via DevOps toolchains like GitHub Actions, Jenkins, or GitLab into ServiceNow Workflow Studio). When the deployment succeeds, the CR is reviewed and closed, and the Release record is officially marked complete.

---
---

# Incident Management Process in context of Service Now

In an ITIL-aligned IT Service Management (ITSM) framework, **Incident Management** is the practice responsible for restoring normal service operation as quickly as possible following a disruption. Its primary goal is to minimize the negative impact on business operations and ensure that high levels of service quality and availability are maintained.

In ServiceNow, this process centers around the **Incident table (`incident`)**, which serves as the core record for documenting, investigating, and resolving disruptions.

1. **The Incident Form Structure**: The incident record captures vital details needed for triage. It is divided into several main sections:

    -   **The Header Context:** Contains the incident number (`INC00XXXXX`), the current **State**, and the calculated **Priority**.
    -   **Caller Information:** The user experiencing the issue. This pulls data from the User table (`sys_user`), displaying their department, location, and contact details.
    -   **Configuration Item (CI):** The specific asset in the Configuration Management Database (CMDB) that is malfunctioning (e.g., a specific database server, an email gateway, or a laptop).
    -   **Service / Service Offering:** The broader business capability affected (e.g., *Online Banking* or *Corporate Email*). This helps determine business impact and visibility.

    -   **Activity Stream and Communication Logs**

        * **Additional Comments (Customer Visible):** Public-facing updates. Anything typed here is sent directly to the Caller via email or displayed on their Service Portal.
        * **Work Notes:** Technical logs visible only to IT service desk workers and engineers. This is used to document troubleshooting steps, script executions, and internal collaboration.

    -   **Assignment Matrix**: ServiceNow automatically or manually routes incidents using a two-tier ownership structure:

        * **Assignment Group:** The team responsible for resolving the ticket (e.g., *Network Support*, *Database Admin*, *Service Desk*).
        * **Assigned To:** The specific IT agent within that group who owns the ticket's resolution.

2. **Key Terms and Concepts**: To navigate ServiceNow Incident Management effectively, it is essential to understand its specific terminology and foundational logic.

    -   **Incident vs. Problem vs. Request**: ServiceNow keeps these modules strictly separated to ensure proper metrics:

        * **Incident:** A single disruption or reduction in quality of an IT service (e.g., *"My outlook won't open"*).
        * **Problem:** The underlying, unknown root cause of one or more incidents (e.g., *"The Exchange mail server crashed"*).
        * **Service Request:** A routine request for something new, handled via the Service Catalog (e.g., *"I need a new mouse"* or *"Requesting access to a folder"*).

    -   **The Priority Matrix (Impact vs. Urgency)**: IT agents do not manually assign a ticket's Priority. Instead, ServiceNow dynamically calculates it using an OOTB matrix based on two distinct inputs:

        1. **Impact:** The business scope of the disruption (e.g., `1 - Entire Organization`, `2 - Multiple Users/Department`, `3 - Single User`).
        2. **Urgency:** The time sensitivity of the issue or how long the business can tolerate the delay (e.g., `1 - High/Critical Critical System Down`, `2 - Medium`, `3 - Low`).

        $$\text{Impact} \times \text{Urgency} = \text{Priority (P1 to P5)}$$

        * **P1 (Critical)**: A major outage affecting core infrastructure or revenue streams.
        * **P1S1 ()**: 
        * **P1S2 ()**: 
        * **P1S3 ()**: 
        * **P1S4 ()**: 
        * **P2 ()**: 
        * **P3 ()**: 
        * **P4 ()**: 
        * **P5 (Planning)**: A minor issue with an easy workaround affecting a single user.

    -   **Major Incident Management (MIM)**: A dedicated workbench and workflow inside ServiceNow triggered when a **P1 or P2** incident occurs. It introduces a specialized role—the **Major Incident Manager**—and opens a collaborative workspace featuring integrated communications, quick-link bridge lines, and targeted impact dashboards to coordinate rapid restoration teams.

3. **The Lifecycle States of an Incident**: An incident record transitions through a prescriptive state model as it moves from creation to final archive.

    ```
    [ New ] ➔ [ In Progress ] ➔ [ On Hold ] ➔ [ Resolved ] ➔ [ Closed ]

    ```

    -   **New**: The incident has been logged (via Service Portal, inbound email, an integration monitor, or a Service Desk call) but has not yet been triaged or worked on by an engineer.

    -   **In Progress**: The ticket has been assigned to an engineer, and active investigation or troubleshooting has begun.

    -   **On Hold**: Work on the incident is temporarily paused. When a ticket is placed **On Hold**, a mandatory **On Hold Reason** dropdown must be populated. This state pauses specific SLA clocks depending on the selection:

        * **Awaiting Caller:** The engineer is waiting for the user to provide more information, logs, or verify a fix. *(SLA typically pauses)*
        * **Awaiting Evidence:** The team is waiting for logs or hardware diagnostics to complete.
        * **Awaiting Problem:** The incident is tied to an active, underlying Problem investigation.
        * **Awaiting Vendor:** The issue requires a fix or hardware replacement from an external third-party vendor (e.g., Microsoft or AWS).

    -   **Resolved**: The engineer has identified and applied a workaround or a permanent fix, and service is restored.

        * **Required Fields:** The agent must provide a **Resolution Code** (e.g., *Solved by Workaround, Solved Permanently, Hardware Replaced*) and detailed **Resolution Notes**.
        * **The User Clock:** Moving a ticket to Resolved stops the resolution SLA clock and notifies the Caller.

    -   **Closed**: The final state of the record. After an incident sits in *Resolved* for a predefined number of days (typically 5 to 7 days OOTB) without the user contesting the fix, ServiceNow automatically runs a background script to update the state to **Closed**. Once Closed, the record is locked and cannot be reopened; any recurring issues require a new incident ticket.

4. **Platform Automation & SLA Integration**: ServiceNow uses background intelligence to ensure incidents are resolved within agreed timeframes.

    -   **Service Level Agreements (SLAs)**: Every incident evaluates against defined **SLA Definitions (`contract_sla`)** based on its Priority.

        * **SLA Timers:** A P1 incident might trigger a 1-hour resolution SLA, while a P3 might have a 3-day SLA.
        * **Visual Indicators:** The incident form displays an embedded *Task SLAs* related list showing elapsed time, remaining time, and a color-coded percentage bar indicating how close the ticket is to breaching its contract.

    -   **Knowledge Management Integration**:

        * **Agent Assist:** An embedded contextual search panel on the incident form. As the agent types the short description, ServiceNow automatically surface relevant entries from the **Knowledge Base (KB)**.
        * **Knowledge Creation:** If an engineer resolves a novel or complex issue, they can check a **"Knowledge"** box upon resolution to automatically generate a draft KB article from their resolution notes, streamlining future troubleshooting.