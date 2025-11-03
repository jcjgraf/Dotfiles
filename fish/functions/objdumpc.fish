function objdumpc --wraps='objdump --disassembler-color=on --visualize-jumps=color' --description 'alias objdumpc=objdump --disassembler-color=on --visualize-jumps=color'
    objdump --disassembler-color=on --visualize-jumps=color $argv
end
