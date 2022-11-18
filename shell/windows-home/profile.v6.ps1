# Profile for Powershell v6

# code $PROFILE

function Invoke-Starship-PreCommand {
  WriteHost "`e]0; PS`: $pwd > $env:USERNAME@$env:COMPUTERNAME `a"
}

Invoke-Expression (&starship init powershell)