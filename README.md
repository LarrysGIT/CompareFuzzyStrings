# Credit to

* https://www.datacamp.com/community/tutorials/fuzzy-string-python

* https://en.wikipedia.org/wiki/Levenshtein_distance

* A dummy conversion from python to powershell

* The purpose of the conversion is recently a new requirement to handle typo in the customer details. e.g. address, names etc....

## Usage

```powershell
>
> . .\CompareFuzzyStrings.ps1
>
> New-Object CompareFuzzyStrings "868d6056869b","a8199d1402dc"
String1            : 868d6056869b
String2            : a8199d1402dc
Description        : The strings are 12 edits away
MinimumEditsNeeded : 12
Ratio              : 0.25

> New-Object CompareFuzzyStrings "larry.song","laryr.song"
String1            : larry.song
String2            : laryr.song
Description        : The strings are 2 edits away
MinimumEditsNeeded : 2
Ratio              : 0.9
```
