@{
    RootModule        = 'PSFuzzySearch.psm1'
    ModuleVersion     = '1.1.0'
    GUID              = 'b09def5c-a8cd-4f75-b0bf-5665dc5326ed'
    Author            = 'Doug Finke'
    CompanyName       = 'Doug Finke'
    Copyright         = 'c 2018 Doug Finke. All rights reserved.'
    Description       = @'
A collection of functions to apply fuzzy searching to various types
'@
    FunctionsToExport = '*'
    CmdletsToExport   = '*'
    AliasesToExport   = '*'

    PrivateData       = @{

        PSData = @{
            Tags       = @("PowerShell", "Search", "Fuzzy")
            LicenseUri = 'https://github.com/dfinke/PSFuzzySearch/blob/master/LICENSE'
            ProjectUri = 'https://github.com/dfinke/PSFuzzySearch'
            # IconUri = ''
            # ReleaseNotes = ''
        }
    }
}

