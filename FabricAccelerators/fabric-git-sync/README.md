# Fabric Workspace "Sync from Git" Accelerator

Tired of manually checking every Fabric workspace to see if it's in sync with the central Git repository? Worried that developers might lose work by accidentally pulling changes over their uncommitted work?

With this accelerator, you can automate the process of safely updating your workspaces from Git!

---

## Prerequisites & Configuration Guide

Before running the script, ensure the following is in place:

### 1. Configure Permissions
The script needs to scan all workspaces in your tenant. To do this, the identity running the notebook (either a user or a Service Principal) must have **Fabric Tenant Admin** permissions.

### 2. Assign a Capacity
The script must be executed in a workspace that is assigned to an active **Fabric Capacity** (F64, P1, or higher).

### 3. Install Required Libraries
The `semantic-link-labs` library is required. The provided notebook includes a step to install this automatically if it's not already in your environment.

---

## How the Accelerator Works

When executed, the Python script performs the following steps:

### 1. Scans the Tenant
It begins by listing all workspaces in your Fabric tenant.

### 2. Identifies Out-of-Sync Workspaces
It checks the Git status for each workspace to find which ones are behind the remote branch.

### 3. Performs Safe Updates
It automatically updates workspaces that are behind **only if** they have **no uncommitted local changes**. This prevents overwriting any work.

### 4. Generates Reports
After running, the script provides two important lists:

- A **DataFrame of workspaces** that have local changes and require manual review.
- A **DataFrame of workspaces** where the Git status could not be checked (usually due to configuration or permission issues).

---

## Scheduling the Script

To run this synchronization process automatically, you can schedule the notebook's execution using:

### Fabric Pipelines
Use the **"Run a notebook"** activity to trigger the script on a schedule (e.g., nightly).

### Azure DevOps Pipelines
Use the **Fabric REST APIs** to start a notebook run as part of a larger CI/CD workflow.

> 📚 Many online guides are available to help you set up scheduling with either of these tools.
