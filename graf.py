import sqlite3
import pandas as pd
import matplotlib.pyplot as plt

# Připojení k SQLite databázi
conn = sqlite3.connect("sakila.db")

# SQL dotaz na vývoj počtu výpůjček podle měsíců
query = """
SELECT strftime('%Y-%m', rental_date) AS month, COUNT(rental_id) AS rentals
FROM rental
GROUP BY month
ORDER BY month;
"""

# Načtení dat do Pandas DataFrame
df = pd.read_sql(query, conn)

# Vykreslení grafu
plt.figure(figsize=(12, 6))

# Podbarvení plochy pod křivkou světle modrou barvou
plt.fill_between(df["month"], df["rentals"], color="lightblue", alpha=0.4)

# Vykreslení hlavní křivky
plt.plot(df["month"], df["rentals"], marker="o", linestyle="-", label="Počet výpůjček", color="blue")

# Přidání hodnot do bodů grafu
for i, txt in enumerate(df["rentals"]):
    plt.text(df["month"][i], df["rentals"][i], str(txt), ha="center", va="bottom", fontsize=10, color="black")

# Popisky os a název grafu
plt.xlabel("Měsíc")
plt.ylabel("Počet výpůjček")
plt.title("Vývoj počtu výpůjček podle měsíců")
plt.xticks(rotation=45)
plt.legend()

# Odstranění mřížky (vodících linií)
plt.grid(False)

# Zobrazení grafu
plt.show()

# Zavření spojení
conn.close()
