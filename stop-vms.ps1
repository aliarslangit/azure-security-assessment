$sub = Get-AzSubscription -SubscriptionId "" | Set-AzContext
Get-AzureVM | Where { $_.Status –eq 'StoppedVM' }