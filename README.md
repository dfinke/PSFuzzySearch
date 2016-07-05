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