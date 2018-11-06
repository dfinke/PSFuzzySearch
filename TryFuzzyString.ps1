Import-Module .\PowerShellFuzzySearch.psd1 -Force

'Select-FuzzyString pia'
.\countries.ps1 | Select-FuzzyString pia
''
'Select-FuzzyString uae'
.\countries.ps1 | Select-FuzzyString uae
''
'Select-FuzzyString svg'
.\countries.ps1 | Select-FuzzyString svg
''
'Select-FuzzyString bh'
.\countries.ps1 | Select-FuzzyString bh
''
'sfs united'
.\countries.ps1 | sfs united