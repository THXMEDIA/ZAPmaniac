# Bewegungs-Paket: Dash und Kehrtwende (Regelversion 2)

Stand 06.10.2026. Gilt in allen Speedrun-Leveln, für alle Spieler gleich, nicht abschaltbar.

## Tasten
- **Dash:** Shift. **Kehrtwende:** Q. Beide werden in `main.gd` (`_register_move_actions`) im Code registriert, `project.godot` bleibt unberührt. Anzeige der Tasten in EINSTELLUNGEN folgt der InputMap.

## Kehrtwende
- Schnitt (yaw + PI), keine Kamerafahrt. Neigung, Sichtfeld, Augenhöhe unberührt (E8e). Nur auf Tastendruck, nie über Konditionen, Kaninchen oder Chat. 0,4 s Pause (weit unter 3 Hz).
- Gilt auch in den Explorer-Städten.

## Dash
- 18 m/s für 0,2 s (ca. 3,6 m) in Richtung der Bewegungseingabe (nach einer Kondition wie Fear & Loathing, also kein Gratis-Gegenmittel), ohne Eingabe geradeaus.
- Normale Geister schaden nicht während des Dash und 0,15 s danach; verängstigte werden gefressen.
- Ladungen: 1 am Start, maximal 2. +1 pro gefressenem Geist oder Frucht, nie über die Zeit. Reset bei Levelstart und Lebensverlust. Kugeln kosten nichts.
- Startet nur bei mindestens 1 m freier Strecke (keine verschwendete Ladung vor Wänden). 0,5 s Pause.
- Zeitgewinn: ca. 0,48 s pro Dash (0,3–0,5 % einer Level-Zeit), gemessen mit `tools/qa/qa_dash_gain.gd`. Die Zielzeiten (`target_s`) bleiben Zeiten ohne Dash.

## Regelversion 2 und Bretter
- Zeiten ohne Dash/Kehrtwende sind mit Zeiten mit ihnen nicht vergleichbar. Speicherstand-Version 4 (`speedrun.gd`, `leaderboard.gd`): beim ersten Laden verschiebt sich jedes Brett einer älteren Datei ins Archiv unter `<Schlüssel>|regel1` (bleibt erhalten, wird nie angezeigt). Die Bretter beginnen neu.

## Regelversionen im Überblick
`Levels.RULES_VERSION` (`levels.gd`) nennt die aktuelle Regelversion (Versus-Handshake); die Archiv-Stufen stehen noch einzeln in `speedrun.gd` und `leaderboard.gd` (`SAVE_VERSION` 6). Zeiten aus verschiedenen Regelversionen sind nicht vergleichbar: Beim ersten Laden einer älteren Datei werden ihre Bretter archiviert (vorher wird die Datei als `<Name>.v<Version>.bak` kopiert), und im Versus treten nur gleiche Regelversionen gegeneinander an (`hello` trägt `rules`, Protokoll 3).

| Regel | seit | Inhalt | Archiv |
|---|---|---|---|
| 1 | Anfang | ohne Dash/Kehrtwende, volle Karte | `|regel1` |
| 2 | 06.10.2026 | Dash + Kehrtwende, volle Karte | `|regel2` |
| 3 | 08.10.2026 | lokale Karte (4 Zellen um den Spieler) + Kompass | `|regel3` |
| 4 | 14.10.2026 | wie 3, dazu KARTE: Taste M zeigt 2 s das ganze Labyrinth, danach 10 s Wartezeit | aktuell |

KARTE (Entscheidung Inhaber 14.10.2026): Die lokale Pflichtkarte bleibt. M öffnet im Speedrun und im Versus für `MAP_PEEK_S` = 2 s die volle Karte (Kaninchen, Restkugeln, Geister, Gegner), danach schaltet sie von selbst zurück; die nächste Nutzung geht `MAP_PEEK_COOLDOWN_S` = 10 s nach dem Schließen. Nicht im Start-Halt (die Uhr läuft noch nicht), nicht bei ausgeschalteter Minimap (Stromausfall), nicht in der Pause. Beide Zeiten laufen auf Spielzeit. Die Pause schließt eine offene KARTE, die Wartezeit bleibt. Stromausfall mitten in KARTE schließt sie ebenfalls, die Wartezeit läuft weiter. Ein Lebensverlust ändert nichts (kein Gratis-Blick fürs Sterben). Jeder Levelstart und jede Versus-Runde beginnt mit bereiter Taste. Während KARTE offen ist, zeichnet die Minimap Kugeln größer mit dunklem Rand und den Spieler mit Ring, damit man sich in 2 s findet. Ein Druck, der nichts bewirkt, gibt den Dash-Leer-Ton und hebt den Chip kurz hervor. Chip KARTE links zeigt „M“, „OFFEN“ oder die Restsekunden. Training und Explorer haben ohnehin die volle Karte. Der Kompass hängt seit 14.10. unter der Minimap; ENERGIE, Zwischenzeit und Titelkarte stapeln sich oben in der Mitte (im Versus unter dem Rennbalken).

## Weitere Schritte (Vorschläge, noch nicht gebaut)
Etagen-Spike. (Karten-Modi und Zwischenzeiten sind inzwischen gebaut, siehe oben.)
