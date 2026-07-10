param (
        [Alias("i","input")]    [Parameter(Position = 0, Mandatory=$true)]   [string]    $INPUT_FILE,
        [Alias("o","output")]  [Parameter(Mandatory=$false)]   [string]    $OUTPUT_FILE,
        [ValidateRange(24,30)]
        [Alias("c","crf")]     [Parameter(Mandatory=$false)]   [int]       $CRF_VALUE = 28
      )

# Write-Output "file name $INPUT_FILE"
# Write-Output "CRF = $CRF_VALUE"

# $ConfigINI = (Get-Item $INPUT_FILE ).DirectoryName+"\"+(Get-Item $INPUT_FILE ).BaseName+".ini"

# if ($OUTPUT_FILE -eq $null) 
if (! $OUTPUT_FILE ) 
{
    # Write-Output "OUTPUT_FILE is null"
    $OUTPUT_FILE = (Get-Item $INPUT_FILE ).DirectoryName+"\"+(Get-Item $INPUT_FILE ).BaseName `
        + "__WIN_CRF_" + $CRF_VALUE + (Get-Item $INPUT_FILE).Extension
} else {
    Write-Output "OUTPUT_FILE is NOT null"
}

# Write-Output "Output >$OUTPUT_FILE<"

Measure-Command `
{
    ffmpeg -y -threads 8 -i "$INPUT_FILE" -v warning  -hide_banner -stats -vcodec libx265 `
        -crf "$CRF_VALUE" -x265-params log-level=warning  "$OUTPUT_FILE"
}

# Write-Output "Exiting ..."
