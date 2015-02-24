#---------------------------------------
# mult
#---------------------------------------

# set the address where you want this
# code segment
  org   0x0000
  # set up stack
  addiu $29, $0, 0xFFFC
  # test operands
  addiu $4, $0, 5
  push  $4
  addiu $4, $0, 10
  push  $4
  addiu $4, $0, 2
  push  $4
  jal   mult
  pop   $3
  halt

mult:
  # extract operands from stack
  pop   $3
  pop   $4

  # clear regs that will be used
  addiu $5, $0, 0x00 #result reg
  addiu $6, $0, 0x00 # i
loop:
  beq   $6, $3, exit
  addu  $5, $5, $4
  addiu $6, $6, 0x01
  j     loop
exit:
  # push the result
  push  $5
  # check if we're at the top of the stack. if not, recurse
  addiu $5, $0, 0xFFFFFFF8
  bne   $5, $29, mult
  jr    $31
