# Check if Scoop is installed
if (!(Get-Command scoop -ErrorAction SilentlyContinue)) {
    # If not, install Scoop
    Write-Host "Scoop not found. Installing now..."
    irm https://get.scoop.sh | iex
} else {
    Write-Host "Scoop already installed, skipping install."
}

# Parse the manifest.json file
$json = Get-Content -Path 'manifest.json' | ConvertFrom-Json

# Iterate over each bucket in the manifest
foreach ($bucket in $json.buckets) {
    # Add the bucket if it's not already added
    if (!(scoop bucket list | Select-String -Pattern $bucket)) {
        Write-Host "Adding bucket: $bucket"
        scoop bucket add $bucket
    } else {
        Write-Host "$bucket already added, skipping."
    }
}

# Iterate over each app in the manifest
foreach ($app in $json.apps) {
    # Install the app if it's not already installed
    if (!(scoop list | Select-String -Pattern $app.name)) {
        Write-Host "Installing $($app.name)"
        scoop install $app.name
    } else {
        Write-Host "$($app.name) already installed, skipping."
    }
}