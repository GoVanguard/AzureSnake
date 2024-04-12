$subscriptions = Get-AzSubscription

# Query 1: # Get all storage accounts 
$query1Result = $storageAccounts = Get-AzStorageAccount

# Iterate through each subscription
foreach ($subscription in $subscriptions) {
    Write-Host "Subscription Name: $($subscription.Name)"

    # Set the subscription context
    Set-AzContext -SubscriptionId $subscription.Id }

    # List all storage accounts in the subscription
    $storageAccounts = Get-AzStorageAccount
    foreach ($storageAccount in $storageAccounts) {
    Write-Host "  Storage Account Name: $($storageAccount.StorageAccountName)"
    Write-Host "Storage Account Name: $($account.StorageAccountName)"
    Write-Host "Resource ID: $($account.Id)"
    Write-Host "Location: $($account.Location)"
    Write-Host "Account Kind: $($account.Kind)"
    Write-Host "Replication Type: $($account.Sku.Name)"
    Write-Host "Public Access Enabled: $($account.EnableHttpsTrafficOnly)" }

# Display results as tables
$query1Result | Format-Table

$downloadCsv = Read-Host "Do you want to download the results as CSV files? (Y/N)"
if ($downloadCsv -eq 'Y') {
    # Save results to CSV files
    $query1Result | Export-Csv -Path "BLOB_Properties.csv" -NoTypeInformation
    
    Write-Host "Results saved as CSV file: BLOB_Properties.csv"
} else {
    Write-Host "Results not saved as CSV file."
}
