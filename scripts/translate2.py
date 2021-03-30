# example
# pip install -U deep_translator
import sys
from deep_translator import GoogleTranslator

translated = GoogleTranslator(source='pt', target='en').translate(sys.argv[1])
print(translated)
