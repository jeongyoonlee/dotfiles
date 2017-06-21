## Removing ^H
```
:g/[\b]/while getline('.') =~ '[^\b]\b' | s/[^\b]\b//g | endwhile
```
