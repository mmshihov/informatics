#модель целочисленного деления

N = 8

def Divide1(dividend, divider):
    dividend    = dividend & ((1 << N) - 1)
    divider     = divider  & ((1 << N) - 1)
    divider     = divider << N
    
    quotent     = 0;
    reminder    = dividend
    i           = 0
    
    oldReminder = reminder
    while (i < N):
        i = i + 1
        
        quotent  = (quotent  << 1)
        reminder = (reminder << 1)
        
        if (oldReminder < 0):
            reminder = reminder + divider
        else:
            reminder = reminder - divider
        
        if (reminder >= 0):
            quotent = (quotent | 1)
            
        oldReminder = reminder

    if (reminder < 0):
        reminder = reminder + divider
        
    return (quotent, reminder >> N)
    
def Divide2(dividend, divider):
    dividend    = dividend & ((1 << N) - 1)
    divider     = divider  & ((1 << N) - 1)
    divider     = divider << N
    
    quotent     = 0;
    reminder    = dividend
    i           = 0
    
    oldReminder = reminder
    while (i < N):
        i = i + 1
        
        quotent  = (quotent << 1)
        divider  = (divider >> 1)

        if (oldReminder < 0):
            reminder = reminder + divider
        else:
            reminder = reminder - divider
        
        if (reminder >= 0):
            quotent = (quotent | 1)
            
        oldReminder = reminder

    if (reminder < 0):
        reminder = reminder + divider
        
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
 
#print(Divide1(7, 3)) 
Test1()
Test2()
