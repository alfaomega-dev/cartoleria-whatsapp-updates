<!-- :
@echo off
setlocal
start "" mshta.exe "%~f0" %*
exit /b
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Disinstallazione PrintZap</title>
<hta:application 
    id="oPrintZapUninstaller"
    applicationname="PrintZapUninstaller"
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
        padding: 22px 26px;
        display: flex;
        flex-direction: column;
        background: radial-gradient(circle at 85% 15%, #23161b 0%, #0b141a 75%);
    }
    .header {
        display: flex;
        align-items: center;
        margin-bottom: 16px;
    }
    .brand-icon {
        width: 44px; height: 44px;
        background: linear-gradient(135deg, #ef4444, #b91c1c);
        border-radius: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 20px;
        font-weight: bold;
        color: #fff;
        margin-right: 14px;
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        flex-shrink: 0;
    }
    .brand-text h1 {
        margin: 0; font-size: 19px; font-weight: 700; color: #ffffff; letter-spacing: -0.3px;
    }
    .brand-text p {
        margin: 3px 0 0 0; font-size: 12px; color: #8696a0; font-weight: 500;
    }
    .info-card {
        background: #111b21;
        border: 1px solid rgba(255, 255, 255, 0.08);
        border-radius: 10px;
        padding: 14px 16px;
        margin-bottom: 14px;
        font-size: 12.5px;
        line-height: 1.5;
        color: #cbd5e1;
    }
    .info-card code {
        background: #202c33;
        color: #38bdf8;
        padding: 1px 5px;
        border-radius: 4px;
        font-family: Consolas, monospace;
        font-size: 11.5px;
    }
    .checkbox-box {
        display: block;
        background: rgba(239, 68, 68, 0.07);
        border: 1px solid rgba(239, 68, 68, 0.28);
        border-radius: 10px;
        padding: 12px 14px;
        margin-bottom: 14px;
        cursor: pointer;
    }
    .checkbox-row {
        display: flex;
        align-items: flex-start;
        gap: 10px;
        cursor: pointer;
    }
    .checkbox-row input[type="checkbox"] {
        margin-top: 2px;
        width: 16px;
        height: 16px;
        cursor: pointer;
        flex-shrink: 0;
    }
    .checkbox-title {
        font-size: 12.5px;
        font-weight: 600;
        color: #fca5a5;
        line-height: 1.35;
    }
    .checkbox-sub {
        margin: 6px 0 0 26px;
        font-size: 11.5px;
        color: #94a3b8;
        line-height: 1.35;
    }
    .actions {
        margin-top: auto;
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }
    .btn {
        border: none;
        border-radius: 8px;
        padding: 9px 18px;
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
    .btn-danger {
        background: #ef4444;
        color: #ffffff;
        box-shadow: 0 4px 12px rgba(239, 68, 68, 0.35);
    }
    .btn-danger:hover {
        background: #dc2626;
    }
    .btn:disabled {
        opacity: 0.5;
        cursor: default;
    }
    .progress-section {
        display: none;
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
        background: linear-gradient(90deg, #ef4444, #f59e0b);
        border-radius: 6px;
        transition: width 0.25s ease-out;
    }
    .status-msg {
        margin-top: 10px;
        font-size: 11.5px;
        color: #94a3b8;
        min-height: 16px;
        text-align: center;
    }
</style>
</head>
<body>
<div class="wrapper">
    <div class="header">
        <div class="brand-icon">🗑</div>
        <div class="brand-text">
            <h1 id="hdrTitle">Disinstallazione PrintZap</h1>
            <p id="hdrSub">Rimozione del software e dei collegamenti di Windows</p>
        </div>
    </div>

    <div class="info-card" id="infoCard">
        Questa procedura rimuoverà l'applicazione PrintZap dalla cartella <code>%LOCALAPPDATA%\PrintZap</code>, l'icona sul Desktop, il Menu Start e l'avvio automatico di Windows.
    </div>

    <label class="checkbox-box" for="chkRemoveData" id="checkboxBox">
        <div class="checkbox-row">
            <input type="checkbox" id="chkRemoveData" />
            <span class="checkbox-title" id="chkTitle">Elimina anche i dati personali, lo storico ordini, la licenza e la sessione WhatsApp (%APPDATA%\PrintZap)</span>
        </div>
        <div class="checkbox-sub" id="chkSub">Lascia deselezionato se vuoi mantenere i tuoi dati e la licenza per una futura reinstallazione.</div>
    </label>

    <div class="actions" id="actionButtons">
        <button type="button" class="btn btn-cancel" id="btnCancel" onclick="window.close()">Annulla</button>
        <button type="button" class="btn btn-danger" id="btnUninstall" onclick="startUninstall()">Disinstalla Ora</button>
    </div>

    <div class="progress-section" id="progressSection">
        <div class="progress-header">
            <span id="progressTitle">Preparazione...</span>
            <span id="progressPct">0%</span>
        </div>
        <div class="progress-track">
            <div class="progress-fill" id="progressBar"></div>
        </div>
        <div class="status-msg" id="statusDetail">Avvio disinstallazione...</div>
    </div>
</div>

<script>
var isEnglish = false;

var I18N = {
    it: {
        winTitle: "Disinstallazione PrintZap",
        hdrTitle: "Disinstallazione PrintZap",
        hdrSub: "Rimozione del software e dei collegamenti di Windows",
        infoCard: "Questa procedura rimuoverà l'applicazione PrintZap dalla cartella <code>%LOCALAPPDATA%\\PrintZap</code>, l'icona sul Desktop, il Menu Start e l'avvio automatico di Windows.",
        chkTitle: "Elimina anche i dati personali, lo storico ordini, la licenza e la sessione WhatsApp (%APPDATA%\\PrintZap)",
        chkSub: "Lascia deselezionato se vuoi mantenere i tuoi dati e la licenza per una futura reinstallazione.",
        btnCancel: "Annulla",
        btnUninstall: "Disinstalla Ora",
        stepStop: "Arresto servizi PrintZap in esecuzione...",
        stepShortcuts: "Rimozione icone Desktop e Menu Start...",
        stepRegistry: "Pulizia voci di registro e avvio automatico...",
        stepData: "Eliminazione dati utente, database e sessione WhatsApp...",
        stepApp: "Rimozione cartella applicazione...",
        doneTitle: "Disinstallazione completata!",
        doneDetail: "PrintZap è stato rimosso dal computer."
    },
    en: {
        winTitle: "Uninstall PrintZap",
        hdrTitle: "Uninstall PrintZap",
        hdrSub: "Remove software and Windows shortcuts",
        infoCard: "This wizard will remove the PrintZap application from <code>%LOCALAPPDATA%\\PrintZap</code>, the Desktop icon, Start Menu folder and Windows auto-start.",
        chkTitle: "Also delete personal data, order history, license and WhatsApp session (%APPDATA%\\PrintZap)",
        chkSub: "Leave unchecked to keep your data and license for a future reinstallation.",
        btnCancel: "Cancel",
        btnUninstall: "Uninstall Now",
        stepStop: "Stopping running PrintZap services...",
        stepShortcuts: "Removing Desktop and Start Menu shortcuts...",
        stepRegistry: "Cleaning up registry entries and auto-start...",
        stepData: "Deleting personal data, database and WhatsApp session...",
        stepApp: "Removing application directory...",
        doneTitle: "Uninstallation completed!",
        doneDetail: "PrintZap has been removed from your computer."
    }
};

function readTextUtf8(fso, filePath) {
    try {
        if (!fso.FileExists(filePath)) return "";
        var stream = new ActiveXObject("ADODB.Stream");
        stream.Type = 2;
        stream.Charset = "utf-8";
        stream.Open();
        stream.LoadFromFile(filePath);
        var content = stream.ReadText(-1);
        stream.Close();
        return content;
    } catch (e) {
        try {
            var tf = fso.OpenTextFile(filePath, 1, false);
            var txt = tf.ReadAll();
            tf.Close();
            return txt;
        } catch (e2) {
            return "";
        }
    }
}

function detectLanguage() {
    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wsh = new ActiveXObject("WScript.Shell");
    var appDataDir = wsh.ExpandEnvironmentStrings("%APPDATA%") + "\\PrintZap";
    var localDir = wsh.ExpandEnvironmentStrings("%LOCALAPPDATA%") + "\\PrintZap";

    var cfgFiles = [appDataDir + "\\config.json", localDir + "\\config.json"];
    for (var i = 0; i < cfgFiles.length; i++) {
        var content = readTextUtf8(fso, cfgFiles[i]);
        if (content) {
            var m = content.match(/"language"\s*:\s*"([^"]+)"/);
            if (m && m[1]) {
                return m[1].toLowerCase() === "en";
            }
        }
    }

    try {
        var cmdLine = (oPrintZapUninstaller.commandLine || "").toLowerCase();
        if (cmdLine.indexOf("--lang=en") !== -1) return true;
    } catch (e) {}

    return false;
}

function applyTranslations() {
    var t = isEnglish ? I18N.en : I18N.it;
    document.title = t.winTitle;
    document.getElementById("hdrTitle").innerText = t.hdrTitle;
    document.getElementById("hdrSub").innerText = t.hdrSub;
    document.getElementById("infoCard").innerHTML = t.infoCard;
    document.getElementById("chkTitle").innerText = t.chkTitle;
    document.getElementById("chkSub").innerText = t.chkSub;
    document.getElementById("btnCancel").innerText = t.btnCancel;
    document.getElementById("btnUninstall").innerText = t.btnUninstall;
}

window.onload = function() {
    window.resizeTo(560, 430);
    window.moveTo((screen.width - 560) / 2, (screen.height - 430) / 2);
    isEnglish = detectLanguage();
    applyTranslations();
};

function setProgress(pct, title, detail) {
    document.getElementById("progressBar").style.width = pct + "%";
    document.getElementById("progressPct").innerText = Math.round(pct) + "%";
    if (title) document.getElementById("progressTitle").innerText = title;
    if (detail) document.getElementById("statusDetail").innerText = detail;
}

function startUninstall() {
    var t = isEnglish ? I18N.en : I18N.it;
    var removeData = document.getElementById("chkRemoveData").checked;

    document.getElementById("actionButtons").style.display = "none";
    document.getElementById("chkRemoveData").disabled = true;
    document.getElementById("checkboxBox").style.opacity = "0.75";
    document.getElementById("progressSection").style.display = "block";

    var fso = new ActiveXObject("Scripting.FileSystemObject");
    var wsh = new ActiveXObject("WScript.Shell");

    var tempDir = wsh.ExpandEnvironmentStrings("%TEMP%");
    var localAppData = wsh.ExpandEnvironmentStrings("%LOCALAPPDATA%");
    var appData = wsh.ExpandEnvironmentStrings("%APPDATA%");
    var targetDir = localAppData + "\\PrintZap";
    var dataDir = appData + "\\PrintZap";

    try { wsh.CurrentDirectory = tempDir; } catch (e) {}

    // Step 1: Arresto processi PrintZap
    setProgress(15, t.stepStop, t.stepStop);
    setTimeout(function() {
        try {
            wsh.Run('cmd.exe /c taskkill /F /IM PrintZap.exe /T >nul 2>&1', 0, true);
            var psKill = 'powershell.exe -NoProfile -NonInteractive -Command "' +
                'Get-CimInstance Win32_Process | Where-Object { ' +
                '($_.Name -eq \'node.exe\' -and $_.CommandLine -match \'PrintZap\') -or ' +
                '(($_.Name -eq \'chrome.exe\' -or $_.Name -eq \'msedge.exe\') -and $_.CommandLine -match \'wwebjs\') ' +
                '} | ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }"';
            wsh.Run(psKill, 0, true);
        } catch (e) {}

        // Step 2: Rimozione icone Desktop e Menu Start
        setProgress(40, t.stepShortcuts, t.stepShortcuts);
        setTimeout(function() {
            try {
                var desktopLnk = wsh.SpecialFolders("Desktop") + "\\PrintZap.lnk";
                if (fso.FileExists(desktopLnk)) fso.DeleteFile(desktopLnk, true);
            } catch (e) {}

            try {
                var userDesktopLnk = wsh.ExpandEnvironmentStrings("%USERPROFILE%") + "\\Desktop\\PrintZap.lnk";
                if (fso.FileExists(userDesktopLnk)) fso.DeleteFile(userDesktopLnk, true);
            } catch (e) {}

            try {
                var programsPath = wsh.SpecialFolders("Programs");
                var legacyLnk = programsPath + "\\PrintZap.lnk";
                if (fso.FileExists(legacyLnk)) fso.DeleteFile(legacyLnk, true);

                var startMenuFolder = programsPath + "\\PrintZap";
                if (fso.FolderExists(startMenuFolder)) {
                    wsh.Run('cmd.exe /c rd /s /q "' + startMenuFolder + '"', 0, true);
                }
            } catch (e) {}

            try {
                var startupLnk = wsh.SpecialFolders("Startup") + "\\PrintZap.lnk";
                if (fso.FileExists(startupLnk)) fso.DeleteFile(startupLnk, true);
            } catch (e) {}

            // Step 3: Pulizia registro utente
            setProgress(65, t.stepRegistry, t.stepRegistry);
            setTimeout(function() {
                try {
                    wsh.Run('cmd.exe /c reg delete "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Run" /v "PrintZap" /f >nul 2>&1', 0, true);
                    wsh.Run('cmd.exe /c reg delete "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Uninstall\\PrintZap" /f >nul 2>&1', 0, true);
                } catch (e) {}

                // Step 4: Rimozione opzionale dati personali %APPDATA%\PrintZap
                if (removeData) {
                    setProgress(80, t.stepData, t.stepData);
                    try {
                        if (fso.FolderExists(dataDir)) {
                            wsh.Run('cmd.exe /c rd /s /q "' + dataDir + '"', 0, true);
                        }
                    } catch (e) {}
                }

                // Step 5: Rimozione finale cartella programma %LOCALAPPDATA%\PrintZap
                setProgress(100, t.doneTitle, t.doneDetail);
                setTimeout(function() {
                    try {
                        wsh.CurrentDirectory = tempDir;
                        if (fso.FolderExists(targetDir)) {
                            wsh.Run('cmd.exe /c ping -n 2 127.0.0.1 >nul & rd /s /q "' + targetDir + '" & ping -n 2 127.0.0.1 >nul & rd /s /q "' + targetDir + '"', 0, false);
                        }
                    } catch (e) {}
                    window.close();
                }, 1200);
            }, 350);
        }, 350);
    }, 300);
}
</script>
</body>
</html>
