FROM mcr.microsoft.com/windows/servercore:ltsc2022

# CMake
RUN mkdir CMake
RUN cd CMake && curl -LO https://github.com/Kitware/CMake/releases/download/v3.26.0-rc1/cmake-3.26.0-rc1-windows-x86_64.zip
RUN cd CMake && tar -xf cmake-3.26.0-rc1-windows-x86_64.zip

# Ninja
RUN mkdir Ninja
RUN cd Ninja && curl -LO https://github.com/ninja-build/ninja/releases/download/v1.12.1/ninja-win.zip
RUN cd Ninja && tar -xf ninja-win.zip

# Skia
RUN mkdir deps 
RUN mkdir deps\skia
RUN cd deps\skia && curl -LO https://github.com/aseprite/skia/releases/download/m102-861e4743af/Skia-Windows-Release-x64.zip
RUN cd deps\skia && tar -xf Skia-Windows-Release-x64.zip

# Git
RUN mkdir git
RUN cd git && curl -LO https://github.com/git-for-windows/git/releases/download/v2.33.0.windows.2/MinGit-2.33.0.2-64-bit.zip
RUN cd git && tar -xf MinGit-2.33.0.2-64-bit.zip

# escape=`

# Download the Build Tools bootstrapper.
RUN curl -SL --output vs_buildtools.exe https://aka.ms/vs/17/release/vs_buildtools.exe
# RUN (start /w vs_buildtools.exe --quiet --wait --norestart --nocache --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" --add Microsoft.VisualStudio.Workload.VCTools --add || IF "%ERRORLEVEL%"=="3010" EXIT 0)
# Cleanup
# RUN del /q vs_buildtools.exe

# Install Build Tools with the Microsoft.VisualStudio.Workload.VCTools workload, including optional components.
RUN (start /w vs_buildtools.exe --quiet --wait --norestart --nocache \
        --installPath "%ProgramFiles(x86)%\Microsoft Visual Studio\2022\BuildTools" \
        --add Microsoft.VisualStudio.Workload.VCTools \
        --add Microsoft.VisualStudio.Component.VC.Tools.x86.x64 \
        --add Microsoft.VisualStudio.Component.VC.ATL \
        --add Microsoft.VisualStudio.Component.Windows10SDK.18362 \
        --add Microsoft.VisualStudio.Component.VC.CMake.Project \
        || IF "%ERRORLEVEL%"=="3010" EXIT 0)

# Add cmake, ninja, and git to Path
RUN setx /M PATH "C:\CMake\cmake-3.26.0-rc1-windows-x86_64\bin;C:\Ninja;C:\git\cmd;%PATH%"

# pass in via docker-compose instead
COPY scripts/build.bat .
ENTRYPOINT ["cmd", "/c", "build.bat"]
