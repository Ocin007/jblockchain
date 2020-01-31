@echo off
set /p port="set port: "
(
    echo server.port=%port%
) > node/src/main/resources/application.properties
echo "Don't forget to build (mvnw package)"
pause