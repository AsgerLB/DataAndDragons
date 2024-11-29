# Fabric Capacity Management using powershell scripts
Are you interested in running a cost-optimized Fabric capacity that can scale dynamically or automatically? Or perhaps pausing the capacity at night is more your style?

With the following PowerShell scripts, you can do just that!

## Prerequisites/ configuration guide:
-	Add an app registration in the Azure Active Directory.
    - Copy the "Application (client) ID" and "Directory (tenant) ID" from the overview page for later use.
    - Create a new Client Secret on the "Certificates & secrets" page. Give it a random description and 24 months to expiration. Save the secret "value" (not the secret id) for later use.
-	Add the app registration to your Microsoft Fabric Capacity in the Azure portal.
    - In the Access Control (IAM) menu add the app (service principal) that you just created as contributor, allowing the app to modify the capacity.
    - Update the placeholder values in each powershell script (found in line 1 to 8 under "# Define parameters" to fit your app registration, Fabric capacity and optionally FSKU size
 
-----------------------------------------------------------------------------------------------------

## Documentation

### PS_FABRIC_CAPACITY_RESUME.ps1
This PowerShell script, when executed, will attempt to resume the configured Fabric capacity.

### PS_FABRIC_CAPACITY_PAUSE.ps1
This PowerShell script, when executed, will attempt to pause the configured Fabric capacity.

### PS_FABRIC_CAPACITY_SCALE.ps1
This script, when executed, will attempt to scale the configured Fabric capacity up or down to a predefined FSKU.

### PS_FABRIC_CAPACITY_SACLE.ps1
This script, when executed, will attempt to scale the configured Fabric capacity up or down based on user input. Alternatively, it can be modified to receive parameters during execution.

-----------------------------------------------------------------------------------------------------

## Scheduling the scripts
To schedule the scripts, you can use either Azure Automation or Microsoft Scheduler. There are plenty of online guides available to help you set this up.
