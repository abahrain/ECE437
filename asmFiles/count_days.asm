#---------------------------------------
# mult
#---------------------------------------

# set the address where you want this
# code segment
  org   0x0000
  # set up stack
  addiu $29, $0, 0xFFFC

  # test operands
  addiu $17, $0, 28 # day
  addiu $18, $0, 8  # month
  addiu $19, $0, 2014 # year

  # temp1
  addiu $10, $0, 1
  subu  $10, $18, $10
  addiu $3, $0, 30
  push  $3
  push  $10
  jal   mult
  pop   $10

  # temp2
  addiu $11, $0, 2000
  subu  $11, $19, $11
  addiu $3, $0, 365
  push  $3
  push  $11
  jal   mult
  pop $11

  # days
  addu  $12, $17, $10
  addu  $12, $12, $11
  push  $12
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
