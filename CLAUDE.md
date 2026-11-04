# Arbeitsweise

## Reviews
Das Projekt hat drei Review-Agenten in `.claude/agents/`: `game-designer`, `ux-reviewer` und `code-reviewer`. Sie lesen nur und liefern priorisierte Befunde; umgesetzt wird im Hauptkontext.

Dazu kommt der `qa-playtester`: Er startet das Spiel wirklich (Headless-Tests, Bot-Simulation, Screenshots über `tools/qa/qa_screenshots.gd`) und ändert keinen Spielcode. Er läuft vor den drei Reviewern, damit der `ux-reviewer` seine Screenshots bekommt. Zusätze: `docs/review/qa-playtester.md`.

- Nach einem größeren Feature, einer neuen Mechanik oder UI-Änderung und vor Merges die passenden Reviewer parallel starten.
- Im Auftrag an jeden Reviewer die geänderten Dateien und das Ziel der Änderung nennen, plus eventuelle Sonderanweisungen des Nutzers.
- Befunde zusammenfassen, Widersprüche zwischen den Rollen benennen und Kritisches zuerst umsetzen. Größere Designänderungen vorher mit dem Nutzer abstimmen.
- Projektkontext für die Reviewer steht in `docs/review/brief.md`, rollenspezifische Anweisungen in `docs/review/<rolle>.md`. Nächtliche Review-Berichte liegen in `docs/review/berichte/`.

## Verbindliche Studio-Entscheidungen (Stand 04.11.2026)

Gelten, bis der Inhaber in der Sitzung ausdrücklich etwas anderes sagt. Quelle: Entscheidungsliste des Studios (BeachVibeStudio, `studio/entscheidungen.md`). Vor jeder Arbeitssitzung lesen.

1. **Fix vor Feature** (Studio-Handbuch §8): Nach jedem Review-Bericht zuerst die Punkte abarbeiten, die der Bericht als „ohne Abstimmung umsetzbar“ führt, mindestens alle kritischen; erst danach neue Features. Ein Befund, der im dritten Bericht in Folge offen steht, geht an den Inhaber („beheben, bewusst lassen oder streichen“).
2. **E33 (14.10.):** NEUSTART und NOCHMAL bleiben im selben Level, zusätzlicher Knopf „NEUES LEVEL“; NOCHMAL startet das Level, in dem man starb; Rückfrage vor NEUSTART/NEUES LEVEL ab dem 2. Level des Laufs (Inhaber 15.10.). Umsetzung auf `fix/e33-gleiches-level` (04.11.), Merge durch den Inhaber.
3. **E34 b (15.10., ersetzt den Stand vom 14.10.): kein Regel-Freeze.** Weiter iterieren; Bestenlisten-Bretter gelten bis zur Steam-Seite als vorläufig und dürfen ohne Migration verworfen werden. Ziel der nächsten Regelversion bleiben (E47 a, 16.10.): Dash 4,0 m (in Metern), Start-Halt in jedem Level, Geister ×1,2 erst nach Messung, Zielzeiten Bot ohne Dash ×1,08 im HUD. Jede neue Regelversion braucht einen Review-Bericht vor dem Merge.
   - **`feature/karte-m`:** Merge erst nach der Fix-Woche (E46) und einem Review-Bericht des Branches.
4. **Code-K1 (seit 05.10.):** Rückgabewert von `write_atomic` an allen Aufrufern auswerten (`leaderboard.gd`, `speedrun.gd`, `settings.gd`, `main.gd`), bevor eine weitere Migration nach `main` kommt. **E54 b (04.11.):** Umsetzung auf `fix/code-k1`, Merge durch den Inhaber.
5. **E24 und E20 (Explorer):** erst nach der Fix-Woche und nach Regelversion 4.
6. **Review deckt Branches ab:** Der Nacht-Review prüft `main` und jeden Branch mit Commits seit dem letzten Bericht. Vor einem Merge nach `main` muss der Branch in einem Bericht vorkommen.
7. **E46 a (16.10.):** Code-K1@10.10., GD-K1@17.10., GD-K2@17.10., UX-K1@17.10., UX-K2@10.10. beheben; Merge-Bedingung vor jedem Feature-Merge. Der Review legt diese Punkte nicht erneut zur Entscheidung vor, sondern meldet nur den Stand.
8. **E20 b (14.10.):** Jede Explorer-Stadt bekommt ein eigenes Sammelziel (Kyoto: Goshuin-Stempel), zusammen mit E24d, nach der Fix-Woche.
9. **E51 b (04.11.):** Kamerahöhe als A/B-Test 2,5 / 1,7 / 1,25 m (Umschalter F6 auf `feature/feedback-1016`); Inhaber und 1 Tester wählen, nach der Fix-Woche. Bis dahin kein Merge, der 2,5 m (Abnahme 06.10.) ersetzt.
10. **Befund-IDs (Handbuch v4.9):** IDs werden nie für einen anderen Befund neu vergeben; in Berichten, Commits und Rückfragen immer `<ID>@<TT.MM.>`.
11. **Leer-Bericht (E55 a, 04.11.):** Gibt es seit dem letzten Bericht keine Code-Änderung, hat der Bericht höchstens 5 Zeilen und legt keine entschiedenen Punkte erneut vor.
12. **Pflege dieses Abschnitts (E55 a):** Der Studio Head hält ihn per reinem Doku-Commit auf `main` aktuell; andere Dateien ändert er dabei nicht.
