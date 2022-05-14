$sub = Get-AzSubscription -SubscriptionId "" | Set-AzContext
$nsgs = Get-AzNetworkSecurityGroup
Get-AzAdvisorRecommendation

foreach ( $azNsg in $azNsgs ) {
    Get-AzNetworkSecurityRuleConfig -NetworkSecurityGroup $azNsg | Where-Object { $_.sourceaddressprefix -eq "*" -and $_.Access -eq "Allow" } | `
    Select-Object @{label = 'NSG Name'; expression = { $azNsg.Name } }, @{label = 'Rule Name'; expression = { $_.Name } }, `
    @{label = 'Source'; expression = { $_.SourceAddressPrefix } }, `
    @{label = 'Destination'; expression = { $_.DestinationAddressPrefix } }, `
    @{label = 'Port Range'; expression = { $_.DestinationPortRange } }, Access, Priority, Direction, `
    @{label = 'Resource Group Name'; expression = { $azNsg.ResourceGroupName } } | Export-Csv -Path "$($home)\clouddrive\nsg-audit.csv" -NoTypeInformation -Append
  
}

