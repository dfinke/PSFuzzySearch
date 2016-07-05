function Select-FuzzyString {
    param(        
        $search='',
        [parameter(ValueFromPipeline=$true)]
        $data
    )
    
    Begin   { $search = $search.ToCharArray() -join '.*?' } 
    Process { if($data -match $search) { $data } }
}

set-alias sfs select-fuzzystring