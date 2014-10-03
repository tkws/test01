cd /d %~dp0
@echo off

rem サーバの役割と機能
rem cmd /c "echo . | powershell hostname ; Import-Module servermanager ; Get-WindowsFeature ^| FT -auto" > %computername%_get-feature.txt

rem サーバの役割と機能 書式2
rem cmd /c "echo . | powershell hostname ; Import-Module servermanager ; Get-WindowsFeature ^| FT -Wrap" > %computername%_get-feature-Wrap.txt

rem services
cmd /c "echo . | powershell hostname ; Get-WmiObject win32_service ^| select-object DisplayName, startMode, state ^| FT -auto " > %computername%_servicestate.txt

rem Hotfixs
cmd /c "echo . | powershell Get-Hotfix ^| FT -auto " > %computername%_get-hotfix.txt


rem Ps-Info-disks
psinfo -d > %computername%_disks.txt

rem Ps-Info-Software
rem psinfo -s > %computername%_software.txt


rem IPCONFIG
ipconfig /all > %computername%_ipconfig.txt

rem Install-software
echo %computer_name% > %computername%_ProgramList-detail.txt 
set A=%PROCESSOR_ARCHITECTURE%
IF %A% == x86 (
pglst\PGLST.exe /ru /vw /vn >> %computername%_ProgramList-detail.txt
) else (
pglst\PGLST64.exe /ru /vw /vn >> %computername%_ProgramList-detail.txt
)


rem get serialno
rem wmic csproduct get IdentifyingNumber > %computername%_serialNo.txt

rem get serialno for posershell
powershell "$s=Get-WmiObject -class Win32_BIOS; $h=hostname ; write-host $h ; write-host $s.SerialNumber" > %computername%_serialNo.txt
