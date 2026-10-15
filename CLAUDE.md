# Arbeitsweise

## Reviews
Das Projekt hat drei Review-Agenten in `.claude/agents/`: `game-designer`, `ux-reviewer` und `code-reviewer`. Sie lesen nur und liefern priorisierte Befunde; umgesetzt wird im Hauptkontext.

Dazu kommt der `qa-playtester`: Er startet das Spiel wirklich (Headless-Tests, Bot-Simulation, Screenshots über `tools/qa/qa_screenshots.gd`) und ändert keinen Spielcode. Er läuft vor den drei Reviewern, damit der `ux-reviewer` seine Screenshots bekommt. Zusätze: `docs/review/qa-playtester.md`.

- Nach einem größeren Feature, einer neuen Mechanik oder UI-Änderung und vor Merges die passenden Reviewer parallel starten.
- Im Auftrag an jeden Reviewer die geänderten Dateien und das Ziel der Änderung nennen, plus eventuelle Sonderanweisungen des Nutzers.
- Befunde zusammenfassen, Widersprüche zwischen den Rollen benennen und Kritisches zuerst umsetzen. Größere Designänderungen vorher mit dem Nutzer abstimmen.
- Projektkontext für die Reviewer steht in `docs/review/brief.md`, rollenspezifische Anweisungen in `docs/review/<rolle>.md`. Nächtliche Review-Berichte liegen in `docs/review/berichte/`.

## Verbindliche Studio-Entscheidungen (Stand 15.10.2026)

Gelten, bis der Inhaber in der Sitzung ausdrücklich etwas anderes sagt. Quelle: Entscheidungsliste des Studios (BeachVibeStudio, `studio/entscheidungen.md`). Vor jeder Arbeitssitzung lesen.

1. **Fix vor Feature** (Studio-Handbuch §8): Nach jedem Review-Bericht zuerst die Punkte abarbeiten, die der Bericht als „ohne Abstimmung umsetzbar“ führt, mindestens alle kritischen; erst danach neue Features. Ein Befund, der im dritten Bericht in Folge offen steht, geht an den Inhaber („beheben, bewusst lassen oder streichen“).
2. **E33 (14.10.):** NEUSTART und NOCHMAL bleiben im selben Level, zusätzlicher Knopf „NEUES LEVEL“ (GD-K1, offen seit 01.10.; `_on_restart_pressed` ruft im Speedrun noch `begin_game()` ohne Level-ID).
3. **E34 (14.10.) – Regel-Freeze:** Genau **eine** Regelversion 4 bis zur Steam-Seite, und sie enthält: Dash 4,0 m (in Metern, nicht Ticks) · Start-Halt in jedem Level (Uhr ab erster Eingabe) · Geister ×1,2 erst nach Messung mit verwundbarem Bot (bei starker Abweichung erst Rückmeldung an den Inhaber) · Zielzeiten = Bot-Zeit ohne Dash × 1,08, auf 5 s gerundet, sichtbar im HUD. Reihenfolge: erst Fix-Woche inkl. Code-K1, dann RV4 in einem Schritt. Danach keine zeitrelevante Änderung ohne Inhaber.
   - **Merge-Sperre `feature/karte-m`:** Der Branch vergibt `RULES_VERSION := 4` ohne diese Inhalte (Dash dort ~3,6 m). Nicht nach `main` mergen, bevor RV4 die E34-Inhalte enthält – sonst braucht E34 eine Regelversion 5 und einen weiteren Bretter-Schnitt. Weicht der Inhaber davon ab, hier vermerken.
4. **Code-K1 (seit 05.10.):** Rückgabewert von `write_atomic` an allen Aufrufern auswerten (`leaderboard.gd`, `speedrun.gd`, `settings.gd`, `main.gd`), bevor eine weitere Migration nach `main` kommt.
5. **E24 und E20 (Explorer):** erst nach der Fix-Woche und nach Regelversion 4.
6. **Review deckt Branches ab:** Der Nacht-Review prüft `main` und jeden Branch mit Commits seit dem letzten Bericht. Vor einem Merge nach `main` muss der Branch in einem Bericht vorkommen.
