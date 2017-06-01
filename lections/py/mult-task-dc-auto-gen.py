#задания на контрольную по методам умножения
#доплнительный код, автоматическая коррекция

multipliers    = [-18,-13,-25,27,13,11]
multiplicands  = [17,19,25,-17,-19,-25]
processes = ["I","II","III","IV"]
number    = 1

def IsGoodTask(multiplier,multiplicand,process):
    return True
        
    
def PrintTask(multiplier,multiplicand,process):
    global number
    if (IsGoodTask(multiplier,multiplicand,process)):
        print("Задание {}. Выполнить умножение чисел: {} (множитель) и {} (множимое) {}-м способом умножения в дополнительном коде с автоматической коррекцией. Масштаб выбрать самостоятельно.".format(number, multiplier, multiplicand, process))
        number = number + 1

for multiplier in multipliers:
    for multiplicand in multiplicands:
        for process in processes:
            PrintTask(multiplier,multiplicand,process)
