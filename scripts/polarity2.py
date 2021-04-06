# install
# $ pip install -U textblob
# $ python -m textblob.download_corpora
# $ pip install -U deep_translator

import sys
# from googletrans import Translator
from textblob import TextBlob

from deep_translator import GoogleTranslator

message = GoogleTranslator(source='pt', target='en').translate(sys.argv[1])

blob = TextBlob(message)

avg = 0

for sentence in blob.sentences:
    polarity = sentence.sentiment.polarity
    if polarity != 0:
        avg = avg + polarity

print(avg)
