const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

function getDesktopPath() {
    const userProfile = process.env.USERPROFILE || process.env.HOME || '';
    const candidates = [
        path.join(userProfile, 'Desktop'),
        path.join(userProfile, 'OneDrive', 'Desktop'),
        path.join(process.env.OneDrive || '', 'Desktop')
    ];
    for (const p of candidates) {
        if (p && fs.existsSync(p)) return path.join(p, 'Antigravity-CN.lnk');
    }
    return path.join(userProfile, 'Desktop', 'Antigravity-CN.lnk');
}

const desktopShortcut = getDesktopPath();
const targetScript = path.join(__dirname, 'antigravity_smart_launcher.vbs');

// 动态检测 Antigravity.exe 实际安装路径 (覆盖 D 盘、E 盘、快捷方式逆向及自定义目录)
const localAppData = process.env.LOCALAPPDATA || '';
const userProfile = process.env.USERPROFILE || '';
const oneDrive = process.env.OneDrive || '';
const progFiles = process.env.ProgramFiles || 'C:\\Program Files';
const progFilesX86 = process.env['ProgramFiles(x86)'] || 'C:\\Program Files (x86)';

const candidates = [
    path.join(localAppData, 'Programs', 'antigravity', 'Antigravity.exe'),
    path.join(localAppData, 'Programs', 'Antigravity', 'Antigravity.exe'),
    path.join(localAppData, 'Programs', 'Antigravity IDE', 'Antigravity.exe'),
    'D:\\Antigravity\\Antigravity.exe',
    'D:\\antigravity\\Antigravity.exe',
    'D:\\Software\\Antigravity\\Antigravity.exe',
    'D:\\Programs\\Antigravity\\Antigravity.exe',
    'D:\\Program Files\\Antigravity\\Antigravity.exe',
    'E:\\Antigravity\\Antigravity.exe',
    'E:\\antigravity\\Antigravity.exe',
    'E:\\Software\\Antigravity\\Antigravity.exe',
    'E:\\Programs\\Antigravity\\Antigravity.exe',
    'E:\\Program Files\\Antigravity\\Antigravity.exe',
    path.join(progFiles, 'Antigravity', 'Antigravity.exe'),
    path.join(progFilesX86, 'Antigravity', 'Antigravity.exe'),
    'C:\\Antigravity\\Antigravity.exe',
    'C:\\Programs\\Antigravity\\Antigravity.exe',
    'F:\\Antigravity\\Antigravity.exe'
];

// 尝试从已有桌面快捷方式逆向解析
const existingShortcuts = [
    path.join(userProfile, 'Desktop', 'Antigravity.lnk'),
    path.join(oneDrive, 'Desktop', 'Antigravity.lnk')
];
for (const sc of existingShortcuts) {
    if (fs.existsSync(sc)) {
        try {
            const tempV = path.join(__dirname, '_t_sc.vbs');
            fs.writeFileSync(tempV, `Set ws = WScript.CreateObject("WScript.Shell")\nWScript.Echo ws.CreateShortcut("${sc.replace(/\\/g, '\\\\')}").TargetPath`, 'ascii');
            const out = execSync(`cscript //nologo "${tempV}"`, { encoding: 'utf-8' }).trim();
            if (fs.existsSync(tempV)) fs.unlinkSync(tempV);
            if (out && fs.existsSync(out)) {
                if (out.toLowerCase().endsWith('antigravity.exe')) {
                    candidates.unshift(out);
                } else if (fs.existsSync(path.join(out, 'Antigravity.exe'))) {
                    candidates.unshift(path.join(out, 'Antigravity.exe'));
                }
            }
        } catch (e) {}
    }
}

let iconExe = '';
for (const p of candidates) {
    if (fs.existsSync(p)) {
        iconExe = p;
        break;
    }
}
if (!iconExe) iconExe = candidates[0];

const vbs = [
    'Set ws = WScript.CreateObject("WScript.Shell")',
    `Set link = ws.CreateShortcut("${desktopShortcut.replace(/\\/g, '\\\\')}")`,
    'link.TargetPath = "wscript.exe"',
    `link.Arguments = """${targetScript.replace(/\\/g, '\\\\')}"""`,
    `link.IconLocation = "${iconExe.replace(/\\/g, '\\\\')},0"`,
    'link.Description = "Antigravity 智能编程 (自动更新汉化)"',
    'link.Save'
].join('\r\n');

const tempFile = path.join(__dirname, '_mklink.vbs');
fs.writeFileSync(tempFile, vbs, 'ascii');
try {
    execSync(`cscript //nologo "${tempFile}"`);
    console.log(`[√] 桌面快捷方式已成功创建: ${desktopShortcut}`);
} finally {
    if (fs.existsSync(tempFile)) fs.unlinkSync(tempFile);
}
