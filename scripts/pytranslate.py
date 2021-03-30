command = "translate-cli -o -f pt -t en Percebemos, cada vez mais, que o entendimento das metas propostas garante a contribuição de um grupo importante na determinação do impacto na agilidade decisória."

# 1
#import os
#result = os.system(command)

# 2
import subprocess
output = subprocess.check_output(command, shell=True)
#output = output.replace("b'", '')
print(output.decode("utf-8") )