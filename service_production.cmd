@ECHO OFF
PUSHD "%~dp0"
set _arch=x86
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (set _arch=x86_64)
IF DEFINED PROCESSOR_ARCHITEW6432 (set _arch=x86_64)

sc stop "GoodbyeDPI"
sc delete "GoodbyeDPI"
sc create "GoodbyeDPI" binPath= "\"%CD%\%_arch%\goodbyedpi.exe\" -5 -e1 -q --fake-gen 29 --fake-from-hex ce2bc9019c51f409b72f7259a1e67f3050b370585acd6439917aa5675e5d9cfab4d389540007d4e9f90164d0b96422bc3e39b8b889e6d566f8d5c01c221d5f3bba6e1201cb17debe052ac4ecb0883d8dc8fefbd613015a4f40b4c4daf8dc2ab87976d9ac500fa75ffed281d92e080604372e55003e2add6efc44831a34e764cc1c92d126144bae9ca79e5872c168c83db2cd1dd3657fa36b6ee51ad77d4091e43fabcf5d34505d61d2beae2eb88f297d6a7cc713d13488f441a8f595a3fc9a9824af013d8bc3345841c54e6aadef744538fddbb8477fb37cff31353ed5af6d7a082ae40ca7156d749a4107f7d2c58af7f3ab43ea550c559ef03d8fbe6386b01b1e236152d67f8b16c9e8c25f1dda6543483db5916fc78255685bffbd683de8476bff --blacklist \"%CD%\russia-blacklist.txt\" --blacklist \"%CD%\russia-youtube.txt\"" start= "auto"
sc description "GoodbyeDPI" "Passive Deep Packet Inspection blocker and Active DPI circumvention utility"
sc start "GoodbyeDPI"

POPD
