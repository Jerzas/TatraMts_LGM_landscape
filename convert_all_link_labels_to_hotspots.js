const fs = require('fs');
const vm = require('vm');

const filePath = 'd:/Terragen/360Panorama_Marzipano/clone/TatraMts_LGM_landscape/data.js';
const raw = fs.readFileSync(filePath, 'utf8');
const cleaned = raw.replace(/^\uFEFF/, '').trimStart();

if (!/^var\s+APP_DATA\s*=/.test(cleaned)) {
  throw new Error('Unexpected data.js format');
}

const sandbox = {};
vm.createContext(sandbox);
vm.runInContext(cleaned + '\n;globalThis.__APP_DATA__ = APP_DATA;', sandbox);
const appData = sandbox.__APP_DATA__;
if (!appData || !Array.isArray(appData.scenes)) {
  throw new Error('Failed to evaluate APP_DATA');
}

function normalize(value) {
  return (value || '')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/&nbsp;/g, ' ')
    .replace(/[^a-z0-9]+/g, ' ')
    .trim();
}

const sceneNameToId = new Map();
for (const scene of appData.scenes) {
  sceneNameToId.set(normalize(scene.name), scene.id);
}

const aliasToId = {
  'lomnica': '21-lomnick-tt',
  'lomnicky stit': '21-lomnick-tt',
  'swistowy': '19-sviov-tt',
  'svistowy': '19-sviov-tt',
  'svistowy stit': '19-sviov-tt',
  'swistowy stit': '19-sviov-tt',
  'slavkosvy': '20-slavkovsk-tt',
  'slavkovsky sttit': '20-slavkovsk-tt',
  'slavkovsky': '20-slavkovsk-tt',
  'hruba veza': '18-hrub-vea',
  'koprova': '12-kprov-dolina',
  'korpvska dolina': '12-kprov-dolina',
  'koprovska dolina': '12-kprov-dolina',
  'koprovsky stit': '13-kprovsk-tt',
  'koprovy': '13-kprovsk-tt',
  'velka kopa': '10-vek-kopa',
  'swinica': '11-winica',
  'swinica': '11-winica',
  'huncovsky': '2-huncovsk-tt',
  'czerwone wierchy': '9-czerwone-wierchy',
  'tapz kiry': '7-tapz-kiry',
  'morskie oko': '15-morskie-oko',
  'batizovska dolina': '17-batizovsk-dolina'
};

function resolveTarget(labelRemainder) {
  const key = normalize(labelRemainder);

  if (aliasToId[key]) {
    return aliasToId[key];
  }

  if (sceneNameToId.has(key)) {
    return sceneNameToId.get(key);
  }

  for (const [nameKey, id] of sceneNameToId.entries()) {
    if (nameKey.includes(key) || key.includes(nameKey)) {
      return id;
    }
  }

  return null;
}

let converted = 0;
const unresolved = [];

for (const scene of appData.scenes) {
  if (!Array.isArray(scene.infoHotspots)) continue;
  if (!Array.isArray(scene.linkHotspots)) scene.linkHotspots = [];

  const keptInfos = [];

  for (const info of scene.infoHotspots) {
    const title = typeof info.title === 'string' ? info.title : '';
    const match = title.match(/^\s*link\s*:?[\s]*(.+)$/i);

    if (!match) {
      keptInfos.push(info);
      continue;
    }

    const remainder = match[1] || '';
    const targetId = resolveTarget(remainder);

    if (!targetId) {
      unresolved.push({ scene: scene.id, title });
      keptInfos.push(info);
      continue;
    }

    scene.linkHotspots.push({
      yaw: info.yaw,
      pitch: info.pitch,
      rotation: 0,
      target: targetId
    });
    converted++;
  }

  scene.infoHotspots = keptInfos;
}

const out = 'var APP_DATA = ' + JSON.stringify(appData, null, 2) + ';\n';
fs.writeFileSync(filePath, out, 'utf8');

console.log(`Converted: ${converted}`);
if (unresolved.length) {
  console.log('Unresolved labels:');
  for (const item of unresolved) {
    console.log(`${item.scene} -> ${item.title}`);
  }
}
