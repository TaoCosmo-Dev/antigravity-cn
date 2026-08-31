const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const desktopPath = path.join(process.env.USERPROFILE, 'Desktop', 'Antigravity-CN.lnk');
const targetScript = path.join(__dirname, 'antigravity_smart_launcher.vbs');
const iconExe = path.join(process.env.LOCALAPPDATA, 'Programs', 'antigravity', 'Antigravity.exe');

const vbs = [
  'Set ws = WScript.CreateObject("WScript.Shell")',
  `Set link = ws.CreateShortcut("${desktopPath.replace(/\\/g, '\\\\')}")`,
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
  console.log('[√] 桌面快捷方式 Antigravity-CN 已成功创建！');
} finally {
  if (fs.existsSync(tempFile)) fs.unlinkSync(tempFile);
}
