class AppStrings {
  

//GENERAL  
  
  static const app_name = "Junbi";
  static const hyeong_explanation = "Hyeongs sind Abläufe vorgefertigter Angriffs -und Verteidigunstechniken, die graduell komplizierter werden.";
  static const junbi_introduction_german = "Willkommen bei Junbi, die App für\n traditionelles Taekwondo.";


//HYEONG INFO

static const hyeong_data = 
  ["Cheon Ji|천지|天地|Himmel und Erde, steht für den Anfang.|19|1|Bedeutet Himmel und Erde (天 und 地). Dieser Hyeong steht für den Anfang.", 
  "Dan Gun|단군|檀君|Ein Heiliger, welcher der Legende nach 2333 v.Chr Korea erschaffen hat.|21|2|Benannt nach dem heiligen Dan Gun, der 2333 v.Chr. Korea gergründet haben soll.", 
  "Do San|도산|島山|Koreanischer Patriot, Anführer der koreanischen Unabhängigkeitsbewegung.|24|3|Do San ist der Pseudonym des Patrioten An Chang Ho (안창호) (1878-1938). Er war ein Koreanischer Politiker, Unabhängigkeitsaktivist, und Leiter der 'Korean-American immigrant community' in den USA. Er und seine Frau waren da erste Koreanischer Ehepaar, das legal in die USA einreiste.", 
  "Won Hyo|원효|元曉|Buddhistischer Mönch, der Buddhismus in Korea verbreitete.|28|4|Won Hyo war ein ein buddhistischer Mönch in Korea. Er hat sich für die Verbreitung des Buddhismus in Korea eingesetz", 
  "Yul Gok|율곡|栗谷|Der Philosoph Yi I hat sich intensiv mit dem 'Ki', der Energie, beschäftigt.|38|5|Yul Gok war der Künstlername des Philosophen Yi I (이이). Gemeinsam mit Toi Gye (Yi Hwang) war er einer der beiden großen Philosophen seiner Zeit. Er legte besonderen Wert auf die Lebensenergie, dem 'KI' ", 
  "Jung Geun|중근|重根|Freiheitskämpfer, bekannt für den Mord eines Japanischen Premirministers.|32|6|An Jung Geun (안중근) war ein Koreanischer Freiheitskämpfer. Er ist berühmt für die Ermordung des Japanischen Ministerpräsidenten, der damals über Korea regierte.", 
  "Toi Gye|퇴계|退溪|Der Philosoph Yi Hwang hat sich intensiv mit dem 'Li', der Ordnung, beschäftigt.|37|7|Toi Gye ist der Künstlername des Philosophen Yi Hwang (이황). Im Gegensatz zu Yul Gok (Yi I), legte er mehr Wert auf die Ordnung (Ri), statt der Energie (Ki).", 
  "Hwa Rang|화랑|花郞|Eine Gruppe jugendlicher Arsitokraten, die Literatur und Kampfkunst lernten.|29|8|Hwa Rang war eine Gruppe aristokratischer Jugendlicher, die eine Gute Bildung genossen. Sie lernten unter anderem Recht, Philosophie, Literatur und Kampfkunst.", 
  "Chung Mu|충무|忠武|Yi Sun Shin war ein Admiral, bekannt für seine Schildkrötenschiffe.|30|9|Yi Sun Shin (이순신) war ein Koreanischer Admiral. Er wird als einer der größten Helden in Korea gefeiert. Er soll mit nur 13 Schiffen gegen 333 japanische Schiffe in einer Schlacht gewonnen haben.",
  "Gwang Gye|광개|廣開|Ein König, der große Teile der Mandschurei zurückeroberte.|39|10|Gwang Gae To Tae Wang (Hanja: 廣開土大王) war ein König von Goguryeo der große Teile der Mandschurei zurückeroberte."];
  

//LIST OF TECHNIQUES OCCURRING IN HYEONGS

static const HyeongTechniqueLists = {
  "techniqueNames_1" : ["arae_makgi", "momtong_jireugi", "momtong_makgi", "hugeul_seogi", "jeonggeul_seogi"],
  "techniqueNames_2" : ["sudo_daebi_makgi", "eolgul_jireugi", "arae_makgi", "ssang_palmok_makgi", "eolgul_makgi", "sudo_yeop_daerigi", "hugeul_seogi", "jeonggeul_seogi"],
  "techniqueNames_3" : ["palmok_makgi", "momtong_jireugi", "sudo_daebi_makgi", "jeong_gwansu_deulgi", "rigwon_daerigi", "hechyeo_makgi", "ap_chagi", "eolgul_makgi", "sudo_yeop_daerigi", "hugeul_seogi", "jeonggeul_seogi", "kima_seogi"],
  "techniqueNames_4" : ["ssang_palmok_makgi", "sudo_aneuro_daerigi", "momtong_jireugi", "yeop_chagi", "sudo_daebi_makgi", "jeong_gwansu_deulgi", "dollimyeo_makgi", "ap_chagi", "palmok_daebi_makgi", "hugeul_seogi", "jeonggeul_seogi", "gojeong_seogi"],
  "techniqueNames_5" : ["momtong_jireugi", "momtong_makgi", "ap_chagi", "sudo_makgi", "yeop_chagi", "palkkeup_deulgi", "ssang_sudo_makgi", "jeong_gwansu_deulgi", "palmok_makgi", "rigwon_daerigi", "du_palmok_makgi", "hugeul_seogi", "jeonggeul_seogi", "kima_seogi", "guburyeo_seogi", "gyocha_seogi"],
  "techniqueNames_6" : ["yeok_sudo_momtong_makgi", "ap_chagi", "jang_gwon_ollyeo_makgi", "sudo_daebi_makgi", "wit_palkkeup_deulgi", "ssang_gwon_eolgul_jireugi", "ssang_gwon_dwijibon_jireugi", "gyocha_makgi", "rigwon_daerigi", "du_palmok_makgi", "momtong_jireugi", "yeop_chagi", "ssang_jang_gwon_nulleo_makgi", "palmok_daebi_makgi", "dollyeo_jireugi", "mongdungi_makgi", "dwit_bal_seogi", "hugeul_seogi", "jeonggeul_seogi", "moa_seogi"],
  "techniqueNames_7" : ["momtong_makgi", "arae_pyeong_gwansu_deulgi", "arae_makgi", "palmok_makgi", "arae_gyocha_makgi", "ssang_gwon_eolgul_jireugi", "ap_chagi", "momtong_jireugi", "bandal_chagi", "san_makgi", "du_palmok_arae_makgi", "mureup_ap_chagi", "sudo_daebi_makgi", "pyeong_gwansu_deulgi", "momtong_makgi", "du_palmok_makgi", "sudo_daebi_arae_makgi", "dollimyeo_makgi", "hugeul_seogi", "jeonggeul_seogi", "moa_seogi", "gyocha_seogi"],
  "techniqueNames_8" : ["jang_gwon_aneuro_makgi", "momtong_jireugi", "ssang_palmok_makgi", "dwijibon_jireugi", "sudo_naeryeo_daerigi", "arae_makgi", "yeop_chagi", "sudo_yeop_daerigi", "sudo_daebi_makgi", "jeong_gwansu_deulgi", "dollyeo_chagi", "arae_gyocha_makgi", "dwit_palkkeup_deulgi", "momtong_makgi", "hugeul_seogi", "jeonggeul_seogi", "moa_seogi"],
  "techniqueNames_9" : ["ssang_sudo_makgi", "sudo_aneuro_daerigi", "sudo_eolgul_makgi", "sudo_daebi_makgi", "pyeong_gwansu_deulgi", "dwit_chagi", "ttwimyeo_yeop_chagi", "arae_makgi", "mureup_ap_chagi", "yeok_sudo_daerigi", "dollyeo_chagi", "palmok_daebi_makgi", "mongdungi_makgi", "arae_pyeong_gwansu_deulgi", "rigwon_dwit_daerigi", "jeong_gwansu_deulgi", "du_palmok_makgi", "rigwon_daerigi", "yeop_chagi", "gyocha_ollyeo_makgi", "ssang_jang_gwon_ollyeo_makgi", "eolgul_makgi", "hugeul_seogi", "jeonggeul_seogi", "kima_seogi"],
  "techniqueNames_10" : ["dwijibon_jireugi", "sudo_makgi", "sudo_daebi_arae_makgi", "sudo_daebi_makgi", "jang_gwon_ollyeo_makgi", "sudo_aneuro_daerigi", "palmok_daebi_makgi", "yeop_chagi", "naeryeo_daerigi", "ssang_jang_gwon_nulleo_makgi", "rigwon_daerigi", "du_palmok_makgi", "arae_makgi", "pyeong_gwansu_deulgi", "ssang_gwon_eolgul_jireugi", "ssang_gwon_dwijibon_jireugi", "ap_chagi", "eolgul_jireugi", "jeonggeul_seogi", "hugeul_seogi", "dwit_bal_seogi", "moa_seogi", "kima_seogi"]
  };


// INDIVIDUAL TECHNIQUES

static const techniqueInformation= {

//HYEONG TECHNIQUES

//YELLOW
"arae_makgi": ["Arae Makgi", "아래막기", "Block Unten", "Blöcke", "Block auf niedriger Höhe mit der Außenkante des Unterarms"],
"momtong_jireugi": ["Momtong Jireugi", "몸통지르기", "Fauststoß Mitte", "Stöße", "Fauststoß auf mittlerer Höhe"],
"momtong_makgi": ["Momtong Makgi", "몸통막기", "Block Mitte", "Blöcke", "Block auf mittlerer Höhe mit der Innenkante des Unterarms"],
"hugeul_seogi": ["Hugeul Seogi", "후글서기", "Rückwärtsfußstellung", "Fußstellungen", "Seitlich orientierte Fußstellung mit größerer Belastung auf dem hinteren Bein"],
"eolgul_jireugi": ["Eolgul Jireugi", "얼굴지르기", "Fauststoß Oben", "Stöße", "Fauststoß auf oberer Höhe"],
"eolgul_makgi": ["Eolgul Makgi", "얼굴막기", "Block Oben", "Blöcke", "Block auf oberer Höhe mit der Außenkante des Unterarms"],
"ssang_palmok_makgi": ["Ssang Palmok Makgi", "쌍팔목막기", "Doppelblock", "Blöcke", "Block oben und vorne mit den Außenkanten des Unterarms"],
"sudo_daebi_makgi": ["Sudo Daebi Makgi", "수도대비막기", "Handkantenblock mit Unterstützung", "Blöcke", "Block auf mittlerer Höhe mit der Außenkante der Hand und Unterstützung"],
"sudo_yeop_daerigi": ["Sudo Yeop Daerigi", "수도옆대리기", "Handkantenschlag", "Schläge", "Schlag auf oberer Höhe mit der Außenkante des Hand"],
"jeonggeul_seogi": ["Jeonggeul Seogi", "정글서기", "Vorwärtsfußstellung", "Fußstellungen", "Nach vorne orientierte Fußstellung mit größerer Belastung auf dem vorderen Bein"],

//IM TRAINING
"baro": ["Baro", "바로", "Gerade", "Im Training", "Kommando am Ende einer Übung"],
"junbi": ["Junbi", "준비", "Vorbereitung", "Im Training", "Kommando fürs Vorebereiten vor einer Übung"],
"charyeot": ["Charyeot", "차렷", "Achtung", "Im Training", "Kommando für die Aufmerksamkeit"],
"gyeongnye": ["Gyeongnye", "경례", "Verbeugung", "Im Training", "Kommando für die Verbeugung"],
"shijak": ["Shijak", "시작", "Start", "Im Training", "Kommando für den Start einer Übung"],
"geuman": ["Geuman", "그만", "Stop", "Im Training", "Kommando für den Stop einer Übung"],
"gyosanim": ["Gyosanim", "교사님", "Anfängermeister*in", "Im Training", "Träger*in eines ersten bis vierten Dans"],
"sabeomnim": ["Sabeomnim", "사범님", "Großmeister*in", "Im Training", "Träger*in eines fünften Dans oder höher"],
"il_bo_daeryeon": ["Il Bo Daeryeon", "일보대련", "Einschrittkampf", "Disziplinen", "Abgesprochener Kampf mit einer Angriffssequenz"],


//GREEN

"palmok_makgi": ["Palmok Makgi", "팔목막기", "Unterarmblock", "Blöcke", "Block mit der Außenkante des Unterarms"],
"jeong_gwansu_deulgi": ["Jeong Gwansu Deulgi", "정관수들기", "Fingerstich", "Stiche", "Vertikaler Fingerstich mit Unterstützung"],
"rigwon_daerigi": ["Rigwon Daerigi", "리권대리기", "Faustrückenschlag", "Schläge", "Seitlicher Schlag mit dem Faustrücken"],
"hechyeo_makgi": ["Hechyeo Makgi", "헤쳐막기", "Durchdrängeblock", "Blöcke", "Doppelter Block nach außen mit den Außenkanten der Unterarme um sich Platz zu schaffen"],
"ap_chagi": ["Ap Chagi", "앞차기", "Vorwärtskick", "Kicks", "Kick nach vorne mit dem Fußballen"],
"kima_seogi": ["Kima Seogi", "기마서기", "Reiterstellung", "Fußstellungen", "Symmetrische Fußstellung, Fußsptizen schauen nach vorne, Beine sind gebeugt"],
"sudo_aneuro_daerigi": ["Sudo Aneuro Daerigi", "수도안으로대리기", "Handkantenschlag", "Schläge", "Schlag von außen nach innen mit der Handkante"],
"yeop_chagi": ["Yeop Chagi", "옆차기", "Seitwärtskick", "Kicks", "Seitlicher Kick mit der Ferse"],
"dollimyeo_makgi": ["Dollimyeo Makgi", "돌리며막기", "Drehblock", "Blöcke", "Block mit der Innenkante des Unterarms von außen nach innen und Drehung"],
"palmok_daebi_makgi": ["Palmok Daebi Makgi", "팔목대비막기", "Freikampfstellung", "Blöcke", "Block mit der Außenkante des Arms mit Unterstützung"],
"gojeong_seogi": ["Gojeong Seogi", "고정서기", "Lange Rückwärtsfußstellung", "Fußstellungen", "'Fixierte Stellung', wie Rückwärtsfußstellung, nur länger"],

//NON HYEONG TECHNIQUES
"bakkeuro_bandal_chagi": ["Bakkeuro Bandal Chagi", "밖으로반달차기", "Halbmondkick nach Außen", "Kicks", "Halbmondkick nach Außen mit der Außenkante des Fußes"],
"bandae_dollyeo_chagi": ["Bandae Dollyeo Chagi", "반대돌려차기", "Umgekehrter Drehkick", "Kicks", "Drehkick mit der Ferse"],
"bitturo_chagi": ["Bitturo Chagi", "비뚜로차기", "Schiefkick", "Kicks", "Schiefer Kick mit dem Fußballen"],
"naeryeo_chagi": ["Naeryeo Chagi", "내려차기", "Axtkick", "Kicks", "Kick von oben mit der Ferse"],
"ap_olligi": ["Ap Olligi", "앞올리기", "Gerader Beinschwung", "Kicks", "Wie Ap Chagi, mit gestrecktem Bein"],
"dollyeo_olligi": ["Dollyeo Olligi", "돌려올리기", "Gedrehter Beinschwung", "Kicks", "Wie Dollyeo Chagi, mit gestrecktem Bein"],
"yeop_olligi": ["Yeop Olligi", "옆올리기", "Seitlicher Beinschwung", "Kicks", "Wie Yeop Chagi, mit gestrecktem Bein"],


//BLUE

"sudo_makgi": ["Sudo Makgi", "수도막기", "Handkantenblock", "Blöcke", "Block nach außen mit der Handkante"],
"palkkeup_deulgi": ["Palkkeup Deulgi", "팔끕들기", "Ellenbogenstoß", "Stöße", "Horizontaler Stoß mit dem Ellenbogen"],
"ssang_sudo_makgi": ["Ssang Sudo Makgi", "쌍수도막기", "Doppelter Handkantenblock", "Blöcke", "Block nach außen und oben mit der Handkante"],
"du_palmok_makgi": ["Du Palmok Makgi", "두팔목막기", "Doppelter Unterarmblock", "Blöcke", "Block mit der Innenkante des Unterarms mit Unterstützung des anderen Arms"],
"guburyeo_seogi": ["Guburyeo Seogi", "구부려서기", "Kranichstellung", "Fußstellungen", "Fußstellung auf einem Bein, mit dem anderen Bein abgewinkelt"],
"gyocha_seogi": ["Gyocha Seogi", "교차서기", "Kreuzstellung", "Fußstellungen", "Fußstellung mit überkreuzten Beinen"],
"yeok_sudo_momtong_makgi": ["Yeok Sudo Momtong Makgi", "역수도몸통막기", "Innenhandkantenblock", "Blöcke", "Block mit der Innenkante der Hand auf mittlerer Höher"],
"jang_gwon_ollyeo_makgi": ["Jang Gwon Ollyeo Makgi", "장권올려막기", "Handballenblock", "Blöcke", "Block nach oben mit dem Handballen"],
"wit_palkkeup_deulgi": ["Wit Palkkeup Deulgi", "윗팔끕들기", "Ellenbogen stoß nach oben", "Stöße", "Ellenbogen stoß nach oben"],
"ssang_gwon_eolgul_jireugi": ["Ssang Gwon Eolgul Jireugi", "쌍권얼굴지르기", "Doppelter Fauststoß", "Stöße", "Doppelter Fauststoß auf Kopfhöhe"],
"ssang_gwon_dwijibon_jireugi": ["Ssang Gwon Dwijibon Jireugi", "쌍권뒤지본지르기", "Doppelter Umgedrehter Fauststoß", "Stöße", "Doppelter Fauststoß auf Rumpfhöhe mit umgedrehten Fäusten"],
"gyocha_makgi": ["Gyocha Makgi", "교차막기", "Kreuzblock", "Blöcke", "Block mit den überkreuzten Außenkanten der Unterarme auf Kopfhöhe"],
"ssang_jang_gwon_nulleo_makgi": ["Ssang Jang Gwon Nulleo Makgi", "쌍장권눌러막기", "Doppelter Handballenblock", "Blöcke", "Block mit den Handballen nach oben und unten, wörtlich 'Schiebeblock'"],
"dollyeo_jireugi": ["Dollyeo Jireugi", "돌려지르기", "Drehstoß", "Stöße", "Fauststoß von außen auf Kopfhöhe"],
"mongdungi_makgi": ["Mongdungi Makgi", "몽둥이막기", "Stockblock", "Blöcke", "Block mit beiden offenen Händen gegen einen vertikalen Stock"],
"dwit_bal_seogi": ["Dwit Bal Seogi", "뒷발서기", "Kurze Rückwärtsfußstellung", "Fußstellungen", "Kurze Rückwärtsfußstellung, der vordere Fuß berührt den Boden nur mit dem Fußballen"],
"moa_seogi": ["Moa Seogi", "모아서기", "Geschlossene fußstellung", "Fußstellungen", "Stehende Fußstellung, die Füße sind geschlossen"],

//RED

"arae_pyeong_gwansu_deulgi": ["Arae Pyeong Gwansu Deulgi", "아래평관수들기", "Fingerstich Unten", "Stiche", "Horizontaler Fingerstich zum Unterleib"],
"arae_gyocha_makgi": ["Arae Gyocha Makgi", "아래교차막기", "Kreuzblock Unten", "Blöcke", "Block mit den überkreuzten Außenkanten der Unterarme auf unterer Höhe"],
"bandal_chagi": ["Bandal Chagi", "반달차기", "Halbmondkick", "Kicks", "Kick mit gestrecktem Bein von außen nach innen in einer großen Kreisbewegung"],
"san_makgi": ["San Makgi", "산막기", "Doppelblock Oben", "Blöcke", "Block mit beiden Armen auf Kopfhöhe vorne und hinten. Das Chinesische Schriftzeichenfür Berg (Koreanisch: San) sieht aus wie dieser Block (山)"],
"du_palmok_arae_makgi": ["Du Palmok Arae Makgi", "두팔목아래막기", "Doppelblock Unten", "Blöcke", "Block mit der Innenkante der Unterarms mit Unterstützung auf unterer Höhe"],
"mureup_ap_chagi": ["Mureup Ap Chagi", "무릎앞차기", "Kniestoß", "Kicks", "Stoß mit dem Knie nach vorne"],
"pyeong_gwansu_deulgi": ["Pyeong Gwansu Deulgi", "평관수들기", "Horizontaler Fingerstich", "Stiche", "Horizontaler Fingerstich auf Kopfhöhe"],
"rigwon_dwit_daerigi": ["Rigwon Dwit Daerigi", "리권뒷대리기", "Faustrückenschlag nach hinten", "Schläge", "Schlag mit der Hinterfaust hinter dem Körper von oben nach unten"],
"sudo_daebi_arae_makgi": ["Sudo Daebi Arae Makgi", "수도대비아래막기", "Handkantenblock mit Unterstützung unten", "Blöcke", "Block auf unterer Höhe mit der Außenkante der Hand und Unterstützung"],
"jang_gwon_aneuro_makgi": ["Jang Gwon Aneuro Makgi", "장권안으로막기", "Handballenblock nach innen", "Blöcke", "Handballenblock nach innen auf Rumpfhöhe"],
"dwijibon_jireugi": ["Dwijibon Jireugi", "뒤지본지르기", "Umgekehrter Fauststoß", "Stöße", "Stoß mit umgedrehter Faust auf Rumpfhöhe"],
"sudo_naeryeo_daerigi": ["Sudo Naeryeo Daerigi", "수도내려대리기", "Handkantenschlag nach unten", "Schläge", "Handkantenschlag nach unten"],
"dollyeo_chagi": ["Dollyeo Chagi", "돌려차기", "Drehkick", "Kicks", "Kick mit dem Fußballen von der Seite"],
"dwit_palkkeup_deulgi": ["Dwit Palkkeup Deulgi", "뒷팔끕들기", "Ellenbogenstich nach hinten", "Stiche", "Ellenbogenstich nach hinten"],


//BLACK

"sudo_eolgul_makgi": ["Sudo Eolgul Makgi", "수도얼굴막기", "Handkantenblock Oben", "Blöcke", "Block mit der Außenhandkante nach oben"],
"dwit_chagi": ["Dwit Chagi", "뒷차기", "Kick nach hinten", "Kicks", "Seitlicher Kick nach hinten"],
"ttwimyeo_yeop_chagi": ["Ttwimyeo Yeop Chagi", "뛰며옆차기", "Gesprunger Seitlicher Kick", "Kicks", "Seitlicher Kick mit der Ferse, gesprungen"],
"yeok_sudo_daerigi": ["Yeok Sudo Daerigi", "역수도대리기", "Innenhandkantenschlag", "Schläge", "Schlag mit der Innenhandkante von außen bei gestrecktem Arm"],
"gyocha_ollyeo_makgi": ["Gyocha Ollyeo Makgi", "교차올려막기", "Überkreuzter Hebeblock", "Blöcke", "Block mit überkreuzten Händen von unten zur Mitte mit offenen Händen"],
"ssang_jang_gwon_ollyeo_makgi": ["Ssang Jang Gwon Ollyeo Makgi", "쌍장권올려막기", "Handballenhebeblock", "Blöcke", "Block mit beiden Handballen von unten zur Mitte"],
"naeryeo_daerigi": ["Naeryeo Daerigi", "내려대리기", "Faustrückenschlag nach unten", "Schläge", "Faustrückenschlag nach unten"],


"i_bo_daeryeon": ["I Bo Daeryeon", "이보대련", "Zweischrittkampf", "Disziplinen", "Abgesprochener Kampf mit zwei Angriffssequenzen"],
"sam_bo_daeryeon": ["Sam Bo Daeryeon", "삼보대련", "Dreischrittkampf", "Disziplinen", "Abgesprochener Kampf mit drei Angriffssequenzen"],
"jayu_daeryeon": ["Jayu Daeryeon", "자유대련", "Freikampf", "Disziplinen", "Freier Kampf ohne Kontakt"],
"hoshinsul": ["Hoshinsul", "호신술", "Selbstverteidigung", "Disziplinen", "Verteidigung mit Hebeln und Würfen gegen einen Angriff"],
"gyeokpa": ["Gyeokpa", "격파", "Bruchtest", "Disziplinen", "Brechen von Brettern, Ziegeln oder Steinen mit einer Taekwondo-Technik"],
"gallyeo": ["Gallyeo", "갈려", "Unterbrechung", "Im Training", "Kommando für die Unterbrechung einer Übung"],
"gyesok": ["Gyesok", "계속", "Weiter", "Im Training", "Kommando für die Fortsetzung einer Übung"],

"zahlen_1_bis_10": ["Zahlen 1 bis 10", "", "", "Zahlen", "Hana 하나 \n Dul 둘 \n Set 셋 \n Net 넷 \n Daseot 다섯 \n Yeoseot 여섯 \n Ilgop 일곱 \n Yeodeol 여덟 \n Ahop  아홉 \n Yeol 열"],
"zahlen_11_bis_20": ["Zahlen 11 bis 20", "", "", "Zahlen", "Yeolhana 열하나 \n Yeoldul 열둘 \n Yeolset 열셋 \n Yeolnet 열넷 \n Yeoldaseot 열다섯 \n Yeolyeoseot 열여섯 \n Yeolilgop 열일곱 \n Yeolyeodeol 열여덟 \n Yeolahop  열아홉 \n Seumul 스물"],
};


static const questions = ["Wie heißt diese Technik?",
 "Wie schreibt man diesen Begriff auf Koreanisch?",
  "Wie heißt dieser Begriff auf Deutsch",
   "Zu welcher Kategorie gehört dieses Bild?",
    "Beschreibe diesen Begriff!",
     "Welches Bild gehört zu diesem Begriff?", 
      "Wie viele Bewegungen hat ",
      "Wie heißt der ",
        "Was bedeutet der "];

}
