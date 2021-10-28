$hash = @{}
$hash2 = @{}
$fileCount = 0
$folderCount = 0
$files = Get-ChildItem -Path 'C:\temp' -Recurse
foreach ($file in $files) {
    if (!$file.PSIsContainer) {
        if ($hash.ContainsKey($file.Extension)) {
            $hash[$file.Extension] = $hash[$file.Extension] + 1
            $hash2[$file.Extension] = $hash2[$file.Extension] + ($file.length / 1MB)
        } else {
            $hash[$file.Extension] = 1
            $hash2[$file.Extension] = ($file.length / 1MB)
        }
        $fileCount += 1    
    } else {
        $folderCount += 1
    }
}

$hash.keys | ForEach-Object {
    Write-Output "$($_),$($hash[$_]),$([math]::Round(($hash2[$_])))"
    }

Write-Host "========================= Summary ========================="
Write-Host "Files $($fileCount), Folders $($folderCount)"
