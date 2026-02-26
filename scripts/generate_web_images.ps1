Add-Type -AssemblyName System.Drawing

$ErrorActionPreference = 'Stop'

function Get-JpegCodec {
  return [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
    Where-Object { $_.MimeType -eq 'image/jpeg' } |
    Select-Object -First 1
}

function Save-JpegWithQuality {
  param(
    [Parameter(Mandatory = $true)] [System.Drawing.Bitmap] $Bitmap,
    [Parameter(Mandatory = $true)] [string] $OutputPath,
    [int] $Quality = 88
  )

  $jpgCodec = Get-JpegCodec
  $encParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
  $encParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter(
    [System.Drawing.Imaging.Encoder]::Quality,
    [long]$Quality
  )

  $Bitmap.Save($OutputPath, $jpgCodec, $encParams)
  $encParams.Dispose()
}

function New-WebVariant {
  param(
    [Parameter(Mandatory = $true)] [string] $InputPath,
    [Parameter(Mandatory = $true)] [int] $TargetWidth,
    [Parameter(Mandatory = $true)] [int] $TargetHeight,
    [ValidateSet('Center','LeftCenter')] [string] $CropAnchor = 'Center'
  )

  if (-not (Test-Path $InputPath)) {
    Write-Host "Skip missing: $InputPath" -ForegroundColor Yellow
    return
  }

  $extension = [System.IO.Path]::GetExtension($InputPath)
  $basePath = $InputPath.Substring(0, $InputPath.Length - $extension.Length)
  $outputPath = "${basePath}_web${extension}"

  $src = [System.Drawing.Image]::FromFile($InputPath)

  try {
    $scaleX = $TargetWidth / $src.Width
    $scaleY = $TargetHeight / $src.Height
    $scale = [Math]::Max($scaleX, $scaleY)

    $scaledW = [int][Math]::Ceiling($src.Width * $scale)
    $scaledH = [int][Math]::Ceiling($src.Height * $scale)

    $scaled = New-Object System.Drawing.Bitmap($scaledW, $scaledH)
    $scaled.SetResolution(96, 96)

    $gScaled = [System.Drawing.Graphics]::FromImage($scaled)
    $gScaled.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $gScaled.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $gScaled.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gScaled.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $gScaled.DrawImage($src, 0, 0, $scaledW, $scaledH)
    $gScaled.Dispose()

    $cropX = 0
    if ($CropAnchor -eq 'LeftCenter') {
      $cropX = 0
    } else {
      $cropX = [int][Math]::Floor(($scaledW - $TargetWidth) / 2)
    }

    if ($cropX -lt 0) { $cropX = 0 }

    $cropY = [int][Math]::Floor(($scaledH - $TargetHeight) / 2)
    if ($cropY -lt 0) { $cropY = 0 }

    $target = New-Object System.Drawing.Bitmap($TargetWidth, $TargetHeight)
    $target.SetResolution(96, 96)

    $gTarget = [System.Drawing.Graphics]::FromImage($target)
    $gTarget.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
    $gTarget.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $gTarget.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $gTarget.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality

    $srcRect = New-Object System.Drawing.Rectangle($cropX, $cropY, $TargetWidth, $TargetHeight)
    $dstRect = New-Object System.Drawing.Rectangle(0, 0, $TargetWidth, $TargetHeight)
    $gTarget.DrawImage($scaled, $dstRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
    $gTarget.Dispose()

    if ($extension -match '\.(jpg|jpeg)$') {
      Save-JpegWithQuality -Bitmap $target -OutputPath $outputPath -Quality 88
    } else {
      $target.Save($outputPath)
    }

    $target.Dispose()
    $scaled.Dispose()

    Write-Host "Generated: $outputPath" -ForegroundColor Green
  }
  finally {
    $src.Dispose()
  }
}

$projectRoot = Split-Path -Parent $PSScriptRoot
$branding = Join-Path $projectRoot 'assets\images\branding'
$pinkNamed = Join-Path $projectRoot 'assets\images\background\pink_named'
$pinkNamedWeb = Join-Path $projectRoot 'assets\images\background\web\pink_named'

if (-not (Test-Path $pinkNamedWeb)) {
  New-Item -ItemType Directory -Path $pinkNamedWeb -Force | Out-Null
}

$webWidth = 3440
$webHeight = 1440

$redHeight = [int][Math]::Round($webHeight * 0.23)
$blueHeight = [int][Math]::Round($webHeight * 0.12)
$greenHeight = $webHeight - $redHeight - $blueHeight
$pinkHeight = $webHeight - $redHeight

New-WebVariant -InputPath (Join-Path $branding 'redlayer.png') -TargetWidth $webWidth -TargetHeight $redHeight -CropAnchor Center
New-WebVariant -InputPath (Join-Path $branding 'bluelayer.png') -TargetWidth $webWidth -TargetHeight $blueHeight -CropAnchor Center
New-WebVariant -InputPath (Join-Path $branding 'greenlayer.png') -TargetWidth $webWidth -TargetHeight $greenHeight -CropAnchor Center
New-WebVariant -InputPath (Join-Path $branding 'pinklayer.png') -TargetWidth $webWidth -TargetHeight $pinkHeight -CropAnchor Center

Get-ChildItem -Path $pinkNamed -File | ForEach-Object {
  if ($_.BaseName -like '*_web') {
    return
  }

  New-WebVariant -InputPath $_.FullName -TargetWidth $webWidth -TargetHeight $pinkHeight -CropAnchor Center

  $generatedInPlace = Join-Path $_.DirectoryName ("{0}_web{1}" -f $_.BaseName, $_.Extension)
  if (Test-Path $generatedInPlace) {
    Move-Item -Path $generatedInPlace -Destination (Join-Path $pinkNamedWeb ([System.IO.Path]::GetFileName($generatedInPlace))) -Force
  }
}

Write-Host 'Web image generation completed.' -ForegroundColor Cyan
