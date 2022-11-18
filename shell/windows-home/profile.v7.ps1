# Profile for Powershell v7+

# code $PROFILE

function Invoke-Starship-PreCommand {
  $host.ui.Write("`e]0; PS`: $pwd > $env:USERNAME@$env:COMPUTERNAME `a")
}

Invoke-Expression (&starship init powershell)
