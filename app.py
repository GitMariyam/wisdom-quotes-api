from flask import Flask, jsonify
import random

app = Flask(__name__)

QUOTES = [
    "Knowing yourself is the beginning of all wisdom. – Aristotle",
    "The only true wisdom is in knowing you know nothing. – Socrates",
    "Turn your wounds into wisdom. – Oprah Winfrey",
    "Wisdom is not a product of schooling but of the lifelong attempt to acquire it. – Albert Einstein",
    "It is the mark of an educated mind to be able to entertain a thought without accepting it. – Aristotle",
    "In the middle of difficulty lies opportunity. – Albert Einstein",
    "The fool doth think he is wise, but the wise man knows himself to be a fool. – Shakespeare",
    "Silence is the sleep that nourishes wisdom. – Francis Bacon"
]

@app.route('/')
def home():
    return "<h2>🧠 Welcome to the Wisdom Quotes API</h2><p>Visit <code>/quote</code> to receive a random quote.</p>"

@app.route('/quote')
def quote():
    return jsonify({
        "quote": random.choice(QUOTES)
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)

