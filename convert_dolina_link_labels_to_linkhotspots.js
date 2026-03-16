const fs = require('fs');

const filePath = 'd:/Terragen/360Panorama_Marzipano/clone/TatraMts_LGM_landscape/data.js';
let text = fs.readFileSync(filePath, 'utf8');

const start = text.indexOf('"id": "5-dolina-biaki"');
const end = text.indexOf('"id": "6-krzyne"', start);
if (start === -1 || end === -1) throw new Error('Scene boundaries not found');

let segment = text.slice(start, end);

const map = {
  'Link: Świnica': '11-winica',
  'Link: Veľká kopa': '10-vek-kopa',
  'Link: Kôprová dolina': '12-kprov-dolina',
  'Link: Morskie Oko': '15-morskie-oko',
  'Link: Kôprovský štít': '13-kprovsk-tt',
  'Link: Batizovská dolina': '17-batizovsk-dolina',
  'Link: Hrubá veža': '18-hrub-vea',
  'Link: Svišťový štít': '19-sviov-tt',
  'Link: Slavkovský štít': '20-slavkovsk-tt',
  'Link: Huncovský štít': '2-huncovsk-tt',
  'Link: Lomnický štít': '21-lomnick-tt',
  'Link: Czerwone Wierchy': '9-czerwone-wierchy'
};

const infoMatch = segment.match(/"infoHotspots"\s*:\s*\[([\s\S]*?)\]\s*\n\s*\}/);
if (!infoMatch) throw new Error('infoHotspots block not found');
const infoContent = infoMatch[1];

const objectRegex = /\{[\s\S]*?\}/g;
const objects = infoContent.match(objectRegex) || [];

const keep = [];
const links = [];

for (const obj of objects) {
  const titleMatch = obj.match(/"title"\s*:\s*"([^"]*)"/);
  const yawMatch = obj.match(/"yaw"\s*:\s*([^,\n]+)/);
  const pitchMatch = obj.match(/"pitch"\s*:\s*([^,\n]+)/);

  const title = titleMatch ? titleMatch[1] : '';
  if (map[title] && yawMatch && pitchMatch) {
    links.push({
      yaw: yawMatch[1].trim(),
      pitch: pitchMatch[1].trim(),
      target: map[title]
    });
  } else {
    keep.push(obj);
  }
}

const linkMatch = segment.match(/"linkHotspots"\s*:\s*\[([\s\S]*?)\],\s*\n\s*"infoHotspots"/);
if (!linkMatch) throw new Error('linkHotspots block not found');
const existingLinkContent = linkMatch[1].trim();
const existingLinks = existingLinkContent ? [existingLinkContent] : [];

const newLinkObjects = links.map(link => [
  '        {',
  `          "yaw": ${link.yaw},`,
  `          "pitch": ${link.pitch},`,
  '          "rotation": 0,',
  `          "target": "${link.target}"`,
  '        }'
].join('\n'));

const combinedLinks = [...existingLinks, ...newLinkObjects].filter(Boolean).join(',\n');

const newLinkBlock = `"linkHotspots": [\n${combinedLinks}\n      ],\n      "infoHotspots"`;
segment = segment.replace(/"linkHotspots"\s*:\s*\[[\s\S]*?\],\s*\n\s*"infoHotspots"/, newLinkBlock);

const newInfoContent = keep.join(',\n');
segment = segment.replace(/"infoHotspots"\s*:\s*\[[\s\S]*?\]\s*\n\s*\}/, `"infoHotspots": [\n${newInfoContent}\n      ]\n    }`);

text = text.slice(0, start) + segment + text.slice(end);
fs.writeFileSync(filePath, text, 'utf8');

console.log(`Converted ${links.length} link labels to linkHotspots.`);
