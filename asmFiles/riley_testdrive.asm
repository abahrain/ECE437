
  #------------------------------------------------------------------
  # R-type Instruction (ALU) Test Program
  #------------------------------------------------------------------

  org 0x0000

  # set up stack
  ori $29, $0, 0xFFFC
  j jumplink

itype:
  # put the decimal value -2 in reg 1
  lui $1, -1
  ori $1, $1, -2 #FF FF FF FE

  addiu $2, $1, 10 # should be 8, or 0x08
  push  $2

  andi  $2, $1, 0x11 # should be 0x10
  push  $2
  # skip BEQ, BNE
  lui   $2, 0xDEAD # should be 0xDEAD0000
  push  $2

  ori   $3, $0, 0x1000
  lw    $2, 4($3)  # should be 0x341DFFFC (see org 0x1000)
  push  $2

  ori   $2, $1, 1  # should be 0xFFFFFFFF
  push  $2

  slti  $2, $1, 0  # should be 1, 0x01
  push  $2

  sltiu $2, $1, 0  # should be 0, and not show in log
  push  $2

  ori   $3, $0, 0x1000
  ori   $2, $0, 0xABBA
  sw    $2, 8($3)  # should store 0xABBA at 0x1008
  # skip LL, SC

  xori  $2, $1, 0xAA00 # should be 0xFFFF55FE
  push $2
  halt

jumplink:
  jal   jumppad
  nop
  nop
  nop
  nop
jumppad:
  or    $1, $0, $31

  halt

branch:
  ori  $1, $0, 1  # load reg 1 with 1
  ori  $2, $0, 2  # load reg 2 with 2
  beq  $1, $2, b1 # shouldn't branch
  ori  $2, $0, 1  # load reg 2 with 1
  nop
  beq  $1, $2, b1 # should branch
  halt
b1:
  ori  $1, $0, 1  # load reg 1 with 1
  ori  $2, $0, 1  # load reg 2 with 1
  bne  $1, $2, b2 # shouldn't branch
  ori  $2, $0, 2  # load reg 2 with 2
  nop
  bne  $1, $2, b2 # should branch
  halt
b2:
  ori  $1, $0, 0xBEEF
  halt




rtype:
  # set up fun operands
  lui $1, -1
  ori $1, $1, -2 #FF FF FF FE
  ori $2, $0, 16 #00 00 00 10

  # run through r-types
  addu $3, $1, $2 # should be 14, or 0x0E
  push $3
  and  $3, $1, $2 # should be 16, or 0x10
  push $3
  #jr   $0  # will cause infinite loop!
  nor  $3, $1, $2 # should be 1, or 0x01
  push $3
  or   $3, $1, $2 # should be -2, or 0xFFFFFFFE
  push $3
  slt  $3, $1, $2 # should be 1, or 0x01
  push $3
  sltu $3, $1, $2 # should be 0, or 0x00 (doesn't show up in dump)
  push $3
  sll  $3, $1, 16 # should be 0xFFFE0000
  push $3
  srl  $3, $1, 16 # should be 0xFFFF
  push $3
  subu $3, $1, $2 # should be -18, or 0xFFFFFFEE
  push $3
  xor  $3, $1, $2 # should be 0xFFFFFFEE
  push $3
  halt  # that's all

  org 0x1000
  nop
  ori $29, $0, 0xFFFC  # not run, used as known data (0x341DFFFC)
  nop
