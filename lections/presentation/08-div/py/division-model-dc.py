#без восстановления остатков в ДК

#получается плохой остаток, когда делимое отрицательно и кратно делителю
#когда кратно:
#(-A)/(+d)
#1) 


N = 8 #[-2^{7}, +2^{7} + 1]

def IsSameSigns(x,y):
    return (x < 0) == (y < 0)

def Divide1(dividend, divider):
    dividend    = dividend
    divider     = divider
    divider     = divider << N
    
    quotent     = -1;
    reminder    = dividend
    i           = 0
    
    if (IsSameSigns(dividend, divider)):
        quotent = 0
        
    while (i < N):
        i = i + 1
        
        quotent  = (quotent  << 1)
        reminder = (reminder << 1)
        
        if (IsSameSigns(reminder, divider)):
            reminder = reminder - divider
        else:
            reminder = reminder + divider
        
        r = 0
        if (IsSameSigns(reminder, dividend)):
            r = 1
        
        if (not IsSameSigns(dividend, divider)):
            r = ~r
            
        quotent = (quotent | (r & 1))

    if (dividend < 0):
        if (divider < 0):
            if (reminder == 0):
                quotent = quotent + 1
            elif (reminder == divider):
                quotent = quotent + 1 
                reminder = 0
            elif (reminder >= 0):
                reminder = reminder + divider
        else:
            if (reminder == 0):
                reminder = 0
            elif (reminder == -divider):
                reminder = 0
            elif (reminder >= 0):
                quotent = quotent + 1 
                reminder = reminder - divider
            else:
                quotent = quotent + 1 
    else:
        if (divider < 0):
            quotent = quotent + 1
            if (reminder < 0):
                reminder = reminder - divider
        else:
            if (reminder < 0):
                reminder = reminder + divider
    
    return (quotent, reminder >> N)
    
def Divide2(dividend, divider):
    dividend    = dividend
    divider     = divider
    divider     = divider << N
    
    quotent     = -1;
    reminder    = dividend
    i           = 0
    
    if (IsSameSigns(dividend, divider)):
        quotent = 0
        
    while (i < N):
        i = i + 1
        
        quotent  = (quotent << 1)
        divider  = (divider >> 1)

        if (IsSameSigns(reminder, divider)):
            reminder = reminder - divider
        else:
            reminder = reminder + divider
        
        r = 0
        if (IsSameSigns(reminder, dividend)):
            r = 1
        
        if (not IsSameSigns(dividend, divider)):
            r = ~r
            
        quotent = (quotent | (r & 1))
        
    if (dividend < 0):
        if (divider < 0):
            if (reminder == 0):
                quotent = quotent + 1
            elif (reminder == divider):
                quotent = quotent + 1 
                reminder = 0
            elif (reminder >= 0):
                reminder = reminder + divider
        else:
            if (reminder == 0):
                reminder = 0
            elif (reminder == -divider):
                reminder = 0
            elif (reminder >= 0):
                quotent = quotent + 1 
                reminder = reminder - divider
            else:
                quotent = quotent + 1 
    else:
        if (divider < 0):
            quotent = quotent + 1
            if (reminder < 0):
                reminder = reminder - divider
        else:
            if (reminder < 0):
                reminder = reminder + divider
            
    return (quotent, reminder)

def Test1():
    a = -(1 << (N-1))
    b = (1 << (N-1)) - 1
    i = a
    while (i <= b):
        j = a
        while (j <= b):
            if (j != 0):
                (q, r) = Divide1(i, j)
                #print(i," div ", j, " = ", q," rem ",r)
                if (r*r >= j*j):
                    print("Bad Reminder", i, j, q, r)
                if (q * j + r != i):
                    print("Error!!!", i, j, q, r)
            j = j + 1
        i = i + 1

def Test2():
    a = -(1 << (N-1))
    b = (1 << (N-1)) - 1
    i = a
    while (i <= b):
        j = a
        while (j <= b):
            if (j != 0):
                (q, r) = Divide2(i, j)
                #print(i," div ", j, " = ", q," rem ",r)
                if (r*r >= j*j):
                    print("Bad Reminder", i, j, q, r)
                if (q * j + r != i):
                    print("Error!!!", i, j, q, r)
            j = j + 1
        i = i + 1

 
print("1st")
Test1()

print("2nd")
Test2()
