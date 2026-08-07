@echo off
REM Daily B2B Outreach Automation - Daily Orchestrator
REM This runs the full automation engine (merge -> select -> send -> update)

cd /d "%~dp0"

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0run-automation.ps1"

pause
