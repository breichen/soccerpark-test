# Soccerpark App – Testseite (GitHub Pages)

Kleine, nicht verlinkte Testseite für die Web-Version (PWA) der Soccerpark-App.

- `index.html` – Startseite mit Knopf „App öffnen“, Installationshinweisen und QR-Code
- `app/` – die gebaute Flutter-App (wird von `build_app.ps1` erzeugt)
- `.nojekyll` – GitHub Pages soll die Dateien unverändert ausliefern

## Einmalig einrichten

1. Auf github.com ein neues Repository **`soccerpark-test`** anlegen
   (Public; GitHub Pages ist im Gratis-Tarif nur für öffentliche Repositorys).
2. Diesen Ordner damit verbinden, z. B. mit GitHub Desktop
   („Add existing repository“ → `D:\Websites\soccerpark-test` → „Publish“),
   oder per Kommandozeile:

       git init -b main
       git add .
       git commit -m "Testseite"
       git remote add origin https://github.com/<benutzer>/soccerpark-test.git
       git push -u origin main

3. Auf GitHub im Repository: **Settings → Pages → Build and deployment →
   Source: Deploy from a branch → Branch: `main`, Ordner `/ (root)` → Save**.
4. Nach 1–2 Minuten ist die Seite erreichbar unter
   `https://<benutzer>.github.io/soccerpark-test/`.

## App bauen bzw. aktualisieren

    powershell -ExecutionPolicy Bypass -File .\build_app.ps1

Danach committen und pushen. GitHub Pages ist nach etwa einer Minute aktuell.
Zeigt der Browser noch die alte Version: App schließen und erneut öffnen.

Anderer Repository-Name? Dann `-Repo <name>` angeben, sonst bleibt die App leer:

    powershell -ExecutionPolicy Bypass -File .\build_app.ps1 -Repo mein-name

## Hinweise

- Unverlinkt heißt nicht geheim: Das Repository ist öffentlich, und wer die
  Adresse kennt, kann die App öffnen. Suchmaschinen werden per `noindex`
  gebeten, die Seite nicht aufzunehmen.
- Die Test-App nutzt dasselbe Supabase-Projekt wie die echte App:
  Testeinträge erscheinen in der echten Tages- und Monatswertung.
  Nach dem Test im Supabase-Dashboard (Table Editor → `online_highscores`) löschen.
- Runden und Spielernamen bleiben im Browser unter dieser Adresse und werden
  nicht in eine spätere Version auf soccerpark.at übernommen.
