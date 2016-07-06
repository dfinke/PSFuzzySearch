function Select-FuzzyString {
    param(        
        $search='',
        [parameter(ValueFromPipeline=$true)]
        $data
    )
    
    Begin   { $search = $search.ToCharArray() -join '.*?' } 
    Process { if($data -match $search) { $data } }
}

function Get-FuzzyCommand {
    param(
        # Search String
        [Parameter(Mandatory)]
        [string]
        $search = ''
    )

    Get-Command | Select-FuzzyString -Search $search
}

function Get-FuzzyChildItem {
        param(
        # Search String
        [Parameter(Mandatory, Position=0)]
        [string]
        $search = '',
        # Specifies a path to one or more locations.
        [Parameter( Position=1,
                   HelpMessage="Path to one or more locations.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Path = $PWD
    )

    Get-ChildItem -Path $Path | Select-FuzzyString -Search $search
}

set-alias sfs select-fuzzystring