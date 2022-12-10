$base_path = 'C:\Users\zocha\Documents\Projects\SYOP\P1\dane_testowe'
$ext = "pdf"


$all =  ((Get-ChildItem -Path $base_path -Filter *.$ext -Recurse -File -Name) + (Get-ChildItem -Path $base_path -Directory -Recurse -Name)) | sort
foreach($path in $all){
    $last = $path.LastIndexOf('\')
    $i = 0 
    if($last -ne -1){
        $i = 1
        $full_path = $base_path + "\" + $path
        $size = (Get-Item -Path $full_path).Length
        $lastModifiedDate = (Get-Item $full_path).LastWriteTime
        $path = $path.Remove(0, $last+1)
        $wciecie = ""
        for($i=0; $i -le $last - 3; $i=$i+1 ){
            $wciecie = " " + $wciecie
        }
        for($i=$last - 3; $i -le $last-3; $i=$i+1 ){
            $wciecie =  $wciecie + "'"
        }
        for($i=$last - 2; $i -le $last; $i=$i+1 ){
            $wciecie =  $wciecie + "-"
        }
        $path = $wciecie + $path
        $last_dot = $path.LastIndexOf('.')
    }

    if($last_dot -ne -1 -and $i -ne 0){
        $wciecie_podpis = ""
        Write-Host($path)
        $last_dash = $path.LastIndexOf(' ')
        for($i=0; $i -le $last_dash + 4; $i=$i+1 ){
            $wciecie_podpis = " " + $wciecie_podpis
        }

        Write-Host($wciecie_podpis+ $size + "b ") -ForegroundColor DarkGreen -NoNewline
        Write-Host($lastModifiedDate) -ForegroundColor DarkCyan
    }
    else{
        Write-Host($path)
    }
}