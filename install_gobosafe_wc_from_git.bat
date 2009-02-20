echo off
setlocal
if -%1- == -- goto default
set GOBOSAFE=%1
goto start
:default
set GOBOSAFE=%~dp0\gobo-void-safe-project

:start
echo Installing gobo/svn/git into %GOBOSAFE%
mkdir %GOBOSAFE%
cd /d %GOBOSAFE%
echo Get source code from EiffelStudio's subversion repository
svn co https://svn.eiffel.com/eiffelstudio/trunk/Src/library/gobo gobo-safe
cd gobo-safe
echo Change the svn folder to get Gobo's trunk, instead of gobo 3.9
svn ps svn:externals "svn https://gobo-eiffel.svn.sourceforge.net/svnroot/gobo-eiffel/gobo/trunk" .
svn update

echo Get the converted files, from git repository
call git clone git://github.com/jocelyn/void-safe-gobo-eiffel.git
echo Copy the git files over the checkout-ed files from subversion
cd void-safe-gobo-eiffel
xcopy /Y/E/I/R/H .git ..\.git
xcopy /Y/E/I/R/H override ..\override
xcopy /Y/E/I/R/H svn ..\svn
copy /Y * ..
cd ..
rd /q/s void-safe-gobo-eiffel
endlocal
