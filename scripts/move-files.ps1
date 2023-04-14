param (
    [Parameter(Mandatory=$true)][array] $moveOperations
)

function MoveFiles {
    param (
        [string] $sourceFolder,
        [string] $destinationFolder,
        [string] $fileType,
        [string] $partialFileName
    )

    # Ensure the destination folder exists
    if (!(Test-Path $destinationFolder)) {
        New-Item -ItemType Directory -Path $destinationFolder | Out-Null
    }

    # Find and move the files
    Get-ChildItem -Path $sourceFolder -Filter "*.$fileType" | Where-Object {
        $_.Name -like "*$partialFileName*"
    } | ForEach-Object {
        $destinationPath = Join-Path $destinationFolder $_.Name
        Move-Item $_.FullName $destinationPath
        Write-Host "Moved $($_.FullName) to $destinationPath"
    }
}

foreach ($operation in $moveOperations) {
    MoveFiles -sourceFolder $operation.SourceFolder `
              -destinationFolder $operation.DestinationFolder `
              -fileType $operation.FileType `
              -partialFileName $operation.PartialFileName
}
