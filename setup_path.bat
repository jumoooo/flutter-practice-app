@echo off
REM Flutter SDK PATH 설정 스크립트
REM 이 스크립트를 실행하면 현재 세션에서 Flutter를 사용할 수 있습니다.

set FLUTTER_PATH=E:\Flutter_Project\training\chapter_1\flutter\bin
set PATH=%FLUTTER_PATH%;%PATH%

echo Flutter SDK PATH가 설정되었습니다!
echo.
echo Flutter 버전 확인:
flutter --version
echo.
echo 이제 flutter 명령어를 사용할 수 있습니다.
echo 예: flutter run, flutter doctor 등
