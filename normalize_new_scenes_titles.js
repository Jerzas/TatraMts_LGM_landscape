const fs = require('fs');
const vm = require('vm');

const filePath = 'd:/Terragen/360Panorama_Marzipano/clone/TatraMts_LGM_landscape/data.js';
const raw = fs.readFileSync(filePath, 'utf8');
const cleaned = raw.replace(/^\uFEFF/, '').trimStart();

const sandbox = {};
vm.createContext(sandbox);
vm.runInContext(cleaned + '\n;globalThis.__APP_DATA__ = APP_DATA;', sandbox);
const appData = sandbox.__APP_DATA__;

if (!appData || !Array.isArray(appData.scenes)) {
  throw new Error('Failed to read APP_DATA');
}

const sceneMaps = {
  '1-ciemniak': {
    'Hruby regiel': 'Hrubý Regiel',
    'KIRY': 'Kiry',
    'Małej Łaki glacier': 'Mała Łąka glacier',
    'Małołączniak': 'Małołączniak 2096',
    'Kopa Kondracka': 'Kopa Kondracka 2005',
    'Ciemniak': 'Ciemniak 2096',
    'Tomanowy Wierch Poslki': 'Tomanowy Wierch Polski',
    'Smreczyński Wierch': 'Smreczyński Wierch 2066',
    'Komiarski Wierch': 'Kominiarski Wierch',
    'Osobita': 'Osobitá',
    'Świnica': 'Świnica 2301',
    'Krivan 2494': 'Kriváň 2494',
    'Velka kopa': 'Veľká kopa',
    'Kasprowy Wierch': 'Kasprowy Wierch 1987',
    'Krzesanica': 'Krzesanica 2122'
  },
  '2-huncovsk-tt': {
    'Ladovy stit': 'Ladový štít 2627',
    'Jagnięcy Szczyt': 'Jagnięcy Szczyt 2230',
    'Czarny szczyt': 'Czarny Szczyt 2429',
    'Paclive': 'Páclivé',
    'Kiezmarski glacier': 'Kežmarski glacier',
    'Huncosvki stit': 'Huncovský štít',
    'Kieżmarski stit': 'Kežmarský štít 2558',
    'Kopske sedlo': 'Kopské sedlo 1749',
    'Barane rohy': 'Baranie rohy',
    'Posredny hrot': 'Prostredný hrot 2441',
    'Gerlachovsky stit': 'Gerlachovský štít 2655',
    'Slavkovsky stit': 'Slavkovský štít',
    'Velkostudeny glacier': 'Veľkostudený glacier',
    'Lomnicky stit': 'Lomnický štít 2634',
    'Białka Glacier': 'Białka glacier',
    'Javoroby glacier': 'Javorový glacier',
    'Hncovsky glacier': 'Huncovský glacier',
    'Skalnaty glacier': 'Skalnatý glacier',
    'Świnica': 'Świnica 2301',
    'Siroka': 'Široká 2210',
    'Biabia góra': 'Babia Góra 1725'
  }
};

let changed = 0;
for (const scene of appData.scenes) {
  const map = sceneMaps[scene.id];
  if (!map || !Array.isArray(scene.infoHotspots)) continue;

  for (const hotspot of scene.infoHotspots) {
    if (typeof hotspot.title === 'string' && map[hotspot.title]) {
      hotspot.title = map[hotspot.title];
      changed++;
    }
  }
}

const out = 'var APP_DATA = ' + JSON.stringify(appData, null, 2) + ';\n';
fs.writeFileSync(filePath, out, 'utf8');
console.log('Updated titles: ' + changed);
