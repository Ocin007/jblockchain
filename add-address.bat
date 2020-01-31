@echo off
set /p fullname="full username: "
set /p node=<node-address.txt
:: set node=http://localhost:8080
IF NOT EXIST users\ (
    md users
)
set user_dir=users\%fullname%
IF EXIST "%user_dir%\" (
    echo %fullname% already exist
) ELSE (
    md "%user_dir%"
    cd "%user_dir%"
    echo Create new key pair...
    java -jar ..\..\client\target\client-0.0.1-SNAPSHOT.jar --keypair
    cd ..\..
)
java -jar client\target\client-0.0.1-SNAPSHOT.jar --address --node "%node%" --name "%fullname%" --publickey "%user_dir%\key.pub"
set /p address_hash="address hash: "
IF "%address_hash%" equ "" (
    exit
)
cd "%user_dir%"
(
    echo @echo off
    echo set /p message="message: "
    echo java -jar ..\..\client\target\client-0.0.1-SNAPSHOT.jar --transaction --node "%node%" --sender "%address_hash%" --message "%%message%%" --privatekey key.priv
    echo pause
) > transaction.bat
pause