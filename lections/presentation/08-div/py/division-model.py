#модель целочисленного деления

# конс 18-55 конс 1-313 ивт-42
# экз  14-го 17-20 1-239
# 
# 41 конс 15 в 17-20 1-313
# 41 э 16 в 8-20 1-113





N = 8

def Divide1(dividend, divider):
    dividend    = dividend & ((1 << N) - 1)
    divider     = divider  & ((1 << N) - 1)
    divider     = divider << N
    
    quotent     = 0;
    reminder    = dividend
    i           = 0
    
    while (i < N):
        i = i + 1
        
        quotent  = (quotent  << 1)
        reminder = (reminder << 1)
        
        if ((reminder - divider) >= 0):
            quotent = (quotent | 1)
            reminder = reminder - divider

    return (quotent, reminder >> N)
    
def Divide2(dividend, divider):
    dividend    = dividend & ((1 << N) - 1)
    divider     = divider  & ((1 << N) - 1)
    divider     = divider << N
    
    quotent     = 0;
    reminder    = dividend
    i           = 0
    
    while (i < N):
        i = i + 1
        
        quotent  = (quotent << 1)
        divider  = (divider >> 1)
        
        if ((reminder - divider) >= 0):
            quotent = quotent | 1
            reminder = reminder - divider
        
    return (quotent, reminder)

def Test1():
    i = 0;
    while (i < (1 << N)):
        j = 1
        while (j < (1 << N)):
            (q, r) = Divide1(i, j)
            if (q * j + r != i):
                print("Error!!!", i, j, q, r)
            j = j + 1
        i = i + 1
        
def Test2():
    i = 0;
    while (i < (1 << N)):
        j = 1
        while (j < (1 << N)):
            (q, r) = Divide2(i, j)
            if (q * j + r != i):
                print("Error!!!", i, j, q, r)
            j = j + 1
        i = i + 1
            
Test1()
Test2()
