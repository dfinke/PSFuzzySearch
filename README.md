# Fuzzy Search

[How is the fuzzy search algorithm in Sublime Text designed?](https://www.quora.com/How-is-the-fuzzy-search-algorithm-in-Sublime-Text-designed)

<p align="center">
<a href="https://dougfinke.visualstudio.com/PSFuzzySearch/_build?buildId=94"><img src="https://dougfinke.visualstudio.com/PSFuzzySearch/_apis/build/status/PSFuzzySearch-CI?branchName=master"></a>
</p>

<!-- https://dougfinke.visualstudio.com/PSFuzzySearch/_build/results?buildId=94&view=logs -->

## In Action

![](https://raw.githubusercontent.com/dfinke/PowerShellFuzzySearch/master/media/fuzzysearch.gif)


# What's New 1.0
- Published to gallery - https://www.powershellgallery.com/packages/PSFuzzySearch
- Added `FuzzySearch` to objects Array, Hashtable and OrderedDictionary
- Supports aliases and functions

```powershell
Set-Alias sfs Select-FuzzyString
Set-Alias sf Select-Fuzzy
Set-Alias sfcm Select-FuzzyCommand
Set-Alias sfci Select-FuzzyChildItem
```