Write-host "   ___                                                               
 -   -_,                               -_-/              ,,         
(  ~/||                               (_ /           _   ||         
(  / ||  /\\ \\ \\ ,._-_  _-_        (_ --_  \\/\\  < \, ||/\  _-_  
 \/==||   /  || ||  ||   || \\         --_ ) || ||  /-|| ||_< || \\ 
 /_ _||  /\\ || ||  ||   ||/          _/  )) || || (( || || | ||/   
(  - \\,  || \\/\\  \\,  \\,/        (_-_-   \\ \\  \/\\ \\,\ \\,/  
          /                                                         
         (,                                                         
                                 
                                                                     "

# Check if Microsoft.Graph module is installed
#if (-not (Get-Module -ListAvailable Microsoft.Graph)) {
#    Write-Host "Microsoft Graph module is not installed. Installing..."
#    Install-Module Microsoft.Graph -Scope CurrentUser -Force
#} else {
#    Write-Host "Microsoft Graph module is already installed."
#}

# Check if Microsoft.Graph.Beta module is installed
#if (-not (Get-Module -ListAvailable Microsoft.Graph.Beta)) {
#    Write-Host "Microsoft Graph Beta module is not installed. Installing..."
#    Install-Module Microsoft.Graph.Beta -Scope CurrentUser -Force
#} else {
#    Write-Host "Microsoft Graph Beta module is already installed."
#}

# Check if the Az.ResourceGraph module is installed
#$moduleInstalled = Get-InstalledModule -Name 'Az.ResourceGraph' -ErrorAction SilentlyContinue

#if ($moduleInstalled) {
#    Write-Host "Az.ResourceGraph module is already installed."
#} else {
#    # Install the module
#    Install-Module -Name Az.ResourceGraph -Scope CurrentUser -Repository PSGallery -Force
#    Write-Host "Az.ResourceGraph module has been installed."
#}

#Authenticate to Azure
#Import-Module Az -verbose
#Connect-AzAccount

# Query 1: # Get all storage accounts 
$query1Result = $storageAccounts = Get-AzStorageAccount

# Display properties for each storage account
foreach ($account in $storageAccounts) {
    Write-Host "Storage Account Name: $($account.StorageAccountName)"
    Write-Host "Resource ID: $($account.Id)"
    Write-Host "Location: $($account.Location)"
    Write-Host "Account Kind: $($account.Kind)"
    Write-Host "Replication Type: $($account.Sku.Name)"
    Write-Host "Public Access Enabled: $($account.EnableHttpsTrafficOnly)"
    
}

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
