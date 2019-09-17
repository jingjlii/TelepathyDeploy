<# Custom Script for Windows to install a file from Azure Storage using the staging folder created by the deployment script #>
param (
    [string]$artifactsFolderName
)
Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
Install-Module -Name Az -AllowClobber -Force
$container_name = 'telepathy'  
$destination_path = "C:\telepathy"
$srcStorageAccountName = "soaserviceartifactci"
$srcStorageAccountKey = "CIUUcB0qMYYZAj+Zz9zllWX8D2WacMdm6uHRr0oqzuLYnaFbmZkY+GDdmIoWETkDYfJhpK1V6ltVrwOq5u13sw=="
$storage_account = New-AzStorageContext -StorageAccountName $srcStorageAccountName -StorageAccountKey $srcStorageAccountKey
$blobs = Get-AzStorageBlob -Container $container_name -Blob $artifactsFolderName -Context $storage_account  
foreach($blob in $blobs) {  
    New-Item -ItemType Directory -Force -Path $destination_path  
    Get-AzStorageBlobContent -Container $container_name -Blob $blob.Name -Destination $destination_path -Context $storage_account  
} 