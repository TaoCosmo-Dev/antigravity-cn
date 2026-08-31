Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
engineScript = scriptDir & "\localization_engine.js"

localAppData = shell.ExpandEnvironmentStrings("%LOCALAPPDATA%")
progFiles = shell.ExpandEnvironmentStrings("%ProgramFiles%")
progFilesX86 = shell.ExpandEnvironmentStrings("%ProgramFiles(x86)%")

candidates = Array(_
    localAppData & "\Programs\antigravity", _
    localAppData & "\Programs\Antigravity IDE", _
    progFiles & "\Antigravity", _
    progFilesX86 & "\Antigravity", _
    "C:\Programs\Antigravity", _
    "D:\Programs\Antigravity", _
    "E:\Programs\Antigravity", _
    "F:\Programs\Antigravity" _
)

installDir = ""
For Each p In candidates
    If p <> "" And fso.FolderExists(p) Then
        If fso.FileExists(p & "\Antigravity.exe") Then
            installDir = p
            Exit For
        End If
    End If
Next

If installDir <> "" Then
    appExe = installDir & "\Antigravity.exe"
    asarBak = installDir & "\resources\app.asar.bak"

    If Not fso.FileExists(asarBak) Then
        If fso.FileExists(engineScript) Then
            cmd = "node """ & engineScript & """ --brand-title english --no-kill"
            shell.Run cmd, 0, True
        End If
    End If

    If fso.FileExists(appExe) Then
        shell.Run """" & appExe & """", 1, False
    End If
Else
    If fso.FileExists(engineScript) Then
        cmd = "node """ & engineScript & """ --brand-title english --no-kill"
        shell.Run cmd, 0, True
    End If
End If
