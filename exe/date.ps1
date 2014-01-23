if ( ( Get-date ).Month -ge 7 ){
  $base = ( Get-date -Month 7 -Day 1 -Hour 0 -Minute 0 -Second 0 )
} else {
  $base = ( Get-date -Month 1 -Day 1 -Hour 0 -Minute 0 -Second 0 )
}
Write-Output $base.toString("yyyy/MM/dd")
$m06b = $base.AddMonths(-6)
Write-Output $m06b.toString("yyyy/MM/dd")
$m12b = $m06b.AddMonths(-6)
Write-Output $m12b.toString("yyyy/MM/dd")
$m18b = $m12b.AddMonths(-6)
Write-Output $m18b.toString("yyyy/MM/dd")

