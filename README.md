# EDA Toolchain Install Scripts (Fedora)

Shell scripts to build and install a basic open-source analog/digital IC design
toolchain from source on Fedora: **xschem**, **magic**, **ngspice**, and
**gaw** (xschem-gaw). Each script installs its own build dependencies via
`dnf`, clones the upstream repo, builds it, and installs it system-wide.

## Scripts

| Script               | Installs                                      |
|----------------------|------------------------------------------------|
| `install_xschem.sh`  | [xschem](https://github.com/StefanSchippers/xschem) — schematic capture / netlisting |
| `install_magic.sh`   | [magic](https://github.com/RTimothyEdwards/magic) — VLSI layout tool |
| `install_ngspice.sh` | [ngspice](https://github.com/ngspice/ngspice) — mixed-signal circuit simulator |
| `install_gaw.sh`     | [xschem-gaw](https://github.com/StefanSchippers/xschem-gaw) — waveform viewer |

## Requirements

- Fedora (tested on Fedora 42)
- `sudo` access (the scripts install packages and run `make install`)
- Internet access to GitHub and the Fedora package repos

## Usage

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

- **xschem**: Fedora 42+ ships Tcl/Tk 9.0 as the default `tcl`/`tk`, while
  xschem's Makefile links against the Tcl/Tk 8.6 ABI. The script installs the
  `tcl8-devel`/`tk8-devel` compat headers so the headers and linked library
  match, avoiding `undefined reference to Tcl_GetBool` link errors.
- **magic**: Modern GCC (14+) treats old K&R-style function declarations and
  incompatible-pointer-type assignments as hard errors instead of warnings.
  The script builds with `-std=gnu17 -Wno-error=incompatible-pointer-types`
  to restore the old, more permissive behavior for this older codebase.
- **gaw**: Hits the same incompatible-pointer-types issue as magic (GTK's
  `gtk_builder_get_object()` returns a generic `GObject*` that older code
  assigns without a cast). Same `-Wno-error` workaround is applied.

Re-running a script is safe: if the repo directory already exists, the
script runs `git pull` instead of failing on a duplicate `git clone`.

## Alternative: install from Fedora's repos

All four tools are also packaged directly in Fedora, if you'd rather skip
building from source and don't need the latest upstream version, note that xschem 
at least won't be install as it's latest version:

```bash
sudo dnf install xschem magic ngspice
```
(`gaw` may not be packaged — check with `dnf search gaw` first, or try
RPM Fusion.)

Building from source is mainly worth it if you want the newest features/
fixes, or need a version that matches a specific PDK's requirements.

## Troubleshooting

If a build still fails after running these scripts, paste the exact error
output — these fixes cover the issues seen so far, but upstream code changes
over time and new compiler versions can surface new incompatibilities.
