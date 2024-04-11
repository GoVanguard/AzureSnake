# Check if the Az.ResourceGraph module is installed
$moduleInstalled = Get-InstalledModule -Name 'Az.ResourceGraph' -ErrorAction SilentlyContinue

if ($moduleInstalled) {
    Write-Host "Az.ResourceGraph module is already installed."
} else {
    # Install the module
    Install-Module -Name Az.ResourceGraph -Scope CurrentUser -Repository PSGallery -Force
    Write-Host "Az.ResourceGraph module has been installed."
}

#Authenticate to Azure
#Import-Module Az -verbose
#Connect-AzAccount

# Query 1: List Virtual Machines and Network Interfaces and their Public IP addresses
$query1Result = Search-AzGraph -Query "Resources | where type =~ 'microsoft.compute/virtualmachines' | extend nics=array_length(properties.networkProfile.networkInterfaces) | mv-expand nic=properties.networkProfile.networkInterfaces | where nics == 1 or nic.properties.primary =~ 'true' or isempty(nic) | project vmId = id, vmName = name, vmSize=tostring(properties.hardwareProfile.vmSize), nicId = tostring(nic.id) | join kind=leftouter ( Resources | where type =~ 'microsoft.network/networkinterfaces' | extend ipConfigsCount=array_length(properties.ipConfigurations) | mv-expand ipconfig=properties.ipConfigurations | where ipConfigsCount == 1 or ipconfig.properties.primary =~ 'true' | project nicId = id, publicIpId = tostring(ipconfig.properties.publicIPAddress.id)) on nicId | project-away nicId1 | summarize by vmId, vmName, vmSize, nicId, publicIpId | join kind=leftouter ( Resources | where type =~ 'microsoft.network/publicipaddresses' | project publicIpId = id, publicIpAddress = properties.ipAddress) on publicIpId | project-away publicIpId1"

# Query 2: List Network Interfaces and Subnets
$query2Result = Search-AzGraph -Query "Resources | where type =~ 'microsoft.network/networkinterfaces' | project id, ipConfigurations = properties.ipConfigurations | mvexpand ipConfigurations | project id, subnetId = tostring(ipConfigurations.properties.subnet.id) | parse kind=regex subnetId with '/virtualNetworks/' virtualNetwork '/subnets/' subnet | project id, virtualNetwork, subnet"

# Query 3: List all public IP addresses
$query3Results = Search-AzGraph -Query "Resources | where type contains 'publicIPAddresses' and isnotempty(properties.ipAddress) | project properties.ipAddress | limit 1000"

# Display results as tables
$query1Result | Format-Table
$query2Result | Format-Table
$query3Result | Format-Table

$downloadCsv = Read-Host "Do you want to download the results as CSV files? (Y/N)"
if ($downloadCsv -eq 'Y') {
    # Save results to CSV files
    $query1Result | Export-Csv -Path "VM_NIC_IPs.csv" -NoTypeInformation
    $query2Result | Export-Csv -Path "NIC_Subnets.csv" -NoTypeInformation
    $query3Result | Export-Csv -Path "Public_IPs.csv" -NoTypeInformation
    Write-Host "Results saved as CSV files: VM_NIC_IPs.csv.csv, NIC_Subnets.csv , and Public_IPs.csv"
} else {
    Write-Host "Results not saved as CSV files."
}
