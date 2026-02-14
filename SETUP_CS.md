# Průvodce nastavením webu Superset Copilot

## Aktuální stav

### ✅ Soubory v repozitáři (Připraveno)
- ✅ Soubor `CNAME` existuje se správnou hodnotou: `supersetcopilot.eu`
- ✅ Soubor `index.html` existuje s požadovaným textem: "Superset Copilot – aktivní"
- ✅ Repozitář je veřejný (Public) a přístupný přes GitHub API

### ❌ Požadovaná konfigurace (Dosud není dokončena)

#### 1. Konfigurace GitHub Pages
**Stav:** Není nakonfigurováno - soubory jsou pouze na feature branch

**Požadované kroky:**
1. Sloučit tento PR pro vytvoření/aktualizaci větve `main`
2. Přejít do nastavení repozitáře Settings → Pages
3. Nastavit:
   - **Source:** Deploy from a branch
   - **Branch:** main
   - **Folder:** / (root - kořenový adresář)
4. Uložit konfiguraci

**Poznámka:** GitHub Pages automaticky nasadí web z větve `main` po nakonfigurování.

#### 2. Konfigurace DNS
**Stav:** DNS domény není nakonfigurováno

**Požadované DNS záznamy pro `supersetcopilot.eu`:**

Přidejte následující A záznamy:
```
supersetcopilot.eu.  A  185.199.108.153
supersetcopilot.eu.  A  185.199.109.153
supersetcopilot.eu.  A  185.199.110.153
supersetcopilot.eu.  A  185.199.111.153
```

**Volitelný TXT záznam (pro ověření GitHub, pokud je vyžadováno):**
```
supersetcopilot.eu.  TXT  "github-verification=..."
```
(Ověřovací kód poskytne GitHub v Settings → Pages při konfiguraci vlastní domény)

#### 3. Nastavení vlastní domény v GitHub Pages
**Po nakonfigurování DNS:**
1. Přejděte do Settings → Pages
2. V sekci "Custom domain" zadejte: `supersetcopilot.eu`
3. Klikněte na Save
4. Počkejte na dokončení kontroly DNS (může trvat několik minut)
5. Po vydání SSL certifikátu povolte "Enforce HTTPS"

## Kroky ověření

### Krok 1: Zkontrolovat, že GitHub Pages je aktivní
```bash
# URL GitHub Pages by měla být přístupná:
# https://kylyka.github.io/packy-ssow.github.io/
```

### Krok 2: Zkontrolovat konfiguraci DNS
```bash
nslookup supersetcopilot.eu
# Mělo by vrátit A záznamy GitHub Pages

dig supersetcopilot.eu +short
# Mělo by zobrazit:
# 185.199.108.153
# 185.199.109.153
# 185.199.110.153
# 185.199.111.153
```

### Krok 3: Ověřit obsah webu
```bash
curl https://supersetcopilot.eu
# Mělo by vrátit HTML obsahující "Superset Copilot – aktivní"
```

## Očekávaný finální výsledek

Po úplném nakonfigurování by měla návštěva `https://supersetcopilot.eu` zobrazit:
- Název stránky: "Superset Copilot"
- Nadpis: "Superset Copilot – aktivní"
- Obsah: "Web je úspěšně nasazen přes GitHub Pages."

## Řešení problémů

### Problém: 404 Not Found
- **Příčina:** GitHub Pages není povoleno nebo je nakonfigurováno nesprávně
- **Řešení:** Zkontrolujte konfiguraci v Settings → Pages

### Problém: DNS_PROBE_FINISHED_NXDOMAIN
- **Příčina:** DNS záznamy nejsou nakonfigurovány
- **Řešení:** Nakonfigurujte A záznamy jak je uvedeno výše

### Problém: Chyba certifikátu
- **Příčina:** HTTPS ještě není povoleno nebo SSL certifikát nebyl vydán
- **Řešení:** Počkejte na vydání certifikátu GitHub (může trvat až 24 hodin po konfiguraci DNS)

## Kontrolní seznam

- [ ] Sloučit PR do větve main
- [ ] Povolit GitHub Pages (Settings → Pages → Deploy from branch: main)
- [ ] Nakonfigurovat DNS A záznamy pro supersetcopilot.eu
- [ ] Nastavit vlastní doménu v nastavení GitHub Pages
- [ ] Počkat na propagaci DNS (až 48 hodin)
- [ ] Povolit vynucení HTTPS
- [ ] Ověřit, že web je přístupný na https://supersetcopilot.eu
- [ ] Potvrdit, že stránka obsahuje "Superset Copilot – aktivní"

## Skripty pro ověření

Spusťte ověřovací skript:
```bash
./verify.sh
```

Tento skript automaticky zkontroluje:
1. Existenci souboru CNAME se správnou hodnotou
2. Existenci souboru index.html s požadovaným textem
3. DNS A záznamy
4. Dostupnost webu
5. Obsah webu

## Kontakt

Pro dotazy nebo problémy s tímto nastavením prosím otevřete issue v repozitáři.
