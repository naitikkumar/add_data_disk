param(
    [Parameter(Mandatory=$true)]
    [String]$vmname,

    [Parameter(Mandatory=$true)]
    [String]$resourcegroup

)


try
{
$vm = get-azvm -ResourceGroupName $resourcegroup -Name $vmname
}
catch
{
    Write-Error 'error in retiving details '+$_
}

$datas =  $vm.StorageProfile

$datadisks = ($datas.DataDisks).name


[int]$count = $datadisks.Count
Write-Output 'count of disk '$count


if($count -ne 0 -and $null -ne $count)
{
    foreach($disks in $datadisks)
    {
       try
       {
        $disks = Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $disks
		Write-Output $disks
        }
        catch
        {
            write-error 'error while retiving disks '$_
        }    
    }
   
}
else
{

Write-Output 'no data disk are attached to vm'
exit
}
