0 PRINT "Bist du bereit fu_r ein waghalsiges Abenteuer in einer unbekannten Burg?"
1 LINE INPUT a$
2 PRINT "Ok. Dann los ..."
3 LINE INPUT a$
4 FOR a = 1 TO 4000
5 NEXT
6 PRINT "10"
7 FOR a = 1 TO 4000
8 NEXT
9 PRINT "9"
10 FOR a = 1 TO 4000
11 NEXT
12 PRINT "8"
13 FOR a = 1 TO 4000
14 NEXT
15 PRINT "7"
16 FOR a = 1 TO 4000
17 NEXT
18 PRINT "6"
19 FOR a = 1 TO 4000
20 NEXT
21 PRINT "5"
22 FOR a = 1 TO 4000
23 NEXT
24 PRINT "4"
25 FOR a = 1 TO 4000
26 NEXT
27 PRINT "3"
28 FOR a = 1 TO 4000
29 NEXT
30 PRINT "2"
31 FOR a = 1 TO 4000
32 NEXT
33 PRINT "1"
34 FOR a = 1 TO 4000
35 NEXT
36 PRINT
37 PRINT
38 PRINT
39 PRINT
40 PRINT
41 PRINT
42 PRINT
43 PRINT
44 PRINT
45 PRINT
46 PRINT
47 PRINT
48 PRINT "---------------------------  D  I  E     B  U  R  G  ---------------------------"
49 PRINT
50 PRINT
51 PRINT
52 PRINT
53 PRINT
54 PRINT
55 PRINT
56 PRINT
57 PRINT
58 PRINT
RANDOMIZE TIMER
x = INT(RND * 2)
IF x = 0 THEN GOTO musik1
IF x = 1 THEN GOTO musik2
musik1:
PLAY "t78 l16 mn<cc<b-b->cc<gg>cc<b-b->cc<gg> msl8cp8<<cp8cp8cl16cc>> mn cc<b-b->cc<gg>cc<b-b->cc<gg> msl8cp8<<cp8cp8cl16cc>>"
PLAY "mn ccl8cl16e-e-l8e-<l16b-b-l8b-l16ggl8g> mscp8<<cp8cp8cl16cc>> mn ccl8cl16e-e-l8e-<l16b-b-l8b-l16ggl8g> mscp8<<cp8cp8cl16cc>>"
PLAY "mn cc<b-b->e-e-ggffcce-e-dd msl8cp8<<cp8cp8cl16cc>> mn cc<b-b->e-e-ggffcce-e-dd msl8cp8<<cp8cp8cl16cc>>"
PLAY "mn cd<b->c<ab-gf>cde-cfdg<b> msl8cp8<<cp8cp8l12ccc>> mnl16cd<b->c<ab-gf>cde-cfdg<b> msl8cp8<<cp8cp8l12ccc>>"
PLAY "mll16 cde-fga-b>c msdd<bbggdd l8cp8<<cp8cp8l12ccc>> mll16 cde-fga-b>c msdd<bbggdd l8cp8<<cp8cp8l12cd<b>"
PLAY "mnl16cc<b-b-a-a-l8g>l16g#g#ffddmsl8gmlcl32cde-fmnl8g<g>l4c<l8c.l16cl2c"
GOTO 60
musik2:
PLAY "t100 <<msl16ddl3gl16ddl3g l32ddl16dgdgbagab>l3c<l16ddgdgbag>c<al3g"
PLAY "l16bbl3al16bbl3a l32bbl16badabadabl3a"
PLAY "l16ddl3gl16dd>l3c l32ddl16c<b>c<b>c<l6al16gl3g"
60 PRINT
61 PRINT
62 PRINT
63 PRINT
64 PRINT
65 PRINT
66 PRINT
67 PRINT
68 PRINT
70 PRINT
71 PRINT
72 PRINT
73 PRINT "Folgende Befehle kannst du benutzen: links, rechts, weiter, zuru_ck, hoch,"
74 PRINT "runter, nimm, o_ffne. Weitere Anweisungen werden stets gegeben, falls no_tig."
75 INPUT a
76 PRINT "DU SITZT IM KERKER DES GRAUSAMEN, TYRANNISCHEN KO_NIGS UBOLZIO ..."
77 FOR a = 1 TO 12000
78 NEXT
79 PRINT
80 PRINT "... denn du wurdest beim A_pfelklauen in den ko_niglichen Obstga_rten erwischt und"
81 PRINT "zu 10 Jahren Kerker verknackt. Scho_ner Mist!!!"
82 PRINT "Doch es ist dir inzwischen endlich gelungen, mit einer scha_bigen Nagelfeile das"
83 PRINT "verflixte Schlosz_ aufzubekommen. Jetzt o_ffne die Kerkertu_r ..."
84 INPUT a$
85 IF a$ = "o_ffne Tu_r" THEN GOTO 88 ELSE GOTO 86
86 PRINT "Ich sagte: >O_ffne die Tu_r!< [Eventuell Artikel weglassen.]"
87 GOTO 84
88 PRINT "Du o_ffnest, trittst aus dem Kerker und stehst jetzt in einem du_steren"
89 PRINT "Gewo_lbekeller. Besonders viel kannst du nicht erkennen, doch du entdeckst"
90 PRINT "schliesz_lich eine Treppe, deren rutschige Stufen vermutlich hier heraus fu_hren."
91 INPUT a$
92 IF a$ = "hoch" THEN GOTO 96
93 IF a$ = "runter" THEN GOTO 94 ELSE GOTO 91
94 PRINT "Die Treppe geht u_brigens nach oben."
95 GOTO 91
96 PRINT "Du gelangst in einen kleinen, beleuchteten Raum. Du kannst nun rechts, links und"
97 PRINT "geradeaus weitergehen. Ausz_erdem bemerkst du, dasz_ vor deinen Fu_sz_en ein Zettel"
98 PRINT "liegt. Entscheide, in welcher Richtung du weiterla_ufst [gib >weiter< fu_r"
99 PRINT "geradeaus ein] oder heb den Zettel auf, wenn du wissen willst, was darauf steht."
100 INPUT a$
101 IF a$ = "nimm Zettel" THEN GOTO 108
102 IF a$ = "rechts" THEN GOTO 114
103 IF a$ = "links" THEN GOTO 123
104 IF a$ = "weiter" THEN GOTO 128 ELSE GOTO 105
105 PRINT "Ich erwarte eine vernu_nftige Entscheidung!"
107 GOTO 100
108 PRINT "Du hebst also den Zettel auf, und darauf steht in bunten Buchstaben:"
109 PRINT "LEST MICKY-MAUS!"
110 FOR a = 1 TO 15000
111 NEXT
112 PRINT "Du wirfst den Wisch a_rgerlich weg und beschliesz_t zu gehen."
113 GOTO 100
114 PRINT "Du wendest dich nach rechts und latschst genau auf die dort verborgene Falltu_r!"
115 PRINT "Du landest ganz scho_n schmerzhaft etliche Meter tiefer und stellst fest, dasz_ es"
116 PRINT "aus diesem Loch keinen Ausweg gibt ..."
117 PRINT "DAS WAR'S FU_R DICH!"
118 GOTO 681
119 PRINT "Willst du das Spiel noch einmal beginnen? [j=ja, n=nein]"
120 INPUT a$
121 IF a$ = "j" THEN GOTO 76
122 IF a$ = "n" THEN GOTO 200 ELSE GOTO 119
123 PRINT "Du gehst nach links und kommst an eine Wendeltreppe. Sie wendelt aufwa_rts."
124 PRINT "Wenn du meinst, dasz_ sie aus dem Kerker fu_hrt, folge ihr. Oder geh zuru_ck."
125 INPUT n$
126 IF n$ = "hoch" THEN GOTO 257
127 IF n$ = "zuru_ck" THEN GOTO 96 ELSE GOTO 125
128 PRINT "Du gehst ein Stu_ck weiter und befindest dich jetzt in einem noch kleineren"
129 PRINT "Raum. Du siehst einen Tisch, und darauf liegen ein Helm und ein Umhang."
130 PRINT "Ausz_erdem steht mitten im Raum eine Leiter, die zu einer O_ffnung in der Decke"
131 PRINT "fu_hrt. Plo_tzlich ho_rst du rauhe Stimmen und schwere Schritte, und du weisz_t, dasz_"
132 PRINT "hier wahrscheinlich gleich die Schergen von Ko_nig UBOLZIO auftauchen werden."
133 INPUT a$
134 IF a$ = "nimm Helm Umhang" THEN GOTO 140
135 IF a$ = "hoch" THEN GOTO 144
136 IF a$ = "zuru_ck" THEN GOTO 137 ELSE GOTO 133
137 PRINT "Du hastest zuru_ck und ... rennst genau den Wa_chtern in die Arme. Jetzt ist"
138 PRINT "alles zu spa_t ..."
139 GOTO 117
140 PRINT "Du schnappst dir Helm und Umhang. Jetzt aber nichts wie weg!"
141 INPUT c$
142 IF c$ = "hoch" THEN GOTO 144
143 IF c$ = "zuru_ck" THEN GOTO 137 ELSE GOTO 141
144 PRINT "So schnell du kannst, erklimmst du die Leiter und verschwindest durch das"
145 PRINT "Schlupfloch in der Decke. Sicherheitshalber ziehst du auch noch die Leiter"
146 PRINT "ein. Jetzt bist du erstmal ausz_er Gefahr. Du schaust dich um: Du befindest dich"
147 PRINT "anscheinend in der Kemenate der Burgwachen. Ihr ganzer Krempel liegt hier"
148 PRINT "verstreut herum, unter anderem:"
149 IF a$ = "hoch" THEN GOTO 151
150 IF a$ = "nimm Helm Umhang" THEN GOTO 173
151 PRINT "Ein Schwert, ein Schild und ein Seil."
152 PRINT "Nimm die Sachen mit!"
153 INPUT b$
154 IF b$ = "nimm Schwert Schild Seil" THEN GOTO 157 ELSE GOTO 155
155 PRINT "Du sollst die Sachen mitnehmen! [Auf Kommata + >und< verzichten.]"
156 GOTO 153
157 PRINT "Nachdem du die Sachen genommen hast, suchst du nach einem Ausgang. Du"
158 PRINT "entdeckst eine Tu_r, die allerdings verschlossen ist."
159 INPUT c$
160 IF c$ = "o_ffne Tu_r" THEN GOTO 163 ELSE GOTO 161
161 PRINT "Versuche, die Tu_r zu o_ffnen."
162 GOTO 159
163 PRINT "Womit?"
164 INPUT c$
165 IF c$ = "Schwert" THEN GOTO 171
166 IF c$ = "Schlu_ssel" THEN GOTO 169 ELSE GOTO 167
167 PRINT "Klappt nicht. Benutze etwas anderes."
168 GOTO 164
169 PRINT "Du hast leider keinen Schlu_ssel."
170 GOTO 164
171 PRINT "Richtig. Du machst aus der Tu_r Kleinholz und verla_sz_t diesen Raum."
172 GOTO 188
173 PRINT "Ein Schlu_sselbund und eine Keule."
174 PRINT "Nimm diese Sachen mit!"
175 INPUT b$
176 IF b$ = "nimm Schlu_sselbund Keule" THEN GOTO 180 ELSE GOTO 177
177 PRINT "Wenn du die Sachen nicht mitnimmst, geht das Spiel nicht weiter! [Auf Kommata +"
178 PRINT ">und< verzichten.]"
179 GOTO 175
180 PRINT "Nachdem du die Sachen genommen hast, suchst du nach einem Ausgang. Du"
181 PRINT "entdeckst eine Tu_r, die allerdings verschlossen ist."
182 INPUT c$
183 IF c$ = "o_ffne Tu_r" THEN GOTO 186 ELSE GOTO 184
184 PRINT "Versuche, die Tu_r zu o_ffnen."
185 GOTO 182
186 PRINT "Da du jetzt die Schlu_ssel besitzt, ist es fu_r dich kein Problem, die Tu_r zu"
187 PRINT "o_ffnen. Du verla_sz_t den Raum."
188 PRINT "Nun stehst du im Freien. Zum Glu_ck ist niemand in der Na_he. Erstmal atmest du"
189 PRINT "tief durch und geniesz_t die frische Luft, die du wa_hrend deines langen"
190 PRINT "Kerkeraufenthaltes so vermisz_t hast."
191 FOR a = 1 TO 40000
192 NEXT
193 PRINT "Du stehst auf dem Burghof und u_berlegst, wo du jetzt hingehen ko_nntest. Es"
194 PRINT "bieten sich gleich mehrere Richtungen an:"
195 PRINT "Links sind die Stallungen, auf der anderen Seite des Hofes liegt der Palas"
196 PRINT "und rechts von dir befindet sich das Lagerhaus. Ausz_erdem ko_nntest du auf den"
197 PRINT "Wehrgang steigen und sehen, ob du da irgendwie weiterkommst. Gib deine"
198 PRINT "Richtungswahl ein. [Benutze >hoch<, wenn du auf den Wehrgang willst.]"
199 GOTO 250
200 PRINT "OK. Dann ist das Spiel zu ..."
201 FOR a = 1 TO 10000
202 NEXT
203 PRINT
204 PRINT
205 PRINT
206 PRINT
207 PRINT
208 PRINT
209 PRINT
210 PRINT
211 PRINT
212 PRINT
213 PRINT
214 PRINT
215 PRINT "----------------------------  E  N  D  E  !  !  !  ----------------------------"
216 PRINT
217 PRINT
218 PRINT
219 PRINT
220 PRINT
221 PRINT
222 PRINT
223 PRINT
224 PRINT
225 PRINT
226 FOR a = 1 TO 20000
227 NEXT
234 PRINT
235 PRINT
236 PRINT
237 PRINT
238 PRINT
239 PRINT "Ein Spiel von KRISCHAN"
240 PRINT
241 PRINT "Idee: KRISCHAN mit hilfreicher Unterstu_tzung von DEWITT"
242 PRINT
243 PRINT "Text: KRISCHAN"
245 GOTO 688
246 PRINT "Programmed by KRISCHAN"
247 PRINT
248 PRINT "Copyrights by KRISCHAN MCMXCVI"
END
250 INPUT c$
251 IF c$ = "hoch" THEN GOTO 569
252 IF c$ = "rechts" THEN GOTO 281
253 IF c$ = "links" THEN GOTO 545
254 IF c$ = "weiter" THEN GOTO 692 ELSE GOTO 255
255 PRINT "Lasz_ den Blo_dsinn! Entscheide dich fu_r eine Richtung."
256 GOTO 250
257 PRINT "Du hast dich entschlossen, die steile Wendeltrepppe hinaufzugehen. Es ist"
258 PRINT "ziemlich mu_hsam; du erreichst keuchend und schnaufend einen Ausgang."
259 PRINT "Und jetzt? Willst du noch weiter hinaufsteigen oder lieber sehen, welche"
260 PRINT "Ra_umlichkeit sich dir hier auftut? [Benutze >hoch< bzw. >links<.]"
261 INPUT d$
262 IF d$ = "hoch" THEN GOTO 349
263 IF d$ = "links" THEN GOTO 266 ELSE GOTO 264
264 PRINT "Kannst du nicht lesen? >Hoch< bzw. >links<!"
265 GOTO 261
266 PRINT "Du betrittst eine grosz_e Halle. Du schaust dich um und entdeckst eine Vielzahl"
267 PRINT "an Lebensmitteln aber auch Boote, behauene Steine, Werkzeuge verschiedenster"
268 PRINT "Art, aufgestapelte Holzbohlen, Stoffballen, Tierha_ute und noch einige andere"
269 PRINT "Sachen. Allem Anschein nach befindest du dich im Lagerhaus. Rechts ist ein"
270 PRINT "grosz_es Tor, was vermutlich auf den Burghof fu_hrt, und am anderen Ende der Halle"
271 PRINT "siehst du eine breite Holztreppe zum Dachboden. Als du gerade u_berlegst, ob du"
272 PRINT "nicht erst etwas von den leckeren Sachen hier essen ko_nntest, bevor du"
273 PRINT "weitergehst, dringen plo_tzlich Gebru_ll, schnelle Schritte und Waffengeklirr von"
274 PRINT "unten aus der Wendeltreppe zu dir herauf! Man hat deine Flucht bemerkt! Jetzt"
275 PRINT "musz_t du rasch entscheiden, wohin du fliehst!"
276 INPUT e$
277 IF e$ = "rechts" THEN GOTO 653
278 IF e$ = "hoch" THEN GOTO 301 ELSE GOTO 279
279 PRINT "Keine Zeit fu_r Scherze! Du musz_t fliehen!"
280 GOTO 276
281 PRINT "Du la_ufst behende u_ber den Burghof zum Lagerhaus, o_ffnest schnell das grosz_e Tor"
282 PRINT "hindurch. Du betrittst eine grosz_e Halle. Du schaust dich um und entdeckst eine"
283 PRINT "Vielzahl an Lebensmitteln aber auch Boote, behauene Steine, Werkzeuge"
284 PRINT "verschiedenster Art, aufgestapelte Holzbohlen, Stoffballen, Tierha_ute und noch"
285 PRINT "einige andere Sachen. An einem Ende der Halle - rechts von dir - steht eine"
286 PRINT "breite Holztreppe, die zum Dachboden fu_hrt. Links, am anderen Ende, siehst du"
287 PRINT "den Eingang zu einer Wendeltreppe, die man sowohl hinauf-, als auch hinabgehen"
288 PRINT "kann. Als du gerade u_berlegst, ob du nicht erst etwas von den leckeren Sachen"
289 PRINT "hier essen ko_nntest, bevor du weitergehst, dringen plo_tzlich Gebru_ll, schnelle"
290 PRINT "Schritte und Waffengeklirr von unten aus der Wendeltreppe zu dir herauf! Schon"
291 PRINT "wieder bist du bemerkt worden!"
292 IF b$ = "nimm Schwert Schild Seil" THEN GOTO 306
293 IF b$ = "nimm Schlu_sselbund Keule" THEN GOTO 294
294 PRINT "Da du nicht ausreichend bewaffnet bist, um es mit einer Schar Wachen"
295 PRINT "aufzunehmen, beschliesz_t du zu fliehen. La_ufst du zuru_ck auf den Burghof oder"
296 PRINT "versuchst du, dich auf dem Dachboden zu verstecken? [>zuru_ck< bzw. >hoch<, das"
297 PRINT "mu_sz_te langsam klar sein.]"
298 INPUT e$
299 IF e$ = "hoch" THEN GOTO 301
300 IF e$ = "zuru_ck" THEN GOTO 677 ELSE GOTO 298
301 PRINT "Du hetzt die Treppe zum Dachboden hinauf und versteckst dich so gut es geht"
302 PRINT "zwischen Fa_ssern mit Po_kelfleisch und Mehlsa_cken. Doch die Wachen sind nicht"
303 PRINT "so leicht auszutricksen und suchen das ganze Lagerhaus ab nach dir. Es ist nur"
304 PRINT "noch eine Frage der Zeit, bis sie dich gefunden haben ..."
305 GOTO 117
306 PRINT "Was nun? Stellst du dich der bewaffneten Schar mutig entgegen und versuchst,"
307 PRINT "sie zu erledigen, oder fliehst du lieber? [Gib >ka_mpfen< bzw. >fliehen< ein.]"
308 INPUT e$
309 IF e$ = "ka_mpfen" THEN GOTO 321
310 IF e$ = "fliehen" THEN GOTO 311 ELSE GOTO 308
311 PRINT "Du hast beschlossen, dich lieber aus dem Staub zu machen. La_ufst du zuru_ck auf"
312 PRINT "den Burghof oder versuchst du, dich auf dem Dachboden zu verstecken?"
313 INPUT e$
314 IF e$ = "hoch" THEN GOTO 316
315 IF e$ = "zuru_ck" THEN GOTO 677 ELSE GOTO 313
316 PRINT "Du hetzt die Treppe zum Dachboden hinauf und versteckst dich so gut es geht"
317 PRINT "zwischen Fa_ssern mit Po_kelfleisch und Mehlsa_cken. Doch die Wachen sind nicht so"
318 PRINT "leicht auszutricksen und suchen das ganze Lagerhaus ab nach dir. Du sitzt in"
319 PRINT "der Falle, und da wird dir auch dein Schwert nicht mehr viel nu_tzen ..."
320 GOTO 117
321 PRINT "Du beschliesz_t, die Schergen UBOLZIOs fertigzumachen! Natu_rlich willst du dich"
322 PRINT "nicht unbedingt auf einen Nahkampf mit 8 Kerlen gleichzeitig einlassen."
323 PRINT "Schnell und entschlossen packst du eines von den Fa_ssern, die gleich neben dir"
324 PRINT "stehen, und sto_sz_t es die Wendeltreppe hinunter, noch bevor deine Gegner den"
325 PRINT "Treppenausgang erreicht haben. Es poltert lautstark die Treppe hinunter und"
326 PRINT "wenige Sekunden spa_ter ho_rst du das Geschrei und Gefluche der Wachen. Das hat"
327 PRINT "geklappt! Ein paar Augenblicke spa_ter ist es einigen gelungen, doch noch bis zu"
328 PRINT "vorzudringen. Du achtest darauf, dich mo_glichst nicht von der Wendeltreppe"
329 PRINT "zuru_ckdra_ngen zu lassen, denn der Ausgang ist so schmal, dasz_ immer nur einer"
330 PRINT "von ihnen hindurchpasz_t. Trotzdem gera_tst du ganz scho_n ins Schwitzen, denn"
331 PRINT "deine Gegner sind nicht von Pappe!"
332 PRINT "Willst du lieber den Ru_ckzug antreten oder weiterka_mpfen? [>ka_mpfen< bzw."
333 PRINT ">fliehen< eingeben.]"
334 INPUT f$
335 IF f$ = "fliehen" THEN GOTO 337
336 IF f$ = "ka_mpfen" THEN GOTO 341 ELSE GOTO 332
337 PRINT "Das war leider ein grosz_er Fehler, genauer gesagt sogar dein letzter! Du drehst"
338 PRINT "dich um und versuchst zu entwischen, und so kannst du nicht sehen, wie einer"
339 PRINT "der Schergen seine Armbrust anlegt, auf dich zielt und abdru_ckt ..."
340 GOTO 117
341 PRINT "Du nimmst all deine Kra_fte zusammen und ka_mpfst verbissen weiter. Und du"
342 PRINT "schaffst es schliesz_lich! Du wischt dir den Schweisz_ vom Gesicht und beschliesz_t"
343 PRINT "nach einer kurzen Ruhepause, die Wendeltreppe hinaufzusteigen, um zu sehen, was"
344 PRINT "dort oben wohl ist."
345 INPUT f$
346 IF f$ = "hoch" THEN GOTO 349 ELSE GOTO 347
347 PRINT "Geh hoch."
348 GOTO 345
349 PRINT "Du steigst die Wendeltreppe immer ho_her, bis sie plo_tzlich vor einer kleinen"
350 PRINT "Tu_r endet."
351 INPUT f$
352 IF f$ = "o_ffne Tu_r" THEN GOTO 355 ELSE GOTO 353
353 PRINT "Mach etwas Sinnvolles!"
354 GOTO 351
355 PRINT "Du versuchst, die Tu_r zu o_ffnen, aber sie ist verschlossen."
356 PRINT "Folgendes kannst du jetzt machen:"
357 IF b$ = "nimm Schwert Schild Seil" THEN GOTO 359
358 IF d$ = "hoch" THEN GOTO 404
359 PRINT "  1. Du gehst wieder."
360 PRINT "  2. Du benutzt wiedermal dein Schwert. [>o_ffne Tu_r mit Schwert<]"
361 PRINT "  3. Du klopfst an und wartest, ob vielleicht jemand o_ffnet. [>klopfe an<]"
362 INPUT f$
363 IF f$ = "runter" THEN GOTO 401
364 IF f$ = "o_ffne Tu_r mit Schwert" THEN GOTO 366
365 IF f$ = "klopfe an" THEN GOTO 371 ELSE GOTO 362
366 PRINT "Du schla_gst mit deinem Stahl ein paar mal auf das Tu_rholz ein, doch auf einmal"
367 PRINT "o_ffnet sich die Tu_r, und ein Zauberer steht vor dir! Dasz_ es ein Zauberer ist,"
368 PRINT "bemerkst du erst, als er dich schon in eine kleine Maus verwandelt hat zur"
369 PRINT "Strafe dafu_r, dasz_ du ihm seine Tu_r bescha_digt hast ..."
370 GOTO 117
371 PRINT "Du klopfst an und - siehe da - plo_tzlich geht die Tu_r auf, und ein alter Mann"
372 PRINT "in einem wallenden Gewand und mit viel Bart steht vor dir. Er bittet dich"
373 PRINT "freundlich herein, und du trittst erfreut ein. Es ist ein Turmzimmer direkt"
374 PRINT "unter dem Dach, nicht besonders grosz_ aber ausgefu_llt mit dicken Bu_cherregalen,"
375 PRINT "einem Bett, einem Schreibtisch, einer eisenbeschlagenen Truhe und noch einigen"
376 PRINT "anderen Dingen. An den Wa_nden ha_ngen seltsame Bilder und Karten."
377 PRINT "Der Mann fragt dich: >>Warum bist du zu mir hinaufgestiegen?<<"
378 PRINT "Du sagst: >>Ich bin aus dem Kerker entflohen und suche einen Ausweg aus dieser"
379 PRINT "furchtbaren Burg.<<"
380 PRINT ">>Niemand ist je aus der Burg UBOLZIOs entkommen.<<, sagt der Mann."
381 PRINT "Du bist sehr verzweifelt."
382 FOR a = 1 TO 100000
383 NEXT
384 PRINT
385 PRINT "Der Mann legt seine Hand auf deine Schulter, sieht dir fest in Augen und sagt"
386 PRINT "zu dir: >>Wenn du diesem Hort des Verderbens entrinnen willst, musz_t du zuerst"
387 PRINT "UBOLZIOs Macht brechen und ihn to_ten.<<"
388 PRINT ">>Wie kann ich das schaffen?<<, fragst du."
389 PRINT ">>Du musz_t bis zum Thronsaal vordringen, denn darin sitzt UBOLZIO Tag fu_r Tag"
390 PRINT "und ergo_tzt sich an seiner Macht. Vor dem Thronsaal liegt ein dreiko_pfiger"
391 PRINT "Drache. Nicht Schwert noch Pfeil ko_nnen ihm etwas anhaben. Doch ru_hrst du ihn"
392 PRINT "mit diesem Stab an (Bei diesen Worten reicht er dir einen kleinen, weisz_en"
393 PRINT "Stab), musz_ er sogleich zu Staub zerfallen.<<"
394 PRINT "Du fasz_t wieder Mut und bedankst dich sehr herzlich bei dem alten Mann. Er"
395 PRINT "geleitet dich bis zur Treppe und wu_nscht dir viel Glu_ck. Du verabschiedest dich"
396 PRINT "von ihm und gehst nun die Wendeltreppe wieder hinab."
397 INPUT e$
398 IF e$ = "runter" THEN GOTO 527 ELSE GOTO 399
399 PRINT "Geh hinunter."
400 GOTO 397
401 PRINT "Du la_ufst die Wendeltreppe hinunter, gehst durch die grosz_e Halle des"
402 PRINT "Lagerhauses und durch das Tor auf den Burghof."
403 GOTO 409
404 PRINT "  1. Du gehst wieder."
405 PRINT "  2. Du klopfst an und wartest, ob vielleicht jemand o_ffnet. [>klopfe an<]"
406 INPUT f$
407 IF f$ = "runter" THEN GOTO 529
408 IF f$ = "klopfe an" THEN GOTO 371 ELSE GOTO 362
409 IF f$ = "klopfe an" THEN GOTO 411
410 IF f$ = "runter" THEN GOTO 418
411 PRINT "Du beschliesz_t, so schnell wie mo_glich zum Thronsaal zu gelangen, um UBOLZIOs"
412 PRINT "Herrschaft ein fu_r alle mal zu beenden. Darum gehst du direkt aber dennoch"
413 PRINT "vorsichtig zum Palas, der sich rechts von dir befindet."
414 INPUT g$
415 IF g$ = "rechts" THEN GOTO 692 ELSE GOTO 416
416 PRINT "Rechts ist der Palas, und dort musz_t du hin."
417 GOTO 414
418 PRINT "Nun entscheide, wohin du gehen willst: In den Palas, der rechts von dir steht,"
419 PRINT "oder in die Stallungen, die sich auf der gegenu_berliegenden Seite des Burghofes"
420 PRINT "befinden? Wenn du lieber auf den Wehrgang steigen willst, gib >hoch< ein."
421 INPUT h$
422 IF h$ = "rechts" THEN GOTO 692
423 IF h$ = "weiter" THEN GOTO 648
424 IF h$ = "hoch" THEN GOTO 427 ELSE GOTO 425
425 PRINT "Ha_remm! Ko_nntest du dich bitte fu_r eine Richtung entscheiden?"
426 GOTO 421
427 IF c$ = "hoch" THEN GOTO 429
428 IF k$ = "hoch" THEN GOTO 429 ELSE GOTO 432
429 PRINT "Du warst doch schon auf dem Wehrgang! Entscheide dich bitte fu_r einen Ort, an"
430 PRINT "dem du noch nicht warst, ok?"
431 GOTO 421
432 IF b$ = "nimm Schwert Schild Seil" THEN GOTO 439
433 IF n$ = "hoch" THEN GOTO 434
434 PRINT "Vo_llig unbewaffnet auf den Wehrgang zu steigen, war eine schlechte Idee! Hier"
435 PRINT "oben laufen einige Wachposten herum, und als sie dich entdecken, legen sie"
436 PRINT "sofort ihre Armbru_ste an und schiesz_en auf dich. Du wirst gleich mehrfach"
437 PRINT "getroffen und stirbst ..."
438 GOTO 117
439 PRINT "Du steigst die Stufen zum Wehrgang hinauf. Als du oben bist, bemerkst du, dasz_"
440 PRINT "hier auch zahlreiche Wachenposten herumstehen. Aber du la_sz_t dich deswegen nicht"
441 PRINT "sehr aus der Ruhe bringen. Du packst Schwert und Schild fester und stu_rzt auf"
442 PRINT "den ersten los. Da du noch nicht bemerkt worden warst, kannst du diesen"
443 PRINT "U_berraschungsangriff ohne Schwierigkeiten beginnen. Dann aber fassen sich deine"
444 PRINT "Gegner schnell und gehen zum Gegenangriff u_ber. Es kommt zu einem langen,"
445 PRINT "harten Kampf, der dir viele Wunden einbringt, obschon du die meisten Hiebe"
446 PRINT "deiner Gegner mit dem Schild auffangen kannst."
447 PRINT "Irgendwann endlich endet das blutige Gefecht. Du la_sz_t das Schwert ermattet"
448 PRINT "sinken und lehnst dich erscho_pft gegen eine Zinne."
449 FOR a = 1 TO 120000
450 NEXT
451 PRINT "Nachdem du wieder zu Kra_ften gekommen bist, gehst du den Wehrgang entlang, bis"
452 PRINT "du zu einem viereckigen Turm gelangst. Du trittst in das Innere des Turms und"
453 PRINT "stehst vor einer Tu_r aus schwerem Holz, die in ein Turmgemach fu_hren musz_. Von"
454 PRINT "ausz_en ist ein eiserner Riegel davorgelegt. Eine Leiter fu_hrt ausz_erdem in das"
455 PRINT "Obergeschosz_ des Turms. Was tust du?"
456 INPUT l$
457 IF l$ = "hoch" THEN GOTO 461
458 IF l$ = "o_ffne Tu_r" THEN GOTO 487
459 IF l$ = "zuru_ck" THEN GOTO 470 ELSE GOTO 456
461 PRINT "Du kletterst die Leiter hinauf. Hier oben ist nichts besonderes. Du entdeckst"
462 PRINT "noch eine Leiter und steigst auch diese empor. Nun stehst du ganz oben auf der"
463 PRINT "Turmplattform. Hier weht ein kra_ftiger Wind, der an deinen Kleidern zerrt und"
464 PRINT "dir die Haare ins Gesicht bla_st. Du bleibst fu_r eine Weile dort oben und siehst"
465 PRINT "dir die Landschaft an. Dann steigst du wieder hinunter. Gehst du nun zum"
466 PRINT "Burghof zuru_ck oder versuchst du, die Tu_r zum Turmgemach zu o_ffnen?"
467 INPUT l$
468 IF l$ = "o_ffne Tu_r" THEN GOTO 487
469 IF l$ = "zuru_ck" THEN GOTO 470 ELSE GOTO 467
470 PRINT "Du la_ufst den ganzen Wehrgang wieder zuru_ck, steigst die Stufen zum Burghof"
471 PRINT "hinunter und musz_t dich nun fu_r eine neue Richtung entscheiden: Links sind die"
472 PRINT "Stallungen, rechterhand befindet sich das Lagerhaus, und wenn du in den Palas"
473 PRINT "mo_chtest, musz_t du geradeaus [>weiter<] u_ber den Burghof gehen."
474 INPUT j$
475 IF j$ = "rechts" THEN GOTO 480
476 IF j$ = "links" THEN GOTO 540
477 IF j$ = "weiter" THEN GOTO 692 ELSE GOTO 478
478 PRINT "Eine klare, vernu_nftige Entscheidung, bitte."
479 GOTO 474
480 IF c$ = "rechts" THEN GOTO 483
481 IF k$ = "weiter" THEN GOTO 483 ELSE GOTO 281
483 PRINT "Mich du_nkt, du warst schon im Lagerhaus! Entscheide dich bitte fu_r einen Ort,"
484 PRINT "an dem du noch nicht warst, ok?"
485 GOTO 474
487 PRINT "Du hast dich entschlossen, die Tu_r zu o_ffnen, denn du willst wissen, was sich"
488 PRINT "dahinter verbirgt. Schwert und Schild legst du beiseite, denn du brauchst beide"
489 PRINT "Ha_nde, um den schweren Riegel zu bewegen. Er sitzt verdammt fest, und du musz_t"
490 PRINT "erst eine Weile rucken und ru_tteln, bis du ihn endlich wegbekommst."
491 PRINT "Dementsprechend bist du gespannt auf das, was dich nun erwarten wird. Du ziehst"
492 PRINT "die Tu_r auf und ..."
493 GOTO 734
494 PRINT
495 PRINT "... vor dir steht eine wunderscho_ne, junge Maid! Sie erschrickt zuerst, weil du"
496 PRINT "ein sehr wildes Bild abgibst, was jedoch vom Kampfe herru_hrt. Dann aber fasz_t"
497 PRINT "sie Vertrauen zu dir, weil du ihr freundlich und offen begegnest. Sie erza_hlt"
498 PRINT "dir, dasz_ sie von UBOLZIO geraubt wurde und er sie hier eingesperrt hat, weil"
499 PRINT "sie sich geweigert hatte, seine Gespielin zu werden. Sie fa_llt gar vor dir"
500 PRINT "nieder und fleht dich an, sie aus der Gewalt UBOLZIOs zu befreien. Hilfst du"
501 PRINT "ihr?"
502 INPUT l$
503 IF l$ = "ja" THEN GOTO 507
504 IF l$ = "nein" THEN GOTO 518 ELSE GOTO 505
505 PRINT "Ja oder nein?"
506 GOTO 502
507 PRINT "Sogleich hebst du sie auf und erkla_rst dich bereit, mit ihr gemeinsam zu"
508 PRINT "fliehen, denn auch dein Verlangen ist es, so rasch wie mo_glich diese Burg zu"
509 PRINT "verlassen. Natu_rlich ist dir klar, dasz_ ihr es nicht schaffen ko_nntet, durch das"
510 PRINT "Burgtor zu entfliehen, ohne von den Wachen entdeckt und geto_tet zu werden."
511 PRINT "Darum musz_t du u_ber einen anderen Fluchtweg nachsinnen. Dir fa_llt ein, dasz_"
512 PRINT "du ja ein langes Seil bei dir hast. Und das ist die Rettung. Zusammen mit dem"
513 PRINT "Ma_dchen verla_sz_t du den Turm und bindest das Seil drausz_en mit dem einen Ende"
514 PRINT "fest um eine Zinne. Das andere Ende wirfst du die Schildmauer hinunter. Ihr"
515 PRINT "steigt daran hinab und seid frei ..."
516 INPUT a
517 GOTO 685
518 PRINT "Ich habe keine Ahnung, welcher bo_se Geist in dich gefahren ist. Das Flehen des"
519 PRINT "Ma_dchens la_sz_t dich ga_nzlich unberu_hrt, du kannst bei deiner Flucht keinen"
520 PRINT "Menschen an deiner Seite dulden. (Es ko_nnte ja eine Trickfalle von UBOLZIO sein"
521 PRINT "oder wie ?!?) Erbarmungslos sperrst du sie wieder zuru_ck in ihr Turmgemach und"
522 PRINT "legst den Tu_rriegel fest davor. Dann nimmst du Schwert und Schild, gehst hinaus"
523 PRINT "aus dem Turm und willst dich davonmachen. Doch deine Unbarmherzigkeit bleibt"
524 PRINT "nicht ungesu_hnt: Vom obersten Rand des Turmes lo_st sich ein grosz_er Stein,"
525 PRINT "stu_rzt hinunter und erschla_gt dich ..."
526 GOTO 117
527 IF b$ = "nimm Schwert Schild Seil" THEN GOTO 401
528 IF d$ = "hoch" THEN GOTO 529
529 PRINT "Du la_ufst die Wendeltreppe hinunter und betrittst eine grosz_e Halle. Du schaust"
530 PRINT "dich um und entdeckst eine Vielzahl an Lebensmitteln, aber auch Boote, behauene"
531 PRINT "Steine, Werkzeuge verschiedenster Art, aufgestapelte Holzbohlen, Stoffballen,"
532 PRINT "Tierha_ute und noch einige andere Sachen. Allem Anschein nach befindest du dich"
534 PRINT "im Lagerhaus. Rechts ist ein grosz_es Tor, was vermutlich auf den Burghof fu_hrt,"
535 PRINT "und am anderen Ende der Halle siehst du eine breite Holztreppe zum Dachboden."
536 PRINT "Da dir von den vielen hier gelagerten Sachen jedoch keine als brauchbar"
537 PRINT "erscheint, beschliesz_t du, hier nicht la_nger zu verbleiben, und gehst hinaus auf"
538 PRINT "den Burghof."
539 GOTO 409
540 IF c$ = "links" THEN GOTO 542
541 IF h$ = "weiter" THEN GOTO 542 ELSE GOTO 545
542 PRINT "In den Stallungen bist du bereits gewesen, wenn ich recht informiert bin. Nimm"
543 PRINT "eine andere Richtung, ok?"
544 GOTO 474
545 PRINT "Du la_ufst hinu_ber zu den Stallungen, um zu sehen, ob es da irgendetwas"
546 PRINT "Interessantes zu entdecken gibt. Du o_ffnest das Tor und gehst hinein. Aber"
547 PRINT "ausz_er Pferdeboxen mit vielen Pferden drin und einem Berg von aufgeha_uftem Heu"
548 PRINT "kannst du hier nichts besonderes erblicken. Was sollte es in einem Pferdestall"
549 PRINT "auch so ausz_ergewo_hnliches geben? Du kehrst dich um und gehst auf den Burghof"
550 PRINT "zuru_ck. Wohin treibt es dich jetzt? In den Palas, dann musz_t du nach links"
551 PRINT "gehen, ins Lagerhaus auf der anderen Seite des Burghofes, oder willst du dich"
552 PRINT "erst auf dem Wehrgang umschauen?"
553 INPUT k$
554 IF k$ = "links" THEN GOTO 692
555 IF k$ = "weiter" THEN GOTO 564
556 IF k$ = "hoch" THEN GOTO 559 ELSE GOTO 557
557 PRINT "Wohin? [>links<, >weiter< bzw. >hoch<]"
558 GOTO 553
559 IF c$ = "hoch" THEN GOTO 561
560 IF h$ = "hoch" THEN GOTO 561 ELSE GOTO 674
561 PRINT "Du warst doch schon auf dem Wehrgang! Entscheide dich bitte fu_r einen Ort, an"
562 PRINT "dem du noch nicht warst, ok?"
563 GOTO 553
564 IF c$ = "rechts" THEN GOTO 566
565 IF j$ = "rechts" THEN GOTO 566 ELSE GOTO 281
566 PRINT "Mich du_nkt, du warst schon im Lagerhaus! Entscheide dich bitte fu_r einen Ort,"
567 PRINT "an dem du noch nicht warst, ok?"
568 GOTO 553
569 IF b$ = "nimm Schwert Schild Seil" THEN GOTO 439
570 IF b$ = "nimm Schlu_sselbund Keule" THEN GOTO 571
571 PRINT "Du steigst die Stufen zum Wehrgang hinauf. Als du oben bist, bemerkst du, dasz_"
572 PRINT "hier auch zahlreiche Wachenposten herumstehen. Noch haben sie dich nicht"
573 PRINT "gesehen. Aber da fa_llt dir schon etwas ein, um ungeschoren an ihnen"
574 PRINT "vorbeizukommen. Du holst Helm und Umhang hervor, die du aus dem Kerker"
575 PRINT "mitgenommen hast, kleidest dich damit ein und siehst nun ebenso aus wie die"
576 PRINT "Schergen UBOLZIOs. In dieser Tarnung betrittst du den Wehrgang und schreitest"
578 PRINT "mutig an den Kerlen vorbei. Und es klappt: Du wirst nicht erkannt. Innerlich"
579 PRINT "frohlockend gehst du immer weiter, bis du zu einem viereckigen Turm gelangst."
580 PRINT "Du trittst in das Innere des Turms und stehst vor einer eisenbeschlagenen Tu_r,"
581 PRINT "die in ein Turmgemach fu_hren musz_. Von ausz_en ist ein schwerer Riegel mit Schlosz_"
582 PRINT "davorgelegt. Eine Leiter fu_hrt ausz_erdem in das Obergeschosz_ des Turms. Was tust"
583 PRINT "du?"
584 INPUT l$
585 IF l$ = "hoch" THEN GOTO 588
586 IF l$ = "o_ffne Tu_r" THEN GOTO 603
587 IF l$ = "zuru_ck" THEN GOTO 597 ELSE GOTO 584
588 PRINT "Du kletterst die Leiter hinauf. Hier oben ist nichts besonderes. Du entdeckst"
589 PRINT "noch eine Leiter und steigst auch diese empor. Nun stehst du ganz oben auf der"
590 PRINT "Turmplattform. Hier weht ein kra_ftiger Wind, der an deinen Kleidern zerrt und"
591 PRINT "dir die Haare ins Gesicht bla_st. Du bleibst fu_r eine Weile dort oben und siehst"
592 PRINT "dir die Landschaft an. Dann steigst du wieder hinunter. Gehst du nun zum"
593 PRINT "Burghof zuru_ck oder versuchst du, die Tu_r zum Turmgemach zu o_ffnen?"
594 INPUT l$
595 IF l$ = "o_ffne Tu_r" THEN GOTO 603
596 IF l$ = "zuru_ck" THEN GOTO 597 ELSE GOTO 594
597 PRINT "Du la_ufst den Wehrgang wieder zuru_ck, vorbei an den ahnungslosen Wachen,"
598 PRINT "steigst die Stufen zum Burghof hinunter und legst dort erst einmal deine"
599 PRINT "Tarnung ab. Nun musz_t du dich fu_r eine neue Richtung entscheiden: Links sind die"
600 PRINT "Stallungen, rechterhand befindet sich das Lagerhaus, und wenn du in den Palas"
601 PRINT "mo_chtest, musz_t du geradeaus [>weiter<] u_ber den Burghof gehen."
602 GOTO 474
603 PRINT "Du hast dich entschlossen, die Tu_r zu o_ffnen, denn du willst wissen, was sich"
604 PRINT "dahinter verbirgt. Du holst den Schlu_sselbund aus deiner Tasche und probierst"
605 PRINT "damit solange, bis du das Schlosz_ aufbekommen hast. Du schiebst den Riegel zur"
606 PRINT "Seite und bist sehr gespannt auf das, was dich nun erwarten wird. Du ziehst die"
607 PRINT "Tu_r auf und ..."
608 GOTO 737
609 PRINT
610 PRINT "... vor dir steht eine wunderscho_ne, junge Maid! Sie erschrickt zuerst, weil du"
611 PRINT "die Kleidung der Burgwachen tra_gst. Dann aber fasz_t sie Vertrauen zu dir, denn"
612 PRINT "du offenbarst ihr deine wahre Gestalt. Sie erza_hlt dir, dasz_ sie von UBOLZIO"
613 PRINT "geraubt wurde und er sie hier eingesperrt hat, weil sie sich geweigert hatte,"
614 PRINT "seine Gespielin zu werden. Sie fa_llt gar vor dir nieder und fleht dich an, sie"
615 PRINT "aus der Gewalt UBOLZIOs zu befreien. Hilfst du ihr?"
616 INPUT l$
617 IF l$ = "ja" THEN GOTO 621
618 IF l$ = "nein" THEN GOTO 639 ELSE GOTO 619
619 PRINT "Ja oder nein?"
620 GOTO 616
621 PRINT "Sogleich hebst du sie auf und erkla_rst dich bereit, mit ihr gemeinsam zu"
622 PRINT "fliehen, denn auch dein Verlangen ist es, so rasch wie mo_glich diese Burg zu"
623 PRINT "verlassen. Dir fa_llt auch sogleich ein Fluchtplan ein. Du gehst zum Eingang des"
624 PRINT "Turmes und rufst den Wa_chter heran, der am na_chsten am Turm steht. Dann stellst"
625 PRINT "du dich schnell hinter den Eingang, und als der Wa_chter hereinkommt schla_gst"
626 PRINT "du ihm deine Keule u_ber den Scha_del. Er sackt zu Boden und ist fu_r die na_chsten"
627 PRINT "paar Stunden ohnma_chtig. Du zerrst ihn in das Turmgemach, nimmst ihm den Helm"
628 PRINT "und den Umhang ab und gibst beides der Maid. Sie verbirgt ihren Leib darunter"
629 PRINT "ebenso, wie du es vorhin getan hast, und ihr verlasz_t den Turm. Ohne verda_chtige"
630 PRINT "Hast aber mit a_ngstlich verkrampftem Herzen geht ihr an den Wachen auf dem"
631 PRINT "Wehrgang vorbei. Ihr erreicht unerkannt den Burghof und geht von dort aus in"
632 PRINT "die Stallungen, wo ihr 2 Pferde sattelt. Ihr fu_hrt sie hinaus auf den Hof,"
633 PRINT "sitzt auf und reitet zum Burgtor. So barsch wie mo_glich und mit verstellter"
634 PRINT "Stimme befiehlst du dem dort wachenden Mann, dasz_ Tor zu o_ffnen. Er scho_pft"
635 PRINT "keinen Argwohn und la_sz_t euch sogleich hinaus. Ihr treibt eure Pferde an und"
636 PRINT "verschwindet fu_r immer aus dieser dunklen Burg ..."
637 INPUT a
638 GOTO 685
639 PRINT "Ich habe keine Ahnung, welcher bo_se Geist in dich gefahren ist. Das Flehen des"
640 PRINT "Ma_dchens la_sz_t dich ga_nzlich unberu_hrt, du kannst bei deiner Flucht keinen"
641 PRINT "Menschen an deiner Seite dulden. (Es ko_nnte ja eine Trickfalle von UBOLZIO sein"
642 PRINT "oder wie ?!?) Erbarmungslos sperrst du sie wieder zuru_ck in ihr Turmgemach und"
643 PRINT "legst den Tu_rriegel fest davor. Dann nimmst du Schwert und Schild, gehst hinaus"
644 PRINT "aus dem Turm und willst dich davonmachen. Doch deine Unbarmherzigkeit bleibt"
645 PRINT "nicht ungesu_hnt: Vom obersten Rand des Turmes lo_st sich ein grosz_er Stein,"
646 PRINT "stu_rzt hinunter und erschla_gt dich ..."
647 GOTO 117
648 IF c$ = "links" THEN GOTO 650
649 IF j$ = "weiter" THEN GOTO 650 ELSE GOTO 545
650 PRINT "In den Stallungen bist du bereits gewesen, wenn ich recht informiert bin. Nimm"
651 PRINT "eine andere Richtung, ok?"
652 GOTO 421
653 PRINT "Schnell bist du beim Tor, welches zu deinem Glu_ck nicht verschlossen ist,"
654 PRINT "o_ffnest es geschwind und la_ufst hinaus auf den Burghof. Krampfhaft nach einem"
655 PRINT "Versteck suchend, blickst du dich um. Da fallen dir die Stallungen ins Auge."
656 PRINT "Ohne noch la_nger zu zo_gern, flu_chtest du hinein und kriechst in einen"
657 PRINT "aufgetu_rmten Berg von Heu. Wenige Augenblicke spa_ter ho_rst du, wie die Schar"
658 PRINT "deiner Verfolger auf den Burghof stu_rmt und lautstark u_berlegt, wo du"
659 PRINT "hingeflohen sein ko_nntest. Dann stu_rzen sie weiter, weil sie dich im Palas"
660 PRINT "wa_hnen. Du wartest noch eine Weile, dann kriechst du aus deinem Versteck und"
661 PRINT "gehst auf den Burghof hinaus. Nun entscheide, wo du als na_chstes hingehen"
662 PRINT "mo_chtest. Bist du mutig und erkundest den Palas, den Sitz UBOLZIOs? Oder willst"
663 PRINT "du lieber hinauf auf den Wehrgang? Gib >links< bzw. >hoch< ein."
664 INPUT m$
665 IF m$ = "links" THEN GOTO 692
666 IF m$ = "hoch" THEN GOTO 669 ELSE GOTO 667
667 PRINT "Hast du denn immernoch nicht kapiert, wie's geht?"
668 GOTO 664
669 IF c$ = "hoch" THEN GOTO 671
670 IF k$ = "hoch" THEN GOTO 671 ELSE GOTO 674
671 PRINT "Du warst doch schon auf dem Wehrgang! Entscheide dich bitte fu_r einen Ort, an"
672 PRINT "dem du noch nicht warst, ok?"
673 GOTO 664
674 IF b$ = "nimm Schwert Schild Seil" THEN GOTO 439
675 IF n$ = "hoch" THEN GOTO 434
676 IF b$ = "nimm Schlu_sselbund Keule" THEN GOTO 571
677 PRINT "Der Dachboden erscheint dir nicht als sicher genug, darum la_ufst du schnell"
678 PRINT "zuru_ck auf den Burghof. Nun blickst du dich hastig um, suchend nach einem"
679 PRINT "geeigneten Versteck vor deinen Verfolgern. Da erblickst du die Stallungen."
680 GOTO 656
681 INPUT a
682 PLAY "<<<<t117mnl2dl4d.l8dl2dmll4fmsemlemsdmldmnc#l2d"
683 INPUT a
684 GOTO 119
685 PLAY "t130ms<<l8cl16ccl8cecegeg>l2c"
686 INPUT a
687 GOTO 837
688 PRINT
689 PRINT "Musik: KRISCHAN (bis auf wenige Raubkopien)"
690 PRINT
691 GOTO 246
692 PRINT "Du gehst die breiten Stufen zum Palas hinauf und o_ffnest die ma_chtige"
693 PRINT "Portaltu_r, in die eine da_monische Fratze hineingeschnitzt ist. Nun stehst du"
694 PRINT "in einem breiten, gewo_lbten Gang, der sich bis zur anderen Seite des Geba_udes"
695 PRINT "hinzieht und dort einen Knick nach rechts macht. Aus der Wand zu deiner Rechten"
696 PRINT "ragen einige Eisenringe, worin Fackeln stecken. Eine Steintafel tra_gt die"
697 PRINT "Inschrift: >>Diesen Palas errichtete der grosz_e Baumeister DEWITT auf Wunsch"
698 PRINT "seiner Majesta_t Ko_nig UBOLZIOs.<< Zu deiner Linken befindet sich eine Tu_r, die"
699 PRINT "mit festen Eisenbanden beschlagen ist. Dort hinten, wo der Gang nach rechts"
700 PRINT "weiterfu_hrt, ist noch eine zweite Tu_r aus einfachem, dunklem Holz."
702 INPUT a$
703 IF a$ = "o_ffne Tu_r" THEN GOTO 707 ELSE GOTO 705
705 PRINT "Versuche, die erste Tu_r zu o_ffnen."
706 GOTO 702
707 IF b$ = "nimm Schwert Schild Seil" THEN GOTO 710
708 IF b$ = "nimm Schlu_sselbund Keule" THEN GOTO 841
709 IF n$ = "hoch" THEN GOTO 852
710 PRINT "Sie ist mit einem schweren Schlosz_ versehen, das du nicht aufbekommst."
711 PRINT "Du gehst hinter zur zweiten Tu_r."
712 INPUT a$
713 IF a$ = "o_ffne Tu_r" THEN GOTO 717
714 IF a$ = "rechts" THEN GOTO 727 ELSE GOTO 715
715 PRINT "Versuche, die 2. Tu_r zu o_ffnen, oder folge dem Gang nach rechts."
716 GOTO 712
717 PRINT "Die Tu_r la_sz_t sich o_ffnen, und du schaust in den Raum hinein. Es befinden sich"
718 PRINT "ein Kamin darin, ein Tisch mit mehreren Schemeln drumherum, einige"
719 PRINT "Kleidertruhen und ein eisernes Gestell mit einem Waschzuber darauf. Es gibt 2"
720 PRINT "Fenster, wovon eines geo_ffnet ist. An den Wa_nden stehen breite Holzba_nke,"
721 PRINT "darauf liegen Schlafdecken. Wahrscheinlich ist dies hier die Kemenate des"
722 PRINT "Burggesindes. Du klappst die Tu_r zu."
723 INPUT a$
724 IF a$ = "rechts" THEN GOTO 727 ELSE GOTO 725
725 PRINT "Folge dem Gang nach rechts."
726 GOTO 723
727 PRINT "Schon nach wenigen Schritten stehst du vor einer grosz_en Wendeltreppe, die ins"
728 PRINT "Obergeschosz_ des Palas fu_hrt. In der Wand rechts von dir ist eine Tu_r, hinter"
729 PRINT "der du Stimmen vernehmen kannst. O_ffnest du die Tu_r oder gehst du gleich die"
730 PRINT "Wendeltreppe hinauf?"
731 INPUT a$
732 IF a$ = "o_ffne Tu_r" THEN GOTO 740
733 IF a$ = "hoch" THEN GOTO 752 ELSE GOTO 731
734 FOR a = 1 TO 70000
735 NEXT
736 GOTO 494
737 FOR a = 1 TO 50000
738 NEXT
739 GOTO 609
740 PRINT "Die Neugier siegt u_ber deinen Verstand: Du o_ffnest die Tu_r vorsichtig eine Hand"
741 PRINT "breit und a_ugst in den Raum hinein. Es ist die Ku_che. Hier herrscht ein"
742 PRINT "hektisches Treiben; wahrscheinlich hat UBOLZIO fu_r heute ein grosz_es Festgelage"
743 PRINT "angesagt. Das gesamte Gesinde ist hier am Schuften und dabei so bescha_ftigt,"
744 PRINT "dasz_ du gar nicht bemerkt wirst. Ma_nner stehen an dem gewaltigen Kamin und"
745 PRINT "beaufsichtigen sa_mtliche Speisen, die dort vor sich hin kochen und braten."
746 PRINT "Andere sitzen um den Tisch herum und nehmen Fasane und Hasen aus, putzen und"
747 PRINT "schneiden das Gemu_se, wieder andere waschen Teller und Pokale, Messer, Lo_ffel"
748 PRINT "und Spiesz_e ab. Frauen scheint es in dieser Burg u_berhaupt nicht zu geben."
749 PRINT "Du schliesz_t die Tu_r wieder und gehst die grosz_e Wendeltreppe hinauf."
750 INPUT a$
751 IF a$ = "hoch" THEN GOTO 752 ELSE GOTO 750
752 PRINT "Du gehst die breite Wendeltreppe hinauf und kommst nun in die ko_niglichen"
753 PRINT "Gefilde des Palas. Du stehst wieder in einem breiten, gewo_lbten Gang, der nach"
754 PRINT "ungefa_hr 5 Metern nach links weiterverla_uft. Das Obergeschosz_ a_hnelt also"
755 PRINT "architektonisch sehr dem unteren Geba_udeteil, doch das ist auch die einzige"
756 PRINT "Gemeinsamkeit. Im Gegensatz zu dem dunklen, schlichten Untergeschosz_ na_mlich ist"
757 PRINT "hier oben alles viel pra_chtiger und majesta_tischer. Grosz_e romanische Fenster"
758 PRINT "lassen viel Licht in diesen Gang, die Wa_nde sind beha_ngt mit grosz_en Bannern,"
759 PRINT "Wappen und Gema_lden, auf denen UBOLZIO abgebildet ist. Links von dir ist eine"
760 PRINT "grosz_e Tu_r aus edelstem Holz mit einem gu_ldenen Griff."
761 INPUT a$
762 IF a$ = "weiter" THEN GOTO 768
763 IF a$ = "o_ffne Tu_r" THEN GOTO 764 ELSE GOTO 761
764 IF b$ = "nimm Schwert Schild Seil" THEN GOTO 767
765 IF b$ = "nimm Schlu_sselbund Keule" THEN GOTO 859
766 IF n$ = "hoch" THEN GOTO 767
767 PRINT "Diese Tu_r ist verschlossen."
768 PRINT "Du gehst den Gang vor und wendest dich nun nach links."
769 INPUT a$
770 IF a$ = "links" THEN GOTO 771 ELSE GOTO 769
771 IF f$ = "klopfe an" THEN GOTO 900
772 IF f$ = "runter" THEN GOTO 773
773 PRINT "Auch dieser Gang wirkt so pra_chtig wie der, den ich eben beschrieb. Alles dient"
774 PRINT "nur dem Zweck, UBOLZIO und seine Herrschaft zu verherrlichen. Du gehst den Gang"
775 PRINT "entlang, bis du zu der grosz_en, teuren Tu_r gelangst, die in den THRONSAAL fu_hrt!"
777 FOR a = 1 TO 35000
778 NEXT
779 PLAY "<<<<t180mnl2cl4cdl6e-dc>l4c.<l8cl2c"
780 INPUT a$
781 IF a$ = "o_ffne Tu_r" THEN GOTO 784 ELSE GOTO 782
782 PRINT "Du zitterst wohl schon vor Angst!"
783 GOTO 780
784 PRINT "Du o_ffnest die Tu_r mit einem Ruck und stu_rmst hinein, Schwert und Schild fest"
785 PRINT "umklammert. Drinnen umfa_ngt dich sogleich ein ungemeiner Prunk und Reichtum."
786 PRINT "An den Wa_nden ha_ngen kostbare Teppiche und goldbestickte Fahnen. Der"
787 PRINT "Steinfusz_boden ist mit zahlreichen Mosaiken geziert. O_llampen auf goldenen"
788 PRINT "Sta_ndern und hohe Fenster mit buntem Glas tauchen den Raum in ein mystisches"
789 PRINT "Licht. Hinter dem ma_chtigen Thron, der mit kunstvollen Schnitzereien versehen"
790 PRINT "ist, erstreckt sich eine lange Reihe von prachtvollen Ru_stungen. Im rechten"
791 PRINT "Teil des Raumes steht eine lange Festtafel mit samtbezogenen Stu_hlen ringherum,"
792 PRINT "wo UBOLZIO wohl immer seine gewaltigen Gelage abha_lt. In der Ecke befindet sich"
793 PRINT "ein grosz_er Kamin, und davor liegt ein Ba_renfell."
794 INPUT a
795 PRINT "UBOLZIO hat dich sofort bemerkt und springt auf von seinem Thron. Er sieht das"
796 PRINT "Schwert in deiner Hand blitzen und zieht sofort aus einer reich verzierten"
797 PRINT "Scheide seinen beru_chtigten Stahl, den Zweiha_nder. Du stu_rzst dich auf ihn, und"
798 PRINT "eure Schwerter treffen klirrend aufeinander. Es entspannt sich ein erbitterter"
799 PRINT "Kampf ..."
800 FOR a = 1 TO 40000
801 NEXT
PLAY "t126<<<<mll16abab>c<b>c<bl8amsb>mlcmsemlamsb>mlcmsemnbb>l4c"
PLAY "<<<mll16abab>c<b>c<bl8amsb>mlcmsemlamsb>mlcmsemnbbl4a"
PLAY "<mll16b-ab-agagal8b-msgmlgmse>mlb-msgmlgmsemneel4f"
PLAY "mll16c<b>c<babab>l8c<msamlamsf#>>mlc<msamlamsf#mnf#f#l4g#"
PLAY "<mll16abab>c<b>c<bl8amsb>mlcmsemlamsb>mlcmse<mnbb>cc#"
PLAY "l4d<mll16fefel8dmsemlfmsa>mldmsemlfmsamng#g#l4a"
PLAY "<mll16afafafgeafb-g>c<agmse mlafafafgeafb-g>c<a>dms<b> mlecececd<b>"
PLAY "ecfdgedms<b> mlecececd<b>ecd<b>c<gb-msg"
PLAY "mlb-gb-gb-gb-g b-gb-gb-gb-msg mla-fa-fa-fa-f a-fa-fa-fa-msf"
PLAY "mlf<a->f<a->f<a->e-<a->f<a->g-<a->a-<a->e-ms<a->"
PLAY "mlfd-gea-fb-msf ml>c<eb-gec<b-msg ml>afafafgeafb-g>c<agmse"
PLAY "mlafafafgeafb-g>c<aemsf ml>d<f>d<f>d<f>c<f>d<f>e<f>f<f>d<f>c<fae"
PLAY "msl8fb-mll4emsl8fp8"
PLAY "<<mll16abab>c<b>c<bl8amsb>mlcmsemlamsb>mlcmsemnbb>l4c"
PLAY "<<<mll16abab>c<b>c<bl8amsb>mlcmsemlamsb>mlcmsemnbbl4a"
PLAY "<mll16b-ab-agagal8b-msgmlgmse>mlb-msgmlgmsemneel4f"
PLAY "mll16c<b>c<babab>l8c<msamlamsf#>>mlc<msamlamsf#mnf#f#l4g#"
PLAY "<mll16abab>c<b>c<bl8amsb>mlcmsemlamsb>mlcmse<mnbb>cc#"
PLAY "l4d<mll16fefel8dmsemlfmsa>mldmsemlfmsamng#g#l4a"
807 PRINT
811 RANDOMIZE TIMER
812 x = INT(RND * 3)
813 GOTO 927
816 PRINT "Du dachtest wohl, UBOLZIO liesz_e sich so einfach to_ten?!? Das erweist sich als"
817 PRINT "ein grosz_er Irrtum! Du hast seine Fechtku_nste gewaltig unterscha_tzt!"
818 PRINT "Er zerschla_gt dir den Schild, dein Schwert zerbricht schliesz_lich auch, und"
819 PRINT "dann versetzt dir UBOLZIO den to_dlichen Streich ..."
820 GOTO 117
821 PRINT "UBOLZIO fu_hrt sein Schwert mit ungeheurer Sta_rke und zerschla_gt deinen Schild."
822 PRINT "Doch nach und nach werden seine Hiebe kraftloser, sein Arm erlahmt unter dem"
823 PRINT "grosz_en Gewicht des Zweiha_nders. Du bringst ihn durch einen geschickten"
824 PRINT "Schwertstreich zu Fall und sto_sz_t ihm das Schwert in die Brust. Da haucht"
825 PRINT "UBOLZIO seinen Odem aus ..."
826 PRINT "DU HAST IHN BEZWUNGEN!"
827 FOR a = 1 TO 50000
828 NEXT
829 PRINT "Du hast UBOLZIO geto_tet und das Land von der Tyrannenherrschaft befreit. Vor"
830 PRINT "lauter Dankbarkeit wa_hlt dich das Volk zu seinem NEUEN KO_NIG!"
831 FOR a = 1 TO 20000
832 NEXT
834 PLAY "t117ms <<l8f#f#f# mlf#l16edef# msl8ggg mlgl16f#ef#g"
835 PLAY "msl8aaa mlal16gf#ed mnl8edc#l4dp8 l8msdddd<ap8aaa> l4d"
836 INPUT a
837 PRINT "                                 GRATULATION!"
838 PRINT "            DU HAST DICH WACKER DURCH DIESES ABENTEUER GESCHLAGEN!"
839 INPUT a
840 GOTO 203
841 PRINT "Sie ist mit einem schweren Schlosz_ versehen, doch das stellt fu_r dich kein"
842 PRINT "Problem dar. Du nimmst den Schlu_sselbund aus der Tasche und probierst"
843 PRINT "damit solange, bis du das Schlosz_ aufbekommen hast. Du o_ffnest die Tu_r und"
844 PRINT "betrittst eine dunkle Kammer. Damit du mehr erkennen kannst, holst du dir aus"
845 PRINT "dem Gewo_lbegang eine Fackel. Nun bemerkst du erfreut, dasz_ dies die"
846 PRINT "Waffenkammer ist! Du denkst, dasz_ es eigentlich besser wa_re, mit scharfem"
847 PRINT "Schwert und festem Schild gewappnet zu sein als mit einer einfachen Keule, wie"
848 PRINT "du sie besitzt. Darum legst du diese geschwind beiseite und suchst dir das"
849 PRINT "beste Schwert und den ha_rtesten Schild aus. Dann verla_sz_t du die Waffenkammer,"
850 PRINT "schliesz_t sie wieder ab und gehst hinter zur zweiten Tu_r."
851 GOTO 712
852 PRINT "Zu deinem Glu_ck ist die Tu_re nicht verschlossen. Du ziehst sie auf und"
853 PRINT "betrittst eine dunkle Kammer. Damit du mehr erkennen kannst, holst du dir aus"
854 PRINT "dem Gewo_lbegang eine Fackel. Nun bemerkst du erfreut, dasz_ dies die"
855 PRINT "Waffenkammer ist! Um nicht weiterhin ungewappnet im Palas herumzutappen,"
856 PRINT "suchst dir das scha_rfste Schwert und den ha_rtesten Schild aus. Dann verla_sz_t du"
857 PRINT "die Waffenkammer wieder und gehst hinter zur zweiten Tu_r."
858 GOTO 712
859 PRINT "Die Tu_r ist verschlossen, doch du o_ffnest auch diese mit den Schlu_sseln. Die"
860 PRINT "Kemenate, die du nun betrittst, ist das Schlafzimmer des Tyrannen UBOLZIO. Die"
861 PRINT "Wa_nde sind mit Samt und Seide u_berzogen, auf dem Boden liegt ein pra_chtiger"
862 PRINT "Teppich und an der rechten Wand steht ein grosz_es Himmelbett mit roten"
863 PRINT "Vorha_ngen. In der linken Ecke der Kemenate steht, abgeschirmt durch"
864 PRINT "halbdurchsichtige, seidene Vorha_nge, ein grosz_er Badekufen, und in der rechten"
865 PRINT "eine grosz_e Truhe fu_r Gewa_nder und andere Bekleidungsstu_cke. Nur wenige Schritte"
866 PRINT "von dir entfernt ist eine kleine Tu_r in der Wand."
867 INPUT a$
868 IF a$ = "o_ffne Tu_r" THEN GOTO 872
869 IF a$ = "zuru_ck" THEN GOTO 889 ELSE GOTO 870
870 PRINT "Versuche, diese Tu_r zu o_ffnen, oder geh aus der Kemenate hinaus."
871 GOTO 867
872 PRINT "Auch diese Tu_r ist abgeschlossen, doch du findest schnell den passenden"
873 PRINT "Schlu_ssel. Als du die Tu_r aufdru_ckst und siehst, was sich dahinter befindet,"
874 PRINT "bist du fu_r eine ganze Weile u_berwa_ltigt! Du stehst in einer kleinen Kammer,"
875 PRINT "die vollgestopft ist mit Reichtu_mern. Da sind grosz_e Truhen und Tonkru_gen, aus"
876 PRINT "denen die Gold- + Silbermu_nzen hervorquellen, mit Perlen und Steinen besetzte"
877 PRINT "Pokale tu_rmen sich neben ungemein kostbaren Vasen, golddurchwirkte Stoffe"
878 PRINT "ha_ufen sich neben Ka_sten voll Schmuck + Geschmeide. Vergoldete Figuren sind"
879 PRINT "hier ebenso zu finden wie mit Edelsteinen besetzte, goldene Dolche. Dir gehen"
880 PRINT "beinahe die Augen u_ber, und du fasz_t auch schnell einen Plan, wie du wenigstens"
881 PRINT "mit einem Teil dieses Schatzes aus der Burg verschwinden ko_nntest: Du nimmst"
882 PRINT "einen Sack, den gro_sz_ten, den du auftreiben kannst, und stopfst dort soviel vom"
883 PRINT "Schatz hinein, wie nur geht. Dann hu_llst du dich ins Helm und Umhang (Beides"
884 PRINT "nahmst du aus dem Kerker mit, falls du dich erinnerst) und hebst den Sack u_ber"
885 PRINT "die Schulter. Anschliesz_end verla_sz_t du den Palas und verla_sz_t - solcherart"
886 PRINT "getarnt - ohne Schwierigkeiten die Burg UBOLZIOs durch das bewachte Burgtor ..."
887 INPUT a
888 GOTO 685
889 PRINT "Du bist nicht an weiteren Kammern interessiert und gehst deshalb aus der"
891 PRINT "Kemenate heraus. Nachdem du die Tu_r wieder verschlossen hast, gehst du den Gang"
892 PRINT "vor und wendest dich nach links."
893 INPUT a$
894 IF a$ = "links" THEN GOTO 895 ELSE GOTO 893
895 PRINT "Dieser Gang ist ebenso prunkvoll eingerichtet wie der, den ich eben beschrieb."
896 PRINT "Alles dient nur dem Zweck, UBOLZIO und seine Herrschaft zu verherrlichen. Du"
897 PRINT "gehst den Gang entlang, bis du zu der grosz_en, teuren Tu_r gelangst, die in den"
898 PRINT "THRONSAAL fu_hrt!"
899 GOTO 777
900 PRINT "Dies ist der letzte Gang vor dem Thronsaal. Und vor der grosz_en Tu_r, die dort"
901 PRINT "hineinfu_hrt, liegt ... ein dreiko_pfiger Drache! Genau so, wie es dir der alte"
902 PRINT "Mann aus dem Turmzimmer gesagt hatte. Der Drache bemerkt dich und richtet seine"
903 PRINT "3 Ha_lse auf. Es ist ein ekelhaftes, schuppiges, schmutzigbraunes Untier mit 4 "
904 PRINT "grosz_en Pranken. Er ist lang und nicht besonders fett, der Drache, so dasz_ er"
905 PRINT "in dem Gang ausreichend Platz findet. U_ber den gesamten Ru_cken zieht sich ein"
906 PRINT "Kamm von Stacheln, ebenso u_ber den Schwanz. Seine Augen leuchten gespenstisch"
907 PRINT "rot, und aus seinen Ma_ulern trieft der Speichel, als er dich da so verzagt"
910 PRINT "stehen sieht. Du fragst dich, wie du je dazu kommen sollst, ihn mit dem Stab"
911 PRINT "anzuru_hren, ohne vorher von ihm verschlungen zu werden. Du gehst langsam auf"
912 PRINT "ihn zu und ha_lst dabei den Schild schu_tzend vor dich, mit der anderen Hand"
913 PRINT "fasz_t du dein Schwert und den Stab. Der Drache la_sz_t dich noch ein Stu_ck"
914 PRINT "herankommen, dann springt er auf dich zu und bru_llt dabei laut aus allen 3"
915 PRINT "Schlu_nden. Du schreist auch, allerdings vor Entsetzen, und fuchtelst wild mit"
916 PRINT "Schwert, obwohl du weisz_t, dasz_ das nichts nu_tzt ..."
917 FOR a = 1 TO 200000
918 NEXT
919 PLAY "<<<t125msl16cccccccccd-cd-ee-d-e-l4c"
920 PRINT "Ich weisz_ zwar nicht wie, aber du schaffst es doch noch, den furchtbaren Drachen"
921 PRINT "mit dem Stab des alten Mannes anzuru_hren, und augenblicklich zerfa_llt das"
922 PRINT "Ungetu_m vor deinen Augen zu Staub. Du wirfst den Stab fort, denn nun ist er fu_r"
923 PRINT "dich ja nutzlos, und schreitest vor bis zur Tu_r, die in den THRONSAAL fu_hrt."
924 FOR a = 1 TO 50000
925 NEXT
926 GOTO 779
927 IF x = 0 THEN GOTO 816
928 IF x = 1 THEN GOTO 821
929 IF x = 2 THEN GOTO 821
