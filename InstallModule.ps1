$fullPath = 'C:\Program Files\WindowsPowerShell\Modules\PSFuzzySearch'

Robocopy . $fullPath /mir /XD .vscode .git media /XF appveyor.yml .gitattributes .gitignore