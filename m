From: Lars Doelle <lars.doelle@on-line.de>
Date: Thu, 10 Jun 2010 14:01:30 +0000
Subject: REGRESSION: dpms-on broken (drm_radeon,displayport)
Message-Id: <201006101601.30483.lars.doelle@on-line.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_6APEMx9TFBmmVpW"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org

--Boundary-00=_6APEMx9TFBmmVpW
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Benjamin,
Hi All,


i write to report a regression that happened after 2.6.34-rc3 and before
or including 2.6.34-rc4 and still persists on 2.6.35-rc2.

The effect is, that after DPMS-OFF, the monitor cannot be reactivated
locally by a key press or remotely via `xset dpms force on=B4.

I can work around the issue switching the monitor off and on again.

=46or the technical details of the local environment see below.
I can provide more information on request and offer help testing patches.



Kind regards

  Lars


=2D-------------------------------


=2D config.gz attached, below some lines.

CONFIG_X86_64=3Dy

CONFIG_DRM=3Dy
CONFIG_DRM_KMS_HELPER=3Dy
CONFIG_DRM_TTM=3Dy
CONFIG_DRM_RADEON=3Dy
CONFIG_DRM_RADEON_KMS=3Dy
CONFIG_VIDEO_OUTPUT_CONTROL=3Dy


=2D X11: find attached the Xorg.0.log for full information

X.Org X Server 1.7.7
Release Date: 2010-05-04
[..]
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "DELL 2408WFP"
(**) |   |-->Device "ATI FireMV 2260"
[..]
(II) RADEON(0): Output DisplayPort-0 using monitor section DELL 2408WFP
[..]
(**) RADEON(0): DPMS enabled


=2D Notes from the kernel.log

following messages occur only >=3D 2.6.34-rc4. I think they are issued
when i `xset dpms force off=B4 or dpms is used automatically.

=2E..

: [drm:dp_link_train] *ERROR* clock recovery tried 5 times
: [drm:dp_link_train] *ERROR* clock recovery failed
: [drm:dp_link_train] *ERROR* channel eq failed: 5 tries
: [drm:dp_link_train] *ERROR* channel eq failed

=2E..

The following messages might be unrelated to the problem and occur
on 2.6.34-rc3 too, when i switch the monitor off/on.

: [drm:atom_dp_get_link_status] *ERROR* displayport link status failed
: [drm:atom_dp_get_link_status] *ERROR* displayport link status failed
: [drm:atom_dp_get_link_status] *ERROR* displayport link status failed

Below stuff from the initiation ...

=2E..

: [drm] Initialized drm 1.1.0 20060810
: [drm] radeon defaulting to kernel modesetting.
: [drm] radeon kernel modesetting enabled.
: radeon 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
: radeon 0000:01:00.0: setting latency timer to 64
: [drm] radeon: Initializing kernel modesetting.
: [drm] register mmio base: 0x90200000
: [drm] register mmio size: 65536
: ATOM BIOS: 113
: [drm] Clocks initialized !
: [drm] Internal thermal controller with fan control
: [drm] 3 Power State(s)
: [drm] State 0 Default (default)
: [drm] 	16 PCIE Lanes
: [drm] 	3 Clock Mode(s)
: [drm] 		0 engine/memory: 500000/500000
: [drm] 		1 engine/memory: 500000/500000
: [drm] 		2 engine/memory: 500000/500000
: [drm] State 1 Performance=20
: [drm] 	16 PCIE Lanes
: [drm] 	3 Clock Mode(s)
: [drm] 		0 engine/memory: 110000/252000
: [drm] 		1 engine/memory: 300000/396000
: [drm] 		2 engine/memory: 500000/500000
: [drm] State 2 Performance=20
: [drm] 	16 PCIE Lanes
: [drm] 	3 Clock Mode(s)
: [drm] 		0 engine/memory: 450000/500000
: [drm] 		1 engine/memory: 450000/500000
: [drm] 		2 engine/memory: 500000/500000
: [drm] radeon: power management initialized
: radeon 0000:01:00.0: VRAM: 256M 0x00000000 - 0x0FFFFFFF (256M used)
: radeon 0000:01:00.0: GTT: 512M 0x10000000 - 0x2FFFFFFF
: [drm] Detected VRAM RAM=3D256M, BAR=3D256M
: [drm] RAM width 64bits DDR
: Available graphics memory: 1017548 kiB.
: [drm] radeon: 256M of VRAM memory ready
: [drm] radeon: 512M of GTT memory ready.
: radeon 0000:01:00.0: irq 30 for MSI/MSI-X
: [drm] radeon: using MSI.
: [drm] radeon: irq initialized.
: [drm] GART: num cpu pages 131072, num gpu pages 131072
: [drm] Loading RV620 Microcode
: platform radeon_cp.0: firmware: using built-in firmware radeon/RV620_pfp.=
bin
: platform radeon_cp.0: firmware: using built-in firmware radeon/RV620_me.b=
in
: platform radeon_cp.0: firmware: using built-in firmware radeon/R600_rlc.b=
in
: [drm] ring test succeeded in 1 usecs
: [drm] radeon: ib pool ready.
: [drm] ib test succeeded in 0 usecs
: [drm] Enabling audio support
: [drm] Radeon Display Connectors
: [drm] Connector 0:
: [drm]   DisplayPort
: [drm]   HPD2
: [drm]   DDC: 0x7e60 0x7e60 0x7e64 0x7e64 0x7e68 0x7e68 0x7e6c 0x7e6c
: [drm]   Encoders:
: [drm]     DFP1: INTERNAL_UNIPHY
: [drm] Connector 1:
: [drm]   DisplayPort
: [drm]   HPD4
: [drm]   DDC: 0x7e20 0x7e20 0x7e24 0x7e24 0x7e28 0x7e28 0x7e2c 0x7e2c
: [drm]   Encoders:
: [drm]     DFP2: INTERNAL_UNIPHY
: [drm] fb mappable at 0x80141000
: [drm] vram apper at 0x80000000
: [drm] size 9216000
: [drm] fb depth is 24
: [drm]    pitch is 7680
: Console: switching to colour frame buffer device 240x75
: fb0: radeondrmfb frame buffer device
: registered panic notifier
: [drm] Initialized radeon 2.2.0 20080528 for 0000:01:00.0 on minor 0

--Boundary-00=_6APEMx9TFBmmVpW
Content-Type: text/x-log;
  charset="UTF-8";
  name="Xorg.0.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Xorg.0.log"


X.Org X Server 1.7.7
Release Date: 2010-05-04
X Protocol Version 11, Revision 0
Build Operating System: Linux 2.6.32-5-amd64 x86_64 Debian
Current Operating System: Linux x64.localnet 2.6.34-rc3 #3 SMP PREEMPT Thu Apr 1 13:55:40 UTC 2010 x86_64
Kernel command line: BOOT_IMAGE=2.6.34-rc3 ro root=801 rootdelay=2
Build Date: 03 June 2010  03:01:44PM
xorg-server 2:1.7.7-2 (Julien Cristau <jcristau@debian.org>) 
Current version of pixman: 0.16.4
	Before reporting problems, check http://wiki.x.org
	to make sure that you have the latest version.
Markers: (--) probed, (**) from config file, (==) default setting,
	(++) from command line, (!!) notice, (II) informational,
	(WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/Xorg.0.log", Time: Thu Jun 10 14:44:56 2010
(==) Using config file: "/etc/X11/xorg.conf"
(==) Using system config directory "/usr/share/X11/xorg.conf.d"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "DELL 2408WFP"
(**) |   |-->Device "ATI FireMV 2260"
(**) |-->Input Device "Generic Keyboard"
(**) |-->Input Device "Configured Mouse"
(**) Option "DontZap" "off"
(**) Option "AllowEmptyInput" "false"
(==) Automatically adding devices
(==) Automatically enabling devices
(WW) `fonts.dir' not found (or not valid) in "/usr/local/share/fonts".
	Entry deleted from font path.
	(Run 'mkfontdir' on "/usr/local/share/fonts").
(WW) The directory "/usr/share/fonts/X11/cyrillic" does not exist.
	Entry deleted from font path.
(**) FontPath set to:
	/usr/share/fonts/X11/misc,
	/usr/share/fonts/X11/100dpi:unscaled,
	/usr/share/fonts/X11/75dpi:unscaled,
	/usr/share/fonts/X11/Type1,
	/var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType,
	/usr/share/fonts/X11/misc,
	/usr/share/fonts/X11/100dpi/:unscaled,
	/usr/share/fonts/X11/75dpi/:unscaled,
	/usr/share/fonts/X11/Type1,
	/usr/share/fonts/X11/100dpi,
	/usr/share/fonts/X11/75dpi,
	/var/lib/defoma/x-ttcidfont-conf.d/dirs/TrueType,
	built-ins
(==) ModulePath set to "/usr/lib/xorg/modules"
(II) Loader magic: 0x7c5e80
(II) Module ABI versions:
	X.Org ANSI C Emulation: 0.4
	X.Org Video Driver: 6.0
	X.Org XInput driver : 7.0
	X.Org Server Extension : 2.0
(++) using VT number 7

(--) PCI:*(0:1:0:0) 1002:95cf:1002:2143 ATI Technologies Inc RV620 [FirePro 2260] rev 0, Mem @ 0x80000000/268435456, 0x90200000/65536, I/O @ 0x00002000/256, BIOS @ 0x????????/131072
(II) Open ACPI successful (/var/run/acpid.socket)
(II) LoadModule: "extmod"
(II) Loading /usr/lib/xorg/modules/extensions/libextmod.so
(II) Module extmod: vendor="X.Org Foundation"
	compiled for 1.7.7, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 2.0
(II) Loading extension SELinux
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "dbe"
(II) Loading /usr/lib/xorg/modules/extensions/libdbe.so
(II) Module dbe: vendor="X.Org Foundation"
	compiled for 1.7.7, module version = 1.0.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 2.0
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "glx"
(II) Loading /usr/lib/xorg/modules/extensions/libglx.so
(II) Module glx: vendor="X.Org Foundation"
	compiled for 1.7.7, module version = 1.0.0
	ABI class: X.Org Server Extension, version 2.0
(==) AIGLX enabled
(II) Loading extension GLX
(II) LoadModule: "record"
(II) Loading /usr/lib/xorg/modules/extensions/librecord.so
(II) Module record: vendor="X.Org Foundation"
	compiled for 1.7.7, module version = 1.13.0
	Module class: X.Org Server Extension
	ABI class: X.Org Server Extension, version 2.0
(II) Loading extension RECORD
(II) LoadModule: "dri"
(II) Loading /usr/lib/xorg/modules/extensions/libdri.so
(II) Module dri: vendor="X.Org Foundation"
	compiled for 1.7.7, module version = 1.0.0
	ABI class: X.Org Server Extension, version 2.0
(II) Loading extension XFree86-DRI
(II) LoadModule: "dri2"
(II) Loading /usr/lib/xorg/modules/extensions/libdri2.so
(II) Module dri2: vendor="X.Org Foundation"
	compiled for 1.7.7, module version = 1.1.0
	ABI class: X.Org Server Extension, version 2.0
(II) Loading extension DRI2
(II) LoadModule: "radeon"
(II) Loading /usr/lib/xorg/modules/drivers/radeon_drv.so
(II) Module radeon: vendor="X.Org Foundation"
	compiled for 1.7.7, module version = 6.13.0
	Module class: X.Org Video Driver
	ABI class: X.Org Video Driver, version 6.0
(II) LoadModule: "kbd"
(II) Loading /usr/lib/xorg/modules/input/kbd_drv.so
(II) Module kbd: vendor="X.Org Foundation"
	compiled for 1.7.7, module version = 1.4.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 7.0
(II) LoadModule: "mouse"
(II) Loading /usr/lib/xorg/modules/input/mouse_drv.so
(II) Module mouse: vendor="X.Org Foundation"
	compiled for 1.7.7, module version = 1.5.0
	Module class: X.Org XInput Driver
	ABI class: X.Org XInput driver, version 7.0
(II) RADEON: Driver for ATI Radeon chipsets:
	ATI Radeon Mobility X600 (M24) 3150 (PCIE), ATI FireMV 2400 (PCI),
	ATI Radeon Mobility X300 (M24) 3152 (PCIE),
	ATI FireGL M24 GL 3154 (PCIE), ATI Radeon X600 (RV380) 3E50 (PCIE),
	ATI FireGL V3200 (RV380) 3E54 (PCIE), ATI Radeon IGP320 (A3) 4136,
	ATI Radeon IGP330/340/350 (A4) 4137, ATI Radeon 9500 AD (AGP),
	ATI Radeon 9500 AE (AGP), ATI Radeon 9600TX AF (AGP),
	ATI FireGL Z1 AG (AGP), ATI Radeon 9800SE AH (AGP),
	ATI Radeon 9800 AI (AGP), ATI Radeon 9800 AJ (AGP),
	ATI FireGL X2 AK (AGP), ATI Radeon 9600 AP (AGP),
	ATI Radeon 9600SE AQ (AGP), ATI Radeon 9600XT AR (AGP),
	ATI Radeon 9600 AS (AGP), ATI FireGL T2 AT (AGP), ATI Radeon 9650,
	ATI FireGL RV360 AV (AGP), ATI Radeon 7000 IGP (A4+) 4237,
	ATI Radeon 8500 AIW BB (AGP), ATI Radeon 8500 AIW BC (AGP),
	ATI Radeon IGP320M (U1) 4336, ATI Radeon IGP330M/340M/350M (U2) 4337,
	ATI Radeon Mobility 7000 IGP 4437, ATI Radeon 9000/PRO If (AGP/PCI),
	ATI Radeon 9000 Ig (AGP/PCI), ATI Radeon X800 (R420) JH (AGP),
	ATI Radeon X800PRO (R420) JI (AGP),
	ATI Radeon X800SE (R420) JJ (AGP), ATI Radeon X800 (R420) JK (AGP),
	ATI Radeon X800 (R420) JL (AGP), ATI FireGL X3 (R420) JM (AGP),
	ATI Radeon Mobility 9800 (M18) JN (AGP),
	ATI Radeon X800 SE (R420) (AGP), ATI Radeon X800XT (R420) JP (AGP),
	ATI Radeon X800 VE (R420) JT (AGP), ATI Radeon X850 (R480) (AGP),
	ATI Radeon X850 XT (R480) (AGP), ATI Radeon X850 SE (R480) (AGP),
	ATI Radeon X850 PRO (R480) (AGP), ATI Radeon X850 XT PE (R480) (AGP),
	ATI Radeon Mobility M7 LW (AGP),
	ATI Mobility FireGL 7800 M7 LX (AGP),
	ATI Radeon Mobility M6 LY (AGP), ATI Radeon Mobility M6 LZ (AGP),
	ATI FireGL Mobility 9000 (M9) Ld (AGP),
	ATI Radeon Mobility 9000 (M9) Lf (AGP),
	ATI Radeon Mobility 9000 (M9) Lg (AGP), ATI Radeon 9700 Pro ND (AGP),
	ATI Radeon 9700/9500Pro NE (AGP), ATI Radeon 9600TX NF (AGP),
	ATI FireGL X1 NG (AGP), ATI Radeon 9800PRO NH (AGP),
	ATI Radeon 9800 NI (AGP), ATI FireGL X2 NK (AGP),
	ATI Radeon 9800XT NJ (AGP),
	ATI Radeon Mobility 9600/9700 (M10/M11) NP (AGP),
	ATI Radeon Mobility 9600 (M10) NQ (AGP),
	ATI Radeon Mobility 9600 (M11) NR (AGP),
	ATI Radeon Mobility 9600 (M10) NS (AGP),
	ATI FireGL Mobility T2 (M10) NT (AGP),
	ATI FireGL Mobility T2e (M11) NV (AGP), ATI Radeon QD (AGP),
	ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP),
	ATI FireGL 8700/8800 QH (AGP), ATI Radeon 8500 QL (AGP),
	ATI Radeon 9100 QM (AGP), ATI Radeon 7500 QW (AGP/PCI),
	ATI Radeon 7500 QX (AGP/PCI), ATI Radeon VE/7000 QY (AGP/PCI),
	ATI Radeon VE/7000 QZ (AGP/PCI), ATI ES1000 515E (PCI),
	ATI Radeon Mobility X300 (M22) 5460 (PCIE),
	ATI Radeon Mobility X600 SE (M24C) 5462 (PCIE),
	ATI FireGL M22 GL 5464 (PCIE), ATI Radeon X800 (R423) UH (PCIE),
	ATI Radeon X800PRO (R423) UI (PCIE),
	ATI Radeon X800LE (R423) UJ (PCIE),
	ATI Radeon X800SE (R423) UK (PCIE),
	ATI Radeon X800 XTP (R430) (PCIE), ATI Radeon X800 XL (R430) (PCIE),
	ATI Radeon X800 SE (R430) (PCIE), ATI Radeon X800 (R430) (PCIE),
	ATI FireGL V7100 (R423) (PCIE), ATI FireGL V5100 (R423) UQ (PCIE),
	ATI FireGL unknown (R423) UR (PCIE),
	ATI FireGL unknown (R423) UT (PCIE),
	ATI Mobility FireGL V5000 (M26) (PCIE),
	ATI Mobility FireGL V5000 (M26) (PCIE),
	ATI Mobility Radeon X700 XL (M26) (PCIE),
	ATI Mobility Radeon X700 (M26) (PCIE),
	ATI Mobility Radeon X700 (M26) (PCIE),
	ATI Radeon X550XTX 5657 (PCIE), ATI Radeon 9100 IGP (A5) 5834,
	ATI Radeon Mobility 9100 IGP (U3) 5835,
	ATI Radeon XPRESS 200 5954 (PCIE),
	ATI Radeon XPRESS 200M 5955 (PCIE), ATI Radeon 9250 5960 (AGP),
	ATI Radeon 9200 5961 (AGP), ATI Radeon 9200 5962 (AGP),
	ATI Radeon 9200SE 5964 (AGP), ATI FireMV 2200 (PCI),
	ATI ES1000 5969 (PCI), ATI Radeon XPRESS 200 5974 (PCIE),
	ATI Radeon XPRESS 200M 5975 (PCIE),
	ATI Radeon XPRESS 200 5A41 (PCIE),
	ATI Radeon XPRESS 200M 5A42 (PCIE),
	ATI Radeon XPRESS 200 5A61 (PCIE),
	ATI Radeon XPRESS 200M 5A62 (PCIE),
	ATI Radeon X300 (RV370) 5B60 (PCIE),
	ATI Radeon X600 (RV370) 5B62 (PCIE),
	ATI Radeon X550 (RV370) 5B63 (PCIE),
	ATI FireGL V3100 (RV370) 5B64 (PCIE),
	ATI FireMV 2200 PCIE (RV370) 5B65 (PCIE),
	ATI Radeon Mobility 9200 (M9+) 5C61 (AGP),
	ATI Radeon Mobility 9200 (M9+) 5C63 (AGP),
	ATI Mobility Radeon X800 XT (M28) (PCIE),
	ATI Mobility FireGL V5100 (M28) (PCIE),
	ATI Mobility Radeon X800 (M28) (PCIE), ATI Radeon X850 5D4C (PCIE),
	ATI Radeon X850 XT PE (R480) (PCIE),
	ATI Radeon X850 SE (R480) (PCIE), ATI Radeon X850 PRO (R480) (PCIE),
	ATI unknown Radeon / FireGL (R480) 5D50 (PCIE),
	ATI Radeon X850 XT (R480) (PCIE),
	ATI Radeon X800XT (R423) 5D57 (PCIE),
	ATI FireGL V5000 (RV410) (PCIE), ATI Radeon X700 XT (RV410) (PCIE),
	ATI Radeon X700 PRO (RV410) (PCIE),
	ATI Radeon X700 SE (RV410) (PCIE), ATI Radeon X700 (RV410) (PCIE),
	ATI Radeon X700 SE (RV410) (PCIE), ATI Radeon X1800,
	ATI Mobility Radeon X1800 XT, ATI Mobility Radeon X1800,
	ATI Mobility FireGL V7200, ATI FireGL V7200, ATI FireGL V5300,
	ATI Mobility FireGL V7100, ATI Radeon X1800, ATI Radeon X1800,
	ATI Radeon X1800, ATI Radeon X1800, ATI Radeon X1800,
	ATI FireGL V7300, ATI FireGL V7350, ATI Radeon X1600, ATI RV505,
	ATI Radeon X1300/X1550, ATI Radeon X1550, ATI M54-GL,
	ATI Mobility Radeon X1400, ATI Radeon X1300/X1550,
	ATI Radeon X1550 64-bit, ATI Mobility Radeon X1300,
	ATI Mobility Radeon X1300, ATI Mobility Radeon X1300,
	ATI Mobility Radeon X1300, ATI Radeon X1300, ATI Radeon X1300,
	ATI RV505, ATI RV505, ATI FireGL V3300, ATI FireGL V3350,
	ATI Radeon X1300, ATI Radeon X1550 64-bit, ATI Radeon X1300/X1550,
	ATI Radeon X1600, ATI Radeon X1300/X1550, ATI Mobility Radeon X1450,
	ATI Radeon X1300/X1550, ATI Mobility Radeon X2300,
	ATI Mobility Radeon X2300, ATI Mobility Radeon X1350,
	ATI Mobility Radeon X1350, ATI Mobility Radeon X1450,
	ATI Radeon X1300, ATI Radeon X1550, ATI Mobility Radeon X1350,
	ATI FireMV 2250, ATI Radeon X1550 64-bit, ATI Radeon X1600,
	ATI Radeon X1650, ATI Radeon X1600, ATI Radeon X1600,
	ATI Mobility FireGL V5200, ATI Mobility Radeon X1600,
	ATI Radeon X1650, ATI Radeon X1650, ATI Radeon X1600,
	ATI Radeon X1300 XT/X1600 Pro, ATI FireGL V3400,
	ATI Mobility FireGL V5250, ATI Mobility Radeon X1700,
	ATI Mobility Radeon X1700 XT, ATI FireGL V5200,
	ATI Mobility Radeon X1700, ATI Radeon X2300HD,
	ATI Mobility Radeon HD 2300, ATI Mobility Radeon HD 2300,
	ATI Radeon X1950, ATI Radeon X1900, ATI Radeon X1950,
	ATI Radeon X1900, ATI Radeon X1900, ATI Radeon X1900,
	ATI Radeon X1900, ATI Radeon X1900, ATI Radeon X1900,
	ATI Radeon X1900, ATI Radeon X1900, ATI Radeon X1900,
	ATI AMD Stream Processor, ATI Radeon X1900, ATI Radeon X1950,
	ATI RV560, ATI RV560, ATI Mobility Radeon X1900, ATI RV560,
	ATI Radeon X1950 GT, ATI RV570, ATI RV570, ATI FireGL V7400,
	ATI RV560, ATI Radeon X1650, ATI Radeon X1650, ATI RV560,
	ATI Radeon 9100 PRO IGP 7834, ATI Radeon Mobility 9200 IGP 7835,
	ATI Radeon X1200, ATI Radeon X1200, ATI Radeon X1200,
	ATI Radeon X1200, ATI Radeon X1200, ATI RS740, ATI RS740M, ATI RS740,
	ATI RS740M, ATI Radeon HD 2900 XT, ATI Radeon HD 2900 XT,
	ATI Radeon HD 2900 XT, ATI Radeon HD 2900 Pro, ATI Radeon HD 2900 GT,
	ATI FireGL V8650, ATI FireGL V8600, ATI FireGL V7600,
	ATI Radeon 4800 Series, ATI Radeon HD 4870 x2,
	ATI Radeon 4800 Series, ATI Radeon HD 4850 x2,
	ATI FirePro V8750 (FireGL), ATI FirePro V7760 (FireGL),
	ATI Mobility RADEON HD 4850, ATI Mobility RADEON HD 4850 X2,
	ATI Radeon 4800 Series, ATI FirePro RV770, AMD FireStream 9270,
	AMD FireStream 9250, ATI FirePro V8700 (FireGL),
	ATI Mobility RADEON HD 4870, ATI Mobility RADEON M98,
	ATI Radeon 4800 Series, ATI Radeon 4800 Series, ATI FirePro M7750,
	ATI M98, ATI M98, ATI M98, ATI Mobility Radeon HD 4650,
	ATI Radeon RV730 (AGP), ATI Mobility Radeon HD 4670,
	ATI FirePro M5750, ATI Radeon RV730 (AGP),
	ATI RV730XT [Radeon HD 4670], ATI RADEON E4600,
	ATI Radeon HD 4600 Series, ATI RV730 PRO [Radeon HD 4650],
	ATI FirePro V7750 (FireGL), ATI FirePro V5700 (FireGL),
	ATI FirePro V3750 (FireGL), ATI Mobility Radeon HD 4830,
	ATI Mobility Radeon HD 4850, ATI FirePro M7740, ATI RV740,
	ATI Radeon HD 4770, ATI Radeon HD 4700 Series, ATI Radeon HD 4770,
	ATI FirePro M5750, ATI RV610, ATI Radeon HD 2400 XT,
	ATI Radeon HD 2400 Pro, ATI Radeon HD 2400 PRO AGP, ATI FireGL V4000,
	ATI RV610, ATI Radeon HD 2350, ATI Mobility Radeon HD 2400 XT,
	ATI Mobility Radeon HD 2400, ATI RADEON E2400, ATI RV610,
	ATI FireMV 2260, ATI RV670, ATI Radeon HD3870,
	ATI Mobility Radeon HD 3850, ATI Radeon HD3850,
	ATI Mobility Radeon HD 3850 X2, ATI RV670,
	ATI Mobility Radeon HD 3870, ATI Mobility Radeon HD 3870 X2,
	ATI Radeon HD3870 X2, ATI FireGL V7700, ATI Radeon HD3850,
	ATI Radeon HD3690, AMD Firestream 9170, ATI Radeon HD 4550,
	ATI Radeon RV710, ATI Radeon RV710, ATI Radeon HD 4350,
	ATI Mobility Radeon 4300 Series, ATI Mobility Radeon 4500 Series,
	ATI Mobility Radeon 4500 Series, ATI FirePro RG220, ATI RV630,
	ATI Mobility Radeon HD 2600, ATI Mobility Radeon HD 2600 XT,
	ATI Radeon HD 2600 XT AGP, ATI Radeon HD 2600 Pro AGP,
	ATI Radeon HD 2600 XT, ATI Radeon HD 2600 Pro, ATI Gemini RV630,
	ATI Gemini Mobility Radeon HD 2600 XT, ATI FireGL V5600,
	ATI FireGL V3600, ATI Radeon HD 2600 LE,
	ATI Mobility FireGL Graphics Processor, ATI Radeon RV710,
	ATI Radeon HD 3470, ATI Mobility Radeon HD 3430,
	ATI Mobility Radeon HD 3400 Series, ATI Radeon HD 3450,
	ATI Radeon HD 3450, ATI Radeon HD 3430, ATI Radeon HD 3450,
	ATI FirePro V3700, ATI FireMV 2450, ATI FireMV 2260, ATI FireMV 2260,
	ATI Radeon HD 3600 Series, ATI Radeon HD 3650 AGP,
	ATI Radeon HD 3600 PRO, ATI Radeon HD 3600 XT,
	ATI Radeon HD 3600 PRO, ATI Mobility Radeon HD 3650,
	ATI Mobility Radeon HD 3670, ATI Mobility FireGL V5700,
	ATI Mobility FireGL V5725, ATI Radeon HD 3200 Graphics,
	ATI Radeon 3100 Graphics, ATI Radeon HD 3200 Graphics,
	ATI Radeon 3100 Graphics, ATI Radeon HD 3300 Graphics,
	ATI Radeon HD 3200 Graphics, ATI Radeon 3000 Graphics,
	ATI Radeon HD 4200, ATI Radeon 4100, ATI Mobility Radeon HD 4200,
	ATI Mobility Radeon 4100, ATI Radeon HD 4290, ATI Radeon HD 4290,
	CYPRESS, ATI FirePro (FireGL) Graphics Adapter,
	ATI FirePro (FireGL) Graphics Adapter,
	ATI FirePro (FireGL) Graphics Adapter, ATI Radeon HD 5800 Series,
	ATI Radeon HD 5800 Series, ATI Radeon HD 5800 Series,
	ATI Radeon HD 5900 Series, ATI Radeon HD 5900 Series,
	ATI Mobility Radeon HD 5800 Series,
	ATI Mobility Radeon HD 5800 Series,
	ATI FirePro (FireGL) Graphics Adapter,
	ATI FirePro (FireGL) Graphics Adapter,
	ATI Mobility Radeon HD 5800 Series, ATI Radeon HD 5700 Series,
	ATI Radeon HD 5700 Series, ATI Radeon HD 5700 Series,
	ATI Mobility Radeon HD 5000 Series,
	ATI Mobility Radeon HD 5000 Series,
	ATI FirePro (FireGL) Graphics Adapter,
	ATI FirePro (FireGL) Graphics Adapter, ATI Radeon HD 5670,
	ATI Radeon HD 5570, ATI Radeon HD 5500 Series, REDWOOD,
	ATI Mobility Radeon HD 5000 Series,
	ATI Mobility Radeon HD 5000 Series, CEDAR, CEDAR, CEDAR,
	ATI FirePro (FireGL) Graphics Adapter,
	ATI FirePro (FireGL) Graphics Adapter, CEDAR, ATI Radeon HD 5450,
	CEDAR
(II) Primary Device is: PCI 01@00:00:0
(II) [KMS] Kernel modesetting enabled.
(II) RADEON(0): Creating default Display subsection in Screen section
	"Default Screen" for depth/fbbpp 24/32
(==) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(--) RADEON(0): Chipset: "ATI FireMV 2260" (ChipID = 0x95cf)
(II) RADEON(0): PCIE card detected
(WW) RADEON(0): Color tiling is not yet supported on R600/R700
(II) RADEON(0): KMS Color Tiling: disabled
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 9, (OK)
drmOpenByBusid: Searching for BusID pci:0000:01:00.0
drmOpenDevice: node name is /dev/dri/card0
drmOpenDevice: open result is 9, (OK)
drmOpenByBusid: drmOpenMinor returns 9
drmOpenByBusid: drmGetBusid reports pci:0000:01:00.0
(II) RADEON(0): Output DisplayPort-0 using monitor section DELL 2408WFP
(II) RADEON(0): Output DisplayPort-1 has no monitor section
(II) RADEON(0): EDID for output DisplayPort-0
(II) RADEON(0): EDID for output DisplayPort-1
(II) RADEON(0): Manufacturer: DEL  Model: a02b  Serial#: 810309971
(II) RADEON(0): Year: 2009  Week: 11
(II) RADEON(0): EDID Version: 1.4
(II) RADEON(0): Digital Display Input
(II) RADEON(0): 8 bits per channel
(II) RADEON(0): Digital interface is DisplayPort
(II) RADEON(0): Max Image Size [cm]: horiz.: 52  vert.: 32
(II) RADEON(0): Gamma: 2.20
(II) RADEON(0): DPMS capabilities: Off
(II) RADEON(0): Supported color encodings: RGB 4:4:4 
(II) RADEON(0): First detailed timing is preferred mode
(II) RADEON(0): Preferred mode is native pixel format and refresh rate
(II) RADEON(0): redX: 0.674 redY: 0.319   greenX: 0.188 greenY: 0.706
(II) RADEON(0): blueX: 0.148 blueY: 0.064   whiteX: 0.313 whiteY: 0.329
(II) RADEON(0): Supported established timings:
(II) RADEON(0): 720x400@70Hz
(II) RADEON(0): 640x480@60Hz
(II) RADEON(0): 640x480@75Hz
(II) RADEON(0): 800x600@60Hz
(II) RADEON(0): 800x600@75Hz
(II) RADEON(0): 1024x768@60Hz
(II) RADEON(0): 1024x768@75Hz
(II) RADEON(0): 1280x1024@75Hz
(II) RADEON(0): Manufacturer's mask: 0
(II) RADEON(0): Supported standard timings:
(II) RADEON(0): #0: hsize: 1280  vsize 1024  refresh: 60  vid: 32897
(II) RADEON(0): #1: hsize: 1600  vsize 1200  refresh: 60  vid: 16553
(II) RADEON(0): #2: hsize: 1152  vsize 864  refresh: 75  vid: 20337
(II) RADEON(0): Supported detailed timing:
(II) RADEON(0): clock: 154.0 MHz   Image Size:  519 x 320 mm
(II) RADEON(0): h_active: 1920  h_sync: 1968  h_sync_end 2000 h_blank_end 2080 h_border: 0
(II) RADEON(0): v_active: 1200  v_sync: 1203  v_sync_end 1209 v_blanking: 1235 v_border: 0
(II) RADEON(0): Serial No: G286H93C0LYS
(II) RADEON(0): Monitor name: DELL 2408WFP
(II) RADEON(0): Ranges: V min: 56 V max: 76 Hz, H min: 30 H max: 83 kHz, PixClock max 170 MHz
(II) RADEON(0): EDID (in hex):
(II) RADEON(0): 	00ffffffffffff0010ac2ba053594c30
(II) RADEON(0): 	0b130104a534207822b325ac5130b426
(II) RADEON(0): 	105054a54b008180a940714f01010101
(II) RADEON(0): 	010101010101283c80a070b023403020
(II) RADEON(0): 	360007402100001a000000ff00473238
(II) RADEON(0): 	3648393343304c59530a000000fc0044
(II) RADEON(0): 	454c4c20323430385746500a000000fd
(II) RADEON(0): 	00384c1e5311010a202020202020007c
(II) RADEON(0): Printing probed modes for output DisplayPort-1
(II) RADEON(0): Modeline "1920x1200"x60.0  154.00  1920 1968 2000 2080  1200 1203 1209 1235 +hsync -vsync (74.0 kHz)
(II) RADEON(0): Modeline "1600x1200"x60.0  162.00  1600 1664 1856 2160  1200 1201 1204 1250 +hsync +vsync (75.0 kHz)
(II) RADEON(0): Modeline "1280x1024"x75.0  135.00  1280 1296 1440 1688  1024 1025 1028 1066 +hsync +vsync (80.0 kHz)
(II) RADEON(0): Modeline "1280x1024"x60.0  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz)
(II) RADEON(0): Modeline "1152x864"x75.0  108.00  1152 1216 1344 1600  864 865 868 900 +hsync +vsync (67.5 kHz)
(II) RADEON(0): Modeline "1024x768"x75.1   78.80  1024 1040 1136 1312  768 769 772 800 +hsync +vsync (60.1 kHz)
(II) RADEON(0): Modeline "1024x768"x60.0   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync (48.4 kHz)
(II) RADEON(0): Modeline "800x600"x75.0   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync (46.9 kHz)
(II) RADEON(0): Modeline "800x600"x60.3   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync (37.9 kHz)
(II) RADEON(0): Modeline "640x480"x75.0   31.50  640 656 720 840  480 481 484 500 -hsync -vsync (37.5 kHz)
(II) RADEON(0): Modeline "640x480"x60.0   25.20  640 656 752 800  480 490 492 525 -hsync -vsync (31.5 kHz)
(II) RADEON(0): Modeline "720x400"x70.1   28.32  720 738 846 900  400 412 414 449 -hsync +vsync (31.5 kHz)
(II) RADEON(0): Output DisplayPort-0 disconnected
(II) RADEON(0): Output DisplayPort-1 connected
(II) RADEON(0): Using exact sizes for initial modes
(II) RADEON(0): Output DisplayPort-1 using initial mode 1920x1200
(II) RADEON(0): Using default gamma of (1.0, 1.0, 1.0) unless otherwise stated.
(II) RADEON(0): mem size init: gart size :1fdff000 vram size: s:10000000 visible:f6f6000
(II) RADEON(0): EXA: Driver will allow EXA pixmaps in VRAM
(==) RADEON(0): DPI set to (96, 96)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/lib/xorg/modules/libfb.so
(II) Module fb: vendor="X.Org Foundation"
	compiled for 1.7.7, module version = 1.0.0
	ABI class: X.Org ANSI C Emulation, version 0.4
(II) Loading sub module "ramdac"
(II) LoadModule: "ramdac"
(II) Module "ramdac" already built-in
(II) Loading sub module "exa"
(II) LoadModule: "exa"
(II) Loading /usr/lib/xorg/modules/libexa.so
(II) Module exa: vendor="X.Org Foundation"
	compiled for 1.7.7, module version = 2.5.0
	ABI class: X.Org Video Driver, version 6.0
(--) Depth 24 pixmap format is 32 bpp
(II) RADEON(0): [DRI2] Setup complete
(II) RADEON(0): Front buffer size: 9600K
(II) RADEON(0): VRAM usage limit set to 218959K
(==) RADEON(0): Backing store disabled
(II) RADEON(0): Direct rendering enabled
(II) RADEON(0): Setting EXA maxPitchBytes
(II) EXA(0): Driver allocated offscreen pixmaps
(II) EXA(0): Driver registered support for the following operations:
(II)         Solid
(II)         Copy
(II)         Composite (RENDER acceleration)
(II)         UploadToScreen
(II)         DownloadFromScreen
(II) RADEON(0): Acceleration enabled
(**) RADEON(0): DPMS enabled
(==) RADEON(0): Silken mouse enabled
(II) RADEON(0): Set up textured video
(II) RADEON(0): RandR 1.2 enabled, ignore the following RandR disabled message.
(--) RandR disabled
(II) Initializing built-in extension Generic Event Extension
(II) Initializing built-in extension SHAPE
(II) Initializing built-in extension MIT-SHM
(II) Initializing built-in extension XInputExtension
(II) Initializing built-in extension XTEST
(II) Initializing built-in extension BIG-REQUESTS
(II) Initializing built-in extension SYNC
(II) Initializing built-in extension XKEYBOARD
(II) Initializing built-in extension XC-MISC
(II) Initializing built-in extension XINERAMA
(II) Initializing built-in extension XFIXES
(II) Initializing built-in extension RENDER
(II) Initializing built-in extension RANDR
(II) Initializing built-in extension COMPOSITE
(II) Initializing built-in extension DAMAGE
SELinux: Disabled on system, not enabling in X server
(II) AIGLX: enabled GLX_MESA_copy_sub_buffer
(II) AIGLX: enabled GLX_SGI_make_current_read
(II) AIGLX: enabled GLX_SGI_swap_control and GLX_MESA_swap_control
(II) AIGLX: GLX_EXT_texture_from_pixmap backed by buffer objects
(II) AIGLX: Loaded and initialized /usr/lib/dri/r600_dri.so
(II) GLX: Initialized DRI2 GL provider for screen 0
(II) RADEON(0): Setting screen physical size to 508 x 317
(**) Option "CoreKeyboard"
(**) Generic Keyboard: always reports core events
(**) Option "Protocol" "standard"
(**) Generic Keyboard: Protocol: standard
(**) Option "XkbRules" "xorg"
(**) Generic Keyboard: XkbRules: "xorg"
(**) Option "XkbModel" "pc105"
(**) Generic Keyboard: XkbModel: "pc105"
(**) Option "XkbLayout" "de"
(**) Generic Keyboard: XkbLayout: "de"
(**) Option "XkbVariant" "nodeadkeys"
(**) Generic Keyboard: XkbVariant: "nodeadkeys"
(**) Option "CustomKeycodes" "off"
(**) Generic Keyboard: CustomKeycodes disabled
(II) XINPUT: Adding extended input device "Generic Keyboard" (type: KEYBOARD)
(**) Option "Protocol" "ImPS/2"
(**) Configured Mouse: Device: "/dev/input/mice"
(**) Configured Mouse: Protocol: "ImPS/2"
(**) Configured Mouse: always reports core events
(**) Option "Device" "/dev/input/mice"
(==) Configured Mouse: Emulate3Buttons, Emulate3Timeout: 50
(**) Configured Mouse: ZAxisMapping: buttons 4 and 5
(**) Configured Mouse: Buttons: 9
(**) Configured Mouse: Sensitivity: 1
(II) XINPUT: Adding extended input device "Configured Mouse" (type: MOUSE)
(**) Configured Mouse: (accel) keeping acceleration scheme 1
(**) Configured Mouse: (accel) acceleration profile 0
(**) Configured Mouse: (accel) acceleration factor: 2.000
(**) Configured Mouse: (accel) acceleration threshold: 4
(II) Configured Mouse: ps2EnableDataReporting: succeeded
(II) config/udev: Adding input device Logitech USB-PS/2 Optical Mouse (/dev/input/mouse0)
(II) No input driver/identifier specified (ignoring)
(II) RADEON(0): EDID vendor "DEL", prod id 41003
(II) RADEON(0): Using EDID range info for horizontal sync
(II) RADEON(0): Using EDID range info for vertical refresh
(II) RADEON(0): Printing DDC gathered Modelines:
(II) RADEON(0): Modeline "1920x1200"x0.0  154.00  1920 1968 2000 2080  1200 1203 1209 1235 +hsync -vsync (74.0 kHz)
(II) RADEON(0): Modeline "800x600"x0.0   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync (37.9 kHz)
(II) RADEON(0): Modeline "640x480"x0.0   31.50  640 656 720 840  480 481 484 500 -hsync -vsync (37.5 kHz)
(II) RADEON(0): Modeline "640x480"x0.0   25.18  640 656 752 800  480 490 492 525 -hsync -vsync (31.5 kHz)
(II) RADEON(0): Modeline "720x400"x0.0   28.32  720 738 846 900  400 412 414 449 -hsync +vsync (31.5 kHz)
(II) RADEON(0): Modeline "1280x1024"x0.0  135.00  1280 1296 1440 1688  1024 1025 1028 1066 +hsync +vsync (80.0 kHz)
(II) RADEON(0): Modeline "1024x768"x0.0   78.75  1024 1040 1136 1312  768 769 772 800 +hsync +vsync (60.0 kHz)
(II) RADEON(0): Modeline "1024x768"x0.0   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync (48.4 kHz)
(II) RADEON(0): Modeline "800x600"x0.0   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync (46.9 kHz)
(II) RADEON(0): Modeline "1280x1024"x0.0  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz)
(II) RADEON(0): Modeline "1600x1200"x0.0  162.00  1600 1664 1856 2160  1200 1201 1204 1250 +hsync +vsync (75.0 kHz)
(II) RADEON(0): Modeline "1152x864"x0.0  108.00  1152 1216 1344 1600  864 865 868 900 +hsync +vsync (67.5 kHz)
(II) RADEON(0): EDID vendor "DEL", prod id 41003
(II) RADEON(0): Using hsync ranges from config file
(II) RADEON(0): Using vrefresh ranges from config file
(II) RADEON(0): Printing DDC gathered Modelines:
(II) RADEON(0): Modeline "1920x1200"x0.0  154.00  1920 1968 2000 2080  1200 1203 1209 1235 +hsync -vsync (74.0 kHz)
(II) RADEON(0): Modeline "800x600"x0.0   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync (37.9 kHz)
(II) RADEON(0): Modeline "640x480"x0.0   31.50  640 656 720 840  480 481 484 500 -hsync -vsync (37.5 kHz)
(II) RADEON(0): Modeline "640x480"x0.0   25.18  640 656 752 800  480 490 492 525 -hsync -vsync (31.5 kHz)
(II) RADEON(0): Modeline "720x400"x0.0   28.32  720 738 846 900  400 412 414 449 -hsync +vsync (31.5 kHz)
(II) RADEON(0): Modeline "1280x1024"x0.0  135.00  1280 1296 1440 1688  1024 1025 1028 1066 +hsync +vsync (80.0 kHz)
(II) RADEON(0): Modeline "1024x768"x0.0   78.75  1024 1040 1136 1312  768 769 772 800 +hsync +vsync (60.0 kHz)
(II) RADEON(0): Modeline "1024x768"x0.0   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync (48.4 kHz)
(II) RADEON(0): Modeline "800x600"x0.0   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync (46.9 kHz)
(II) RADEON(0): Modeline "1280x1024"x0.0  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz)
(II) RADEON(0): Modeline "1600x1200"x0.0  162.00  1600 1664 1856 2160  1200 1201 1204 1250 +hsync +vsync (75.0 kHz)
(II) RADEON(0): Modeline "1152x864"x0.0  108.00  1152 1216 1344 1600  864 865 868 900 +hsync +vsync (67.5 kHz)
(II) RADEON(0): EDID vendor "DEL", prod id 41003
(II) RADEON(0): Using hsync ranges from config file
(II) RADEON(0): Using vrefresh ranges from config file
(II) RADEON(0): Printing DDC gathered Modelines:
(II) RADEON(0): Modeline "1920x1200"x0.0  154.00  1920 1968 2000 2080  1200 1203 1209 1235 +hsync -vsync (74.0 kHz)
(II) RADEON(0): Modeline "800x600"x0.0   40.00  800 840 968 1056  600 601 605 628 +hsync +vsync (37.9 kHz)
(II) RADEON(0): Modeline "640x480"x0.0   31.50  640 656 720 840  480 481 484 500 -hsync -vsync (37.5 kHz)
(II) RADEON(0): Modeline "640x480"x0.0   25.18  640 656 752 800  480 490 492 525 -hsync -vsync (31.5 kHz)
(II) RADEON(0): Modeline "720x400"x0.0   28.32  720 738 846 900  400 412 414 449 -hsync +vsync (31.5 kHz)
(II) RADEON(0): Modeline "1280x1024"x0.0  135.00  1280 1296 1440 1688  1024 1025 1028 1066 +hsync +vsync (80.0 kHz)
(II) RADEON(0): Modeline "1024x768"x0.0   78.75  1024 1040 1136 1312  768 769 772 800 +hsync +vsync (60.0 kHz)
(II) RADEON(0): Modeline "1024x768"x0.0   65.00  1024 1048 1184 1344  768 771 777 806 -hsync -vsync (48.4 kHz)
(II) RADEON(0): Modeline "800x600"x0.0   49.50  800 816 896 1056  600 601 604 625 +hsync +vsync (46.9 kHz)
(II) RADEON(0): Modeline "1280x1024"x0.0  108.00  1280 1328 1440 1688  1024 1025 1028 1066 +hsync +vsync (64.0 kHz)
(II) RADEON(0): Modeline "1600x1200"x0.0  162.00  1600 1664 1856 2160  1200 1201 1204 1250 +hsync +vsync (75.0 kHz)
(II) RADEON(0): Modeline "1152x864"x0.0  108.00  1152 1216 1344 1600  864 865 868 900 +hsync +vsync (67.5 kHz)
(II) 3rd Button detected: disabling emulate3Button

--Boundary-00=_6APEMx9TFBmmVpW
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

H4sIAOOktEsCA5Q823Lbtrbv/QqOe2bOPjO7ja9q0hk/QCBIoSIIBgBlKS8Yx2ZaTx07W5a7m78/
C+ANoABZzUMSrbVwX3cs8McffkzQ6+756+3u4e728fF78nvz1Gxvd8198vX2zya5e3768vD7r8n9
89P/7pLm/mEHLYqHp9e/kz+b7VPzmPzVbF8enp9+Tc5/nv18cfnT9u4CSNQfrwn6tk2Ss+Ts4tfL
979efkjOT89Of/jxB8zLjOZ6djmn6vo70HaA9fuZvjhPHl6Sp+dd8tLsfnAQs0sgHX+PP3itqlrp
jAuG1PVJ8/hldvnT3+9nP80uT3oaJPBCpyRrf16f3G7v/ngHNO/a1b2Y/8MI+r750kKGljkpiaBY
K8rIOGYPxYxLXVcpUg4SFxwvJa8FJvoGKbxIeR5oaqjIipRKHkTqueAoxUiqkcxgU1JpWVcVFw5C
KoSXSiAYeQ+3QCuiC5hpiTeKBxozVo8/PvGS6JShEVISkhqIZqgyA6nAflCJ/EYDgkOrffC8zoNA
LQjMlMKEK05LRURgjxY3hOYLZ/72kBnatCutsM5S7LKXuJGEDc1lRUuzjwF2awnXeJGjNNWoyLmg
asEmIy2Q1LiqNU0Lc85UBY4RFXQuYKeA9wq02ScwXKVXciOBsoj0b7ZiHcABO6O6UHb8UFOEF3De
FI5R0k9kwgeSqLrSFRF2CCTI9KB7FGFz+JVRIZXGi7pcRugqlJMwmR0PSBiSS80zS+0xQztlOiei
hDPnJZy5lHS+typZy4qUaQDdM+vF+aRJxavasLzUJU/JZNg6pcqS7Y1jBUNqXsH5wN6lGliFlrTM
Y5QpMUxr9gDOkePJ4gkSxQbOUU7ghrMLrdYBzlkgkVLxUcYxsCKtU67h/wFxEx91Jfg8IKJmC2El
frtaklEwWKUXpKg8oWs1sMH5MFf+zG/QPazihutcyVtaPjdMjkRA3gbFDOwKau7k3ePD53dfn+9f
H5uXd/9TlwgagxQQJMm7nyf6Gf6RStRYcTtdsC4/Jrm1YI9miNdvo70ha1gTTKRUqPB1qV4C7xEH
CIetNClXcMxmUgyE++LcaYGKFWwP8Or1yUkIDMyl+OS02zF0/olWYcwcMOdhVPHJVao+xhnHH2Lc
fqd/d/unBGaUw3geOD1540oV6LIVrfAewPyLlbPFIMV0rdnHmtQkDN1rMpep4WpMpNQIY893mOL0
6iK4FAVayBgvGViJ1QgTBbGvm63aUIKQnt0ErhP5+vnl+8uu+TqymyHRgHNnaWEV/MUqZXDhKdJy
E0UCXFsDH7JbgMtQCQ7R9ezSb9KCQQQQVtF+M3AyjFpZfArPq1tQdHy67Pyr71OIPRpX5uDA6kzL
Bc3U9dmVx9g1CDQC9Q76YgGq17pCjnOVC15XcgpoNfAetNwnzGAVn4gIdLCi2PXiKlCK1jcbNsAs
Qlc07XCBHej6AnzHn/3uks4fxLyeuDNdEwYeB1BpYHjhjhlAW4kLnlBHbDcuMDvGNL8pidc/8Hdm
7BcwJQZDmepVWEUYL2QT6NMoZ1kBPzhLqsEiujtvxN/9DZsnPIDZU/d3SZT3e14szflYtSxSX02D
wYEFtNvraGORTjQtACYKFiC+XrUA7u0+HpwAE2BYTyqkAieKCoSthMmBy+Hxj/Wl0uDR1DQ9m3lK
EzrUe8pnCb/khnm99jAQbtgMcEJkSLctuKoKV0IqAe6HI1ie+JAC/DQuXMWMZbUUugJvykRaTjuw
yjqr3VlmtSKOx0rAIXCwkuYlKjLnGI13IFyAjXxcgFyAADj7S6fGFSx7podoyqrlZRudVs32y/P2
6+3TXZOQv5qn3UuCnu4T/Pz6tIPAddTXfhej0BtwL7aBjV2xtlFAtCtM9ceaiqXXIeasQgrCulDo
IQs098SzqOdBeZQFDyNASWUUHLA8xARmq3hL4Tto1lmUsSYkyyimZpHgjBVwfqAnQMGBrZ0ItYCw
QpRgQxTNqKtkW38XOMoEjzDYNC7tJjCFQn9BBAhlEG69cmueFpxPYxATuyKlxLSRIDn4DBBY2Oi5
W5hGFQ21r+jU1Fjc4gYOlKClDVcnuMjOtK4q5qufPt++NPd9NuXb9vnLw+PD0+8WP572jb7hPssM
WDtK776bWWK+IAKOK8JgtMwc+RFKMyOw7mZaoZbM6J7TwXrwtC58hdaCjGYE01ZwFDQ6LU1dGryT
bHCbDki3586VlsEld82lwIPHXRSh5ZpMB4NQuI1IBnvS+hSj99gZmLnMg8ONBkiRXFC1iVK1Jjgw
EztmJ/z96VOeyLs/GhPouJqI8tb1KTl3DFgPTQlKC285PQZnHz1Fk33UrUPQEQQn3acR+m7D8Zkl
mfTfg800D7TqBr8+ufvyn5PR+rQ+cC8PHlvZaJvYDA0I82aapTlEp+eLN0mP6u+fdGZi6aMJJQjr
m8R1edQkW7JjptlRHjPRkRQcTgirD84WdF56zBlZuqOJ3ljRSPfGejzCtzbeEr+98Q7ZMdM8buMn
pEds/A1oIXLMzreEx1O9sSiH8I01+ZRv7X5L/fb2u3RHTfW4A5jSBk6gtzzGVraSAlanj6d6z3cI
Lq1+r7bPd83Ly/M22X3/1iS34Hd+aW53r9vG0faKwpC8JHLhekU2DHccCZovbABofeW3bgxqWrjO
M/OyQRCtCbDukw1xcnisshTTmxkIL0iZmpRvFwNEmg9JUXDZudjoDNGidkOJ1lhxRhXsl8ntdTl+
x3FGAq0oOCZ5TaR/RUTKwLBLcMIneQID6ltPevW8+36k/jog5AMPRJMx4IzmnKs2NBldE8IUjBt2
Wy7ez8KIyxji6gBCSRzFMbYO42axDitgHlozSt9AH8azg9jLMHYZmdLylwj8fRiORS15WM8wG8QQ
XoaxN7QEJ7HCs4Poi7APxXICsX6+PjuA1UXkPPBG0HV0V1cU4Qt9HkdGdqjyWWMYDJTaucetSPHw
kQ2apaojkg4YP/tvxdjetLS3T21+b+a1YZW5WPPbFWfxBmuUpj71TWVDIandCK8fvrDhFubVxseZ
G44KYkYNw4CU18xHVzOQ5sndBkiXD+jmPrmJNpfAKx/CaElZzexVV4YYLTYmIesQ2BASq4JJ4WUc
jfJsl7EPRizdB2Jzm1GLqa5Og6F8RVRrPxy7YmCE2UsyiASdBafMiX9zJIwj394QjwEGKgCxaRFB
HoI572OHewPKVTF3wxgg7K6eplAvGi/tlaN0rmRakyKZmloZhv0Ebh91lCSSPGkJVryoYWNFKOPZ
0Uw42Fz+mFlOWIbyHuidjyAQl6k2pzgXfElKa0msoxSzym5yugMMrOJ1bhCw8fF+tFoI424Uaagp
LX8jWEVaqwURDFa6IubGzQva3ofyWYxiwTFoBCfy70H7sx9R4fmPeJh7q20ytLcvck8cgFtoqL/2
jnixkRqUjNBqKEnpZYAKWKfO5+Zm1wtRy9q/KvM6NNcES6NpNbiK0wKF1v0y+fwuQI7iSYkCl+Ck
MFPqfCsGe+FeWxYFyeF0OodKr1BRk+vTv++b2/tT588gI8HOhkVmoBXMRBgqa1SEswdUwv8UzcN0
nss5kjhS2mMmObNuSiBrkrgJNWd31koQtyZnRK3gL5NnnG7gSGFv6XU7oUornhPD2Af6mjh4Zm5d
Rj3oL+YE9i6Xg8/s9lyA31upNhtktNhgGA4wYl/gYI4kvz4bckq8Ll32t06qAq+0ll5Zj5t2HHO+
kh3I2tgNBDtmJ3R9efphFq582HPyp9vUYYLcY2XT2GM9p1yaGwdRV6YEJKJ9DDcIU8XEb2CHHOvP
lBD+Ly1RSRX1bvp8eMcegxieRsgML9gksbE7PfGZ5zygqRCDtyF1lUNAaf0aT8+SjIZEhGCTG5xc
PtmMtEmXW3UbTv5+0menpzHU+VUUdeG38ro7dcTx0/WZqzKsWV0IE7X6NQZrEg5GsEByodOahZKE
huepMZ2wUojMTv8+6zSUe/EIttXeCB9qb68lnPb+tZfvqnY3MKtU+pd9zCZAjSUuYrq94xlfBQzh
/vN/m23y9fbp9vfma/O0swE/whVNnr/tHp6f3MsmL2SsWOsRhhbItCyIqfVzS296qKNX2uKoPYCT
khgPf6y1CntBTAtwf8BTDE+Iu/fvZn3+r2FqoxtooMYsZsGyixELluvGn2uLNFDYdLBpsfbtPXbf
fNpze0U3QSA8AcyRghE2U2itFC8nwBVNCZ/AMjSlSr10wTAbIiWfztJn1P2ds200ynNQRGiiC1za
zkHb6wPXEgI9CAxSFWs6L0DZmAosvSFIXJ9Oetjj0MkksTl4HnMcgW0moUc7LXAeEC0DZy7n4Zsf
6avP9pYMQtRs2/zntXm6+5683N1292dOsARi8NEPnwxEK99DGODTcpIebkqHPJ3hIqAVLKYI8bjT
cWtfc76yV8umarm14ft9erSGs6NJ1GATEwjb0ozjm3BwVmA+6fEtTP0d2GRbrHto3ces9x+sM7q+
EGG/quigsUX0zGV4y1zMdsnc++3DX+2FnefJVNgmS0yvESFoWb4lmcYoduElODaR3JZNrVaEpFKR
Nu4XtORR0uqyzVaCU7+3opc/brfNvWOUIoMUdB7ZWr/meKiCNntZgMNIRATJSFn31pI1X5+335Nv
1mi+3P4FIuvNhf4CHoptureA+etLP/vkX6B4kmZ39/P/OdYVU78Kow3kfBhj02o1S8kZ6CPp5kGQ
p5zM70ECgp6qpcgKXlUbfYP8i01lKgEYCrpCmBLjU3vOuwEiXzsakCZYhL2trkEgivdJZMViPs7o
28vJNrYAtyPQe3WISRaqKzD2iClfhRcOGD930j0k8PM+y/e6nPt9YiTCyqq3p4Y7puxD/m7uXne3
nx+b5MuD+cvUB+1ekncJ+fr6eDtx1Uy5BFOmJGrPg/RQToEPxAvG3x3YxJRTLQhKJxVEfgEH4nXI
eHZjMOpmIym6OO/SdtT6JiOLGUykq6H4wF+FSULVs8vWhWZ+uN0V705blmSoYSib3X+ft3+C9Aa8
XHAoiNOsLunay6IQBYFDKMlGS7cdhVAU9pF2r2DGxVYQnq6MPUm1TaiF3CIgyujcvIlYTNpWZbiM
0kyLVvQQMg/eDZp52nlMB6JMMr0KXw+M+HCWH4kqzOJyU8LB8CUlMnK1CVNFiziOyCqOhGPn7AB+
nQlw6eqyJEXk/DqsrwD7libZZCq1Sml0zRvDtMR7Y8Uo5yRYnGupCsHd+lGApBTlE5DCVQ8eq58B
Bv/NB44LjDDQ4HruarNeD/T465O7188Pdyd+7yy9kjQPstVq5nPUambqN1cIbyIsBQStQJgUWhYn
aqtbpTKFYyiNbu7sEB/NDjLS7CAnmTkwWs0ONI8w2oTqTYJ/wnWz49ludoDvooT2aLrCYhTJd9mt
kVTtHTzA9EyksSalScna505qU5G91oeWYw/D6NkK3DUbGckDhHYRMRVZoHlkFECa2zuT8AI/KXRn
ABQZLZTv9QzAaKZkpOgl1KvwEzTNyUi07+Y/bxtjzMAj2IFDiu0zo9et9QZct3QcxiyTlkttH6vE
1jqhLXg4hC5NjXFZmtLV5RtdmcrX9ebgBqzbwwvv3xr0EBI5MeUMSEqabd4YcGyQSly9MXBPuije
Gn16+geJyyy6c0HqY85kpDdPNGMlGyH6vQcwh6lxxaT8J+SgGiSEd9XbbZh5X2zcMzYp9z1EnmJ8
dNfTIz9EGzMDAVLjjdl3dW+xU0ce56aWgFag1HNy7PAFKXO1OJp6OtFDxAzh40mPkYCO1urlmNEK
NLCVaccSV0tlrMWx5B9rrtCxxEcLV0dOUMGOJ8b/gO8lVkczqMnnWb/o+AZi8ujiEPWxOqGjnqTi
D9HWF+exMGMl96werX49yuhlxocVyNr+y1j/QLWndz0srQbD5MHbmZubxs5nCWEXYTjBZRih3BdZ
LWJwKzxobwTIb16OyEMW7iccPEwdQDHQRQWJNAhMuNf8+zMW6GYSSwIQXKd6+gjBI4CQMbzRgAjv
ASDGWXec8dfsKN6gpnYqO+AFdQT94ce4Z2qVRoyRW6+CFX7rdJ5rFnmuMRDw+W84oh8szQK0dbwa
aCSRC3QWurQdCCB28z41kcrI094qrFCQYsHXK84NX+vBTn9rmjPYIfMGo/0+gZeoSGVYTa8KVOr3
p+dnHyNvQnAZDKGLwitlgp8xZbOOLBMVYZO3Pr8KwgtUhd+5Efg3Em7dwOL200Fj1nARbUkJIWZb
ri6juZ8DL2nwfE+/dtmxZNe87CZvukxnYHdzUkZygkyglIYz/BiFG1GRhg98Hl4vAg2zFlWoVPSG
mk8uSP/pYpab3QnnsQo630O26+1bPTXN/Uuye04+N0nzZPKv9yb3moAAWQJ3d24oQ2EeEtmSFtHY
Un+o9iaQNn893DVJOlzbjF+JeLjrwAmfJi/r9llnW49oajwW1yfvXj4/PL3743n37fH19xNXYFaK
VcHbbXAkyhQV3H2wVYm274wKdmOqSyYV+9mNfU3nvSzoSWm597WK9uFvT3F9sr29b56f3onZ6ane
Pt79DHM+CdOai5HuextfHrZf/3u7bU68t+F6AQZZrKiMVJ+YoDVem8JUWFIqMDcTV7bHlG6VQ9m9
69cMGLErwesfVuye754f3VxzWfmlCN2bvdAzvyyNv9+rPuqYDHVoTKU8RGNGSBH+MDs9SFIzwg4S
YH5jI7tgeqgnKrw3gkNTsakU73CtDIh5mtw/vLRS97m5u319aRJbG5HJfycmQ5WAKI7n2Y732Nzt
mntXMPshynl6cPZy/f7w8ucHViUQ218UANtH1tdnsxDOfubIVqrtDbaOxNI4FZwZLYzTVRqzWJqv
TLVYJF7sh1iEC1Yl7r4s4SlSlF6dX611WvGIHZozjSSLmC9Uxmr2ZW6u0vBlxPnImL2cCg+J5YeL
c3l5GtbupMQFl7Uwn44Sdj3hDZVXVxdXmmV5FV7ZotK0CBs1KovzD6en4e+2SFKCDpJaAdFVpKgt
lWez9+eRtRuR/OXqLIzG51N91F4UEhAQlry8fvv2vN25UtBigDvOLwPHPmI9r7ADmxrdSOK+owDT
N3v/y9Uhkg8XeB3OmuP5L2ene+fsvcNP/bxwun/DLrGkyX1rN8flD26vpCaR7Xm8iKbt6/qgn+ze
JNvm3lfiLETlynfyAdalTSNd6k599TrOTrqbbfvi7l+g8f78d7K7/db8O8HpT7BzTpnAoKrchxUL
0cL8Mp8OyqVUB9SW+5pjhGmw9alb8DWMkYfGAAcztl6bBNJFXU62zn4EC00+XGExEJzmsbSEJZDg
SoKq2ZQ4Nqj5tJ0lu/7qbLPa3j69mI32ajbaLk1t3ZQTfJIMv0VB7d9vEEkkjdsJ/xyggcj2jW4K
flOAQ1bEKdJFHMdlaj9EQ2NlecqrATEGpWzPK0XBaxxDARZnziXRRAivVBBQvpcjDahya0MtBC2w
V6phgZIWQXVlcVm2T7+6idrEitKwe25bslUcV4ZxVQo8kUY+QGYbfpQxP7PdhP9n7EqaG9et9V9R
vVWySMJBoqj3KgtwkIQWpyZADb1R6drqtCtuu8t2V27+/TsHpCSSwgG86EH4PgIgiOEAOAMMbi5S
miD2UwPIMxMoaLDJOA1uOTOBEuRaQ42hW8Vu4O0JIbrrDAY0M4F5YgBrWVYGWFZhMDfVS0L/MGQQ
50kwdcbaORqOoQyUNTzHjPsm/IDmJYImpEtWkwOgM4+kn15X0g8CM25qQsT3XmEh+DTOZei5ewtu
eP6LMrcyVMAgyChc1nyZpYYa5KyGaTczEMhpRsFllpgJID/ExgIKXnxhxIl5SxDhfOo6NsLMUMlK
cjNKzXqKAPOi53imjoIzJ7QETcBzJNjLGwiJoR/X39CmgsZF7HpGHE12amWxayDxLAhNmXDDw7IU
ax4Z2pCahRW440VUFonpBXUCWd8a9yLr9dPyRDkBTVKZDj1VAoBmJsTUAiiK0o4JdLXVaSFnVBQm
TmcBlV17rciIvS0QlOLSwSDzJvlQO9ZgJwCgOpigQFGwCr1gUHjOURqi0G9pXZJPGl9TVXrk3rAP
tieBWnTZiJH6Tnt5kqbpxPUX08lflk9v5x38+WtvH6U4h9ffk4fTS3cSOnl9OeMBzB+vHz8ml2c6
TfPJ+8fp4d/vf788KX+cJy/n/1wALP3t/PD68+f55fH8+Pe+QL7kdYonubqLFagjVrF3FdSlHEuQ
HjtocDSuQFizs0OxN+R4FFHlaZ9FoLVzpOa8KzWVa/UvbnZR2f3wKbqZVLMdcaB+pSjDHntOydbO
6WR4ejxwT1+ZnMW8wEntmNR8q3c7CCub5lwpafKc8E1WKrfPVHl4IaQ/bvjagBT5TatZK5uB6vE2
pVUq4MuTqwirY+o+RmmpokmT/jqqbYSLwWLPfigtCMksyTzdaUI6tHlUP0e6c+PqX4DVQCMdfm71
6pYgJ/ghIa6umXJRp8UOIL+UuyXXf546dIOFfgPBhbvQFyc2hKaM2Bz0ohAsoPB5szKmXN9JvioL
vSwZFXvi0I36SF8z5u/31A1i5pJASiL6gr7QahWXfuUQrpB1N2YZG4wHxokFCa3qCZm05iInLh8b
ER2/JSBruYTBg5Ds/u4rbVeX3RNep/3lXln/r3gf934+Tz5+XFiPw3syKPd6jckeT78+RqZPWK+Y
yZis9IbtqJkB4Qp2EaIRJF7LLHSJE1/E4Y/hIli/aieJfrCteUXtp6uK8MNqsBNYktpDeGJXZmTv
Q4+5ZK4IKsPJGv5D3HFv8z1QfeKcPSnoi/F7Webl1+8P8iyYF1Uz1FEuVDSWJdpIZ9T2uiXhi8A4
MzBaPwybXNOxm/fz2zMaWD+hH9/vp4e+T7X26bxscPnd3lfvghwrwRqtKDOkibhO0+K4/6freFMz
5/DPeRCOy/tSHswvmm5t+EiI6H2au+vtwZOb9BCVrE6Gxvpt2pEl1WwWhjqXaleK3ESDh79KzyWu
Nq8PZZsNcT14pcBMM/dnCzOpSHeSOIG4csoqLfC2Q5hpQpY7tiOE/BurKaw130uK0usRBhw6AyoW
bgwUpSklTYSyiddtj6N7b2syNh50ypG3IWtYLpk4RrIQRhJHQ8ZSpp8ieQYWtCsM88KenbKQzZmR
c0jZ+MJoxIhz11mQbdYQ81l3SHCM+b3lwPr09oiaExP+j3JyuRK5XlvWfV/l6ueRh850sD9qk+Fv
UsG3ZcQy9OI5cRrVUmB3VglP62AE4YxHAN+XDTsjQ6YMVQbZcZTxzVMcy1Pt/Wn84/R2ekDtwXb5
6DXMdmCHqBbD1jCnNWnsaS5u5YXQc0qy66XdFj3ZA9BwktzxwGS7odQv8JVZRt3R3Fbi8luZ39uW
ivPb0+m5J0MNcw29mTPsDl3i/Tsu+b6NHAS/jwMPSf3HBqbOA6CvSdMHivrYsFr2HA/10c7xx5Uy
bhZFurg1uld3e335GzIgRTWDuonVXJ93mcEa4LvabVVHGMYg6CXqPn8HfxHG7wpvF6V1wrTuZNBA
dREeK3kYbqvTbYX20BfbKK66BqUD0R6Lq0y0+qw5hw1fkWRDLVxIhVmQ37kq6SGtivkIak8BdM7Q
FNy/eFcJ9xHp2hJwci2Xy8EYg/GYlIPzvWti682Dl6NRdEe78/F2g/Q+3m44bDp7FsfbVifotvP1
F4F+o8SqKuMxoSGT7yjfElUczv3gz+OqIs6IYI7sDmQI54ojt4pjv2Hw0VettyvVdvqNZQx/Kn3V
oSFjImIddtBBLD/uxYMfRyW6DB3/Y/LYsFulYYixdDtM7NQgh3GtEMDweK2vslYk9eLbgoh+Gkan
nlU8ETmm/3h9/8Dgkh9vr8/PZ61TjTZ77s78GXF+1uGBb8b3BjxP5sTxeAeHrqs7cEcUFnJ3ICtg
2ui6YADibdWURAsVDcEjccHFbLaYmfCAuPDs4EWwJ2HqkqTDquFhhvpO6vaZ+HAi1qyO2DvaOFmT
P6APdI9O/vITOsPzfyfnn3+cHx/Pj5N/dKy/wXry8OPp11/HuZe0xN++ai4Jd2QI7zFAyl7jFwJE
lRdYtoDzj7aXntoDD+olO0VWEKtWa0kWJ1kpYFrPaQJG/MJzlnGNyo8fUPitOr1Gu6tKzLSeuYft
IolwMgi2qra0guCVgkPeQokarR7YQHOl4iAACHlzlw4pk/z03lmbXCaG5P598VGYcyJGaTYBfv+N
B3CSYhwi1IG+F+GgGhcF464+d6XDH2rDjrDM0sDbO3dZV5XQiUOYTDhj2bFCqkvisgDhBdcmEOH7
c06XpD//0k1crTM1dPKSHQbOVHrphku8KmEtVX/Y27pQOybCm1P6zz0Koa15oURfvfmfjjkbkCHd
uTPV+jLc5UPnKCoBr3j0h38K7UbBmt8fORWnD+iKugF40U5l0CubVVM3Rh3WK8us6sqS+dSd2imh
hRITR+k3BmyJPfcTnNknOMEnOAs7x7fWZ+FNHQtHQuu4dk7g2TnzT5Q1t7SPiOeBpZ03oUwJXxlX
iutYOUxdt5kpcl+Z64Lq1Jbq8tkGRKTIyFnO3dCZLa2c0FuuLKSZP58JMwekL0Kv7UJZwcTEzIxs
5obkLvLK8RytB90LAxdS/FDDLWrXblHOUnMBQKlS88DlMpwbCVke+BaCpV8DwZrDzEawVXIeWgih
rZKhrZKhrZLWllzY6rDwbARLJWU89dyZnTO1vcti5k3N4xYXTde1cwJ3YeMEwczcMu2+2s6ZenML
ZxnOFuY6m3ZI12ktT925by5L5CKeznP3UyTLh29pkb+YW1YQAeKQZS3P4yC0TMlynceWLyLzijLz
6VMsBaFOQFw11rUIeEEYmGfcrXQ9S3fcytCzCAW70J+HbmLlLD7D8T7B8W2UbB7OpPgEKyhWNlbg
zdfLT5BSC2udsMpcpYwLH/dy5r4I+4RU5PGnDwVugsfGcV3HWoNs63haJ2v3Ho4vUSmUBK/TzLid
efZ0A9q0Y1Hu2GHkMFHVe3f6ePjx+Pqv+wvWW33LpbzmROhW7QN/vzeTWIxhYtPjLiHMtNGhlUxx
O0gxMp7jOZmRMHcdlySIGAQaGo3i45LLKvbMb5I2ylk9XVEezR3HgOZM1IQuxxK2p+SDge84qYjG
hAss4xKhwWEdprWmWReXp/qsQcpyvSVdNOAkuK7M7dUqT5OPq3XR9Uk8cLBr0d8MJgQ6c5i86f6C
qxZqPvuuuzeS/Hk0NzTAZeIyEhZ2AuzJDYRwPjdmsDDhqHv3zdjz02p/jH3tl+wOtXkXxPc6Z8Sn
t8fBVIEXs7GxL0ANdN5qGxFZMweOPvPLS6CeVSkEj24OXsTry9PD+0Q8PT89vL5MotPDv389n17O
g/lNcyaZ/37+ePr+++UB9ccuekGa+T5fJvRhIoJhWOUh9GCSIPIZpewm8exV8Fi/AstdNnV8x1y8
zIl7nipX3jAXjr+ncaU5Q6hzYu4w74cL4sAE8V0eTh3HBPvu3gjPHHKN7igLQkMZYZCmZ07g+/QL
xC5IU3qcRXhtSzdv+m2P59EV8fB0Zno4q+IjdYdSpyv0eay1s8zTBCTSbia/OhnHzvrz/Ph0mjyg
g0fN4avS+D5Sp7nJNqKr2j6qCtYPk7bkO2UAXo9uttuM+NDROLsfe6u3068fOGrv9PDYahhxY6UC
xgVac89VdX8ti4mUkQ1io9uhS71XaCrYi+HWJWD3P64wupHb88aAoNjBugviWlnqrjHrnpYD/Dhu
cnEXEA7TpRxanWBSstSPFwRr1wv15aFxVNoP73FLw9LHpfCQkFxb0DeAC2Jvj2C+YiRGfRXEqDs7
9RzbMkLPGz4E+rfTaUC0PRHEYaUr1SqZ9nRSIo1HGuj+AwXBZXRMEp05OQAqyt02Ff2BekNj+LPk
WTZ01t8BGNMRimN3AM/hPaNs6Cq3w2rU8eT7NBPoOCc6EMpjwERnN5eyTZxLNUyca40o0hJGP18V
R5A+OaWj3FWpJDZriMN3pK5+ljgGY/Q2TD4eqXAvo4vL3uPoqbgdfGLUspJn6vXkSL9KzVHLt9PP
8+SP39+/n98mPy6qABoBAT8Rr+uGrGCVexQUH6K09ij1fCAwIj4CQoJn0Orkx+G5kCQITe4G+gbD
bj1qqIK6fwBsvaL7kJu4pAUEZgujlJNPo2NwCsvS0JkR562qy8B4J4ttp0WyWeXB9UIDSr6tTyL0
FIYoJ3vOlm6dIi1hdHKyd2wOhNUGYD61xmCRZZmUJfm1tzIMPPJFZQ3TLt0jKT+xaoyQmcasznlB
Np+KSkw3YC2pmI/YT1LoJ0WZk8/nEbwu3YGjumSJWOv99F/npWMWJ/frBCYqz9Wd6tvAISFgmdyC
bPxVL84hAUb/widEd8RlUnrTnIS3q5U39T02JRmGAOm3dxu9wh3e+RcYuC+7glVdrigL4hsrjyrT
VHEjCrZm9b0Imzy9w47wv/e2H/3wn/CyB935SedU/eX99fmMjsfanDp71rH0ipLhnQIsJKLqqzpj
EzEau2CNbXjrBsybXV2EKZtIjXothp6PmiWeKmmUSTXwsbXlRiOtnBH2qLrH6lLSsfaWIGLplD8w
/Rj+GfYq3Ka4QW8olKty+AtNy5s9rN2FHlDLlxaJs0Z6Xs8aWJTNIJ4g/kQHSGOl3EE6ujaEns37
2sqDXIA7igOHSVU8fOC43iWD6IYFWrLvcujLw0SRfm3SIh7GCuiAe2vYHg4Vxvg5w9xykBRrhO5q
RyYeMcrQIGDUoFrdc4OqYfBMSv8T8eRQMDxigMm7pNwWFdeJUYVCZhUn3vPiSKiNrziuyg2FDeGG
rhERckFhOcjyK+jy2q+FLTEutKwyHw0RECOLBNLUShIR26VGBnxj19m4Ro7GyHqAU05qVA3Ihm9E
NGwRtFVkTcLLcXsoI0bmUjdyF4bYewcjI2acfbXk4XpeRr9MSVz5qCGO057WpRzXLNLr4ZYQfo4s
TK6mpX0btr73VajufSawl0tIQ1DAR6c47Tnnr/MD2iIArNuFYK5+Dh9ZEu/GpnihMXi19vJrmBSl
2YYXwzQ86OjHE23TOPwaJ7auiIaJ0GSrsqi5SIenEJfU43JJVDn9tklHJWwOo/quDvUleFgvVe54
sWajxE1aCNjpyTEZVg/etc1N/unSRpUb4HWTR1lascQzsVaLqUO/ovJNhEv/uIfkpWA19S1hXZRp
PW4bDKW4GiZBZ043w6QKtozwPbNyaEvZS6ZrW6WSodOMcWW/NvA0owYVy0VTjCom2r4zyEX5/mty
cmwWsEaN+tYKLQdhIzzYsF4T6RcRIPnIL+Why7F3E3RLp5+WZSXSfjR0lbiuGyGvmsC9S91bOp0l
en0ZV+aSpn8Kp4q7+UpNznUbmOS4jhMCKdd9c6sBlI6hfo2QSS2iKpeiUKHc0eC15y+2PUh+en84
P+PNzOvvdzVl3sXZa7PHp4ZL/C293W6QU+cnRA6klXJFYjkh4CK2G+m234HHOGJL7fKwRjMRsza4
ej6Y7x0HvxxZzh4+0JjQg9MOHn5elVrjoeW6gW261KBS4lcT4zDvqr32jec668pYL9hCuW6wt3Lm
gWPl+IFn5JTmNmhubTB4TGSh6xozrkMWBLPF3EjaaUofruA7NsavHaFTwoifT+9aGwg1jOKceDMl
4A7nF1WjJCcrIzW6LUUp0/+dqCaRZY1nU4/nX+eXx/fJ60vrF/UPEGZufmUnP0//vVg+nZ7fled7
9IJ/fvw/5XSjn9P6/PxLucP/iRdVTy/fX4cDvOPdfZs22aCxP2AxyZYssvIwajxlQtfncZFQzt/6
NPg/k1aWSJLaWXyKNptZaV+anPYm1ieyDMRyZqVh0Ai0urcSN6zO7dl1Ih/6kowjotfC/qcRjdJ1
usnLP0//Qv8tN4vq4TScxKHhgyixCUQb7RBT1rp3l5Wq0sp29q7rXexxaV8mapb8Npr+77PQHHb1
UMbrGB0i0G3a8eqN77qBjdZK6jZWvPYJJdoeabcGYXedmvp2S0z4isP0FKdZSioa9QuvYN3YW1ld
F8pDGzPNq3Rl/gRLibv14e60DzcFStu2guhIET0Sr4h9ap9jzSVNVp9qywvvSLjh7HdDdWJur/7O
SmkaG+Xi9qIyTT0DqpWWCesbbsqIZxi3yEbMY3lsPMIzap9Xivnccz5DC6efoMHsWGbWFinYNmeF
uUNXmec7PtGdS8mDcGYdN1/jkXsgLQlmaIzTYeOJKq7C/cxGW1dTa5GCLa2zoeBpDht39KH7CWqN
vhHbiD9W9iGPyszGso82dYf7hQp42iPuYf4vrc3bGklaWXnBKXdho8xie25bvi0rvP9QP62LQKpz
4oSL43CPR0i3ac4DejwC6tFLH0saaezJW5HS0mPNy5lBqMjSFYxbyiRUMQxCf5bS2GWFiw/zmDBl
amlKA5zeGiW0TybE1dqXZoYpVh34dbdddCtyAf9sV/T0ldGvis5vYtirRzWThiWUlztWw/egGZIK
ttluEvHCb0kvYCsGy+X9RR7u/NHZ2tv5+fRxRqdr399O7x9vvx8+fr8NVEaLsmq323HK9XewzU6/
/8hzQpsxzWl/WXhgAl+GUFwDgQuVXnlG+a3k8HfBI0b4f04TplNkqmV8bM2wewnqhGWYtI5lKQ76
xMvV7/+8fTw4vaBbSNFPFDX6WNQ4u8MnYHe7RH2h5agwlY53P5rkgY+Pfuqx4emxux0b1qve3nWv
q18HrJ5m5ro8lwjXd/QmUH3KfGqjBHPPSEGLiwUxW104tZjFviUfLjLXc0IjZw+MmZGhrNaIqWvA
Cc2cfOrK0PxS0Vff2xgZwp/5C8L49cJZ5r7rW1pvD9V1bZSRufjVtYKln+CLLqydwLc0O1IWzif6
ibkP1Iu549p70jS0VMb3/KmtC3juUD+otSyA6fb769vPUauNno5BvNaNVWgFLwxsDTVzXStl5tso
86m5KYXcuHPJQksvD6WlwkjxZ1YK4VnyShF54FlqHH2dhrb+Uc1iSwfZ+o537wjk9eVvcdVQYyHJ
WXcJoF/Wmr1RFOH3nnpAGt9mh+JrzyGdZKtRxNgu6Zju46xJuqiU+nVRupR5gkDfW0IQezNedSEN
hwfpGJyaOHsGCF0b0xLNJUZkWpBnRMqtsnekbiHSeE14/JIwfBwSImzn4QVTwr8wOjo+lpTEW4du
OCfEVOUFeeGJxoQawZTwZM2Kb1rdra+/T88YVGACY2USn36e304TBiLg9unx/Ho51O7Sxfnl/fUN
/sF4keP40MqBJulVrSrXeZotCV9O0AurNRfETgzjaATkZ1UK8vluZbALKMpmm7JGK8+cXx5eH89v
GJThx/n5F/wPPVENxynq9SuPaXPHCT5xToA3494neZhEeGOXQUAcgCsooNQum0S/R22DvBKOpNOx
M6dWGGX1pD7/60l5a2ov5QarOavRWIcLKggzJ53s5d/EjjAdipjMMVxdQnhekjXhjBu1hfP5/zd2
Jc1t40r4r7hyn4q12JEPPoCrEIGLCVCWfWF5HM3Y9RI7Jcv1Kv9+0OAiAESDOknsr7FvDaDRjeij
RmIxQ6ozrB7kpMicvj13q+tB09Pp4xPGOiMl5kgrqb9TwWsfS0lyIvs+DX1MYk3zTUki3BeYeuwj
t1E5KxCHbjJkc59RHEQttMOVvpCN7cmgisDno6fDmkD4nDuraMKsHN/KJZ3rYtflcBy52m54uyL3
lpaVxihmrKmCGnHxHQXEtbZFGTWVlVr/hTRIwMtzHjny/HPfGbnTBLp4J+aNvofrCM0OXBiOyWXB
6U7WjLFT60Eeh3WFbXyHiM0Rc0IXjalLoEhRrPwBcdlkTVFFcRVHeGhHphe+TC/OyfSycXrZ/h7o
7rN5kwUhCdfGZWkVUznBJrxB1prvI+gUnTPLOzyuNOFzDAM9zLk7pUC0+dP0wTuKkYP+6IOyNib9
TRaLG7ARatiJTXheCJpoWk+RTaAIQS5C5q35XV0IgkilosCqsMWWZl5rUGEz/ctbh3R9bba3g13p
O7nj+cW8/Ey4avGxCrry+voV/DvDmBsNOSlc3FxfXxpZ+14wqptzfZRMOl5HSWN/52zQ2IkK/jUh
4msu3ElKzCp4xmUYd9VtB24tdDcOpagZxSUoBSwX31w4LcCYK5dl+fL68b5aXd38NdPOmnIxarB2
1/mx//zxfvGPK/Mnn7s6YWMqhSsaf+ChYBYRcgu6QlTofk2tkyuRlaNP1whY12ksWKDzdiSVjmFh
XP5YY0s554YRI1MXcWY56MYHN0lwLFYOzjB0jQeUUKuy5oaDGA8aeLKDQ6xIESSUMhgCcSmb8jUC
bj0TYkZz2XjYjJh56qXEsbt8t8TRyhetbPIthtXYLJbHAtwYWn2mB63eBd/bhf1tzeBAM7ystZTG
ZbdTQpERNGq281F8kZ1o5Eo1apMdukK4iaxPgyHewQ7RLp2MdKxICYC9w+d1XpWh/d2kxnF5Gcql
H2jNpgqunAAvN9nC1DoNsEYM43KNYhQB8rBEwxQRwScE9yz6dDi+KiMZ4s9v/cC+JJWgcFnZGvYJ
TcVBIqfS/MTjHjE8meAgGU3JFI8U3OkET0ZCN4excg0cxnM12c0iyjeMBIi7q3ZW4HXgzwMvmMwo
b3dcXk6w36/ken+6LMomIuLpVMXI5bWSmZ+Ipp5qSaUs5q3hOKHu+oU57HrlDdsKJaePXjC4/fJ5
/Oev1Rcd6mWJRsoSxpSkY5jhPJMJMQlpMK0QI3UW0/wcprOSOyPj2GGfxTQ7h+mcjCP3QhbT8hym
c6oA8UZtMd1MM90szojp5pwGvlmcUU83yzPytPqG15MU30H2bVbT0czm52RbcuGdgPCQUvdgHHIy
s0dYD8wnC7GY5JiuiKtJjutJjm+THDeTHLPpwsymSzPDi7Mp6Kqp/HCNtFUtEu35bcRMkzMsQ67p
N/vD2/7nxcvTM/hZPK36oiLgp6W6SxhJuSY56dcUuWi9g7jWAXW/0cjlDYyUwztbIkzJoePIai4a
5WjEdZgBD5RVJLfzy+VKX+hTqvZs1R1+uCr7dgb6X4jgnIMrvE4/DDFao65qMFk/JlEMlpPtvFvB
N+APljndoLS+B9LuXavWegrJ4qyoHhopdWgS68nMfls3ZaGeCnDrqXhP1yTTsAYbenBtxlj3OLww
DkuYbKE8fLAORk/Lt9weqx8Irwqt34qBMX5Bwk3bb8YvLMk2Bq3cUAmSiqnC0LQiUho+hycplYKH
N5kmC4taVpeDsX9HlChGOxYjtOy/7Us6naWvDMWpKlw/BqjAL3LqGjlt1MjdXwE2jQaf1urBMvQA
xNs3gcfUntcUnGRg+NT1HA1KoHrTJo0Cq2QtXXbAvp2NgRXCkc3W7UsJpN7+nTaYT6q1d/HKP1g3
bxgzgUZvoiB1H8xTuU+D7lvFHC1PltEC6YG0aN2mN+KhjJvL3ery9hLD5EQ1c2O1+n87d6N5kce3
ixGmEtNP208Acrc6cNS4q/eBJ7f8oA6TSH+qpmVRlvm0LSvl3E0fwRsXk13MYRyJ758/D6/HP+M3
fKDkfapb+OomrfZ8zUD7Q3LTtHxLc55c9GB/hOEKKDcSiJfe9v5I7DDXhF14HitLEn4mUWTFA+I9
Bnk101f7WQmNmTOCLiYW6zhvGGdEQn1tMdHbL8O+Sp0GFsOh9eHP7+N7a4hwuFU+9YCWGbzrEN1P
jkGej+ly0RxTA7YJabnWp3sbGQdaE752EsesVZ6OiSV4ExtRM5JLkbnC6IYzyg5Kk9l8ldUMu5MF
nrxmXrxUv47G7HAYBnd1XMeO9NVP5Iud1GItl3Yfi1NRknweX/Zvx9dnpUUbvz1Dl4Ajov+/Hl8u
yMfH+/OrgqKn45N+vdHnLMx8aaZ+mMd3dGwgIfj5/vy/i1/vP/Qzqj69IHTVj6h8yYSC++A4DHww
q+797Rp4q30nuMND68cLUsB1Rlwl3E2kss1I6LCX9O/+4ziuwypczJ3VqIB2evW2KoxBH0MWLfGO
nkVXjrSllLYmoBVAveWssggz6qZxIMcmJ445opNy4rAMcln9dk1mjjJI8kTEkuNqNveO0rTCHDj0
E0U5EYVqniZkcsJqcjpuznYYv/5+MXQ3h+mbO6b09qzzeukoNICuVEZ8eR1Q7ziUIunShwesuE+o
v+eFcmfEmNM27MDBhasDAv0aDxaZyjQdNRlN6jbHZk0eiXfq5oRxMr88g6VrBP+MGvsTi6sSM+w3
rBPEC98XU43QsTiy2xlh+/X7sP/4sPTyhopOGOZTu2N5xIyM9jP241jhtHp6+/H+6yL//PX3/nCR
7t/2h6ejOwck51RupKs8xbvD+t7RG+CpQkki2yeqi21Nk7z5dnO1w/Y5m21m7dgkBU5rwBOcA1Fe
ehNt/wpEKaCFaqcHJnBErd+IAwx7Kd3mszKxSB8tMzxGTlQmbFvNKinEy9UWlGUb7IUbpNk6CffB
gdyCF8h9RUBzUnVby7HFDvb69+Hp8Ofi8P55fH3Tl9uAym0mmNnS6qTX6wAFKVDJkhkP9JMZA8/j
nQ9mxA4tV1cpLlEhzJ4TzrAVI2zE7DKiibMXymVa1I0Z/cKSXcNvjqBy7AwCQK9OAnbNaK7GnUXt
RqN2GfsIHRgEa9NA1InWpI96D9WAQAJzJ8IeM4IAhd7ZeaM8PNsk+yQKnCrpvppZp/j1H5xOX4Nd
6gAA

--Boundary-00=_6APEMx9TFBmmVpW--
