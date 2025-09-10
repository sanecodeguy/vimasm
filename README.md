# VimAsm

Neovim assembly development environment for 8086 NASM programming with DOSBox integration.

## Features

- **:Nc** - Compile and run assembly code
- **:Nd** - Compile and debug with AFD debugger  
- Auto NASM syntax highlighting
- DOSBox configuration optimized for assembly
- Includes AFD (Assembly File Debugger)

## Quick Start

```bash
# Run the installer
chmod +x install_vimasm.sh
./install_vimasm.sh

.Open any .asm file in Neovim and use:

    :Nc to compile and run

    :Nd to compile and debug with AFD
```
##Requirements

    Neovim

    NASM (assembler)

    DOSBox (DOS emulator)

    wget, unzip

##Installation Details

The installer:

    Checks for root privileges (don't run as root)

    Installs required packages via pacman

    Downloads AFD debugger to /usr/local/vimasm/dos/

    Creates DOSBox configuration at ~/.dosbox/dosbox-vimasm.conf

    Sets up Neovim plugin in ~/.config/nvim/lua/vimasm/init.lua

    Creates demo file at ~/vimasm_demo/welcome.asm

##File Structure

```
/usr/local/vimasm/
└── dos/
    └── AFD.EXE                 # Assembly debugger

~/.config/nvim/
└── lua/
    └── vimasm/
        └── init.lua            # Neovim plugin

~/.dosbox/
└── dosbox-vimasm.conf          # DOSBox configuration

~/vimasm_demo/
└── welcome.asm                 # Example assembly program
```
##Usage
```
    Create or open an .asm file:
    bash

    nvim hello.asm

    Write your assembly code using NASM syntax

    Compile and run:


:Nc

Compile and debug with AFD:
text

:Nd

Neovim Commands
Command	Description
:Nc	Compile + Run in DOSBox
:Nd	Compile + Debug with AFD
Configuration

The DOSBox config (~/.dosbox/dosbox-vimasm.conf) automatically:

    Mounts /usr/local/vimasm as C: drive

    Sets up PATH environment

    Configures prompt

Example

Try the included demo:
bash

nvim ~/vimasm_demo/welcome.asm
:Nc

Troubleshooting

    Permission denied: Don't run installer as root

    Missing packages: Ensure pacman has internet access

    DOSBox errors: Check ~/.dosbox/dosbox-vimasm.conf exists

Uninstall

Remove the installed files:
bash

sudo rm -rf /usr/local/vimasm
rm -rf ~/.config/nvim/lua/vimasm
rm -f ~/.dosbox/dosbox-vimasm.conf
rm -rf ~/vimasm_demo

Credits

Created by Syed Ali Rizvi
Contact: rizvihuihuihui@icloud.com
GitHub: https://github.com/sanecodeguy/vimasm
License

MIT License - feel free to modify and distribute.
text


