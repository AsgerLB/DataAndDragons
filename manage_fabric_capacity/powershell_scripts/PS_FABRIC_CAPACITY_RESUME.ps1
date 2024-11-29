# Define parameters
$subscriptionId = ""                # Your subscription ID
$resourceGroupName = ""             # Your esourcegroup of the Fabric capacity
$dedicatedCapacityName = ""         # The name of your Fabric capacity
$clientId = ""                      # Your app registration client id
$clientSecret = ""                  # Your app registration client secret
$tenantId = ""                      # Your MS tenant ID
$apiVersion = "2022-07-01-preview"  # Current API version

# Step 1: Get OAuth Token
$tokenUrl = "https://login.microsoftonline.com/$tenantId/oauth2/token"
$tokenBody = @{
    client_id     = $clientId
    client_secret = $clientSecret
    grant_type    = "client_credentials"
    resource      = "https://management.azure.com"
}

try {
    $tokenResponse = Invoke-RestMethod -Uri $tokenUrl -Method Post -ContentType "application/x-www-form-urlencoded" -Body $tokenBody
    $accessToken = $tokenResponse.access_token
    Write-Output "Access token retrieved successfully."
} catch {
    Write-Error "Failed to retrieve access token. $_"
    exit
}

# Step 2: Suspend Fabric Capacity with Body
$suspendUrl = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Fabric/capacities/$dedicatedCapacityName/resume?api-version=$apiVersion"

# Define the body as per the JSON configuration
$suspendBody = @{
    dummy = $true  # Replace with actual body content if necessary
}

try {
    $headers = @{
        Authorization = "Bearer $accessToken"
    }

    # Perform the POST request with the body included
    $suspendResponse = Invoke-RestMethod -Uri $suspendUrl -Method Post -Headers $headers -Body ($suspendBody | ConvertTo-Json) -ContentType "application/json"
    Write-Output "Fabric capacity resumed successfully."
} catch {
    Write-Error "Failed to resume Fabric capacity. $_"
}
