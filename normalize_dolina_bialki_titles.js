const fs = require('fs');

const filePath = 'd:/Terragen/360Panorama_Marzipano/clone/TatraMts_LGM_landscape/data.js';
let text = fs.readFileSync(filePath, 'utf8');

const start = text.indexOf('"id": "5-dolina-biaki"');
const end = text.indexOf('"id": "6-krzyne"', start);
if (start === -1 || end === -1) throw new Error('Scene boundaries not found');

let segment = text.slice(start, end);

const replacements = {
  'link świnica': 'Link: Świnica',
  'Link velka Kopa': 'Link: Veľká kopa',
  'link koprowa': 'Link: Kôprová dolina',
  'Link Morskie Oko': 'Link: Morskie Oko',
  'Link koprowy': 'Link: Kôprovský štít',
  'Link batizovska&nbsp;': 'Link: Batizovská dolina',
  'Link hruba veza': 'Link: Hrubá veža',
  'link swistowy': 'Link: Svišťový štít',
  'link salvkovsky': 'Link: Slavkovský štít',
  'Link huncovsky': 'Link: Huncovský štít',
  'link łomnicky': 'Link: Lomnický štít',
  'link Czerwone wierchy': 'Link: Czerwone Wierchy',

  'Goły Wierch': 'Goły Wierch 1206',
  'Lubań': 'Lubań 1225',
  'Turbacz': 'Turbacz 1310',
  'Mogielica': 'Mogielica 1170',
  'Jagniecy stit': 'Jagnięcy Szczyt 2230',
  'Czarny stit': 'Czarny Szczyt 2429',
  'Lomnicky stit': 'Lomnický štít 2634',
  'kiezmarsky stit': 'Kežmarský štít 2558',
  'Ladovy stit': 'Ladový štít 2627',
  'Posredny hrot': 'Prostredný hrot 2441',
  'ostry stit': 'Ostry Szczyt 2360',
  'Javorovy stit': 'Javorový štít 2418',
  'Bradvica': 'Bradavica 2476',
  'gerlachosvy stot': 'Gerlachovský štít 2655',
  'Koncista': 'Končistá 2538',
  'Batozovski stit': 'Batizovský štít 2448',
  'Mlynar': 'Mlynár 2170',
  'Vysoka': 'Vysoká 2547',
  'Ganek': 'Ganek 2459',
  'Rysy': 'Rysy 2501',
  'Żabi Koń': 'Żabi Koń 2291',
  'Gęsia Szyja': 'Gęsia Szyja 1490',
  'krivan': 'Kriváň 2494',
  'Świnica': 'Świnica 2301',
  'Wielka Koszyta': 'Wielka Koszysta 2193',
  'Kasprowy Wierch': 'Kasprowy Wierch 1987',
  'Giewont': 'Giewont 1894',
  'Mnich': 'Mnich 2068',
  'Mieguszowiskic szczyt Wielki': 'Mięguszowiecki Szczyt Wielki 2438',
  'Babia gora': 'Babia Góra 1725',
  'Radziejowa': 'Radziejowa 1262',
  'Jaworzyna Krynicka': 'Jaworzyna Krynicka 1114',
  'Dumbier': 'Ďumbier 2043',
  'Gubałówka': 'Gubałówka 1126',
  'Opalony wierch': 'Opalony Wierch 2115',
  'Miedziane': 'Miedziane 2233',
  'Kopske sedlo': 'Kopské sedlo 1749',
  'Havran': 'Havran 2152',
  'Skrajny Wołoszyn': 'Skrajny Wołoszyn 2168',

  'Javoroy glacier': 'Javorový glacier',
  'Siroky glacier': 'Široká glacier',
  'Zabi glacier': 'Żabi glacier',
  'Belovodsky glacier': 'Bielovodský glacier',
  'Waksumundzki glacier': 'Waksmundzki glacier',
  'Levocke vyrchy&nbsp;': 'Levočské vrchy',
  'Spiska Magura': 'Spišská Magura',
  'Cervena dolina': 'Červená dolina',
  'Waksmundszka Przełęcz': 'Waksmundzka Przełęcz',
  'Filipka Valley': 'Dolina Filipka',
  'Chovancov vyrch': 'Chovanec',
  'Zamky': 'Zámky',
  'Morskie Oko will be hire': 'Morskie Oko',

  '<h2>Bielovodská veža</h2>': 'Bielovodská veža',
  '<h1>Żabia Czuba 2080</h1>': 'Żabia Czuba 2080',
  '<h2>Veža nad kolibou</h2>': 'Veža nad kolibou',
  '<h1>Úplazky</h1>': 'Úplazky',
  '<h1>Roztocka Czuba 1425</h1>': 'Roztocka Czuba 1425',

  'Velky Babos': 'Veľký Baboš',
  'Kicera': 'Kiczera',
  'Hruba veza': 'Hrubá veža',
  'C e r g o v': 'Čergov',
  'Siroka 2210': 'Široká 2210',
  'Paclive': 'Páclivé',
  'Zadnia kopa': 'Zadnia Kopa'
};

for (const [oldTitle, newTitle] of Object.entries(replacements)) {
  segment = segment.split(`"title": "${oldTitle}"`).join(`"title": "${newTitle}"`);
}

text = text.slice(0, start) + segment + text.slice(end);
fs.writeFileSync(filePath, text, 'utf8');

console.log('done');
