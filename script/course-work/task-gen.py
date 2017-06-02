import random

def isValidIntPart(i):
    n0 = n1 = 0
    while True:
        if (i == 0):
            break
        if ((i & 1) == 0):
            n0 = n0 + 1
        else:
            n1 = n1 + 1
        i = i >> 1
    return abs(n0-n1) <= 1

def getValidIntInRange(a, b):
    x = []
    for i in range(a, b):
        if (isValidIntPart(i)):
            x.append(i)
    return x

def getValidIntPartsOfA():
    return getValidIntInRange(260, 500)

def getValidIntPartsOfB():
    return getValidIntInRange(600, 900)

def IsValidIntABPair(a, b):
    return (a != b) and ((a + b) > 1050)

def getValidIntPartsOfC():
    return getValidIntInRange(20, 90)

def getValidIntPartsOfD():
    return getValidIntInRange(20, 90)

def IsValidIntCDPair(c, d):
    return ((c % d) != 0) and ((d % c) != 0)

def getValidRealParts():
    r = []
    for i in range(1,9):
        for j in range(1,9):
            d = i*10 + j
            if (i != j) and (d != 50) and (d != 25) and (d != 75):
                r.append(d/100)
    return r

random.seed()
    
validIntsOfA = getValidIntPartsOfA()
validIntsOfB = getValidIntPartsOfB()
validIntsOfC = getValidIntPartsOfC()
validIntsOfD = getValidIntPartsOfD()
validReal    = getValidRealParts()

rs = []
while True:
    r = []
    while True:
        a = random.choice(validIntsOfA)
        b = random.choice(validIntsOfB)
        if (IsValidIntABPair(a, b)):
            r.append(a + random.choice(validReal))
            r.append(b + random.choice(validReal))
            break;

    while True:
        c = random.choice(validIntsOfC)
        d = random.choice(validIntsOfD)
        if (IsValidIntCDPair(c, d)):
            r.append(c)
            r.append(d)
            break;
    
    rs.append(r)
    if (len(rs) > 100):
        break;

for r in rs:
    print("A={:-.2f}\tB={:-.2f}\tC={}\tD={}".format(r[0], r[1], r[2], r[3]))

