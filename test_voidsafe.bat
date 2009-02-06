setlocal
@echo off
set EC_CMD=ec -batch -melt -project_path safe-test
set EC_CMD=%EC_CMD% -clean
set EC_CMD=%EC_CMD% -config
set LOGTHIS=logs\
mkdir logs

@echo Checking Kernel
%EC_CMD% gobo_kernel-safe.ecf > %LOGTHIS%kernel 2>&1
type %LOGTHIS%kernel
echo.

@echo Checking Structure
%EC_CMD% gobo_structure-safe.ecf > %LOGTHIS%structure 2>&1
type %LOGTHIS%structure
echo. 

@echo Checking Utility
%EC_CMD% gobo_utility-safe.ecf > %LOGTHIS%utility 2>&1
type %LOGTHIS%utility
@echo. 

@echo Checking Time
%EC_CMD% gobo_time-safe.ecf > %LOGTHIS%time 2>&1
type %LOGTHIS%time
@echo. 

@echo Checking Argument
%EC_CMD% gobo_argument-safe.ecf > %LOGTHIS%argument 2>&1
type %LOGTHIS%argument
@echo. 

@echo Checking Lexical
%EC_CMD% gobo_lexical-safe.ecf > %LOGTHIS%lexical 2>&1
type %LOGTHIS%lexical
@echo. 

@echo Checking Parse
%EC_CMD% gobo_parse-safe.ecf > %LOGTHIS%parse 2>&1
type %LOGTHIS%parse
@echo. 

@echo Checking Pattern
%EC_CMD% gobo_pattern-safe.ecf > %LOGTHIS%pattern 2>&1
type %LOGTHIS%pattern
@echo. 

@echo Checking Regexp
%EC_CMD% gobo_regexp-safe.ecf > %LOGTHIS%regexp 2>&1
type %LOGTHIS%regexp
@echo. 

@echo Checking String
%EC_CMD% gobo_string-safe.ecf > %LOGTHIS%string 2>&1
type %LOGTHIS%string
@echo. 

@echo Checking Xml
%EC_CMD% gobo_xml-safe.ecf > %LOGTHIS%xml 2>&1
type %LOGTHIS%xml
@echo.

@echo Skipping Math
%EC_CMD% gobo_math-safe.ecf > %LOGTHIS%math 2>&1
type %LOGTHIS%math
@echo.


@echo Skipping Test
rem TODO %EC_CMD% gobo_test-safe.ecf > %LOGTHIS%test 2>&1
rem type %LOGTHIS%test
rem @echo.

@echo Skipping Sample
rem TODO %EC_CMD% gobo_sample-safe.ecf > %LOGTHIS%sample 2>&1
rem type %LOGTHIS%sample
rem @echo.

@echo Skipping Expat
rem TODO %EC_CMD% gobo_with_expat-safe.ecf > %LOGTHIS%with_expat 2>&1
rem type %LOGTHIS%with_expat
rem @echo.


@echo Checking Gobo ...in progress
%EC_CMD% gobo-safe.ecf
@echo Skipping Gobo all
%EC_CMD% gobo_all-safe.ecf > %LOGTHIS%all 2>&1
@type %LOGTHIS%all
@echo.

endlocal
