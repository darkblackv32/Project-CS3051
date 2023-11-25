#ASM ARM "ENCODER"
CMMDS = ["ADD","SUB","ORR","AND","FMUL","B"]
pc = 0
#CONSTANTS
op = {
    "ADD"  : "00",
    "SUB"  : "00",
    "ORR"  : "00",
    "AND"  : "00",
    "FMUL" : "00",
    "LSL"  : "00",
    "LSR"  : "00",
    "B"    : "10",
    "LDR"  : "01",
    "STR"  : "01",
}

funct = {
    "ADD"  : "0100",
    "SUB"  : "0010",
    "ORR"  : "1100",
    "AND"  : "0000",
    "FMUL" : "1111",
    "LSL"  : "1101",
    "LSR"  : "1101",
}

sh = {
    "LSL" : "00",
    "LSR" : "01",
}

memFunct = {
    "LDR" : "011001",
    "STR" : "011000",
}

conds = {
    "EQ" : "0000",
    "NE" : "0001",
    "CS" : "0010",
    "CC" : "0011",
    "MI" : "0100",
    "PL" : "0101",
    "VS" : "0110",
    "VC" : "0111",
    "HI" : "1000",
    "LS" : "1001",
    "GE" : "1010",
    "LT" : "1011",
    "GT" : "1100",
    "LE" : "1101",
}

def encondeDP(conds,cmd,I,S,Rn,Rd,Src2):
    return  conds + "00" + I + cmd + S + Rn + Rd + Src2

def encodeB(conds,imm24):
    return conds + "10" + "10" + imm24

def encondeMR(conds,cmd,rn,rd,Src2):
    return conds + "01" + cmd + rn + rd + Src2 

def parser(line):
    #remove \n
    line = line[:-1]
    #replace all , for espaces
    line = line.replace(","," ")
    
    #replace all [ for espaces]
    line = line.replace("[","")
    line = line.replace("]","")
    #remove all ;
    try:
        line = line.split(";")[0]
    except:
        raise Exception("Comment not closed")
    #parse line
    return line.split(" ")

def twos_complement_binary(num, num_bits):
    # Check if the number is negative
    if num < 0:
        binary_representation = bin((1 << num_bits) + num)[2:]
    else:
        binary_representation = bin(num)[2:].zfill(num_bits)

    return binary_representation

def getImm(imm):
    if(imm[0] == "#"):
        return imm[1:]
    else: 
        return ""
    
def getReg(register):
    return bin(int(register.split("R")[1]))[2:].zfill(4)


def decodeFunc(OPCODE):
    if (OPCODE[-1] == "S") :
        S = "1"
        OPCODE = OPCODE[:-1]
    else:
        S = "0"

    if OPCODE[-2:] in conds:
        COND = conds[OPCODE[-2:]]
        OPCODE = OPCODE[:-2]
    else:
        COND ="1110"

    FUNC = OPCODE
    return (COND,FUNC,S)
    

#Use args to get file name
def main():
    fileSrc = open("src.s","r")
    fileLab = open("src.s","r")
    fileOut = open("memfile.dat","w")

    pc = 0
    instr = None
    labels = {}


    #GET LABELS
    for index,line in enumerate(fileLab):
        #FORMAT INPUT
        line = parser(line)

        #check if is a empty line
        if (line[0] == ""):
            continue
    
        #check if is a comment
        if (line[0][0] == "/"):
            continue

        #CHECK IF IS A LABEL
        if (line[0][-1] == ":"):
            labels[line[0][:-1]] = pc
            continue

        pc += 4

    pc = 0
    level = 0

    for index,line in enumerate(fileSrc):
        level += 1
        print("Line:",level)
        #FORMAT INPUT
        line = parser(line)

        #check if is a empty line
        if (line[0] == ""):
            continue
    
        #check if is a comment
        if (line[0][0] == "/"):
            continue

        #CHECK IF IS A LABEL
        if (line[0][-1] == ":"):
            continue

        
        #ENCODE TO BINARY
        cond, func, setFlags = decodeFunc(line[0])
        opcode = op[func]
        
        #CHECK POINT
        #print(cond,opcode,func,setFlags)
        if opcode == "00":
            #print("DP")
            #check if is SHIFT OR else
            if (func in sh):
                shamt = bin(int(getImm(line[3])))[2:].zfill(5)
                Rm = getReg(line[2])
                Rd = getReg(line[1])
                src2 = shamt + sh[func] + "0" + Rm
                #print("SH:",setFlags)
                instr = encondeDP(cond,funct[func],"0",setFlags,"0000",Rd,src2)
            else:
                imm = getImm(line[3]) if (func != "FMUL")  else ""
                Rn = getReg(line[2])
                Rd = getReg(line[1])
                #build src2
                if (imm != ""):
                    src2 = bin(int(imm))[2:].zfill(12)
                    instr = encondeDP(cond,funct[func],"1",setFlags,Rn,Rd,src2)
                else:
                    src2 = getReg(line[3]).zfill(12)
                    instr = encondeDP(cond,funct[func],"0",setFlags,Rn,Rd,src2)
                #nm = encondeDP(func)
                pass
        elif opcode == "01":
            #print("MEM")
            Rd = getReg(line[1])
            Rn = getReg(line[2])
            imm = bin(int(getImm(line[3])))[2:].zfill(12)  

            instr = encondeMR(cond,memFunct[func],Rn,Rd,imm)
        else:
            #print("B")
            #Get label
            labelPC = labels[line[1]]
            #Get offset
            if (labelPC > pc):
                offset = labelPC - (pc + 8)
            else:
                offset = (pc + 8) - labelPC 

            imm24 = twos_complement_binary(offset // 4,24)
            #Get imm24
            instr = encodeB(cond,imm24)
        pc += 4

        toFile = hex(int(instr,2))[2:].upper()
        #WRITE one byte per line
        fileOut.write("//" + str(line) + "\n")
        for i in range(0,len(toFile),2):
            fileOut.write(toFile[i:i+2])
            fileOut.write( "\n")

        fileOut.write("\n")
        print(func  + " => " + instr)

    fileSrc.close()
    fileOut.close()
    fileLab.close()


if __name__ == "__main__":
    print("ARM ASSEMBLER")
    print("Reading ./src.s ...")
    main()
    print("DONE! Written to memfile.dat")

