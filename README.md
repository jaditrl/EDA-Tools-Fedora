# EDA Toolchain Install Scripts (Fedora)

Shell scripts to build and install a basic open-source analog/digital IC design
toolchain from source on Fedora including: **xschem**, **magic** and **ngspice**. 
Each script installs its own build dependencies via`dnf`, clones the upstream repo, 
builds it, and installs it system-wide.

## Scripts

| Script               | Installs                                       |
|----------------------|------------------------------------------------|
| `xschem.sh`  | [xschem](https://github.com/StefanSchippers/xschem) — schematic capture / netlisting |
| `magic.sh`   | [magic](https://github.com/RTimothyEdwards/magic) — VLSI layout tool                 |
| `ngspice.sh` | [ngspice](https://github.com/ngspice/ngspice) — mixed-signal circuit simulator       |

## Requirements

- Fedora (tested on Fedora 44)
- `sudo` access (the scripts install packages and run `make install`)
- Internet access to GitHub and the Fedora package repos and `git`

## Usage
Install `git` and `make`

```bash
sudo dnf install git make
```
Make a script executable and run it:

```bash
chmod +x install_xschem.sh
./install_xschem.sh
```

Repeat for whichever tools you need. There's no strict order required, but a
typical setup installs `magic` and `xschem` before pulling in a PDK (e.g.
sky130 via `open_pdks`), since PDK generation often invokes `magic` directly.

Each script is self-contained — run only the ones you need.

## Notes and known fixes

These scripts bake in fixes for a few build issues encountered on current
Fedora releases (GCC 14/15, Tcl/Tk 9.0 as default):

- **xschem**: Fedora 44+ ships Tcl/Tk 9.0 as the default `tcl`/`tk`, while
  xschem's Makefile links against the Tcl/Tk 8.6 ABI. The script installs the
  `tcl8-devel`/`tk8-devel` compat headers so the headers and linked library
  match, avoiding `undefined reference to Tcl_GetBool` link errors.
- **magic**: Modern GCC (14+) treats old K&R-style function declarations and
  incompatible-pointer-type assignments as hard errors instead of warnings.
  The script builds with `-std=gnu17 -Wno-error=incompatible-pointer-types`
  to restore the old, more permissive behavior for this older codebase.

Re-running a script is safe: if the repo directory already exists, the
script runs `git pull` instead of failing on a duplicate `git clone`.

## Alternative: install from Fedora's repos

All three tools are also packaged directly in Fedora, if you'd rather skip
building from source and don't need the latest upstream version, note that through 
this method you will not be able to update to the latest of version of xschem:

```bash
sudo dnf install xschem magic ngspice
```

Building from source is mainly worth it if you want the newest features/
fixes, or need a version that matches a specific PDK's requirements.

