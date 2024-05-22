" VIM Syntax File
" Language: NESA Pseudocode
" Maintainer: Hellx2
" Latest Revision: 16 May 2024

if exists("b:current_syntax")
    finish
endif

syn keyword NESAPSCKeyword IF THEN ELSE ELSEIF ENDIF BEGIN END CASEWHERE OTHERWISE ENDCASE WHILE ENDWHILE REPEAT UNTIL FOR NEXT
syn match NESAPSCKeyword "\(FOR\s\+.\+\s\+\)\@<=IN\(\s\+.\+\s\+TO\s\+.\+\)\@="
syn match NESAPSCKeyword "\(FOR\s\+.\+\s\+IN\s\+.\+\s\+\)\@<=TO"
syn match NESAPSCKeyword "\(FOR\s\+.\+\s\+\IN\s\+.\+\s\+TO\s\+.\+\s\+\)\@<=STEP\(\s\+.\+\)\@="

let b:current_syntax = "nesa-psc"

hi def link NESAPSCKeyword Keyword
