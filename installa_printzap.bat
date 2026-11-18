<!-- :
@echo off
setlocal
start "" mshta.exe "%~f0"
exit /b
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Installazione PrintZap</title>
<hta:application 
    id="oPrintZapInstaller"
    applicationname="PrintZapInstaller"
    border="dialog"
    caption="yes"
    sysmenu="yes"
    maximizebutton="no"
    minimizebutton="yes"
    windowstate="normal"
    scroll="no"
    selection="yes"
    contextmenu="no"
/>
<style type="text/css">
    * { box-sizing: border-box; }
    html, body {
        margin: 0; padding: 0;
        width: 100%; height: 100%;
        background-color: #0b141a;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #e9edef;
        user-select: none;
        overflow: hidden;
    }
    .wrapper {
        position: fixed;
        top: 0; left: 0; right: 0; bottom: 0;
        padding: 22px 26px;
        display: flex;
        flex-direction: column;
        background: radial-gradient(circle at 85% 15%, #182229 0%, #0b141a 75%);
    }
    .header {
        display: flex;
        align-items: center;
        margin-bottom: 16px;
        flex-shrink: 0;
    }
    .brand-icon {
        width: 44px; height: 44px;
        background: linear-gradient(135deg, #7c3aed, #25d366);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 22px;
        font-weight: bold;
        color: #fff;
        margin-right: 14px;
        box-shadow: 0 4px 12px rgba(37, 211, 102, 0.25);
        flex-shrink: 0;
    }
    .brand-text h1 {
        margin: 0; font-size: 19px; font-weight: 700; color: #ffffff; letter-spacing: -0.3px;
    }
    .brand-text p {
        margin: 3px 0 0 0; font-size: 12px; color: #8696a0; font-weight: 500;
    }

    /* Schermata Licenza */
    .screen-license {
        display: flex;
        flex-direction: column;
        flex-grow: 1;
    }
    .license-card {
        background: #111b21;
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 8px;
        padding: 12px 14px;
        margin-bottom: 12px;
        overflow-y: scroll;
        height: 250px;
        font-size: 11.5px;
        line-height: 1.55;
        color: #cbd5e1;
        white-space: pre-wrap;
        user-select: text;
        font-family: Consolas, 'Segoe UI', monospace;
    }
    .checkbox-box {
        background: rgba(37, 211, 102, 0.06);
        border: 1px solid rgba(37, 211, 102, 0.28);
        border-radius: 8px;
        padding: 10px 14px;
        margin-bottom: 14px;
        cursor: pointer;
        flex-shrink: 0;
    }
    .checkbox-row {
        display: flex;
        align-items: center;
        gap: 10px;
        cursor: pointer;
    }
    .checkbox-row input[type="checkbox"] {
        margin: 0;
        width: 17px;
        height: 17px;
        cursor: pointer;
        flex-shrink: 0;
    }
    .checkbox-title {
        font-size: 12px;
        font-weight: 600;
        color: #e9edef;
        line-height: 1.35;
        user-select: none;
    }
    .actions {
        margin-top: auto;
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        flex-shrink: 0;
    }
    .btn {
        border: none;
        border-radius: 8px;
        padding: 9px 20px;
        font-size: 13px;
        font-weight: 600;
        cursor: pointer;
        font-family: inherit;
    }
    .btn-cancel {
        background: #202c33;
        color: #e9edef;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
    .btn-cancel:hover {
        background: #2a3942;
    }
    .btn-primary {
        background: linear-gradient(135deg, #7c3aed, #25d366);
        color: #ffffff;
        box-shadow: 0 4px 12px rgba(37, 211, 102, 0.3);
    }
    .btn-primary:hover {
        filter: brightness(1.1);
    }
    .btn:disabled {
        opacity: 0.35;
        cursor: default;
        filter: grayscale(1);
        box-shadow: none;
    }

    /* Schermata Installazione */
    .screen-install {
        display: none;
        flex-direction: column;
        flex-grow: 1;
    }
    .steps-container {
        background: #111b21;
        border: 1px solid rgba(255, 255, 255, 0.07);
        border-radius: 10px;
        padding: 14px 18px;
        margin-bottom: 18px;
    }
    .step-row {
        display: flex;
        align-items: center;
        padding: 6px 0;
        font-size: 13px;
        color: #8696a0;
    }
    .step-row.active {
        color: #e9edef;
        font-weight: 600;
    }
    .step-row.done {
        color: #10b981;
    }
    .step-bullet {
        width: 22px; height: 22px;
        border-radius: 50%;
        background: #202c33;
        color: #8696a0;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 11px;
        font-weight: bold;
        margin-right: 12px;
        flex-shrink: 0;
    }
    .step-row.active .step-bullet {
        background: #7c3aed;
        color: #ffffff;
        box-shadow: 0 0 8px rgba(124, 58, 237, 0.6);
    }
    .step-row.done .step-bullet {
        background: #10b981;
        color: #ffffff;
    }
    .progress-box {
        margin-top: auto;
    }
    .progress-header {
        display: flex;
        justify-content: space-between;
        font-size: 12px;
        color: #aebac1;
        margin-bottom: 8px;
        font-weight: 500;
    }
    .progress-track {
        width: 100%;
        height: 10px;
        background: #202c33;
        border-radius: 6px;
        overflow: hidden;
        border: 1px solid rgba(255, 255, 255, 0.05);
    }
    .progress-fill {
        height: 100%;
        width: 0%;
        background: linear-gradient(90deg, #7c3aed, #25d366);
        border-radius: 6px;
        transition: width 0.25s ease-out;
    }
    .status-msg {
        margin-top: 10px;
        font-size: 11px;
        color: #8696a0;
        min-height: 16px;
        text-align: center;
    }
    .error-box {
        display: none;
        background: #3b1219;
        border: 1px solid #ef4444;
        border-radius: 8px;
        padding: 10px;
        color: #fca5a5;
        font-size: 12px;
        margin-top: 10px;
        text-align: center;
    }
</style>
</head>
<body>
<div class="wrapper">
    <div class="header">
        <div class="brand-icon">⚡</div>
        <div class="brand-text">
            <h1 id="brandTitle">Installazione Rapida PrintZap</h1>
            <p id="brandSubtitle">Contratto di Licenza d'Uso e Condizioni di Servizio</p>
        </div>
    </div>

    <!-- 1. ACCETTAZIONE LICENZA -->
    <div id="screenLicense" class="screen-license">
        <div class="license-card">CONTRATTO DI LICENZA D'USO E CONDIZIONI DI VENDITA - PRINTZAP
=============================================================

1. OGGETTO DEL CONTRATTO
Il Licenziatario acquisisce il diritto d'uso personale, non trasferibile e a tempo determinato (es. mensile, annuale o secondo offerta commerciale) del software "PrintZap", un'applicazione desktop progettata per:
* La gestione automatica di file in coda di stampa localmente;
* L'organizzazione e la cancellazione automatica dei file dopo la consegna/stampa;
* Il prelievo automatico di file da una cartella locale e dall'integrazione con il servizio di messaggistica WhatsApp (di seguito "Modulo di Integrazione").

---

2. NATURA DEL MODULO DI INTEGRAZIONE (WHATSAPP)
Il Licenziatario prende atto e accetta espressamente che:
* Il modulo di integrazione con WhatsApp non è un prodotto ufficiale di Meta Platforms Inc. né è da essa approvato, sponsorizzato o autorizzato.
* Il funzionamento di tale modulo dipende esclusivamente dalla struttura tecnica che Meta decide di adottare per il proprio servizio WhatsApp Web.
* Il Licenziante non ha alcun controllo sulle modifiche, aggiornamenti o interruzioni che Meta potrà apportare al proprio servizio.

---

3. LIMITAZIONE DI RESPONSABILITÀ PER INTERRUZIONE DEL SERVIZIO E CASO DI FORZA MAGGIORE
Il Licenziatario solleva espressamente il Licenziante da qualsiasi responsabilità, richiesta di risarcimento, perdita di fatturato, fermo macchina o danno derivante da:
* Sospensione, blocco o cancellazione dell'account WhatsApp del Licenziatario;
* Interruzione, malfunzionamento o impossibilità tecnica del modulo di prelievo automatico a seguito di aggiornamenti dei sistemi di Meta/WhatsApp;
* Mancata ricezione o ritardo nella ricezione di file da parte dei clienti a causa di problemi di rete o di terze parti.

Clausola di Forza Maggiore: Qualora modifiche strutturali o di sicurezza ai servizi di terze parti (WhatsApp) rendessero tecnicamente impossibile il ripristino o il funzionamento del Modulo di Integrazione, il contratto si risolverà di diritto per impossibilità sopravvenuta (forza maggiore), escludendo qualsiasi obbligo di risarcimento, indennizzo o rimborso dei canoni residui da parte del Licenziante.

---

4. MANUTENZIONE, AGGIORNAMENTI E COMPATIBILITÀ
* Assistenza Inclusa: Per la durata del periodo di validità della licenza acquistata, il Licenziante garantisce il rilascio di aggiornamenti correttivi per bug interni del software e per il ripristino del modulo di integrazione WhatsApp (compatibilmente con i limiti delle librerie open-source utilizzate).
* Compatibilità: Il Licenziante non garantisce il corretto funzionamento del software su sistemi operativi obsoleti o non supportati (es. versioni Windows non aggiornate), né in presenza di antivirus, firewall o software di sicurezza locali del Licenziatario che ne blocchino le attività di rete o l'accesso al sistema.

---

5. TRATTAMENTO DEI DATI E PRIVACY (GDPR)
Trattandosi di software installato localmente sul PC del Licenziatario:
* I file (PDF, immagini e documenti) inviati dai clienti finali risiedono esclusivamente sull'hardware locale del Licenziatario.
* Il Licenziante non ha accesso, non archivia su propri server e non tratta in alcun modo i dati dei clienti finali o i documenti gestiti da PrintZap.
* Il Licenziatario si dichiara unico Titolare del trattamento dei dati personali dei propri clienti e si impegna a rispettare la normativa GDPR (Regolamento UE 2016/679) nei loro confronti.

---

6. DIVIETO DI MANOMISSIONE, DECOMPILAZIONE E CRACKING
Il codice sorgente, l'architettura e l'interfaccia di PrintZap sono di esclusiva proprietà intellettuale del Licenziante. È fatto espresso divieto al Licenziatario di:
* Decompilare, disassemblare o effettuare operazioni di reverse engineering sul software;
* Bypassare, alterare o tentare di aggirare i sistemi di verifica e controllo online della licenza d'uso.
Qualsiasi violazione comporterà la disattivazione immediata del software, la revoca della licenza senza alcun diritto di rimborso, e la segnalazione per la tutela dei diritti d'autore.

---

7. LIMITAZIONE MASSIMA DEL RISARCIMENTO DANNI
In ogni caso e per qualsiasi tipo di controversia (inclusi eventuali bug del software o perdite di dati), la responsabilità totale del Licenziante nei confronti del Licenziatario per danni diretti, indiretti, commerciali o perdite di profitto non potrà mai superare la somma complessiva effettivamente pagata dal Licenziatario per l'acquisto della licenza d'uso del software nei dodici (12) mesi precedenti all'evento che ha generato il danno.

---

8. MANLEVA SUL COPYRIGHT DEI CONTENUTI DEI CLIENTI
Il Licenziatario garantisce che i file inviati dai propri utenti finali e stampati tramite il software non violano diritti d'autore, brevetti, marchi o qualsiasi altra normativa vigente. Il Licenziatario si impegna a manlevare e tenere indenne il Licenziante da qualsiasi sanzione, spesa legale o richiesta di risarcimento avanzata da terzi a causa del contenuto o della liceità dei documenti elaborati e stampati tramite PrintZap.

---

9. COMUNICAZIONE E TELEMETRIA DI CONTROLLO
Il software richiede una connessione internet attiva per il controllo periodico di validità della licenza e la ricerca di aggiornamenti. Il Licenziatario acconsente a tale trasmissione di dati tecnici, necessaria a verificare il corretto utilizzo del software.

---

10. NULLITÀ PARZIALE (SEVERABILITY)
L'eventuale invalidità, inefficacia o nullità di una o più clausole del presente contratto, anche derivante da modifiche della legislazione vigente o da sentenze giudiziarie, non pregiudicherà la validità e l'efficacia delle rimanenti disposizioni, che continueranno ad avere piena forza e validità.

---

11. LEGGE APPLICABILE E FORO COMPETENTE ESCLUSIVO
Il presente contratto è regolato dalla legge italiana. Per qualsiasi controversia derivante dall'interpretazione, esecuzione o risoluzione del presente accordo, le parti stabiliscono la competenza esclusiva e inderogabile del Foro di Reggio Calabria.

=============================================================
ACCETTAZIONE SPECIFICA DELLE CLAUSOLE VESSATORIE
Ai sensi e per gli effetti degli artt. 1341 e 1342 del Codice Civile italiano, il Licenziatario dichiara di aver letto attentamente e di approvare specificamente i seguenti articoli:
* Art. 3: Limitazione di responsabilità per interruzione servizio e forza maggiore;
* Art. 4: Limitazioni di compatibilità tecnica e antivirus;
* Art. 6: Divieto di manomissione, reverse engineering e revoca immediata senza rimborso;
* Art. 7: Limitazione massima dell'importo del risarcimento danni;
* Art. 8: Manleva sul copyright e sulla liceità dei contenuti stampati;
* Art. 11: Foro competente esclusivo inderogabile di Reggio Calabria.</div>
        <div class="checkbox-box" onclick="toggleAgree()">
            <div class="checkbox-row">
                <input type="checkbox" id="chkAgree" onclick="onCheckboxClick(event)">
                <div class="checkbox-title">Ho letto e accetto integralmente il Contratto di Licenza e i termini d'uso</div>
            </div>
        </div>
        <div class="actions">
            <button type="button" class="btn btn-cancel" onclick="window.close()">Annulla</button>
            <button type="button" class="btn btn-primary" id="btnContinue" disabled onclick="acceptAndInstall()">Accetta e Installa →</button>
        </div>
    </div>

    <!-- 2. PROGRESSO INSTALLAZIONE -->
    <div id="screenInstall" class="screen-install">
        <div class="steps-container">
            <div class="step-row" id="step1">
                <div class="step-bullet">1</div>
                <div class="step-label">Verifica disponibilità ultima versione su GitHub</div>
            </div>
            <div class="step-row" id="step2">
                <div class="step-bullet">2</div>
                <div class="step-label">Download pacchetto completo (via curl)</div>
            </div>
            <div class="step-row" id="step3">
                <div class="step-bullet">3</div>
                <div class="step-label">Estrazione dei file in %LOCALAPPDATA%\PrintZap</div>
            </div>
            <div class="step-row" id="step4">
                <div class="step-bullet">4</div>
                <div class="step-label">Creazione icona Desktop, Menu Start e avvio applicazione</div>
            </div>
        </div>

        <div class="progress-box">
            <div class="progress-header">
                <span id="progressStepTitle">Inizializzazione in corso...</span>
                <span id="progressPct">0%</span>
            </div>
            <div class="progress-track">
                <div class="progress-fill" id="progressBar"></div>
            </div>
            <div class="status-msg" id="statusDetail">Preparazione ambiente...</div>
            <div class="error-box" id="errorBox"></div>
        </div>
    </div>
</div>

<script>
window.onload = function() {
    window.resizeTo(600, 560);
    window.moveTo((screen.width - 600) / 2, (screen.height - 560) / 2);
};

function toggleAgree() {
    var chk = document.getElementById('chkAgree');
    chk.checked = !chk.checked;
    updateButton();
}

function onCheckboxClick(e) {
    if (!e) e = window.event;
    if (e.stopPropagation) e.stopPropagation();
    e.cancelBubble = true;
    updateButton();
}

function updateButton() {
    var chk = document.getElementById('chkAgree');
    var btn = document.getElementById('btnContinue');
    btn.disabled = !chk.checked;
}

function acceptAndInstall() {
    document.getElementById('screenLicense').style.display = 'none';
    document.getElementById('screenInstall').style.display = 'flex';
    document.getElementById('brandSubtitle').innerText = "Download dei componenti ufficiali da GitHub e configurazione client";
    startInstallation();
}

function setProgress(pct, title, detail) {
    document.getElementById('progressBar').style.width = pct + '%';
    document.getElementById('progressPct').innerText = Math.round(pct) + '%';
    if (title) document.getElementById('progressStepTitle').innerText = title;
    if (detail) document.getElementById('statusDetail').innerText = detail;
}

function setStep(stepNum, state) {
    var row = document.getElementById('step' + stepNum);
    if (!row) return;
    row.className = 'step-row ' + (state || '');
    var bullet = row.getElementsByTagName('div')[0];
    if (state === 'done') {
        bullet.innerText = '✔';
    } else {
        bullet.innerText = stepNum;
    }
}

function showError(msg) {
    var b = document.getElementById('errorBox');
    b.innerText = msg;
    b.style.display = 'block';
    document.getElementById('statusDetail').innerText = 'Installazione interrotta.';
}

function startInstallation() {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wsh = new ActiveXObject("WScript.Shell");

    var localAppData = wsh.ExpandEnvironmentStrings("%LOCALAPPDATA%");
    var tempDir = wsh.ExpandEnvironmentStrings("%TEMP%");
    var targetDir = localAppData + "\\PrintZap";
    var tempZip = tempDir + "\\PrintZap_setup.zip";
    var tempJson = tempDir + "\\PrintZap_ver.json";

    var defaultZipUrl = "https://raw.githubusercontent.com/alfaomega-dev/cartoleria-whatsapp-updates/main/releases/PrintZap_Full.zip";
    var versionUrl = "https://raw.githubusercontent.com/alfaomega-dev/cartoleria-whatsapp-updates/main/version.json";

    // Step 1: Connessione e verifica versione
    setStep(1, 'active');
    setProgress(5, "Verifica versione su GitHub...", "Connessione al server in corso...");

    try {
        if (fso.FileExists(tempJson)) fso.DeleteFile(tempJson, true);
    } catch(e){}

    setTimeout(function() {
        var curlJsonCmd = 'curl.exe -s -L "' + versionUrl + '" -o "' + tempJson + '"';
        wsh.Run(curlJsonCmd, 0, true);

        var downloadUrl = defaultZipUrl;
        if (fso.FileExists(tempJson)) {
            try {
                var stream = fso.OpenTextFile(tempJson, 1, false);
                var content = stream.ReadAll();
                stream.Close();
                var match = content.match(/"fullZipUrl"\s*:\s*"([^"]+)"/);
                if (match && match[1]) {
                    downloadUrl = match[1];
                } else {
                    var match2 = content.match(/"zipUrl"\s*:\s*"([^"]+)"/);
                    if (match2 && match2[1]) downloadUrl = match2[1];
                }
            } catch(e){}
            try { fso.DeleteFile(tempJson, true); } catch(e){}
        }

        setStep(1, 'done');
        setProgress(15, "Download pacchetto PrintZap...", "Avvio download con curl...");

        // Step 2: Download ZIP con curl in background senza finestre
        setStep(2, 'active');
        try {
            if (fso.FileExists(tempZip)) fso.DeleteFile(tempZip, true);
        } catch(e){}

        var flagDone = tempDir + "\\pz_dl_done.tmp";
        try { if (fso.FileExists(flagDone)) fso.DeleteFile(flagDone, true); } catch(e){}

        var curlCmd = 'cmd.exe /c curl.exe -L -s -o "' + tempZip + '" "' + downloadUrl + '" & echo done > "' + flagDone + '"';
        wsh.Run(curlCmd, 0, false);

        var approxSize = 83259000; // ~79.4 MB
        var checkTimer = setInterval(function() {
            var currentSize = 0;
            if (fso.FileExists(tempZip)) {
                try {
                    currentSize = fso.GetFile(tempZip).Size;
                } catch(e){}
            }

            if (currentSize > 0) {
                var mb = (currentSize / (1024 * 1024)).toFixed(1);
                var pct = 15 + Math.min(65, (currentSize / approxSize) * 65);
                setProgress(pct, "Download pacchetto completo...", mb + " MB scaricati...");
            }

            if (fso.FileExists(flagDone)) {
                clearInterval(checkTimer);
                try { fso.DeleteFile(flagDone, true); } catch(e){}
                onDownloadFinished();
            }
        }, 300);

        function onDownloadFinished() {
            if (!fso.FileExists(tempZip) || fso.GetFile(tempZip).Size < 5000000) {
                showError("Errore nel download: pacchetto non disponibile o connessione interrotta.");
                return;
            }

            var finalMb = (fso.GetFile(tempZip).Size / (1024 * 1024)).toFixed(1);
            setStep(2, 'done');
            setProgress(80, "Estrazione dei file in corso...", "Pacchetto scaricato (" + finalMb + " MB). Installazione...");

            // Step 3: Estrazione
            setStep(3, 'active');
            setTimeout(function() {
                try {
                    if (!fso.FolderExists(targetDir)) fso.CreateFolder(targetDir);
                } catch(e){}

                var extractCmd = 'tar.exe -xf "' + tempZip + '" -C "' + targetDir + '"';
                var res = wsh.Run(extractCmd, 0, true);
                if (res !== 0) {
                    var psCmd = 'powershell.exe -NoProfile -Command "Expand-Archive -Path \'' + tempZip + '\' -DestinationPath \'' + targetDir + '\' -Force"';
                    wsh.Run(psCmd, 0, true);
                }

                try { fso.DeleteFile(tempZip, true); } catch(e){}

                // Configurazione lingua italiana e Web Bancone disattivato di default
                function readUtf8File(filePath) {
                    var s = new ActiveXObject("ADODB.Stream");
                    s.Type = 2;
                    s.Charset = "utf-8";
                    s.Open();
                    s.LoadFromFile(filePath);
                    var txt = s.ReadText(-1);
                    s.Close();
                    return txt.replace(/^\uFEFF/, '');
                }
                function writeUtf8NoBom(filePath, content) {
                    var s = new ActiveXObject("ADODB.Stream");
                    s.Type = 2;
                    s.Charset = "utf-8";
                    s.Open();
                    s.WriteText(content);
                    s.Position = 0;
                    s.Type = 1;
                    if (s.Size > 3) s.Position = 3;
                    var bin = new ActiveXObject("ADODB.Stream");
                    bin.Type = 1;
                    bin.Open();
                    s.CopyTo(bin);
                    bin.SaveToFile(filePath, 2);
                    bin.Close();
                    s.Close();
                }
                function updateJsonConfig(filePath, updates) {
                    try {
                        var cfg = {};
                        if (fso.FileExists(filePath)) {
                            cfg = JSON.parse(readUtf8File(filePath));
                        }
                        for (var k in updates) {
                            if (updates.hasOwnProperty(k)) cfg[k] = updates[k];
                        }
                        writeUtf8NoBom(filePath, JSON.stringify(cfg, null, 2));
                    } catch (e) {}
                }

                updateJsonConfig(targetDir + "\\config.json", { language: "it", webBanconeEnabled: false, licenseAccepted: true });
                var appDataDir = wsh.ExpandEnvironmentStrings("%APPDATA%") + "\\PrintZap";
                if (fso.FileExists(appDataDir + "\\config.json")) {
                    updateJsonConfig(appDataDir + "\\config.json", { language: "it", licenseAccepted: true });
                }

                if (!fso.FileExists(targetDir + "\\disinstalla_printzap.bat")) {
                    try {
                        var uninstUrl = "https://raw.githubusercontent.com/alfaomega-dev/cartoleria-whatsapp-updates/main/disinstalla_printzap.bat";
                        wsh.Run('curl.exe -s -L "' + uninstUrl + '" -o "' + targetDir + '\\disinstalla_printzap.bat"', 0, true);
                    } catch(e){}
                }

                setStep(3, 'done');
                setProgress(95, "Configurazione collegamenti...", "Creazione icona Desktop e Menu Start...");

                // Step 4: Collegamenti Desktop, Menu Start e Registro Windows
                setStep(4, 'active');
                setTimeout(function() {
                    try {
                        var desktopPath = wsh.SpecialFolders("Desktop");
                        var shortcut = wsh.CreateShortcut(desktopPath + "\\PrintZap.lnk");
                        shortcut.TargetPath = targetDir + "\\PrintZap.exe";
                        shortcut.WorkingDirectory = targetDir;
                        if (fso.FileExists(targetDir + "\\app.ico")) {
                            shortcut.IconLocation = targetDir + "\\app.ico,0";
                        }
                        shortcut.Save();

                        var programsPath = wsh.SpecialFolders("Programs");
                        var legacyStartLnk = programsPath + "\\PrintZap.lnk";
                        if (fso.FileExists(legacyStartLnk)) {
                            try { fso.DeleteFile(legacyStartLnk, true); } catch(e){}
                        }

                        var startMenuFolder = programsPath + "\\PrintZap";
                        if (!fso.FolderExists(startMenuFolder)) {
                            fso.CreateFolder(startMenuFolder);
                        }

                        var shortcut2 = wsh.CreateShortcut(startMenuFolder + "\\PrintZap.lnk");
                        shortcut2.TargetPath = targetDir + "\\PrintZap.exe";
                        shortcut2.WorkingDirectory = targetDir;
                        if (fso.FileExists(targetDir + "\\app.ico")) {
                            shortcut2.IconLocation = targetDir + "\\app.ico,0";
                        }
                        shortcut2.Save();

                        var mshtaExe = wsh.ExpandEnvironmentStrings("%SystemRoot%") + "\\System32\\mshta.exe";
                        var shortcutUninst = wsh.CreateShortcut(startMenuFolder + "\\Disinstalla PrintZap.lnk");
                        shortcutUninst.TargetPath = mshtaExe;
                        shortcutUninst.Arguments = '"' + targetDir + '\\disinstalla_printzap.bat"';
                        shortcutUninst.WorkingDirectory = targetDir;
                        shortcutUninst.IconLocation = "shell32.dll,31";
                        shortcutUninst.Save();

                        var regBase = "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\PrintZap\\";
                        wsh.RegWrite(regBase + "DisplayName", "PrintZap", "REG_SZ");
                        wsh.RegWrite(regBase + "DisplayVersion", "1.1.20", "REG_SZ");
                        wsh.RegWrite(regBase + "Publisher", "PrintZap", "REG_SZ");
                        wsh.RegWrite(regBase + "DisplayIcon", targetDir + "\\app.ico", "REG_SZ");
                        wsh.RegWrite(regBase + "InstallLocation", targetDir, "REG_SZ");
                        wsh.RegWrite(regBase + "UninstallString", 'mshta.exe "' + targetDir + '\\disinstalla_printzap.bat"', "REG_SZ");
                        wsh.RegWrite(regBase + "NoModify", 1, "REG_DWORD");
                        wsh.RegWrite(regBase + "NoRepair", 1, "REG_DWORD");
                    } catch(e){}

                    setStep(4, 'done');
                    setProgress(100, "Installazione completata con successo!", "Avvio di PrintZap in corso...");

                    setTimeout(function() {
                        try {
                            wsh.CurrentDirectory = targetDir;
                            wsh.Run('cmd.exe /c ping -n 2 127.0.0.1 >nul & start "" /D "' + targetDir + '" "' + targetDir + '\\PrintZap.exe"', 0, false);
                        } catch(e){}
                        window.close();
                    }, 1200);

                }, 400);

            }, 400);
        }

    }, 300);
}
</script>
</body>
</html>