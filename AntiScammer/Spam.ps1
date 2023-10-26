$wshell = New-Object -ComObject WScript.Shell
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Alle .png Dateien im Verzeichnis finden
$imageList = Get-ChildItem -Path ".\" -Filter "*.png"
$tempList = $imageList.FullName.Clone()

$specialImages = @(".\meme6.png", ".\meme5.png")
$Message = Get-Content -Path ".\hebretext.txt" -Encoding BigEndianUnicode

Start-Sleep -Seconds 5

$i=0
$j=0
while ($i -lt 5)
{
  if ($i -lt 2) {
    $randomImage = $specialImages[$j]
    $j++
  } else {
    if ($tempList.Count -eq 0) {
      $tempList = $imageList.FullName.Clone()
    }
    $randomImage = Get-Random -InputObject $tempList
    $tempList = $tempList | Where-Object { $_ -ne $randomImage }
  }

  Set-Clipboard -Value $Message
  Start-Sleep -Milliseconds 1500

  $wshell.SendKeys("^v")
  $wshell.SendKeys('~')

  Start-Sleep -Milliseconds 2000

  Set-Clipboard -Path $randomImage
  $wshell.SendKeys("^v")
  $wshell.SendKeys('~')

  Start-Sleep -Milliseconds 1500
  $i++
}
