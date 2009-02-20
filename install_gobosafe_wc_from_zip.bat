echo off
setlocal
if -%1- == -- goto default
set GOBOSAFE=%1
goto start
:default
set GOBOGIT=%~dp0
set GOBOSAFE=%GOBOGIT%\..\gobo-void-safe

:start
echo Installing gobo/svn/git into %GOBOSAFE%
mkdir %GOBOSAFE%
cd /d %GOBOSAFE%
svn co https://svn.eiffel.com/eiffelstudio/trunk/Src/library/gobo .
cd gobo-safe
svn ps svn:externals "svn https://gobo-eiffel.svn.sourceforge.net/svnroot/gobo-eiffel/gobo/trunk" .
svn update
cd %GOBOGIT%
move /Y .git %GOBOSAFE%
xcopy /Y/E/I/R/H override %GOBOSAFE%\override
xcopy /Y/E/I/R/H svn %GOBOSAFE%\svn
copy /Y * %GOBOSAFE%
cd %GOBOGIT%\..
echo Now, you can remove folder %GOBOGIT% , and go to %GOBOSAFE%
endlocal
