Set fso = CreateObject("Scripting.FileSystemObject")
Set shell = CreateObject("WScript.Shell")

scriptDir = fso.GetParentFolderName(WScript.ScriptFullName)
engineScript = scriptDir & "\localization_engine.js"

localAppData = shell.ExpandEnvironmentStrings("%LOCALAPPDATA%")
userProf = shell.ExpandEnvironmentStrings("%USERPROFILE%")
oneDrive = shell.ExpandEnvironmentStrings("%OneDrive%")
progFiles = shell.ExpandEnvironmentStrings("%ProgramFiles%")
progFilesX86 = shell.ExpandEnvironmentStrings("%ProgramFiles(x86)%")

candidates = Array(_
    localAppData & "\Programs\antigravity", _
    localAppData & "\Programs\Antigravity", _
    localAppData & "\Programs\Antigravity IDE", _
    "D:\Antigravity", _
    "D:\antigravity", _
    "D:\Software\Antigravity", _
    "D:\Programs\Antigravity", _
    "D:\Program Files\Antigravity", _
    "E:\Antigravity", _
    "E:\antigravity", _
    "E:\Software\Antigravity", _
    "E:\Programs\Antigravity", _
    "E:\Program Files\Antigravity", _
    progFiles & "\Antigravity", _
    progFilesX86 & "\Antigravity", _
    "C:\Antigravity", _
    "C:\Programs\Antigravity" _
)

installDir = ""

' H¿ÂLbÚ	Îwπ
scList = Array(userProf & "\Desktop\Antigravity.lnk", oneDrive & "\Desktop\Antigravity.lnk")
For Each sc In scList
    If sc <> "" And fso.FileExists(sc) Then
        On Error Resume Next
        Set scObj = shell.CreateShortcut(sc)
        target = scObj.TargetPath
        If Err.Number = 0 And target <> "" Then
            If LCase(Right(target, 15)) = "antigravity.exe" Then
                targetDir = fso.GetParentFolderName(target)
                If fso.FolderExists(targetDir) Then
                    installDir = targetDir
                End If
            ElseIf fso.FolderExists(target) And fso.FileExists(target & "\Antigravity.exe") Then
                installDir = target
            End If
        End If
        On Error GoTo 0
        If installDir <> "" Then Exit For
    End If
Next

If installDir = "" Then
    For Each p In candidates
        If p <> "" And fso.FolderExists(p) Then
            If fso.FileExists(p & "\Antigravity.exe") Then
                installDir = p
                Exit For
            End If
        End If
    Next
End If

If installDir <> "" Then
    appExe = installDir & "\Antigravity.exe"
    asarBak = installDir & "\resources\app.asar.bak"

    If Not fso.FileExists(asarBak) Then
        If fso.FileExists(engineScript) Then
            Set env = shell.Environment("PROCESS")
            env("ELECTRON_RUN_AS_NODE") = "1"
            cmd = """" & appExe & """ """ & engineScript & """ --brand-title english --no-kill"
            shell.Run cmd, 0, True
            env.Remove("ELECTRON_RUN_AS_NODE")
        End If
    End If

    If fso.FileExists(appExe) Then
        shell.Run """" & appExe & """", 1, False
    End If
Else
    whereNode = False
    On Error Resume Next
    testRun = shell.Run("where node", 0, True)
    If Err.Number = 0 And testRun = 0 Then whereNode = True
    On Error GoTo 0

    If whereNode And fso.FileExists(engineScript) Then
        cmd = "node """ & engineScript & """ --brand-title english --no-kill"
        shell.Run cmd, 0, True
    End If
End If
