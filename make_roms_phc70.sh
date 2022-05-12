# this script generates a japanesse version of msx2+ and an international one
# to be compatible with games, is a test with only int. keys with jap for the rest
# ¿included changes for fmpac and RAM on 3-0 sanyo PHC-70FD bios?.
#!/bin/bash

SYSTEM_ROMS_DIR=systemroms
CBIOS_ROMS_DIR=cbios-0.29a/roms
# set PATCH_KEYS to 1 to patch the keyboard in Japanese MSX2/MSX2+ ROMs
# to match the international keyboard layout
PATCH_KEYS=1
PATCH_BACKSLASH=0
PATCH_VERSION=0

# Create MSX2+ BIOS Jap + MSX2+ BIOS Int NTSC image

# copy MSX2+ NTSC ROMs
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_basic-bios2p.rom > omega_msx2+_fmm_ntsc.bin #32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_msx2psub.rom >> omega_msx2+_fmm_ntsc.bin #16k
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_kanjibasic.rom >> omega_msx2+_fmm_ntsc.bin #32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
#cat ${SYSTEM_ROMS_DIR}/phc-70fd2_disk.rom >> omega_msx2+_fmm_ntsc.bin #16k
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
dd if=/dev/zero ibs=1k count=48 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> omega_msx2+_fmm_ntsc.bin #16k
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_basickun.rom >> omega_msx2+_fmm_ntsc.bin #16k
#dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
# patch the keys
if [ "$PATCH_KEYS" -eq "1" ]; then
  dd if=int_keys_patch.bin of=omega_msx2+_fmm_ntsc.bin bs=1 seek=3529 conv=notrunc
fi
# patch the backslash
if [ "$PATCH_BACKSLASH" -eq "1" ]; then
  dd if=backslash_patch.bin of=omega_msx2+_fmm_ntsc.bin bs=1 seek=7839 conv=notrunc
fi

# high part with all international mods
PATCH_KEYS=1
PATCH_BACKSLASH=1
PATCH_VERSION=1

# copy the second set of MSX2 NTSC ROMs
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_basic-bios2p.rom >> omega_msx2+_fmm_ntsc.bin
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_msx2psub.rom >> omega_msx2+_fmm_ntsc.bin #16k
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_kanjibasic.rom >> omega_msx2+_fmm_ntsc.bin #32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
#cat ${SYSTEM_ROMS_DIR}/phc-70fd2_disk.rom >> omega_msx2+_fmm_ntsc.bin #16k
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
dd if=/dev/zero ibs=1k count=48 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> omega_msx2+_fmm_ntsc.bin #16k
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_basickun.rom >> omega_msx2+_fmm_ntsc.bin #16k
#dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> omega_msx2+_fmm_ntsc.bin
# patch the keys
if [ "$PATCH_KEYS" -eq "1" ]; then
  dd if=int_keys_patch.bin of=omega_msx2+_fmm_ntsc.bin bs=1 seek=265673 conv=notrunc
fi
# patch the backslash
if [ "$PATCH_BACKSLASH" -eq "1" ]; then
  dd if=backslash_patch.bin of=omega_msx2+_fmm_ntsc.bin bs=1 seek=269983 conv=notrunc
fi
# patch the BASIC ROM version
if [ "$PATCH_VERSION" -eq "1" ]; then
  dd if=rom_version_patch.bin of=omega_msx2+_fmm_ntsc.bin bs=1 seek=262187 conv=notrunc
fi
