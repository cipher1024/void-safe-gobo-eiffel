echo off
setlocal
if -%1- == -- goto default
set GOBOSAFE=%1
goto start
:default
set GOBOSAFE=%CD%\gobo-void-safe-project

:start
echo Installing gobo/svn/git into %GOBOSAFE%
mkdir %GOBOSAFE%
cd /d %GOBOSAFE%
svn co https://svn.eiffel.com/eiffelstudio/trunk/Src/library/gobo gobo-safe
cd gobo-safe
svn ps svn:externals "svn https://gobo-eiffel.svn.sourceforge.net/svnroot/gobo-eiffel/gobo/trunk" .
svn update
git clone git://github.com/jocelyn/void-safe-gobo-eiffel.git
cd void-safe-gobo-eiffel
move /Y * ..
move /Y .git ..
xcopy /Y/E/I/R/H override ..\override
xcopy /Y/E/I/R/H svn ..\svn
cd ..
rd /q/s void-safe-gobo-eiffel
endlocal
