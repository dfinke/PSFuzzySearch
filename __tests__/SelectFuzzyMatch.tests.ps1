Describe "PSFuzzySearch tests" {
    BeforeAll {
        Import-Module $PSScriptRoot\..\PSFuzzySearch.psd1
    }

    It "Should be true" {
        $actual = Get-Content $PSScriptRoot\countries.txt | ForEach-Object { Select-FuzzyMatch bh $_ } | Where-Object matched

        $actual.Count | Should Be 8

        $first = ($actual | Sort-Object score -Descending)[0]
        $last = ($actual | Sort-Object score -Descending)[-1]

        $first.str   | Should Be 'Bhutan'
        $first.score | Should Be 11
        $last.str    | Should Be 'Congo, Democratic Republic of the'
        $last.score  | Should Be -40
    }

    It "Calcs bonus match" {
        $list = $(
            "invoke command"
            "Invoke Command"
            "invoke_command"
            "Invoke_Command"
            "InvokeCommand"
        )

        $actual = $list | ForEach-Object { Select-FuzzyMatch icm $_ }

        $actual.Count    | Should Be 5
        $actual[0].score | Should Be 14
        $actual[1].score | Should Be 14
        $actual[2].score | Should Be 14
        $actual[3].score | Should Be 14
        $actual[4].score | Should Be 5
    }
}