function Show-Menu {
    param (
        [string]$Title = 'AzureSnake'
    )

    Clear-Host
    
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
    Write-Host "1: Setup and Authenticate "
    Write-Host "2: Enumerate Virtual Machines, NICS, and Public IP Addresses"
    Write-Host "3: Pull a list of Entra ID User Properties & Groups"
    Write-Host "4: Enumerate Properties of BLOBs"
    Write-Host "5: Enumerate Azure Applications & Associated Properties"
    # Add more options  if needed
    Write-Host "Q: Quit"

                                                                     }

# Display the menu
Show-Menu

# Prompt user for input
$selection = Read-Host "Please enter the number of the attack/technique you want to execute"

# Execute the selected script based on user input
switch ($selection) {
    '1' {
        # Invoke Script 1
        .\Setup.ps1
    }
    '2' {
        # Invoke Script 2
        .\SnakePublicIPs.ps1
    }
    '3' {
        # Invoke Script 3
        .\SnakeEntraIDUsers.ps1
    }
    '4' {
        # Invoke Script 3
        .\SnakeBlobEnum.ps1
    }
    '5' {
        # Invoke Script 3
        .\SnakeApplications.ps1
    }

    # Add more cases for scripts if needed
    'Q' {
        # Quit
        Write-Host "Exiting the menu."
    }
    default {
        Write-Host "Invalid selection. Please choose a valid option."
    }
}
