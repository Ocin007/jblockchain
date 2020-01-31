@echo off
set /p fullname="full username: "
set /p node=<node-address.txt
IF NOT EXIST users\ (
    md users
)
set user_dir=users\%fullname%
set user_exist=0
IF EXIST "%user_dir%\" (
    echo %fullname% already exist
    set user_exist=1
) ELSE (
    md "%user_dir%"
    cd "%user_dir%"
    echo Create new key pair...
    java -jar ..\..\client\target\client-0.0.1-SNAPSHOT.jar --keypair
    cd ..\..
)
java -jar client\target\client-0.0.1-SNAPSHOT.jar --address --node "%node%" --name "%fullname%" --publickey "%user_dir%\key.pub"
IF "%user_exist%" equ "1" (
    pause
    exit
)
set /p address_hash="address hash: "
IF "%address_hash%" equ "" (
    pause
    exit
)
cd "%user_dir%"
(
    echo @echo off
    echo set /p message="message: "
    echo java -jar ..\..\client\target\client-0.0.1-SNAPSHOT.jar --transaction --node "%node%" --sender "%address_hash%" --message "%%message%%" --privatekey key.priv
    echo pause
) > transaction.bat
(
    echo @echo off
    echo java -jar ..\..\client\target\client-0.0.1-SNAPSHOT.jar --address --node "%node%" --name "%fullname%" --publickey key.pub
    echo pause
) > add-address.bat
pause