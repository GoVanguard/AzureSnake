# AzureSnake
A suite of PowerShell scripts to automate portions of Azure Risk Assessments and Penetration Tests

![image](https://github.com/GoVanguard/AzureSnake/assets/75676514/69f6ca24-9a18-4e14-b632-ab5afef44e98)


AzureSnake assists in automating the process of aggregating large amounts of data from an Azure subscription which you have authenticated access to. Each individual script can be called interactively from AzureSnake.ps1 through the menu option which provides the following choices:

1. Setup
2. Authenticate
3. Enumerate Virtual Machines, NICS, and Public IP Addresses
4. Pull a list of Entra ID User Properties & Groups
5. Enumerate Properties of BLOBs
6. Enumerate Azure Applications & Associated Properties

**Note #1 - AzureSnake must be run from an Administrator PowerShell prompt or it will not function properly.**

**Note #2 -  The “Authenticate” option prompts an interactive login (which supports MFA) and only needs to be done once per session.**
