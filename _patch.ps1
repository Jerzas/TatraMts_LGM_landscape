$target = "d:\Terragen\360Panorama_Marzipano\clone\TatraMts_LGM_landscape\data.js"
$c = [System.IO.File]::ReadAllText($target, [System.Text.Encoding]::UTF8)

function Patch($c, $id, $newHotspots) {
    $idPos = $c.IndexOf('"id": "' + $id + '"')
    if ($idPos -lt 0) { Write-Host "[!] Scene not found: $id"; return $c }
    foreach ($nl in @("`r`n", "`n")) {
        $old = '"linkHotspots": [],' + $nl + '      "infoHotspots": []'
        $mPos = $c.IndexOf($old, $idPos)
        if ($mPos -ge 0) {
            $c = $c.Substring(0, $mPos) + $newHotspots + $c.Substring($mPos + $old.Length)
            Write-Host "[OK] $id"
            return $c
        }
    }
    Write-Host "[!] Empty hotspots not found for: $id"; return $c
}

# ── 0-ornak ──────────────────────────────────────────────────────────────────
$c = Patch $c "0-ornak" @'
"linkHotspots": [
        {
          "yaw": -0.7290307427088898,
          "pitch": 0.07312402715734478,
          "rotation": 0,
          "target": "1-ciemniak"
        }
      ],
      "infoHotspots": []
'@

# ── 1-ciemniak ───────────────────────────────────────────────────────────────
$c = Patch $c "1-ciemniak" @'
"linkHotspots": [
        {
          "yaw": -2.092738476387556,
          "pitch": 0.07398212397432857,
          "rotation": 0,
          "target": "0-ornak"
        },
        {
          "yaw": -2.226031537074011,
          "pitch": 0.003026688866171412,
          "rotation": 0,
          "target": "0-ornak"
        },
        {
          "yaw": -0.45829343616058793,
          "pitch": -0.025075385647010506,
          "rotation": 0,
          "target": "0-ornak"
        },
        {
          "yaw": -2.7934592423923466,
          "pitch": 0.02898326595419931,
          "rotation": 0,
          "target": "0-ornak"
        },
        {
          "yaw": 2.2390371124922117,
          "pitch": -0.07253296358755179,
          "rotation": 0,
          "target": "0-ornak"
        },
        {
          "yaw": 1.4781332980058313,
          "pitch": 0.12231960955820398,
          "rotation": 0,
          "target": "0-ornak"
        },
        {
          "yaw": 1.7413622228016177,
          "pitch": -0.02049941991664994,
          "rotation": 0,
          "target": "0-ornak"
        },
        {
          "yaw": 2.294917040950793,
          "pitch": -0.0013468447756572743,
          "rotation": 0,
          "target": "0-ornak"
        },
        {
          "yaw": -1.7600320742570084,
          "pitch": 0.031394524933404,
          "rotation": 0,
          "target": "0-ornak"
        }
      ],
      "infoHotspots": [
        {
          "yaw": -2.385299194279966,
          "pitch": 0.06156189214428487,
          "title": "Bystra 2248",
          "text": "Text"
        },
        {
          "yaw": 0.9645970426801025,
          "pitch": 0.23366684170280294,
          "title": "Giewont 1894",
          "text": "Text"
        },
        {
          "yaw": 0.5811664469164519,
          "pitch": 0.2246291387822268,
          "title": "Z A K O P A N E",
          "text": "Text"
        },
        {
          "yaw": -0.12337688449199113,
          "pitch": 0.3215812444188,
          "title": "Hruby regiel",
          "text": "Text"
        },
        {
          "yaw": -0.3825585895530317,
          "pitch": 0.2876177859626754,
          "title": "KIRY",
          "text": "Text"
        },
        {
          "yaw": -0.07154343761978055,
          "pitch": 0.4991748931300908,
          "title": "Miętusia glacier",
          "text": "Text"
        },
        {
          "yaw": 0.2050470979625274,
          "pitch": 0.44488878049555325,
          "title": "Małej Łaki glacier",
          "text": "Text"
        },
        {
          "yaw": 1.4336266473725452,
          "pitch": 0.3660881583236417,
          "title": "Małołączniak",
          "text": "Text"
        },
        {
          "yaw": 1.475766454260027,
          "pitch": 0.268397921996991,
          "title": "Kopa Kondracka",
          "text": "Text"
        },
        {
          "yaw": 2.4289475705908252,
          "pitch": 1.034091757390435,
          "title": "Ciemniak",
          "text": "Text"
        },
        {
          "yaw": 3.1104402478953856,
          "pitch": 0.298686430387594,
          "title": "Tomanowy Wierch Poslki",
          "text": "Text"
        },
        {
          "yaw": -2.6870462058985414,
          "pitch": 0.16143850325938658,
          "title": "Smreczyński Wierch",
          "text": "Text"
        },
        {
          "yaw": -2.595695545129363,
          "pitch": 0.11325562536040223,
          "title": "Kamienista",
          "text": "Text"
        },
        {
          "yaw": -2.028952635380053,
          "pitch": 0.032693545243406064,
          "title": "Baranec",
          "text": "Text"
        },
        {
          "yaw": -1.3207010765820808,
          "pitch": 0.16166090590001403,
          "title": "Komiarski Wierch",
          "text": "Text"
        },
        {
          "yaw": -1.2486521133590358,
          "pitch": 0.06945333800009479,
          "title": "Osobita",
          "text": "Text"
        },
        {
          "yaw": 1.820602642328673,
          "pitch": 0.04165149982382843,
          "title": "Świnica",
          "text": "Text"
        },
        {
          "yaw": 2.4561522766564856,
          "pitch": 0.01803251574289888,
          "title": "Krivan 2494",
          "text": "Text"
        },
        {
          "yaw": 2.2326028264513766,
          "pitch": 0.33382124906930954,
          "title": "Tichy glacier",
          "text": "Text"
        },
        {
          "yaw": -2.048356884405031,
          "pitch": 0.5554342783680024,
          "title": "Tomanowy glacier",
          "text": "Text"
        },
        {
          "yaw": -1.8376070608326671,
          "pitch": 0.40432407102322365,
          "title": "Kościeliski glacier",
          "text": "Text"
        },
        {
          "yaw": -1.4554957527855663,
          "pitch": 0.1724649482728502,
          "title": "Chochołowski glacier",
          "text": "Text"
        },
        {
          "yaw": 2.94486942829895,
          "pitch": 0.15666974427210079,
          "title": "Koprovy glacier",
          "text": "Text"
        },
        {
          "yaw": 1.1930031800947916,
          "pitch": 0.23610853123969378,
          "title": "Bystrej glacier",
          "text": "Text"
        },
        {
          "yaw": 0.7799068059830017,
          "pitch": 0.2637331835011967,
          "title": "Sarnia Skała",
          "text": "Text"
        },
        {
          "yaw": 0.4074674292251217,
          "pitch": 0.33876947513918765,
          "title": "Łysanki",
          "text": "Text"
        },
        {
          "yaw": -0.584387844133321,
          "pitch": 0.4325356232083557,
          "title": "Kościeliska valley",
          "text": "Text"
        },
        {
          "yaw": -1.9560874346044272,
          "pitch": 0.14737259140302683,
          "title": "Ornak",
          "text": "Text"
        },
        {
          "yaw": 1.64869250905668,
          "pitch": 0.11464527067798258,
          "title": "Kasprowy Wierch",
          "text": "Text"
        },
        {
          "yaw": 2.2281934756616586,
          "pitch": 0.0957585832916159,
          "title": "Velka kopa",
          "text": "Text"
        },
        {
          "yaw": 1.7972116504955027,
          "pitch": 0.5791449396908668,
          "title": "Krzesanica",
          "text": "Text"
        }
      ]
'@

# ── 2-huncovsk-tt ─────────────────────────────────────────────────────────────
$c = Patch $c "2-huncovsk-tt" @'
"linkHotspots": [],
      "infoHotspots": [
        {
          "yaw": 0.29216786035605224,
          "pitch": 0.04616690351325303,
          "title": "Ladovy stit",
          "text": "Text"
        },
        {
          "yaw": 1.3025061043633208,
          "pitch": 0.18757776270063786,
          "title": "Jagnięcy Szczyt",
          "text": "Text"
        },
        {
          "yaw": 0.8733890937386803,
          "pitch": 0.13939815469810313,
          "title": "Czarny szczyt",
          "text": "Text"
        },
        {
          "yaw": 1.5423971410584736,
          "pitch": 0.11248475794793578,
          "title": "Paclive",
          "text": "Text"
        },
        {
          "yaw": 2.744244293827723,
          "pitch": 0.46622571805279733,
          "title": "Kiezmarski glacier",
          "text": "Text"
        },
        {
          "yaw": 0.7394350415702959,
          "pitch": 1.2028638650002126,
          "title": "Huncosvki stit",
          "text": "Text"
        },
        {
          "yaw": 0.6198077416884757,
          "pitch": 0.3751419127140956,
          "title": "Kieżmarski stit",
          "text": "Text"
        },
        {
          "yaw": 1.6632786076497013,
          "pitch": 0.26881962628470824,
          "title": "Kopske sedlo",
          "text": "Text"
        },
        {
          "yaw": 0.47466609029179807,
          "pitch": 0.11636182533312578,
          "title": "Barane rohy",
          "text": "Text"
        },
        {
          "yaw": -0.26330623174417056,
          "pitch": 0.12855271615008412,
          "title": "Posredny hrot",
          "text": "Text"
        },
        {
          "yaw": -0.24174234914652537,
          "pitch": 0.012492727596779218,
          "title": "Gerlachovsky stit",
          "text": "Text"
        },
        {
          "yaw": -0.5855579736382115,
          "pitch": 0.06662717094940618,
          "title": "Slavkovsky stit",
          "text": "Text"
        },
        {
          "yaw": -0.9935105430187363,
          "pitch": 0.36871476047346263,
          "title": "Velkostudeny glacier",
          "text": "Text"
        },
        {
          "yaw": 0.05172291667336282,
          "pitch": 0.15064141470572778,
          "title": "Lomnicky stit",
          "text": "Text"
        },
        {
          "yaw": -0.034783177880029825,
          "pitch": 0.07558732363081688,
          "title": "link Łomnica",
          "text": "Text"
        },
        {
          "yaw": -0.638038879115328,
          "pitch": 0.0256689638602694,
          "title": "link Slavkosvy",
          "text": "Text"
        },
        {
          "yaw": -0.09597343553843629,
          "pitch": 0.04020180186396338,
          "title": "Link Svistowy",
          "text": "Text"
        },
        {
          "yaw": 0.8078966939109709,
          "pitch": 0.12330828265929483,
          "title": "Białka Glacier",
          "text": "Text"
        },
        {
          "yaw": 1.0624511868547604,
          "pitch": 0.1980401626871302,
          "title": "Javoroby glacier",
          "text": "Text"
        },
        {
          "yaw": 1.82934164571751,
          "pitch": 1.0135844089541273,
          "title": "Hncovsky glacier",
          "text": "Text"
        },
        {
          "yaw": -0.2854526921226057,
          "pitch": 0.8298360702436565,
          "title": "Skalnaty glacier",
          "text": "Text"
        },
        {
          "yaw": 0.40703530488760364,
          "pitch": 0.011503070325705522,
          "title": "Świnica",
          "text": "Text"
        },
        {
          "yaw": 0.44909611377247316,
          "pitch": 0.08158964437767224,
          "title": "Siroka",
          "text": "Text"
        },
        {
          "yaw": 0.9609123538014437,
          "pitch": 0.009378158164476957,
          "title": "Biabia góra",
          "text": "Text"
        }
      ]
'@

# ── 5-dolina-biaki ────────────────────────────────────────────────────────────
$c = Patch $c "5-dolina-biaki" @'
"linkHotspots": [],
      "infoHotspots": [
        {
          "yaw": 1.2675409638712107,
          "pitch": 0.024685184790541825,
          "title": "link świnica",
          "text": "Text"
        },
        {
          "yaw": 1.076937892726491,
          "pitch": -0.01789584181102022,
          "title": "Link velka Kopa",
          "text": "Text"
        },
        {
          "yaw": 0.8577404146400749,
          "pitch": 0.03720987907930251,
          "title": "link koprowa",
          "text": "Text"
        },
        {
          "yaw": 0.44724345527613707,
          "pitch": 0.028521685320432866,
          "title": "Link Morskie Oko",
          "text": "Text"
        },
        {
          "yaw": 0.5039850790169744,
          "pitch": 0.03590730973988521,
          "title": "Link koprowy",
          "text": "Text"
        },
        {
          "yaw": -0.27684615525568645,
          "pitch": 0.0019613951416701525,
          "title": "Link batizovska&nbsp;",
          "text": "Text"
        },
        {
          "yaw": -0.48436518486584923,
          "pitch": 0.11619882700220785,
          "title": "Link hruba veza",
          "text": "Text"
        },
        {
          "yaw": -0.520385015014833,
          "pitch": 0.04163902378135376,
          "title": "link swistowy",
          "text": "Text"
        },
        {
          "yaw": -0.7650855155260974,
          "pitch": 0.02603267813577048,
          "title": "link salvkovsky",
          "text": "Text"
        },
        {
          "yaw": -1.2528961937409235,
          "pitch": 0.02707732021177023,
          "title": "Link huncovsky",
          "text": "Text"
        },
        {
          "yaw": -1.0941627665393874,
          "pitch": 0.018266663758263135,
          "title": "link łomnicky",
          "text": "Text"
        },
        {
          "yaw": -1.8835913072436679,
          "pitch": 0.34322929324369156,
          "title": "Javoroy glacier",
          "text": "Text"
        },
        {
          "yaw": -1.5462061259170579,
          "pitch": 0.516768433559605,
          "title": "Siroky glacier",
          "text": "Text"
        },
        {
          "yaw": 2.9805720879909234,
          "pitch": 0.6768323249827048,
          "title": "Białka glacier",
          "text": "Text"
        },
        {
          "yaw": 2.798446036878752,
          "pitch": 0.5011712420647392,
          "title": "Rusinowa Polana",
          "text": "Text"
        },
        {
          "yaw": 2.9822903867040207,
          "pitch": 0.4331718301402496,
          "title": "Goły Wierch",
          "text": "Text"
        },
        {
          "yaw": -3.071298894299936,
          "pitch": 0.21279120590881284,
          "title": "Cyrchla nad Białką",
          "text": "Text"
        },
        {
          "yaw": -2.69875107292542,
          "pitch": 0.052620049777036826,
          "title": "Lubań",
          "text": "Text"
        },
        {
          "yaw": 3.063781190844983,
          "pitch": 0.04376661683158112,
          "title": "Turbacz",
          "text": "Text"
        },
        {
          "yaw": -2.9788120281797585,
          "pitch": 0.03505823041508194,
          "title": "Mogielica",
          "text": "Text"
        },
        {
          "yaw": -1.4230784092083475,
          "pitch": 0.08481102587575506,
          "title": "Jagniecy stit",
          "text": "Text"
        },
        {
          "yaw": -1.2768311287975465,
          "pitch": 0.06034460558154642,
          "title": "Czarny stit",
          "text": "Text"
        },
        {
          "yaw": -1.1434617269159624,
          "pitch": 0.028476458013319217,
          "title": "Lomnicky stit",
          "text": "Text"
        },
        {
          "yaw": -1.2092605337686813,
          "pitch": 0.03437707372957277,
          "title": "kiezmarsky stit",
          "text": "Text"
        },
        {
          "yaw": -1.0376002815167986,
          "pitch": 0.03177077992506128,
          "title": "Ladovy stit",
          "text": "Text"
        },
        {
          "yaw": -0.9532254303330383,
          "pitch": 0.046685387572640735,
          "title": "Posredny hrot",
          "text": "Text"
        },
        {
          "yaw": -0.8854263553012327,
          "pitch": 0.06530220081292804,
          "title": "ostry stit",
          "text": "Text"
        },
        {
          "yaw": -0.8165641551176392,
          "pitch": 0.059440398210776735,
          "title": "Javorovy stit",
          "text": "Text"
        },
        {
          "yaw": -0.7971855006606514,
          "pitch": 0.15729206486226133,
          "title": "Siroka 2210",
          "text": "Text"
        },
        {
          "yaw": -0.5839339876905463,
          "pitch": 0.043238920158113814,
          "title": "Bradvica",
          "text": "Text"
        },
        {
          "yaw": -0.37237800130420595,
          "pitch": 0.02263528281035576,
          "title": "gerlachosvy stot",
          "text": "Text"
        },
        {
          "yaw": -0.19344316463202915,
          "pitch": 0.03357940404206694,
          "title": "Koncista",
          "text": "Text"
        },
        {
          "yaw": -0.29314535177698,
          "pitch": 0.046061340770767956,
          "title": "Batozovski stit",
          "text": "Text"
        },
        {
          "yaw": -0.10906768864342453,
          "pitch": 0.13760884709853016,
          "title": "Mlynar",
          "text": "Text"
        },
        {
          "yaw": -0.01803745990059724,
          "pitch": 0.03864675786281069,
          "title": "Vysoka",
          "text": "Text"
        },
        {
          "yaw": -0.11430747428629928,
          "pitch": 0.051914235474834314,
          "title": "Ganek",
          "text": "Text"
        },
        {
          "yaw": 0.0562471817083221,
          "pitch": 0.05091220780479411,
          "title": "Rysy",
          "text": "Text"
        },
        {
          "yaw": 0.15257413410855314,
          "pitch": 0.08155343044160901,
          "title": "Żabi Koń",
          "text": "Text"
        },
        {
          "yaw": -0.22404142320586473,
          "pitch": 0.2014040398524699,
          "title": "<h2>Bielovodská veža</h2>",
          "text": "Text"
        },
        {
          "yaw": 0.17364098341590584,
          "pitch": 0.1606837595203512,
          "title": "<h1>Żabia Czuba 2080</h1>",
          "text": "Text"
        },
        {
          "yaw": 0.031700106859831934,
          "pitch": 0.23170383813932816,
          "title": "Zabi glacier",
          "text": "Text"
        },
        {
          "yaw": -1.4030684111078102,
          "pitch": 0.634131166160909,
          "title": "Zadnia kopa",
          "text": "Text"
        },
        {
          "yaw": -1.6934678775165466,
          "pitch": 0.35236911199704757,
          "title": "Velky Babos",
          "text": "Text"
        },
        {
          "yaw": -2.2672153011571865,
          "pitch": 0.2794669692530487,
          "title": "Kicera",
          "text": "Text"
        },
        {
          "yaw": -2.4935680258258586,
          "pitch": 0.3557727136875588,
          "title": "Tatranska Javorina",
          "text": "Text"
        },
        {
          "yaw": -2.8300449870631397,
          "pitch": 0.4788811239892503,
          "title": "Łysa Polana",
          "text": "Text"
        },
        {
          "yaw": -2.943210045582285,
          "pitch": 0.4705594061804579,
          "title": "Łysa Skałka",
          "text": "Text"
        },
        {
          "yaw": -3.131400396209184,
          "pitch": 0.29789422219997874,
          "title": "Wierch Poroniec",
          "text": "Text"
        },
        {
          "yaw": 2.4339296527681276,
          "pitch": 0.4104812577672554,
          "title": "Gęsia Szyja",
          "text": "Text"
        },
        {
          "yaw": -0.26463057100767884,
          "pitch": 0.372469576651417,
          "title": "Belovodsky glacier",
          "text": "Text"
        },
        {
          "yaw": 0.4080195183953226,
          "pitch": 0.44977928461741,
          "title": "Rybi Potok glacier",
          "text": "Text"
        },
        {
          "yaw": -0.4159694875353548,
          "pitch": 0.11067471937471751,
          "title": "Hruba veza",
          "text": "Text"
        },
        {
          "yaw": -0.43294650541742286,
          "pitch": 0.18247123304272073,
          "title": "<h2>Veža nad kolibou</h2>",
          "text": "Text"
        },
        {
          "yaw": -0.4019540678845708,
          "pitch": 0.4852127126593899,
          "title": "<h1>Úplazky</h1>",
          "text": "Text"
        },
        {
          "yaw": 0.588528832130347,
          "pitch": 0.8896535333715683,
          "title": "<h1>Roztocka Czuba 1425</h1>",
          "text": "Text"
        },
        {
          "yaw": 0.9615534413946403,
          "pitch": 0.5054182218954644,
          "title": "Roztoka glacier",
          "text": "Text"
        },
        {
          "yaw": 1.9412060009823113,
          "pitch": 0.45917388746280885,
          "title": "Waksumundzki glacier",
          "text": "Text"
        },
        {
          "yaw": 1.2671271926259955,
          "pitch": 0.16654494270456865,
          "title": "Krzyżne",
          "text": "Text"
        },
        {
          "yaw": 2.0048783928310794,
          "pitch": 0.23584799520754274,
          "title": "Sucha Woda glacier",
          "text": "Text"
        },
        {
          "yaw": 1.9820403273132836,
          "pitch": 0.14679858133965595,
          "title": "Zakopane",
          "text": "Text"
        },
        {
          "yaw": 0.646844655769609,
          "pitch": 0.02929037384587474,
          "title": "krivan",
          "text": "Text"
        },
        {
          "yaw": 1.2091510137117254,
          "pitch": 0.07146676747864511,
          "title": "Świnica",
          "text": "Text"
        },
        {
          "yaw": 1.4567317446791117,
          "pitch": 0.17394037295790987,
          "title": "Wielka Koszyta",
          "text": "Text"
        },
        {
          "yaw": 1.4394783695295876,
          "pitch": 0.0873363805936549,
          "title": "Kasprowy Wierch",
          "text": "Text"
        },
        {
          "yaw": 1.625828204750463,
          "pitch": 0.07069027166849473,
          "title": "Giewont",
          "text": "Text"
        },
        {
          "yaw": 0.9390868429215846,
          "pitch": 0.21207227597635026,
          "title": "Siklawa icefall",
          "text": "Text"
        },
        {
          "yaw": 0.8003548066860287,
          "pitch": 0.3031870539716923,
          "title": "Świstówka icefall",
          "text": "Text"
        },
        {
          "yaw": 0.5152986157475787,
          "pitch": 0.12415721609724173,
          "title": "Mnich",
          "text": "Text"
        },
        {
          "yaw": 0.4109233398326744,
          "pitch": 0.06544637385636243,
          "title": "Mieguszowiskic szczyt Wielki",
          "text": "Text"
        },
        {
          "yaw": 2.226247862352821,
          "pitch": 0.012788014635235712,
          "title": "Babia gora",
          "text": "Text"
        },
        {
          "yaw": -2.2591566965842986,
          "pitch": 0.04116031348416804,
          "title": "Radziejowa",
          "text": "Text"
        },
        {
          "yaw": -2.016752527897962,
          "pitch": 0.03489625896345672,
          "title": "Jaworzyna Krynicka",
          "text": "Text"
        },
        {
          "yaw": -1.6436461807109364,
          "pitch": 0.03331366329373253,
          "title": "C e r g o v",
          "text": "Text"
        },
        {
          "yaw": 0.692211744075335,
          "pitch": 0.015891185102818284,
          "title": "Dumbier",
          "text": "Text"
        },
        {
          "yaw": -1.5108299410456993,
          "pitch": 0.042867152119862695,
          "title": "Levocke vyrchy&nbsp;",
          "text": "Text"
        },
        {
          "yaw": -2.1556306725635928,
          "pitch": 0.1399030332740896,
          "title": "Spiska Magura",
          "text": "Text"
        },
        {
          "yaw": 1.9808214556450707,
          "pitch": 0.09762555756330293,
          "title": "Gubałówka",
          "text": "Text"
        },
        {
          "yaw": 1.2569225010723262,
          "pitch": 0.5441246895962291,
          "title": "Turnia nad Szczotami",
          "text": "Text"
        },
        {
          "yaw": 1.1372897361460765,
          "pitch": 0.6624573587081208,
          "title": "Roztocka Turniczka",
          "text": "Text"
        },
        {
          "yaw": 0.7042636432369846,
          "pitch": 0.17385593341489347,
          "title": "Opalony wierch",
          "text": "Text"
        },
        {
          "yaw": 0.6656575589281939,
          "pitch": 0.1231695127734973,
          "title": "Miedziane",
          "text": "Text"
        },
        {
          "yaw": -1.555910455631178,
          "pitch": 0.12881463257301817,
          "title": "Kopske sedlo",
          "text": "Text"
        },
        {
          "yaw": -1.839725428588558,
          "pitch": 0.09909232603497209,
          "title": "Havran",
          "text": "Text"
        },
        {
          "yaw": -1.7745367100311675,
          "pitch": 0.09569636906982915,
          "title": "Paclive",
          "text": "Text"
        },
        {
          "yaw": -2.8625886959429643,
          "pitch": 0.7558647267163305,
          "title": "Tisovka",
          "text": "Text"
        },
        {
          "yaw": -2.684371785430187,
          "pitch": 0.776723358547855,
          "title": "Cervena dolina",
          "text": "Text"
        },
        {
          "yaw": 2.21023838486569,
          "pitch": 0.41320962448430976,
          "title": "Waksmundszka Przełęcz",
          "text": "Text"
        },
        {
          "yaw": 2.835777264779799,
          "pitch": 0.3085895038211319,
          "title": "Filipka Valley",
          "text": "Text"
        },
        {
          "yaw": -2.567599158474895,
          "pitch": 0.30736201307703226,
          "title": "Chovancov vyrch",
          "text": "Text"
        },
        {
          "yaw": -1.8097971788325573,
          "pitch": 0.7910179526408534,
          "title": "Holica",
          "text": "Text"
        },
        {
          "yaw": -0.695252117326687,
          "pitch": 0.2514574199877888,
          "title": "Zamky",
          "text": "Text"
        },
        {
          "yaw": 1.3685142748085024,
          "pitch": 0.25967463325953055,
          "title": "Skrajny Wołoszyn",
          "text": "Text"
        },
        {
          "yaw": 0.9305565144898331,
          "pitch": 0.1493760291911883,
          "title": "Pięć Stawów Polskich cirque field",
          "text": "Text"
        },
        {
          "yaw": 0.4065981319621592,
          "pitch": 0.2539236180397584,
          "title": "Morskie Oko will be hire",
          "text": "Text"
        },
        {
          "yaw": 1.470561982340013,
          "pitch": 0.03353755351525223,
          "title": "link Czerwone wierchy",
          "text": "Text"
        }
      ]
'@

# ── 6-krzyne ──────────────────────────────────────────────────────────────────
$c = Patch $c "6-krzyne" @'
"linkHotspots": [],
      "infoHotspots": [
        {
          "yaw": 0.6560717151480713,
          "pitch": 0.05023334461257889,
          "title": "link Korpvska dolina",
          "text": "Text"
        },
        {
          "yaw": 1.0053740101365225,
          "pitch": -0.004786562734251376,
          "title": "link velka kopa",
          "text": "Text"
        },
        {
          "yaw": 1.2939116314340815,
          "pitch": 0.049266201183183256,
          "title": "Link świnica",
          "text": "Text"
        },
        {
          "yaw": -1.9255489144303652,
          "pitch": 0.06575986400053324,
          "title": "Dolina Białki",
          "text": "Text"
        },
        {
          "yaw": -0.2752714989461822,
          "pitch": 0.05922301766389282,
          "title": "link morskie Oko",
          "text": "Text"
        },
        {
          "yaw": 0.06296498445910714,
          "pitch": 0.061379103213583974,
          "title": "link koprovsky stit",
          "text": "Text"
        },
        {
          "yaw": -0.6431542777787644,
          "pitch": -0.0012026336335839716,
          "title": "link batizovska dolina",
          "text": "Text"
        },
        {
          "yaw": -0.9981717186976411,
          "pitch": 0.016004088209042422,
          "title": "link slavkovsky sttit",
          "text": "Text"
        },
        {
          "yaw": -0.944474313544788,
          "pitch": 0.08329808833128993,
          "title": "link hruba veza",
          "text": "Text"
        },
        {
          "yaw": -0.9258748404121864,
          "pitch": 0.030890827204245852,
          "title": "link svistowy stit",
          "text": "Text"
        },
        {
          "yaw": -1.3079669193335786,
          "pitch": 0.015675406163961014,
          "title": "link lomnica",
          "text": "Text"
        },
        {
          "yaw": -1.4094966570181544,
          "pitch": 0.02163790831590795,
          "title": "link huncovsky",
          "text": "Text"
        },
        {
          "yaw": 1.5824533846927178,
          "pitch": 0.047545894498254526,
          "title": "link czerwone wierchy",
          "text": "Text"
        },
        {
          "yaw": 1.8025090903720518,
          "pitch": 0.05588424117443758,
          "title": "link TAPZ Kiry",
          "text": "Text"
        },
        {
          "yaw": 0.3811450175237763,
          "pitch": 0.49099798803350403,
          "title": "Siklawa icefall",
          "text": "Text"
        }
      ]
'@

[System.IO.File]::WriteAllText($target, $c, [System.Text.Encoding]::UTF8)
Write-Host "Zapisano."
