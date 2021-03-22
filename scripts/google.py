import requests

r = requests.post("https://translation.googleapis.com/language/translate/v2", 
    data={
      "q": ["Hello world", "My name is Jeff"],
      "target": "de"
    }
)

print(r.status_code, r.reason)
print(r.text[:300] + '...')