# Function to install a SQL Server 2019 instance
function Install-SqlServerInstance {
    param (
        [Parameter(Mandatory=$true)]
        [string]$InstanceName,

        [Parameter(Mandatory=$false)]
        [string]$InstallerPath= "d:\setup.exe",

        [Parameter(Mandatory=$true)]
        [securestring]$SaPassword
    )

    Write-Host "Installing SQL Server instance: $InstanceName"

    # Change the path to the installer according to your system
    #get sql server 2019 installer path
    $InstallerPath = "d:\setup.exe"
    
    # Install command
    $installCommand = "$InstallerPath /qs /ACTION=Install /FEATURES=SQLEngine /INSTANCENAME=$InstanceName /SQLSVCACCOUNT='NT AUTHORITY\SYSTEM' /SQLSYSADMINACCOUNTS='BUILTIN\Administrators' /AGTSVCACCOUNT='NT AUTHORITY\Network Service' /SAPWD=$SaPassword /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS"
    
    # Run the install command
    Invoke-Expression $installCommand
}

function Uninstall-SqlServerInstance {
    param (
        [Parameter(Mandatory=$true)]
        [string]$InstanceName
    )

    Write-Host "Uninstalling SQL Server instance: $InstanceName"

    # Change the path to the installer according to your system
    #get sql server 2019 installer path
    $InstallerPath = "d:\setup.exe"
    
    # Install command
    $Uninstallcommand = "$InstallerPath /ACTION=Uninstall /FEATURES=SQLEngine /INSTANCENAME=$InstanceName /Q"
    
    # Run the install comman

    Invoke-Expression $Uninstallcommand
}

# Function to remove a SQL Server instance

Install-SqlServerInstance -InstanceName 'SQLBOBBY' -InstallerPath "d:\setup.exe" -SaPassword "P@ssw0rd"
#Uninstall-SqlServerInstance -InstanceName 'SQLBOBBY'

