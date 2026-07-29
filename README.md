# wow-logrotate

PowerShell script that deletes old World of Warcraft combat log files, keeping only the most recent one.

## What it does

Scans the current directory for files matching `WoWCombatLog-YYMMDD_HHMMSS.txt`, sorts them by creation time, and deletes all but the newest.

## Usage

Run from the directory containing your combat logs (e.g. WoW install's `Logs` folder):

```powershell
.\wow-logrotate.ps1
```

### Parameters

- `-Path <string>` directory to scan (default: current directory)
- `-KeepCount <int>` number of newest logs to keep (default: 1)
- `-LogFile <string>` path to append delete/failure records to (default: no logging)
- `-WhatIf` preview what would be deleted without deleting anything

```powershell
.\wow-logrotate.ps1 -Path "C:\WoW\Logs" -KeepCount 3 -LogFile "C:\WoW\Logs\rotate.log" -WhatIf
```

Schedule it (Task Scheduler, cron via WSL, etc.) to run periodically and keep log directory from filling up disk space.
