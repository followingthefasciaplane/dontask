SerializeToBuffer:
    push rbp
    mov rbp, rsp
    sub rsp, 16

    ; call CBaseVisualsDataCompare::SerializeToBuffer(buf)
    mov rax, [rdi]
    mov rax, [rax]
    call rax

    ; serialize(buf, m_bIsBody)
    lea rax, [rdi + 8] ; m_bIsBody addy
    mov [rbp - 8], rax ; store on stack
    mov rax, [rip + Serialize] ; get func addy
    call rax

    ; serialize(buf, CUtlString(m_pchSkinIdent))
    lea rax, [rdi + 16] ; m_pchSkinIdent addy
    mov [rbp - 16], rax ; store on stack
    mov rax, [rip + CUtlString_ctor] ; get const addy
    call rax
    mov rax, [rip + Serialize] ; again
    call rax
    mov rax, [rip + CUtlString_dtor] ; get the other 2
    call rax

    add rsp, 16
    pop rbp
    ret
