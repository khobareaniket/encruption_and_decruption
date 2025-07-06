@echo off
setlocal enabledelayedexpansion

REM Define the directory to decrypt
set "directory=."

REM Collect encrypted files in the directory
set "files="
for /r "%directory%" %%A in (*_encrypted*) do (
    set "files=!files! "%%A""
)

REM Check if there are encrypted files to decrypt
if not defined files (
    echo No encrypted files found for decryption.
    exit /b
)

REM Read the decryption key
set /p decrypt_key="Enter Key to Decrypt Your Files: "

REM Decrypt each file
for %%F in (%files%) do (
    python -c "from cryptography.fernet import Fernet; key = open('thekey.key', 'rb').read(); data = open('%%F', 'rb').read(); f = Fernet(key); decrypted_data = f.decrypt(data); with open('%%~dpnF_decrypted%%~xF', 'wb') as decrypted_file: decrypted_file.write(decrypted_data)"
)

echo File decryption completed.

endlocal
pause
