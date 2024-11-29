# Define parameters
$subscriptionId = ""                # Your subscription ID
$resourceGroupName = ""             # Your esourcegroup of the Fabric capacity
$dedicatedCapacityName = ""         # The name of your Fabric capacity
$clientId = ""                      # Your app registration client id
$clientSecret = ""                  # Your app registration client secret
$tenantId = ""                      # Your MS tenant ID
$apiVersion = "2022-07-01-preview"  # Current API version
$sku = "F4" # Change to the desired FSKU goes both up and down

# Step 1: Get the OAuth token
$authUrl = "https://login.microsoftonline.com/$tenantId/oauth2/token"
$authBody = @{
    client_id     = $clientId
    client_secret = $clientSecret
    grant_type    = "client_credentials"
    resource      = "https://management.azure.com"
}

try {
    $authResponse = Invoke-RestMethod -Uri $authUrl -Method Post -Body $authBody -ContentType "application/x-www-form-urlencoded"
    $token = $authResponse.access_token
    Write-Output "Access token obtained successfully."
} catch {
    Write-Output "Error retrieving access token: $_"
    exit
}

# Step 2: Update the capacity SKU using the token
$capacityUrl = "https://management.azure.com/subscriptions/$subscriptionId/resourceGroups/$resourceGroupName/providers/Microsoft.Fabric/capacities/$dedicatedCapacityName/?api-version=2022-07-01-preview"
$headers = @{
    Authorization = "Bearer $token"
    "Content-Type" = "application/json"
}

#Write-Output "test $capacityUrl"

$body = @{
    sku = @{
        name = $sku
    }
} | ConvertTo-Json

try {
    $capacityResponse = Invoke-RestMethod -Uri $capacityUrl -Method Patch -Headers $headers -Body $body
    Write-Output "Capacity SKU updated successfully."
    Write-Output $capacityResponse
} catch {
    Write-Output "Error updating capacity SKU: $_"
}
