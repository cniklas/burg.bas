# Vue Text Adventure

## Struktur

- für die Darstellung des Raums braucht man nur eine Komponente
	- in Slots werden dann jeweils Story, Auswahl der Actions und ggf. sonstige Informationen gerendert


## Routing

- Routing ist nicht nötig, weil man nicht über die Browser-History „wandern“ und auch nicht per URL einzelne Räume anspringen darf


## Events

- Renderless Event Component, um per Arrow Keys (rauf, runter) und Enter einen Eintrag aus einer Liste von Actions zu feuern


## Speech API

- Sprachausgabe
- Spracheingabe?


## Musik

- __1\. Iteration:__ als mp3 aufnehmen vom Original und einfach abspielen
	- https://howlerjs.com/
- __2\. Iteration:__ mit Tone.js o.ä. umsetzen
	- Library: https://tonejs.github.io/
	- Tutorial: https://codepen.io/gregh/post/recreating-legendary-8-bit-games-music-with-web-audio-api
- zum Entziffern der Noten in QBasic s. http://www.qb64.org/wiki/PLAY
