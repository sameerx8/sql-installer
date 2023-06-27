function Install-SqlServerInstance {
    param (
        [Parameter(Mandatory=$true)]
        [string]$InstanceName,
        
        [Parameter(Mandatory=$true)]
        [securestring]$SaPassword,
        
        [Parameter(Mandatory=$true)]
        [string]$InstallerPath,

        [Parameter(Mandatory=$true)]
        [string]$LogFilePath,

        [Parameter(Mandatory=$false)]
        [int]$SQLMaxMemory=1024

    )

    if (-not (Test-Path $InstallerPath)) {
        Write-Host "Installer not found at $InstallerPath. Please make sure the installer is available at the specified path."
        return
    }

    Write-Host "Installing SQL Server instance: $InstanceName"
  
    $installCommand = "$InstallerPath /qs /ACTION=Install /FEATURES=SQLEngine /INSTANCENAME=$InstanceName /SECURITYMODE='SQL' /SQLSVCACCOUNT='NT AUTHORITY\SYSTEM' /SQLSYSADMINACCOUNTS='BUILTIN\Administrators' /AGTSVCACCOUNT='NT AUTHORITY\Network Service' /SAPWD='$($SaPassword | ConvertFrom-SecureString)' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS /SQLMAXMEMORY='$SQLMaxMemory' /INDICATEPROGRESS /IACCEPTROPENLICENSETERMS"   

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
    
    $Uninstallcommand = "$InstallerPath /ACTION=Uninstall /FEATURES=SQLEngine /INSTANCENAME=$InstanceName /Q /INDICATEPROGRESS"
    
    Invoke-Expression $Uninstallcommand
}

$SaPwd = "P@ssw0rd12345" | ConvertTo-SecureString -AsPlainText -Force
Install-SqlServerInstance -InstanceName 'SMALLINSTANCE1' -InstallerPath "d:\setup.exe" -SaPassword $SaPwd -LogFilePath "F:\dev\sql-stuff\install.log" -SQLMaxMemory 1024
#Uninstall-SqlServerInstance -InstanceName 'SMALLINSTANCE1' -InstallerPath "d:\setup.exe"
#P@ssw0rd12345
