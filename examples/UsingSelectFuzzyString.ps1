Import-Module $PSScriptRoot\..\PSFuzzySearch.psd1 -Force

$data = .\countries.ps1 | sort

write-host -fore green 'Select-FuzzyString pia'
$data | Select-FuzzyString pia
''

write-host -fore green 'Select-FuzzyString uae'
$data | Select-FuzzyString uae
''

write-host -fore green 'Select-FuzzyString svg'
$data | Select-FuzzyString svg
''

write-host -fore green 'Select-FuzzyString bh'
$data | Select-FuzzyString bh
''
write-host -fore green 'sfs united'
$data | sfs united