param([switch]$Elevated)

function Test-Admin {
    $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
    $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false) {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    }
    else {
        Start-Process pwsh -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition)) -WorkingDirectory $PWD
    }
    exit
}

$out = .\service_remove.cmd
$out += .\service_production.cmd
$out | Select-String -Pattern "success" -SimpleMatch

Write-Host "$($PSStyle.Foreground.BrightGreen)$($PSStyle.Blink)##########################`n# Script execution done  #`n# Press any key to close #`n##########################$($PSStyle.Reset)"

$host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

(Get-Host).SetShouldExit(0)
