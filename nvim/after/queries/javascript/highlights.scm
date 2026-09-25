; ;; extends
; ((string_fragment) @injection.content 
;            (#set! injection.language "html"))

; ;extends
; ((comment) @_comment
;  (#match? @_comment "(_html|_HTML)")
;   value: (template_string) @SESSO (#offset! @SESSO 0 1 0 -1)
; )

; ;extends
; ((comment) @_comment
;  (#match? @_comment "(_html|_HTML)")
;   value: (template_string
;          .((string_fragment).(template_substitution)?) @PROVA
;          .((string_fragment).(template_substitution)?)* @PROVA
;          .((string_fragment).(template_substitution)?) @PROVA
;          .
;    ) 
; )
; ;extends
; ((comment) @_comment
;  (#match? @_comment "(_html|_HTML)")
;   value: (template_string
;          .((string_fragment) (template_substitution)?)* @SESSO
;          .
;     ;(((string_fragment) (template_substitution)?))* @SESSO
;    ) 
; )
; ;extends
; ((comment) @_comment
;  (#match? @_comment "(_html|_HTML)")
;   value: (template_string
;          .((string_fragment).(template_substitution)?) @SESSO1
;          .((string_fragment).(template_substitution)?)* @SESSO1
;          .((string_fragment).(template_substitution)?) @SESSO1
;          .
;          
;     ;(((string_fragment) (template_substitution)?))* @SESSO
;    ) 
; )

