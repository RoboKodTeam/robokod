@echo off
chcp 65001>nul

setlocal EnableExtensions EnableDelayedExpansion

if not exist "C:\Program Files (x86)" (
    echo.^(x^) Processor architecture %processor_architecture% is not supported
    exit /b
)

set $FALSE=0
set $TRUE=1

pushd "%~dp0"

set $PROPS=console.properties
set $PROPS_GIT_ROOT=git
set $PROPS_GODOT_ROOT=godot
set $PROPS_REPO_REMOTE=

::Read custom console properties if available
for /f "delims=" %%i in ('type "%$PROPS%" 2^>nul') do call set "$PROPS_%%i"



::Check Git availability
git>nul 2>nul
::Append Git root to PATH if no Git found (must not include brackets)
if !errorLevel! == 9009 if exist "%$PROPS_GIT_ROOT%" path %$PROPS_GIT_ROOT%;%PATH%

::Ensure Git availability
git>nul 2>nul
if !errorLevel! == 9009 (
    echo.^(x^) Git not found
    echo.    Use "%$PROPS%" to set the root directory as follows:
    echo.
    echo.    GIT_ROOT=[full_path_to_git_folder]
    pause>nul
    exit /b 1
)



::Ensure Godot availability
if not exist "%$PROPS_GODOT_ROOT%" (
    echo.^(x^) Godot Engine not found
    echo.    Use "%$PROPS%" to set the root directory as follows:
    echo.
    echo.    GODOT_ROOT=[full_path_to_godot_folder]
    pause>nul
    exit /b 1
)

::Get the console executable path
for %%i in ("%$PROPS_GODOT_ROOT%\*win64_console.exe") do set $GODOT_CONSOLE=%%~nxi

::Append Godot root to PATH
path %$PROPS_GODOT_ROOT%;%PATH%



::Ensure repository found
if "%$PROPS_REPO_REMOTE%" == "" (
    echo.^(x^) Repository "%$PROPS_REPO_REMOTE%" not found
    echo.    Use "%$PROPS%" to set the remote URL as follows:
    echo.
    echo.    REPO_REMOTE=[repository_url]
    pause>nul
    exit /b 1
)

git status>nul 2>nul
if !errorLevel! == 128 (
    git init
    git remote add origin "%$PROPS_REPO_REMOTE%"
    git fetch
    git switch main --force & %0
    exit /b
)

git config --global --add safe.directory "%cd:\=/%"

git status>nul 2>nul
if !errorLevel! NEQ 0 (
    echo.^(x^) Git reports something is wrong with your local repository
    echo.    Please, ensure everything is right
)



::Setup custom command shortcuts
doskey plug="%$GODOT_CONSOLE%" --headless -s plug.gd $*

doskey editor="%$GODOT_CONSOLE%" -e $*
doskey editor-opengl3="%$GODOT_CONSOLE%" -e --rendering-driver opengl3 $*

doskey game="%$GODOT_CONSOLE%" $*
doskey game-opengl3="%$GODOT_CONSOLE%" --rendering-driver opengl3 $*



::Show console help
title Project Console v2.0

echo.^(i^) Welcome to the Project Command Prompt
echo.    Here's a quick help below to help you out
echo.

echo.    git                                access Git commands
echo.    git branch --all                   show all local and remote branches
echo.    git switch -c demo origin/demo     create and switch to a specific remote branch
echo.    git fetch                          fetch updates
echo.    git pull                           update current branch
echo.
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