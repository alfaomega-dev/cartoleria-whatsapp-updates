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
<title>PrintZap Installation</title>
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

    /* License Screen */
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

    /* Installation Screen */
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
            <h1 id="brandTitle">PrintZap Quick Installation</h1>
            <p id="brandSubtitle">End User License Agreement & Terms of Service</p>
        </div>
    </div>

    <!-- 1. LICENSE ACCEPTANCE -->
    <div id="screenLicense" class="screen-license">
        <div class="license-card">END USER LICENSE AGREEMENT AND TERMS OF SERVICE - PRINTZAP
=============================================================

1. SUBJECT OF THE AGREEMENT
The Licensee acquires the personal, non-transferable, and time-limited right to use (e.g. monthly, annual, or according to commercial offer) the "PrintZap" software, a desktop application designed for:
* Automatic local print queue management;
* Automatic organization and deletion of files after delivery/printing;
* Automatic fetching of files from a local directory and from integration with WhatsApp messaging service (hereinafter "Integration Module").

---

2. NATURE OF THE INTEGRATION MODULE (WHATSAPP)
The Licensee expressly acknowledges and agrees that:
* The WhatsApp integration module is not an official product of Meta Platforms Inc. nor is it approved, sponsored, or authorized by Meta.
* The operation of this module depends exclusively on the technical structure that Meta chooses to adopt for its WhatsApp Web service.
* The Licensor has no control over modifications, updates, or service interruptions made by Meta to its service.

---

3. LIMITATION OF LIABILITY FOR SERVICE INTERRUPTION AND FORCE MAJEURE
The Licensee expressly releases the Licensor from any liability, claim for compensation, loss of turnover, downtime, or damage arising from:
* Suspension, blocking, or deletion of the Licensee's WhatsApp account;
* Interruption, malfunction, or technical impossibility of the automatic fetching module following updates to Meta/WhatsApp systems;
* Failure or delay in receiving files from end customers due to network or third-party issues.

Force Majeure Clause: Should structural or security changes to third-party services (WhatsApp) render the restoration or operation of the Integration Module technically impossible, the agreement shall terminate by operation of law due to supervening impossibility (force majeure), excluding any obligation of compensation, indemnity, or refund of remaining fees by the Licensor.

---

4. MAINTENANCE, UPDATES, AND COMPATIBILITY
* Included Support: For the duration of the purchased license period, the Licensor guarantees the release of corrective updates for internal software bugs and for restoring the WhatsApp integration module (subject to open-source library limitations).
* Compatibility: The Licensor does not guarantee proper operation of the software on obsolete or unsupported operating systems (e.g., outdated Windows versions), nor in the presence of local antivirus, firewall, or security software blocking network activity or system access.

---

5. DATA PROCESSING AND PRIVACY (GDPR)
Since the software is installed locally on the Licensee's PC:
* Files (PDFs, images, and documents) sent by end customers reside exclusively on the Licensee's local hardware.
* The Licensor does not access, store on its servers, or process in any way the data of end customers or documents managed by PrintZap.
* The Licensee declares to be the sole Data Controller of their end customers' personal data and agrees to comply with GDPR regulations (EU Regulation 2016/679).

---

6. PROHIBITION OF TAMPERING, REVERSE ENGINEERING, AND CRACKING
The source code, architecture, and interface of PrintZap are the exclusive intellectual property of the Licensor. The Licensee is strictly prohibited from:
* Decompiling, disassembling, or performing reverse engineering operations on the software;
* Bypassing, altering, or attempting to circumvent online license verification and control systems.
Any violation will result in immediate deactivation of the software, revocation of the license without refund, and report for copyright protection.

---

7. MAXIMUM LIMITATION OF DAMAGES
In any event and for any type of dispute (including software bugs or data loss), the Licensor's total liability to the Licensee for direct, indirect, commercial, or lost profit damages shall never exceed the total sum actually paid by the Licensee for purchasing the software license in the twelve (12) months preceding the event giving rise to damage.

---

8. INDEMNIFICATION ON CUSTOMER CONTENT COPYRIGHT
The Licensee warrants that files sent by their end users and printed via the software do not violate copyrights, patents, trademarks, or any applicable laws. The Licensee agrees to indemnify and hold harmless the Licensor from any penalty, legal expense, or compensation claim by third parties due to the content or legality of documents processed and printed via PrintZap.

---

9. CONTROL COMMUNICATION AND TELEMETRY
The software requires an active internet connection for periodic license validity checks and update searches. The Licensee consents to such transmission of technical data necessary to verify proper software usage.

---

10. SEVERABILITY
The invalidity, ineffectiveness, or nullity of one or more clauses of this agreement shall not affect the validity and effectiveness of the remaining provisions, which shall continue in full force and effect.

---

11. GOVERNING LAW AND JURISDICTION
This agreement is governed by Italian law. For any dispute arising from the interpretation, execution, or termination of this agreement, the parties establish the exclusive jurisdiction of the Court of Reggio Calabria (Italy).

=============================================================
SPECIFIC ACCEPTANCE OF UNREASONABLE / BURDENSOME CLAUSES
Pursuant to Articles 1341 and 1342 of the Italian Civil Code, the Licensee declares to have carefully read and specifically approved the following sections:
* Section 3: Limitation of liability for service interruption and force majeure;
* Section 4: Technical compatibility limitations and antivirus;
* Section 6: Prohibition of tampering, reverse engineering, and immediate revocation without refund;
* Section 7: Maximum limitation of damages;
* Section 8: Indemnification on customer content copyright;
* Section 11: Exclusive jurisdiction of the Court of Reggio Calabria.</div>
        <div class="checkbox-box" onclick="toggleAgree()">
            <div class="checkbox-row">
                <input type="checkbox" id="chkAgree" onclick="onCheckboxClick(event)">
                <div class="checkbox-title">I have read and agree to the End User License Agreement and Terms of Service</div>
            </div>
        </div>
        <div class="actions">
            <button type="button" class="btn btn-cancel" onclick="window.close()">Cancel</button>
            <button type="button" class="btn btn-primary" id="btnContinue" disabled onclick="acceptAndInstall()">Accept & Install →</button>
        </div>
    </div>

    <!-- 2. INSTALLATION PROGRESS -->
    <div id="screenInstall" class="screen-install">
        <div class="steps-container">
            <div class="step-row" id="step1">
                <div class="step-bullet">1</div>
                <div class="step-label">Check latest version availability on GitHub</div>
            </div>
            <div class="step-row" id="step2">
                <div class="step-bullet">2</div>
                <div class="step-label">Download full package (via curl)</div>
            </div>
            <div class="step-row" id="step3">
                <div class="step-bullet">3</div>
                <div class="step-label">Extract files to %LOCALAPPDATA%\PrintZap</div>
            </div>
            <div class="step-row" id="step4">
                <div class="step-bullet">4</div>
                <div class="step-label">Create Desktop icon, Start Menu folder and launch app</div>
            </div>
        </div>

        <div class="progress-box">
            <div class="progress-header">
                <span id="progressStepTitle">Initializing...</span>
                <span id="progressPct">0%</span>
            </div>
            <div class="progress-track">
                <div class="progress-fill" id="progressBar"></div>
            </div>
            <div class="status-msg" id="statusDetail">Preparing environment...</div>
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
    document.getElementById('brandSubtitle').innerText = "Downloading official components from GitHub and setting up client";
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
    document.getElementById('statusDetail').innerText = 'Installation aborted.';
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

    // Step 1: Check version
    setStep(1, 'active');
    setProgress(5, "Checking version on GitHub...", "Connecting to server...");

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
        setProgress(15, "Downloading PrintZap package...", "Starting curl download...");

        // Step 2: Download ZIP with curl
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
                setProgress(pct, "Downloading full package...", mb + " MB downloaded...");
            }

            if (fso.FileExists(flagDone)) {
                clearInterval(checkTimer);
                try { fso.DeleteFile(flagDone, true); } catch(e){}
                onDownloadFinished();
            }
        }, 300);

        function onDownloadFinished() {
            if (!fso.FileExists(tempZip) || fso.GetFile(tempZip).Size < 5000000) {
                showError("Download error: package not available or connection lost.");
                return;
            }

            var finalMb = (fso.GetFile(tempZip).Size / (1024 * 1024)).toFixed(1);
            setStep(2, 'done');
            setProgress(80, "Extracting files...", "Package downloaded (" + finalMb + " MB). Installing...");

            // Step 3: Extraction
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

                // English language config
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

                updateJsonConfig(targetDir + "\\config.json", { language: "en", webBanconeEnabled: false, licenseAccepted: true });
                var appDataDir = wsh.ExpandEnvironmentStrings("%APPDATA%") + "\\PrintZap";
                if (fso.FileExists(appDataDir + "\\config.json")) {
                    updateJsonConfig(appDataDir + "\\config.json", { language: "en", licenseAccepted: true });
                }

                if (!fso.FileExists(targetDir + "\\disinstalla_printzap.bat")) {
                    try {
                        var uninstUrl = "https://raw.githubusercontent.com/alfaomega-dev/cartoleria-whatsapp-updates/main/disinstalla_printzap.bat";
                        wsh.Run('curl.exe -s -L "' + uninstUrl + '" -o "' + targetDir + '\\disinstalla_printzap.bat"', 0, true);
                    } catch(e){}
                }

                setStep(3, 'done');
                setProgress(95, "Configuring shortcuts...", "Creating Desktop and Start Menu icons...");

                // Step 4: Shortcuts and Windows Registry
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
                        var shortcutUninst = wsh.CreateShortcut(startMenuFolder + "\\Uninstall PrintZap.lnk");
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
                    setProgress(100, "Installation completed successfully!", "Launching PrintZap...");

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