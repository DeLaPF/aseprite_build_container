:: Check if repo already exists (since this is mounted dir)
if exist C:\target\aseprite (
    echo "`aseprite` repo already found. Checking for updates..."
    cd C:\target\aseprite
    git pull
    git submodule update --init --recursive
) else (
    cd C:\target
    git clone --recursive https://github.com/aseprite/aseprite.git
)

:: Ensure build dir exists and is empty
if exist C:\target\aseprite\build (
    rmdir /s /q C:\target\aseprite\build
)
cd C:\target\aseprite
mkdir build

:: Setup build env
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\Common7\Tools\VsDevCmd.bat" -arch=x64
:: Build aseprite
cd C:\target\aseprite\build
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLAF_BACKEND=skia -DSKIA_DIR=C:\deps\skia -DSKIA_LIBRARY_DIR=C:\deps\skia\out\Release-x64 -DSKIA_LIBRARY=C:\deps\skia\out\Release-x64\skia.lib -G Ninja ..
ninja aseprite

:: Keep running to allow jumping in
cmd

:: Use xcopy to copy build folder
:: set "sourcePath=C:\aseprite\build"
:: set "destinationPath=C:\target"
:: xcopy /E /I "%sourcePath%" "%destinationPath%"
