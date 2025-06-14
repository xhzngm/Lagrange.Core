@echo off
chcp 65001
echo ====================================
echo  Lagrange.OneBot 多平台编译脚本
echo ====================================
echo.

set PROJECT_PATH=Lagrange.OneBot/Lagrange.OneBot.csproj
set TARGET_FRAMEWORK=net9.0
set CONFIGURATION=Release

echo 开始编译所有平台...
echo.

echo [1/6] 编译 Windows x64...
dotnet publish %PROJECT_PATH% -f %TARGET_FRAMEWORK% -c %CONFIGURATION% -r win-x64 --self-contained -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:DebugType=None -p:DebugSymbols=false -o ./publish-net9-win-x64
if %ERRORLEVEL% NEQ 0 (
    echo 错误: Windows x64 编译失败
    pause
    exit /b 1
)
echo Windows x64 编译完成!
echo.

echo [2/6] 编译 Windows ARM64...
dotnet publish %PROJECT_PATH% -f %TARGET_FRAMEWORK% -c %CONFIGURATION% -r win-arm64 --self-contained -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:DebugType=None -p:DebugSymbols=false -o ./publish-net9-win-arm64
if %ERRORLEVEL% NEQ 0 (
    echo 错误: Windows ARM64 编译失败
    pause
    exit /b 1
)
echo Windows ARM64 编译完成!
echo.

echo [3/6] 编译 Linux x64...
dotnet publish %PROJECT_PATH% -f %TARGET_FRAMEWORK% -c %CONFIGURATION% -r linux-x64 --self-contained -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:DebugType=None -p:DebugSymbols=false -o ./publish-net9-linux-x64
if %ERRORLEVEL% NEQ 0 (
    echo 错误: Linux x64 编译失败
    pause
    exit /b 1
)
echo Linux x64 编译完成!
echo.

echo [4/6] 编译 Linux ARM64...
dotnet publish %PROJECT_PATH% -f %TARGET_FRAMEWORK% -c %CONFIGURATION% -r linux-arm64 --self-contained -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:DebugType=None -p:DebugSymbols=false -o ./publish-net9-linux-arm64
if %ERRORLEVEL% NEQ 0 (
    echo 错误: Linux ARM64 编译失败
    pause
    exit /b 1
)
echo Linux ARM64 编译完成!
echo.

echo [5/6] 编译 macOS x64...
dotnet publish %PROJECT_PATH% -f %TARGET_FRAMEWORK% -c %CONFIGURATION% -r osx-x64 --self-contained -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:DebugType=None -p:DebugSymbols=false -o ./publish-net9-osx-x64
if %ERRORLEVEL% NEQ 0 (
    echo 错误: macOS x64 编译失败
    pause
    exit /b 1
)
echo macOS x64 编译完成!
echo.

echo [6/6] 编译 macOS ARM64...
dotnet publish %PROJECT_PATH% -f %TARGET_FRAMEWORK% -c %CONFIGURATION% -r osx-arm64 --self-contained -p:PublishSingleFile=true -p:IncludeNativeLibrariesForSelfExtract=true -p:DebugType=None -p:DebugSymbols=false -o ./publish-net9-osx-arm64
if %ERRORLEVEL% NEQ 0 (
    echo 错误: macOS ARM64 编译失败
    pause
    exit /b 1
)
echo macOS ARM64 编译完成!
echo.

echo ====================================
echo  所有平台编译完成！
echo ====================================
echo.
echo 编译结果位置:
echo - Windows x64:    ./publish-net9-win-x64/
echo - Windows ARM64:  ./publish-net9-win-arm64/
echo - Linux x64:      ./publish-net9-linux-x64/
echo - Linux ARM64:    ./publish-net9-linux-arm64/
echo - macOS x64:      ./publish-net9-osx-x64/
echo - macOS ARM64:    ./publish-net9-osx-arm64/
echo.

echo 是否要创建压缩包? (Y/N)
set /p CREATE_ZIP=
if /i "%CREATE_ZIP%"=="Y" (
    echo.
    echo 正在创建压缩包...
    
    powershell -Command "Compress-Archive -Path './publish-net9-win-x64/*' -DestinationPath 'publish-net9-win-x64.zip' -Force"
    powershell -Command "Compress-Archive -Path './publish-net9-win-arm64/*' -DestinationPath 'publish-net9-win-arm64.zip' -Force"
    powershell -Command "Compress-Archive -Path './publish-net9-linux-x64/*' -DestinationPath 'publish-net9-linux-x64.zip' -Force"
    powershell -Command "Compress-Archive -Path './publish-net9-linux-arm64/*' -DestinationPath 'publish-net9-linux-arm64.zip' -Force"
    powershell -Command "Compress-Archive -Path './publish-net9-osx-x64/*' -DestinationPath 'publish-net9-osx-x64.zip' -Force"
    powershell -Command "Compress-Archive -Path './publish-net9-osx-arm64/*' -DestinationPath 'publish-net9-osx-arm64.zip' -Force"
    echo.
    echo 压缩包创建完成!
    echo - publish-net9-win-x64.zip
    echo - publish-net9-win-arm64.zip
    echo - publish-net9-linux-x64.zip
    echo - publish-net9-linux-arm64.zip
    echo - publish-net9-osx-x64.zip
    echo - publish-net9-osx-arm64.zip
)

echo.
echo ====================================
echo  编译脚本执行完成！
echo ====================================
pause
