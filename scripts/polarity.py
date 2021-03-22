# install
# $ pip install -U textblob
# $ python -m textblob.download_corpora

import sys
from googletrans import Translator
from textblob import TextBlob

translator = Translator()
translator = Translator(service_urls=[
    'translate.google.com',
    'translate.google.com.br',
])

translator.translate(sys.argv[1])

message = translator.translate(sys.argv[1], dest='en', src='pt').text

blob = TextBlob(message)

avg = 0

for sentence in blob.sentences:
    polarity = sentence.sentiment.polarity
    if polarity != 0:
        avg = avg + polarity

print(avg)