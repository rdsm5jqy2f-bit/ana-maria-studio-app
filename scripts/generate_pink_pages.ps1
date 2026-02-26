Add-Type -AssemblyName System.Drawing

$projectRoot = Resolve-Path (Join-Path $PSScriptRoot '..')
$sourceDir = Join-Path $projectRoot 'assets/images/background/pink'
$targetDir = Join-Path $projectRoot 'assets/images/background/pink_pages'

if (-not (Test-Path $sourceDir)) {
  throw "Source folder not found: $sourceDir"
}

if (-not (Test-Path $targetDir)) {
  New-Item -ItemType Directory -Path $targetDir | Out-Null
}

$targetWidth = 1080
$targetHeight = 1479
$targetAspect = [double]$targetWidth / [double]$targetHeight

$files = Get-ChildItem -Path $sourceDir -File | Where-Object {
  $_.Extension -match '^(?i)\.(jpg|jpeg|png)$'
} | Sort-Object Name

foreach ($file in $files) {
  $sourceImage = [System.Drawing.Image]::FromFile($file.FullName)
  try {
    $sourceWidth = [double]$sourceImage.Width
    $sourceHeight = [double]$sourceImage.Height
    $sourceAspect = $sourceWidth / $sourceHeight

    if ($sourceAspect -gt $targetAspect) {
      $cropWidth = [int][Math]::Round($sourceHeight * $targetAspect)
      $cropHeight = [int]$sourceHeight
      $cropX = [int][Math]::Round(($sourceWidth - $cropWidth) / 2.0)
      $cropY = 0
    } else {
      $cropWidth = [int]$sourceWidth
      $cropHeight = [int][Math]::Round($sourceWidth / $targetAspect)
      $cropX = 0
      $cropY = [int][Math]::Round(($sourceHeight - $cropHeight) / 2.0)
    }

    if ($cropX -lt 0) { $cropX = 0 }
    if ($cropY -lt 0) { $cropY = 0 }
    if (($cropX + $cropWidth) -gt $sourceImage.Width) {
      $cropWidth = $sourceImage.Width - $cropX
    }
    if (($cropY + $cropHeight) -gt $sourceImage.Height) {
      $cropHeight = $sourceImage.Height - $cropY
    }

    $destinationBitmap = New-Object System.Drawing.Bitmap($targetWidth, $targetHeight)
    try {
      $graphics = [System.Drawing.Graphics]::FromImage($destinationBitmap)
      try {
        $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

        $srcRect = New-Object System.Drawing.Rectangle($cropX, $cropY, $cropWidth, $cropHeight)
        $dstRect = New-Object System.Drawing.Rectangle(0, 0, $targetWidth, $targetHeight)
        $graphics.DrawImage($sourceImage, $dstRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
      } finally {
        $graphics.Dispose()
      }

      $outputPath = Join-Path $targetDir $file.Name
      $jpgEncoder = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() |
        Where-Object { $_.MimeType -eq 'image/jpeg' } |
        Select-Object -First 1

      if ($null -ne $jpgEncoder) {
        $encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
        $encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, 90L)
        $destinationBitmap.Save($outputPath, $jpgEncoder, $encoderParams)
        $encoderParams.Dispose()
      } else {
        $destinationBitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Jpeg)
      }
    } finally {
      $destinationBitmap.Dispose()
    }
  } finally {
    $sourceImage.Dispose()
  }
}

"Processed $($files.Count) images into $targetDir"
