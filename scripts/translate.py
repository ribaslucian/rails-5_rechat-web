# example
# $ pip install googletrans
# py translate.py "Nao estou muito bem."
# py scripts/translate.py "Nao estou muito bem."

import sys
from googletrans import Translator

translator = Translator()
translator = Translator(service_urls=[
    'translate.google.com',
    'translate.google.com.br',
])

translator.translate(sys.argv[1])

print(translator.translate(sys.argv[1], dest='en', src='pt').text)