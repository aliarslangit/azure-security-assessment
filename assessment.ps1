//Get all Nsgs in a subscription
$sub = Get-AzSubscription -SubscriptionId "" | Set-AzContext
$nsgs = Get-AzNetworkSecurityGroup
Get-AzAdvisorRecommendation

