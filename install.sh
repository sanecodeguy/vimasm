#!/bin/bash
echo "installing vimasm..."
if [ "$EUID" -eq 0 ]; then echo "do not run as root"; exit 1; fi
sudo mkdir -p /usr/local/vimasm/dos
BASE=/usr/local/vimasm
sudo pacman -S --noconfirm nasm dosbox wget unzip >/dev/null 2>&1
if [ ! -f "$BASE/dos/AFD.EXE" ]; then
  wget -q -O /tmp/AFD.EXE https://github.com/soothscier/assembly-nasm/raw/master/AFD.EXE
  sudo cp /tmp/AFD.EXE "$BASE/dos/AFD.EXE"
  rm -f /tmp/AFD.EXE
fi
#!/bin/sh
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${RED}██╗   ██╗██╗███╗   ███╗ ${GREEN}█████╗ ███████╗${YELLOW}███╗   ███╗${NC}"
echo -e "${RED}██║   ██║██║████╗ ████║${GREEN}██╔══██╗██╔════╝${YELLOW}████╗ ████║${NC}"
echo -e "${RED}██║   ██║██║██╔████╔██║${GREEN}███████║███████╗${YELLOW}██╔████╔██║${NC}"
echo -e "${BLUE}╚██╗ ██╔╝██║██║╚██╔╝██║${MAGENTA}██╔══██║╚════██║${CYAN}██║╚██╔╝██║${NC}"
echo -e "${BLUE} ╚████╔╝ ██║██║ ╚═╝ ██║${MAGENTA}██║  ██║███████║${CYAN}██║ ╚═╝ ██║${NC}"
echo -e "${BLUE}  ╚═══╝  ╚═╝╚═╝     ╚═╝${MAGENTA}╚═╝  ╚═╝╚══════╝${CYAN}╚═╝     ╚═╝${NC}"
sleep 2
mkdir -p ~/.dosbox
cat > ~/.dosbox/dosbox-vimasm.conf <<'EOL'
[autoexec]
mount c /usr/local/vimasm
c:
set PATH=%PATH%;C:\DOS
prompt $p$g
EOL
mkdir -p ~/.config/nvim/lua/vimasm
cat > ~/.config/nvim/lua/vimasm/init.lua <<'LUA'
vim.cmd([[command! -nargs=0 Nc lua require('vimasm').compile_and_run()]])
vim.cmd([[command! -nargs=0 Nd lua require('vimasm').compile_and_debug()]])
local M = {}
function M.compile_and_run()
  local asm = vim.fn.expand('%:p')
  if asm == '' then vim.cmd("echo 'No file'") return end
  local dir = vim.fn.fnamemodify(asm,":h")
  local base = vim.fn.expand('%:r')
  local com = base .. ".com"
  local lst = base .. ".lst"
  vim.cmd('write')
  vim.cmd("silent !/usr/bin/nasm -f bin " .. vim.fn.shellescape(asm) .. " -o " .. vim.fn.shellescape(com) .. " -l " .. vim.fn.shellescape(lst))
  if vim.v.shell_error == 0 then
    local run = string.format('silent !dosbox -noconsole -conf ~/.dosbox/dosbox-vimasm.conf -c "mount d %s" -c "d:" -c "%s"', dir, vim.fn.fnamemodify(com,":t"))
    vim.cmd(run)
  else
    vim.cmd("echo 'Compilation failed'")
  end
end
function M.compile_and_debug()
  local asm = vim.fn.expand('%:p')
  if asm == '' then vim.cmd("echo 'No file'") return end
  local dir = vim.fn.fnamemodify(asm,":h")
  local base = vim.fn.expand('%:r')
  local com = base .. ".com"
  local lst = base .. ".lst"
  vim.cmd('write')
  vim.cmd("silent !/usr/bin/nasm -f bin " .. vim.fn.shellescape(asm) .. " -o " .. vim.fn.shellescape(com) .. " -l " .. vim.fn.shellescape(lst))
  if vim.v.shell_error == 0 then
    local run = string.format('silent !dosbox -noconsole -conf ~/.dosbox/dosbox-vimasm.conf -c "mount d %s" -c "d:" -c "c:\\dos\\afd %s"', dir, vim.fn.fnamemodify(com,":t"))
    vim.cmd(run)
  else
    vim.cmd("echo 'Compilation failed'")
  end
end
vim.cmd([[autocmd BufRead,BufNewFile *.asm set filetype=nasm]])
return M
LUA
if [ ! -f ~/.config/nvim/init.lua ]; then
  echo 'require("vimasm")' > ~/.config/nvim/init.lua
else
  if ! grep -q "vimasm" ~/.config/nvim/init.lua; then
    echo '' >> ~/.config/nvim/init.lua
    echo 'require("vimasm")' >> ~/.config/nvim/init.lua
  fi
fi
mkdir -p ~/vimasm_demo
cat > ~/vimasm_demo/welcome.asm <<'ASM'
 org 100h

section .data
    line1 db 0Dh, 0Ah, '__     ___              _                  $'
    line2 db 0Dh, 0Ah, '\ \   / (_)_ __ ___    / \   ___ _ __ ___  $'
    line3 db 0Dh, 0Ah, ' \ \ / /| | ,_ ` _ \  / _ \ / __| ,_ ` _ \ $'
    line4 db 0Dh, 0Ah, '  \ V / | | | | | | |/ ___ \\__ \ | | | | |$'
    line5 db 0Dh, 0Ah, '   \_/  |_|_| |_| |_/_/   \_\___/_| |_| |_|$'
    line6 db 0Dh, 0Ah, '$'
    
    contact db 'Contact: rizvihuihuihui@icloud.com$'
    github  db 'www.github.com/sanecodeguy/vimasm$'
    cmds    db 0Dh, 0Ah, 'Run inside Neovim:', 0Dh, 0Ah, ':Nc   (Compile + Run)', 0Dh, 0Ah, ':Nd   (Compile + Debug)$'

section .text
mov ax, 0x0003  ; Set 80x25 text mode (clears screen)
    int 10h
    mov ah, 09h
    
    ; Print VimAsm ASCII art
    mov dx, line1
    int 21h
    mov dx, line2
    int 21h
    mov dx, line3
    int 21h
    mov dx, line4
    int 21h
    mov dx, line5
    int 21h
    mov dx, line6
    int 21h
    
    ; Print contact info
    mov dx, contact
    int 21h
    
    ; Print github link
    mov dx, github
    int 21h
    
    ; Print commands
    mov dx, cmds
    int 21h
    
    ; Wait for key press
    mov ah, 00h
    int 16h
    
    ; Exit to DOS
    mov ax, 4C00h
    int 21h
ASM

nvim -c "edit ~/vimasm_demo/welcome.asm" -c "Nc"
echo "done."

