function Select-FuzzyMatch {
    param($pattern, $str)

    # Score consts
    $adjacency_bonus = 5 # bonus for adjacent matches
    $separator_bonus = 10 # bonus if match occurs after a separator
    $camel_bonus = 10 # bonus if match is uppercase and prev is lower
    $leading_letter_penalty = -3 # penalty applied for every letter in str before the first match
    $max_leading_letter_penalty = -9 # maximum penalty for leading letters
    $unmatched_letter_penalty = -1 # penalty for every letter that doesn't matter

    # Loop variables
    [int]$score = 0
    $patternIdx = 0
    $patternLength = $pattern.length
    $strIdx = 0
    $strLength = $str.length
    $prevMatched = $false
    $prevLower = $false
    $prevSeparator = $true       # true so if first letter match gets separator bonus

    # Use "best" matched letter if multiple string letters match the pattern
    $bestLetter = $null
    $bestLower = $null
    $bestLetterIdx = $null
    $bestLetterScore = 0

    $matchedIndices = @()

    # Loop over strings
    while ($strIdx -ne $strLength) {

        [string]$patternChar = $null
        if ($patternIdx -ne $patternLength) {
            $patternChar = $pattern[$patternIdx]
        }

        [string]$strChar = $str[$strIdx]

        if ($null -ne $patternChar) {
            [string]$patternLower = $patternChar.ToLower()
        }

        $strLower = $strChar.ToLower()
        $strUpper = $strChar.ToUpper()

        $nextMatch = $patternChar -and $patternLower -eq $strLower
        $rematch = $bestLetter -and $bestLower -eq $strLower

        $advanced = $nextMatch -and $bestLetter
        $patternRepeat = $bestLetter -and $patternChar -and $bestLower -eq $patternLower

        if ($advanced -or $patternRepeat) {
            $score += $bestLetterScore
            $matchedIndices += $bestLetterIdx
            $bestLetter = $null
            $bestLower = $null
            $bestLetterIdx = $null
            $bestLetterScore = 0
        }

        if ($nextMatch -or $rematch) {
            $newScore = 0;

            # Apply penalty for each letter before the first pattern match
            # Note: std::max because penalties are negative values. So max is smallest penalty.
            if ($patternIdx -eq 0) {
                $penalty = [Math]::max($strIdx * $leading_letter_penalty, $max_leading_letter_penalty)
                $score += $penalty
            }

            # Apply bonus for consecutive bonuses
            if ($prevMatched) {
                $newScore += $adjacency_bonus
            }

            # Apply bonus for matches after a separator
            if ($prevSeparator) {
                $newScore += $separator_bonus
            }

            # Apply bonus across camel case boundaries. Includes "clever" isLetter check.
            if ($prevLower -and $strChar -eq $strUpper -and $strLower -ne $strUpper) {
                $newScore += $camel_bonus
            }

            # Update pattern index IF the next pattern letter was matched
            if ($nextMatch) {
                ++$patternIdx
            }

            # Update best letter in str which may be for a "next" letter or a "rematch"
            if ($newScore -ge $bestLetterScore) {

                # Apply penalty for now skipped letter
                if ($null -ne $bestLetter) {
                    $score += $unmatched_letter_penalty
                }

                $bestLetter = $strChar
                $bestLower = $bestLetter.ToLower()
                $bestLetterIdx = $strIdx
                $bestLetterScore = $newScore
            }

            $prevMatched = $true
        }
        else {
            # Append unmatch characters
            $score += $unmatched_letter_penalty
            $prevMatched = $false
        }

        # Includes "clever" isLetter check.
        $prevLower = $strChar -eq $strLower -and $strLower -ne $strUpper
        $prevSeparator = $strChar -eq '_' -or $strChar -eq ' '

        ++$strIdx
    }

    # Apply score for last match
    if ($bestLetter) {
        $score += $bestLetterScore
        $matchedIndices += $bestLetterIdx
    }

    $matched = $patternIdx -eq $patternLength

    [pscustomobject]@{
        str     = $str
        matched = $matched
        score   = $score
    }
}