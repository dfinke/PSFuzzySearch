Import-Module $PSScriptRoot\..\PSFuzzySearch.psd1 -Force

'System.Array'
$list = .\countries.ps1
$list.FuzzySearch('uae')

''
'Hashtable'
''
#$h = @{}
#.\countries.ps1 | ForEach-Object {$h.$_ = 1}
#$h.FuzzySearch('uae')

$list = .\countriesHashtable.ps1
$list.FuzzySearch('uae')