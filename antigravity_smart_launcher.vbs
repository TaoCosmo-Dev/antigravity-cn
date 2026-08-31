Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

localAppData = shell.ExpandEnvironmentStrings("%LOCALAPPDATA%")
installDir = localAppData & "\Programs\antigravity"
appExe = installDir & "\Antigravity.exe"
asarBak = installDir & "\resources\app.asar.bak"
engineScript = "D:\GitHub\antigravity2-cn-main\antigravity2-cn-main\localization_engine.js"

If Not fso.FileExists(asarBak) Then
    If fso.FileExists(engineScript) Then
        cmd = "node """ & engineScript & """ --brand-title english --no-kill"
        shell.Run cmd, 0, True
    End If
End If

If fso.FileExists(appExe) Then
    shell.Run """" & appExe & """", 1, False
End If
