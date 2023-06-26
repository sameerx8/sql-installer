# Function to install a SQL Server 2019 instance
function Install-SqlServerInstance {
    param (
        [Parameter(Mandatory=$true)]
        [string]$InstanceName,
        
        [Parameter(Mandatory=$true)]
        [securestring]$SaPassword,
        
        [Parameter(Mandatory=$true)]
        [string]$InstallerPath
    )

    if (-not (Test-Path $InstallerPath)) {
        Write-Host "Installer not found at $InstallerPath. Please make sure the installer is available at the specified path."
        return
    }

    Write-Host "Installing SQL Server instance: $InstanceName"
  
    $installCommand = "$InstallerPath /qs /ACTION=Install /FEATURES=SQLEngine /INSTANCENAME=$InstanceName /SQLSVCACCOUNT='NT AUTHORITY\SYSTEM' /SQLSYSADMINACCOUNTS='BUILTIN\Administrators' /AGTSVCACCOUNT='NT AUTHORITY\Network Service' /SAPWD=$SaPassword /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS"
    
    Write-Host "Executing command: $installCommand"

    Invoke-Expression $installCommand
}

function Uninstall-SqlServerInstance {
    param (
        [Parameter(Mandatory=$true)]
        [string]$InstanceName,

        [Parameter(Mandatory=$true)]
        [string]$InstallerPath
    )

    if (-not (Test-Path $InstallerPath)) {
        Write-Host "Installer not found at $InstallerPath. Please make sure the installer is available at the specified path."
        return
    }
    
    Write-Host "Uninstalling SQL Server instance: $InstanceName"
    
    $Uninstallcommand = "$InstallerPath /ACTION=Uninstall /FEATURES=SQLEngine /INSTANCENAME=$InstanceName /Q"
    
    Invoke-Expression $Uninstallcommand
}

#$SaPwd = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force
#Install-SqlServerInstance -InstanceName 'SMALLINSTANCE1' -InstallerPath "d:\setup.exe" -SaPassword $SaPwd
#Uninstall-SqlServerInstance -InstanceName 'SMALLINSTANCE1' -InstallerPath "d:\setup.exe"

