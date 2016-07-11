<#
.SYNOPSIS
    Returns a Regex object from a string.
.DESCRIPTION
    Returns a Regex object from a string. The Regex object has no options 
    and the pattern is built from `$Search.ToCharArray() -join '.*?'`.
.EXAMPLE
    C:\PS> Get-FuzzyPattern test

    Options MatchTimeout      RightToLeft
    ------- ------------      -----------
    None    -00:00:00.0010000 False
.Parameter Search
    The search string
.NOTES
    General notes
#>
function Get-FuzzyPattern {
    [CmdletBinding()]
    [OutputType([String])]
    param(
        [Parameter(Mandatory, Position=0)]        
        $Search=''
    )

    $escArray = $Search.ToCharArray() | Foreach { [Regex]::Escape($_) }  
    
    return $escArray -join '.*?'
}

<#
.SYNOPSIS
    Search the contents of the a file.
.DESCRIPTION
    Long description
.EXAMPLE
    C:\PS> ls c:\temp | sfs temp

    2000010.txt:2:*****This file should be named 2000010.txt or 2000010.zip******
    2000010.txt:5:Please take a look at the important information in this header.
    2000010.txt:12:**Etexts Readable By Both Humans and By Computers, Since 1971**
    2000010.txt:32:*****This file should be named 2000010.txt or 2000010.zip*****
    2000010.txt:51:in the first week of the next month.  Since our ftp program has
    2000010.txt:64:per text is nominally estimated at one dollar, then we produce 2

.NOTES
    General notes
#>
function Select-FuzzyString {
    [CmdletBinding()]
    [OutputType([Microsoft.PowerShell.Commands.MatchInfo])]
    param(        
        [Parameter(Mandatory, Position=0)]
        $Search='',
        [parameter(ValueFromPipeline=$true)]
        $Path
    )
    
    Begin   { $pattern = Get-FuzzyPattern $Search } 
    Process { $Path | Select-String -Pattern $pattern }
}

function Select-Fuzzy {
    [CmdletBinding()]
    param(        
        $Search='',
        [parameter(ValueFromPipeline=$true)]
        $InputObject
    )
    
    Begin 
    { 
        $pattern = Get-FuzzyPattern -Search $Search 
    } 
    Process 
    {
        If ($InputObject -match $pattern) { $InputObject } 
    }
}


function Select-FuzzyCommand {
    [CmdletBinding()]
    [OutputType([System.Management.Automation.AliasInfo],
                [System.Management.Automation.FunctionInfo],
                [System.Management.Automation.FilterInfo],
                [System.Management.Automation.CmdletInfo])]
    param(
        # Search String
        [Parameter(Mandatory)]
        [string]
        $Search = ''
    )

    Get-Command | Select-Fuzzy -Search $search
}

function Select-FuzzyChildItem {
    [CmdletBinding()]
    param(
        # Search String
        [Parameter(Mandatory, Position=0)]
        [string]
        $Search = '',
        
        # Specifies a path to one or more locations.
        [Parameter(ValueFromPipeline=$true,
                   Position=1,
                   HelpMessage="Path to one or more locations.")]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Path = $PWD,

        # Resurse
        [Parameter()]
        [switch]
        $Recurse
    )

    $params = $PSBoundParameters
    $params.Remove("Search") | Out-Null
    Get-ChildItem @params | Select-Fuzzy -Search $Search
}

function Select-FuzzyEvents {
    [CmdletBinding()]
    [OutputType([System.Diagnostics.EventLogEntry])]
    param(
        # Search String
        [Parameter(Mandatory, Position=0)]
        [string]
        $Search = '',

	    [Parameter(Position=1)]
        [string]
        $LogName = "Application"
    )

    $pattern = Get-FuzzyPattern -Search $Search 

    $appEvents = Get-EventLog -LogName $LogName

    $appEvents.Where({  
        $_.Source -match $pattern -or
        $_.MachineName -match $pattern -or
        $_.EntryType -match $pattern -or
        $_.Message -match $pattern
    })

}

function Select-FuzzyVariable {
    [CmdletBinding()]
    [OutputType([System.Object])]
    param(
        # Search String
        [Parameter(Mandatory, Position=0)]
        [string]
        $Search = ''
    )

    $pattern = Get-FuzzyPattern -Search $Search 

    $variables = Get-Variable

    $variables.Where({ 
        ($_.Key -match $pattern -or $_.Value -match $pattern) -and $_.Name -ne "pattern" -and $_.Name -ne "Search" -and $_.Name -ne '$'
    })
}

Set-Alias sfs Select-FuzzyString
Set-Alias sf Select-Fuzzy
Set-Alias sfcm Select-FuzzyCommand
Set-Alias sfci Select-FuzzyChildItem

#Update-TypeData -MemberType ScriptProperty -MemberName AsFuzzyPattern -Value {Get-FuzzyPattern $this} -TypeName "System.String" -Force