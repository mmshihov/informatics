#генератор заданий




shifts  = [r'\Opcode{ror}', r'\Opcode{rol}']
logics  = [[r'\Opcode{or}', r'\Opcode{not}'], [r'\Opcode{nor}'], [r'\Opcode{nand}'], [r'\Opcode{xor}', r'\Opcode{or}']]
adds    = [r'\Opcode{add}', r'\Opcode{sub}']
jumps   = [r'\Opcode{jz}', r'\Opcode{jo}']


for shift in shifts:
    for logic in logics:
        logicstr = ""
        for basis in logic:
            logicstr = logicstr + ', ' + basis
        for add in adds:
            for jump in jumps:
                common = r'\Opcode{in}, \Opcode{out}, '
                print(
                    "\\item {}{}{}, {}, {};".format(common, shift, logicstr, add, jump))


