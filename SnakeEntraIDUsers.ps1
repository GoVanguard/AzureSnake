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

# Connect to Entra ID
Connect-AzureAd

# Query 1: List all EntraID Users
$query1Result = Get-AzureADUser -All $true

# Query 2: List all EntraID Groups
$query2Result = Get-MgGroup

# Display results as tables
$query1Result | Format-Table
$query2Result | Format-Table

$downloadCsv = Read-Host "Do you want to download the results as CSV files? (Y/N)"
if ($downloadCsv -eq 'Y') {
    # Save results to CSV files
    $query1Result | Export-Csv -Path "Entra_ID_Users.csv" -NoTypeInformation
    $query2Result | Export-Csv -Path "Entra_ID_Groups.csv" -NoTypeInformation

    Write-Host "Results saved as CSV files: Entra_ID_Users.csv , and Entra_ID_Groups.csv"
} else {
    Write-Host "Results not saved as CSV files."
}
