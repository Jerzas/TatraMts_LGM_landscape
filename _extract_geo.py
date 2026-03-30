import re, json, pathlib
p = pathlib.Path(r'd:/Terragen/360Panorama_Marzipano/clone/TatraMts_LGM_landscape/data.js')
s = p.read_text(encoding='utf-8')

names = []
for m in re.finditer(r'"title"\s*:\s*"([^"]+)"', s):
    names.append(m.group(1))
for m in re.finditer(r'"name"\s*:\s*"([^"]+)"', s):
    names.append(m.group(1))

clean = []
for n in names:
    n = re.sub(r'<[^>]+>', '', n)
    n = n.replace('\\"', '"').strip()
    n = re.sub(r'\s+', ' ', n)
    n2 = re.sub(r'\s+\d{3,4}(?:\s?m)?$', '', n).strip()
    if n2.lower() in {'text', ''}:
        continue
    clean.append(n2)

uniq = []
seen = set()
for n in clean:
    if n in seen:
        continue
    seen.add(n)
    uniq.append(n)

out = pathlib.Path(r'd:/Terragen/360Panorama_Marzipano/clone/TatraMts_LGM_landscape/_geo_names_raw.json')
out.write_text(json.dumps(uniq, ensure_ascii=False, indent=2), encoding='utf-8')
print('count=', len(uniq))
print('saved=', out)
print('preview:')
for x in uniq[:80]:
    print(x)
