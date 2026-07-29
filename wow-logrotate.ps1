[CmdletBinding(SupportsShouldProcess)]
param(
	[string]$Path = ".",
	[int]$KeepCount = 1,
	[string]$LogFile
)

# Find WoW combat log files, keep newest $KeepCount by LastWriteTime, mark rest for delete
$filesToDelete = @()
$filesToDelete += Get-ChildItem -LiteralPath $Path | Where-Object { $_.Name -match '^WoWCombatLog\-[0-9]{6}_[0-9]{6}\.txt$' } | Sort-Object LastWriteTime -Descending | Select-Object -Skip $KeepCount

# Delete each old log file (use -WhatIf to preview without deleting)
foreach ($file in $filesToDelete)
{
	if (Test-Path -LiteralPath $file.FullName) {
		if ($PSCmdlet.ShouldProcess($file.FullName, "Delete")) {
			try {
				Remove-Item -LiteralPath $file.FullName -Force -ErrorAction Stop
				if ($LogFile) {
					"$(Get-Date -Format o)  Deleted: $($file.FullName)" | Add-Content -LiteralPath $LogFile
				}
			} catch {
				Write-Warning "Failed to delete $($file.FullName): $_"
				if ($LogFile) {
					"$(Get-Date -Format o)  FAILED to delete: $($file.FullName) - $_" | Add-Content -LiteralPath $LogFile
				}
			}
		}
	}
}
