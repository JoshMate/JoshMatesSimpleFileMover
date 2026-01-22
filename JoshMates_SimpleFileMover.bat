@echo off
setlocal enabledelayedexpansion

:: When you run this script it will search through all childeren folders in the directory the script was run.
:: For each file it finds, it will move it back up to the directory containing the script.
:: Then it will give you a report on what it has moved.

:: Get the current directory
set "parent_dir=%cd%"

:: Set up counters for end report
set /a moved_count=0

:: Tell the user about the script and where we are moving the files to
echo ##################################################
echo Josh Mate's Sample Mover (version 1.0.0)
echo ##################################################
echo Moving Files to: "%cd%"
echo ##################################################

:: Loop through all files in child directories and move them to the parent directory
for /r "%parent_dir%" %%f in (*) do (
    if not "%%~dpf"=="%parent_dir%\" (
        :: The Nul >nul 2>&1 part is to stop the anoying "File Moved Log"
        move "%%f" "%parent_dir%\" >nul 2>&1
        :: On Success Print status and update counters
        if not errorlevel 1 (
            echo Moved "%%~nxf"
            set /a moved_count+=1
        )
    )
)

:: If no files were moved then tell the user
if %moved_count%==0 (
    echo No files found to move
)

:: Show end report to the user
echo ##################################################
echo Done, we moved: %moved_count% file(s)
echo ##################################################
pause
