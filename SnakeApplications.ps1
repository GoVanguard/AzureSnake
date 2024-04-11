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
# Authenticate to Azure (you may need to log in interactively or use service principal credentials)
Connect-AzAccount

# Get all Azure applications
$allApplications = Get-AzureADApplication

# Initialize an empty array to store application details
$applicationDetails = @()

# Iterate through each application
foreach ($app in $allApplications) {
    $appId = $app.ApplicationId
    $appDetails = Get-AzureADApplication -ObjectId $appId

    # Extract relevant details
    $displayName = $appDetails.DisplayName
    $appIdUri = $appDetails.IdentifierUris -join ', '
    $replyUrls = $appDetails.ReplyUrls -join ', '

    # Create a custom object with the extracted details
    $appInfo = [PSCustomObject]@{
        ApplicationName = $displayName
        ApplicationId = $appId
        AppIdUri = $appIdUri
        ReplyUrls = $replyUrls
    }

    # Add the custom object to the array
    $applicationDetails += $appInfo
}

# Display the application details as a table
$applicationDetails | Format-Table -AutoSize

$downloadCsv = Read-Host "Do you want to download the output as a CSV file? (Y/N)"
if ($downloadCsv -eq "Y") {
    $applicationDetails | Export-Csv -Path "applications.csv" -NoTypeInformation
    Write-Host "Output saved to applications.csv"
} else {
    Write-Host "CSV file not saved."
}
