@echo off
chcp 65001>nul

setlocal EnableExtensions EnableDelayedExpansion

if not exist "C:\Program Files (x86)" (
    echo.^(x^) Processor architecture %processor_architecture% is not supported
    exit /b
)

pushd "%~dp0"

set $CONSOLE_PROPS=console.properties

title Project Command Prompt v1.2
cls



rem Read custom console properties if available
for /f "delims=" %%i in ('type "%$CONSOLE_PROPS%" 2^>nul') do call set %%i

rem Ensure engine root is specified
if not exist "%$ENGINE_ROOT%" (
    echo.^(x^) Engine root not found
    echo.    Use %$CONSOLE_PROPS% to set the root dir as follows: $ENGINE_ROOT=[path]
    exit /b
)

rem Apply wildcard* transformations
for /d %%i in ("%$ENGINE_ROOT%") do set $ENGINE_ROOT=%%~fi

rem Get the engine console path
for %%i in ("%$ENGINE_ROOT%\*win64_console.exe") do set $ENGINE_CONSOLE=%%~nxi


rem Append engine root to the path
path %$ENGINE_ROOT%;%PATH%


rem Setup custom command shortcuts
doskey plug="%$ENGINE_CONSOLE%" --headless -s plug.gd $*

doskey editor="%$ENGINE_CONSOLE%" -e $*
doskey editor-opengl3="%$ENGINE_CONSOLE%" -e --rendering-driver opengl3 $*

doskey game="%$ENGINE_CONSOLE%" $*
doskey game-opengl3="%$ENGINE_CONSOLE%" --rendering-driver opengl3 $*



echo.^(i^) Welcome to the Project Command Prompt
echo.    Here's a quick help below to help you out
echo.

git>nul 2>nul
if %errorLevel% NEQ 9009 (
    echo.    git                                access the VCS
    echo.    git branch --all                   show all local and remote branches
    echo.    git switch -c demo origin/demo     create and switch to a specific remote branch
    echo.    git fetch                          fetch updates
    echo.    git pull                           update current branch
    echo.
)

echo.    plug                               access plugin manager
echo.    plug install                       install dependencies
echo.    plug uninstall                     uninstall dependencies
echo.
echo.    editor                             open the project in the editor
echo.    editor-opengl3                     open the project in the editor with OpenGL ES 3 support
echo.
echo.    game                               run the game
echo.    game-opengl3                       run the game with OpenGL ES 3 support
echo.

cmd /k "prompt projectCMD ^> "