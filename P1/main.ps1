$base_path = 'D:\Documents\Projects\SYOP\P1\dane_testowe'
$ext = "pdf"

$all = ((Get-ChildItem -Path $base_path -Filter *.$ext -Recurse -File -Name) + (Get-ChildItem -Path $base_path -Directory -Recurse -Name)) | Sort-Object
if ((Get-ChildItem -Path $base_path -Filter *.$ext -Recurse -File -Name).Length -eq 0) {
    Write-Host("Nic nie znaleziono") -ForegroundColor Green
    return
}
foreach ($path in $all) {
    $full_path = $base_path + "\" + $path
    $last = $path.LastIndexOf('\')
    $is_file = (Get-Item $full_path) -is [System.IO.FileInfo]

    $i = 0 
    if ($last -ne -1) {
        $i = 1
        $full_path = $base_path + "\" + $path
        if ($is_file) {
            $size = (Get-Item -Path $full_path).Length
            $lastModifiedDate = (Get-Item $full_path).LastWriteTime
        }


        $path = $path.Remove(0, $last + 1)
        $wciecie = ""
        for ($i = 0; $i -le $last - 3; $i = $i + 1 ) {
            $wciecie = " " + $wciecie
        }
        for ($i = $last - 3; $i -le $last - 3; $i = $i + 1 ) {
            $wciecie = $wciecie + "'"
        }
        for ($i = $last - 2; $i -le $last; $i = $i + 1 ) {
            $wciecie = $wciecie + "-"
        }
        $path = $wciecie + $path
    }

    if ( $is_file -eq "True") {
        Write-Host($path) -ForegroundColor Red -NoNewline
        Write-Host(" " + $size + "b ") -ForegroundColor DarkGreen -NoNewline
        Write-Host($lastModifiedDate) -ForegroundColor DarkCyan
    }
    else {
        Write-Host($path) -ForegroundColor Green
    }
}
