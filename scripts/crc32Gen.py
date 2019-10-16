import math
import sys
def crcGen(currCRC, newData, orientation):
    crc = list()
    data = list()
    orient = list()
    newCRC = list()
    decCRC = 0
    for i in range(0,32):
        crc.append((currCRC >> i) & 1)
        data.append((newData >> i) & 1)
        orient.append((orientation >> i) & 1)
        newCRC.append(0)

    #print("orinet: " + str(orient))
    #print("new data: " + str(data))
    #print("crc loaded: " + str(crc))
    count = 0
    for i in range(0,32):
        if orient[0] == 1:
            newCRC[0] = data[31-i] ^ crc[31]
        else:
            newCRC[0] = data[31-i]
        #print(data[31 - i])
        for j in range(1,32):
            if orient[j] == 1:
                newCRC[j] = crc[j-1] ^ crc[31]
            else:
                newCRC[j] = crc[j-1]
        for k in range(0,32):
            crc[k] = newCRC[k]
        #print(newCRC)
        count = count + 1
    #print(orient)
    #print(data)
    #print(crc)
    #print(count)

    for a in range(0,32):
        if newCRC[a] == 1:
            decCRC = round(decCRC + math.pow(2,a))
        else:
            decCRC = decCRC + 0
    return decCRC

if __name__ == "__main__":
    if (len(sys.argv) == 1):
        while(True):
            currCRC = int(input("currCRC:"))
            newData = int(input("newData:"))
            orientation = int(input("orientation:"))
            print(crcGen(currCRC,newData,orientation))
    else:
        print(crcGen(int(sys.argv[1]),int(sys.argv[2]),int(sys.argv[3])))
