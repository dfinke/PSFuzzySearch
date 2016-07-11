# Fuzzy Search

[How is the fuzzy search algorithm in Sublime Text designed?](https://www.quora.com/How-is-the-fuzzy-search-algorithm-in-Sublime-Text-designed)

Here it is in PowerShell.

```
.\countries.ps1 | Select-FuzzyString pia
.\countries.ps1 | Select-FuzzyString uae
.\countries.ps1 | Select-FuzzyString svg
.\countries.ps1 | Select-FuzzyString bh

.\countries.ps1 | sfs united
```

## In Action

![](https://raw.githubusercontent.com/dfinke/PowerShellFuzzySearch/master/media/fuzzysearch.gif)


## Changes

### 7/11/2016
Thank you [Chris Hunt](https://github.com/cdhunt)
* Adds Get-FuzzyCommand and Get-FuzzyChildItem
* Adds a Recurse switch to Get-FuzzyChildItem
* Extact the creation of the Regex pattern to use with any Pattern param
* Extact the creation of the Regex pattern to use with any Pattern param
* Fixes using [Regex] type breaking file system object matching
* Select-FuzzyVariable