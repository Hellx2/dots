" VIM Syntax File
" Language: NESA Pseudocode
" Maintainer: Hellx2
" Latest Revision: 16 May 2024

if exists("b:current_syntax")
    finish
endif

syn keyword NESAPSCKeyword IF THEN ELSE ELSEIF ENDIF BEGIN END CASEWHERE OTHERWISE ENDCASE WHILE ENDWHILE REPEAT UNTIL NEXT OR AND
syn match NESAPSCFor "\(FOR\s\+.\+\s\+\)\@<=IN\(\s\+.\+\s\+TO\s\+.\+\)\@="
syn match NESAPSCFor "\(FOR\s\+.\+\s\+IN\s\+.\+\s\+\)\@<=TO"
syn match NESAPSCFor "\(FOR\s\+.\+\s\+\IN\s\+.\+\s\+TO\s\+.\+\s\+\)\@<=STEP\(\s\+.\+\)\@="
" TODO: Make this not match between FOR and TO and NEXT
" syn match NESAPSCFor "\(FOR\s\+.\+IN\s\+.\+TO\s\+.\+\(\n.*\)\+\)\@<=\_.\{-}NEXT"
syn match NESAPSCFor "FOR\(\s\+.\+IN\s\+.\+TO\s\+.\+\(\n.*\)\+\s*NEXT\s*\)\@="

syn match NESAPSCNumber "\(0x[0-9a-fA-F]\+\)\|\(0o[0-7]\+\)\|\(0b[01]\+\)\|\(\d\+\(\.\d\+\)\?\)"

syn match NESAPSCFunction "\(\(BEGIN\|END\)\s\+\)\@<=.\+\n"

syn match NESAPSCOperator "[<>*=/+-]\+"

" Folds and stuff
syn region NESAPSCForBlock start="\(FOR\(\s\+.\+IN\s\+.\+TO\s\+.\+\(\(\n.*\)\+\s*NEXT\s*\)\@=\)\)\@<=" end="\(NEXT\)\@=" fold transparent

" Comments
syn match NESAPSCComment "\(#\|\/\/\|--\).*$"

let b:current_syntax = "nesa-psc"

hi def link NESAPSCKeyword Keyword
hi def link NESAPSCFor Keyword
hi def link NESAPSCComment Comment
hi def link NESAPSCForBlock Comment
hi def link NESAPSCNumber Number
hi def link NESAPSCFunction Function
hi def link NESAPSCOperator Operator
