@"
@{
[ordered]$(.\countries.ps1 | % {
    "`t`"{0}`" = 'Country'`r`n" -f $_.trim()
})
}
"@ > .\countriesHashtable.ps1