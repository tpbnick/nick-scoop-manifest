:: This is a simple batch file to update all Scoop apps.  I keep this on my desktop and run sporadically.
@echo off
powershell -Command "scoop update *"
pause
