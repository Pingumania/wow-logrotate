$filesToDelete = @()
$filesToDelete += Get-ChildItem -LiteralPath . | Where-Object { $_.Name -match '^WoWCombatLog\-[0-9]{6}_[0-9]{6}\.txt$' } | Sort-Object CreationTime -Descending | Select-Object -Skip 1

foreach ($file in $filesToDelete)
{
	if (Test-Path -LiteralPath $file.FullName) {
		$deletedFile = Remove-Item -LiteralPath $file.FullName -Force
	}
}
