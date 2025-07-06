@echo off
setlocal enabledelayedexpansion

REM Define the directory to encrypt
set "directory=."

REM Collect files in the directory
set "files="
for /r "%directory%" %%A in (*) do (
    set "files=!files! "%%A""
)

REM Check if there are files to encrypt
if not defined files (
    echo No files found for encryption.
    exit /b
)

REM Generate encryption key
python -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())" > thekey.key

REM Encrypt each file
for %%F in (!files!) do (
    python -c "from cryptography.fernet import Fernet; key = open('thekey.key', 'rb').read(); data = open('%%~F', 'rb').read(); f = Fernet(key); open('%%~dpnF_encrypted%%~xF', 'wb').write(f.encrypt(data))"
)

echo File encryption completed.

endlocal
pause
