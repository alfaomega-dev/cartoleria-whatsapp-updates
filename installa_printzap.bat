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
    selection="no"
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
        padding: 24px 28px;
        display: flex;
        flex-direction: column;
        background: radial-gradient(circle at 85% 15%, #182229 0%, #0b141a 75%);
    }
    .header {
        display: flex;
        align-items: center;
        margin-bottom: 20px;
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
    }
    .brand-text h1 {
        margin: 0; font-size: 20px; font-weight: 700; color: #ffffff; letter-spacing: -0.3px;
    }
    .brand-text p {
        margin: 2px 0 0 0; font-size: 12px; color: #8696a0; font-weight: 500;
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
        transition: color 0.2s;
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
            <h1>Installazione Rapida PrintZap</h1>
            <p>Download dei componenti ufficiali da GitHub e configurazione client</p>
        </div>
    </div>

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

<script>
window.onload = function() {
    window.resizeTo(570, 440);
    window.moveTo((screen.width - 570) / 2, (screen.height - 440) / 2);
    startInstallation();
};

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

                updateJsonConfig(targetDir + "\\config.json", { language: "it", webBanconeEnabled: false });
                var appDataDir = wsh.ExpandEnvironmentStrings("%APPDATA%") + "\\PrintZap";
                if (fso.FileExists(appDataDir + "\\config.json")) {
                    updateJsonConfig(appDataDir + "\\config.json", { language: "it" });
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
