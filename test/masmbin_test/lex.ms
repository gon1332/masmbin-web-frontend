main:
    add $t0, $zero, $5
    addi $s0, $t2, 0xd34d
    addu $t9, $s1, $t8
middle:
    addiu $6, $5, 7
    div $a0, $a1, $a3
comp:
    mult $k0, $s1, $23  # fake_label:
#    lw  $t0, 16($t1)
    beq $t0, $t1, middle
    beq $t0, $t1, comp
    j middle
