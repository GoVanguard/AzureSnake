 #Check if Microsoft.Graph module is installed
if (-not (Get-Module -ListAvailable Microsoft.Graph)) {
    Write-Host "Microsoft Graph module is not installed. Installing..."
    Install-Module Microsoft.Graph -Scope CurrentUser -Force
} else {
    Write-Host "Microsoft Graph module is already installed."
}

 #Check if Microsoft.Graph.Beta module is installed
if (-not (Get-Module -ListAvailable Microsoft.Graph.Beta)) {
    Write-Host "Microsoft Graph Beta module is not installed. Installing..."
    Install-Module Microsoft.Graph.Beta -Scope CurrentUser -Force
} else {
    Write-Host "Microsoft Graph Beta module is already installed."
}

 #Check if the Az.ResourceGraph module is installed
$moduleInstalled = Get-InstalledModule -Name 'Az.ResourceGraph' -ErrorAction SilentlyContinue

if ($moduleInstalled) {
    Write-Host "Az.ResourceGraph module is already installed."
} else {
    # Install the module
    Install-Module -Name Az.ResourceGraph -Scope CurrentUser -Repository PSGallery -Force
    Write-Host "Az.ResourceGraph module has been installed."
}

#Authenticate to Azure
Import-Module Az -verbose
Connect-AzAccount
