#задания на контрольную по методам умножения
#дополнительный код, ручная (простая) коррекция
digits    = [3,5,6]
signs     = [1,-1]
processes = ["I","II","III","IV"]
number    = 1

def IsGoodTask(xsign,x,ysign,y,process):
    if ((xsign*ysign < 0) and (x == y)):
        return False
    return not ((xsign < 0) and (ysign < 0))
        
    
def PrintTask(xsign,x,ysign,y,process):
    global number
    if (IsGoodTask(xsign,x,ysign,y,process)):
        print("Задание {}: выполнить умножение чисел {} (множитель) и {} (множимое) {}-м способом умножения в дополнительном коде с ручной коррекцией. Масштаб выбрать самостоятельно.".format(number, xsign*x, ysign*y, process))
        number = number + 1

for x in digits:
    for xsign in signs:
        for y in digits:
            for ysign in signs:
                for process in processes:
                    PrintTask(xsign,x,ysign,y,process)
