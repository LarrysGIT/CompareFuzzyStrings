
#
# An powershell implementation of the following great articles and people
# https://www.datacamp.com/community/tutorials/fuzzy-string-python
# https://en.wikipedia.org/wiki/Levenshtein_distance
# 

<#
    levenshtein_ratio_and_distance:
    Calculates levenshtein distance between two strings.
    If ratio_calc = True, the function computes the
    levenshtein distance ratio of similarity between two strings
    For all i and j, distance[i,j] will contain the Levenshtein
    distance between the first i characters of s and the
    first j characters of t
#>

class CompareFuzzyStrings
{
    # properties
    [string]$String1
    [string]$String2
    [string]$Description
    [int]$MinimumEditsNeeded
    [decimal]$Ratio

    # constructor
    CompareFuzzyStrings([string]$String1, [string]$String2)
    {
        $this.String1 = $String1
        $this.String2 = $String2

        $rows = $String1.Length + 1
        $cols = $String2.Length + 1

        # Initialize matrix of zeros
        $distance = New-Object "int[,]" $rows, $cols
        $distanceRatio = New-Object "int[,]" $rows, $cols
        # Populate matrix of zeros with the indeces of each character of both strings
        for($i = 1; $i -lt $rows; $i++)
        {
            for($j = 1; $j -lt $cols; $j++)
            {
                $distance[$i,0] = $i
                $distance[0,$j] = $j
                $distanceRatio[$i,0] = $i
                $distanceRatio[0,$j] = $j
            }
        }

        ## 
        # for($i = 0; $i -lt $rows; $i++){@(for($j = 0; $j -lt $cols; $j++){$distance[$i,$j]}) -join ","}

        # 
        $col = 0
        $row = 0
        for($col = 1; $col -lt $cols; $col++)
        {
            for($row = 1; $row -lt $rows; $row++)
            {
                if($String1[$col - 1] -eq $String2[$row - 1])
                {
                    # If the characters are the same in the two strings in a given position [i,j] then the cost is 0
                    $cost = 0
                    $costRatio = 0
                }
                else
                {
                    # In order to align the results with those of the Python Levenshtein package, if we choose to calculate the ratio
                    # the cost of a substitution is 2. If we calculate just distance, then the cost of a substitution is 1.
                    $cost = 1
                    $costRatio = 2
                }
                $distance[$row, $col] = [System.Linq.Enumerable]::Min([int[]]@(
                    ($distance[($row - 1), $col] + 1),
                    ($distance[$row, ($col - 1)] + 1),
                    ($distance[($row - 1), ($col - 1)] + $cost)
                ))
                $distanceRatio[$row, $col] = [System.Linq.Enumerable]::Min([int[]]@(
                    ($distanceRatio[($row - 1), $col] + 1),
                    ($distanceRatio[$row, ($col - 1)] + 1),
                    ($distanceRatio[($row - 1), ($col - 1)] + $costRatio)
                ))
            }
        }
        # print(distance) # Uncomment if you want to see the matrix showing how the algorithm computes the cost of deletions,
        # insertions and/or substitutions
        # This is the minimum number of edits needed to convert string a to string b
        $this.MinimumEditsNeeded = $distance[($row - 1), ($col - 1)]
        $this.Description = "The strings are {0} edits away" -f $this.MinimumEditsNeeded
        # Computation of the Levenshtein Distance Ratio
        $this.Ratio = ($String1.Length + $String2.Length - $distanceRatio[($row - 1), ($col - 1)])/($String1.Length + $String2.Length)
    }
}
