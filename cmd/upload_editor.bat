@echo on
SetLocal EnableDelayedExpansion

set LONGTAIL=%1
set WORK_FOLDER=%2
set VERSION=%3
set SOURCE_FOLDER=%4
set BUCKET=%5

rem gsutil cp !BUCKET!\test_bucket\store.lci !WORK_FOLDER!\store.lci
!LONGTAIL! --upsync --version "!SOURCE_FOLDER!" --version-index "!WORK_FOLDER!\!VERSION!.lvi" --content-index "!WORK_FOLDER!\store.lci" --upload-content "!WORK_FOLDER!\store"
rem gsutil cp !WORK_FOLDER!\upload\*.lrb !BUCKET!\test_bucket\store\
rem gsutil cp !WORK_FOLDER!\store.lci !BUCKET!\test_bucket\store\store.lci
rem gsutil cp !WORK_FOLDER!\!VERSION!.lvi !BUCKET!\test_bucket\!VERSION!.lvi

GOTO end



IF NOT EXIST "remote" mkdir "remote"
IF NOT EXIST "upload" mkdir "upload"

echo Indexing !SOURCE_FOLDER!
!LONGTAIL! --create-version-index "local_version.lvi" --version "!SOURCE_FOLDER!"
if %errorlevel% neq 0 exit /b %errorlevel%

echo Fetching remote content index
rem We should download remote.lci
if NOT EXISTS "remote.lci" (
	!LONGTAIL! --create-content-index "remote\remote.lci"
	if %errorlevel% neq 0 exit /b %errorlevel%
)

echo Download remote content index
copy "remote\remote.lci" "remote.lci"

echo Analyzing missing content at remote
!LONGTAIL! --create-content-index "upload.lci" --version "!SOURCE_FOLDER!" --version-index "local_version.lvi" --content-index "remote.lci"
if %errorlevel% neq 0 exit /b %errorlevel%

echo Create the missing content
!LONGTAIL! --create-content "upload" --content-index "upload.lci" --version "!SOURCE_FOLDER!" --version-index "upload.lci"

echo Creating new remote content index
!LONGTAIL! --create_content_index "remote.lci" --merge-content-index "remote.lci" --content-index "upload.lci"

echo Uploading content
IF NOT EXIST "remote\chunks" mkdir "remote\chunks"
copy upload\* remote\chunks

echo Cleaning upload folder
del upload\*.*

echo Upload new remote content index
copy "remote.lci" "remote\remote.lci"

echo Uploading version
copy "local_version.lvi" remote\!SOURCE_FOLDER!.lvi


:end
