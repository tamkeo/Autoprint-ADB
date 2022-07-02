#RequireAdmin
#include <GUIConstantsEx.au3>
#include <Math.au3>
Local $process = ProcessList("autoprintpvoil.exe")
For $i = 1 To $process[0][0]
ProcessClose($process[$i][1])
Next
$Form2 = GUICreate("Tự động in Auto Update", 268, 150)
$Label2 = GUICtrlCreateLabel("Tự động in Update", 60, 10, 250, 23 )
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
GUICtrlSetColor(-1, 0xFF0000)
$url='https://github.com/chinhanh09/Autoprint-ADB/raw/main/AutoPrintPVoil.exe'
$_TempPath = @ScriptDir & '\Update.New'
$_FileSize = InetGetSize ( $url )
$_Download = InetGet ( $url, $_TempPath, 1, 1 )

$_ProgressBar = GUICtrlCreateProgress ( 5, 55, 250, 23 )  ;tạo Progress hiển thị tiến trình tải
GUISetState(@SW_SHOW)


Local $_InfoData
Do
    $_InfoData = InetGetInfo($_Download )
    If Not @error Then
        $_InetGet = $_InfoData[0]
        $_DownloadPercent = Round ( ( 100 * $_InetGet ) / $_FileSize )
        $_DownloadPercent = _Min ( _Max ( 1, $_DownloadPercent ), 99 )
        GUICtrlSetData ($_ProgressBar,$_DownloadPercent )
        $_Label = GUICtrlCreateLabel ( 'Downloading : ' & $_DownloadPercent & ' %', 50, 90, 350, 20 )
        GUICtrlSetFont(-1, 12, 400, 0, "Tahoma")
        GUICtrlSetColor(-1, 0xFF0000)
    EndIf
    Sleep ( 100 )
Until $_InfoData[2] = True

FileDelete("AutoPrintPVoil.exe")
$sFileOld = "Update.New"
$sFileRenamed = "AutoPrintPVoil.exe"
FileMove($sFileOld, $sFileRenamed)
MsgBox(64,"Update","Update Completed")


