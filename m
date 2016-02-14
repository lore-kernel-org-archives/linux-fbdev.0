From: Lars =?ISO-8859-1?Q?D=F6lle?= <lars.doelle@on-line.de>
Date: Sun, 14 Feb 2016 15:59:58 +0000
Subject: RADEON/4.3.0 sets non-native screen resolution for the console
Message-Id: <2076177.cEDS1jCEQG@x64.localnet>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi All,

since quite a while, the RADEON frame buffer driver does not longer initially
sets the native screen resolution for the console, which is 1920x1200 here, 
but decides on 1024x768 instead. The display uses a display-port connector, 
which might be the particularity.

As you see, this is a stock debian kernel, but I have the same effect with
locally compiled kernels. Earlier kernels up to late 3.x worked well in this
respect, so do drivers for other hardware. Thus I assume that the effect is
unwanted. I can not work around the problem, since mode setting is not longer
available.

I'm not sure what information you'd need beside the ones included below, but
I would gladly provide them on request and/or could try out a patch if 
necessary.

Kind regards

  Lars

-- ---

$ lspci

01:00.0 VGA compatible controller: Advanced Micro Devices, Inc.[AMD/ATI] RV620 
GL [FirePro 2260]

$ journalctl -b | grep radeon|drm|fbcon

: Linux version 4.3.0-1-amd64 (debian-kernel@lists.debian.org)
: [drm] Initialized drm 1.1.0 20060810
: [drm] radeon kernel modesetting enabled.
: [drm] initializing kernel modesetting (RV620 0x1002:0x95CF 0x1002:0x2143).
: [drm] register mmio base: 0xE0200000
: [drm] register mmio size: 65536
: radeon 0000:01:00.0: VRAM: 256M 0x0000000000000000 - 0x000000000FFFFFFF 
(256M used)
: radeon 0000:01:00.0: GTT: 512M 0x0000000010000000 - 0x000000002FFFFFFF
: [drm] Detected VRAM RAM%6M, BAR%6M
: [drm] RAM width 64bits DDR
: [drm] radeon: 256M of VRAM memory ready
: [drm] radeon: 512M of GTT memory ready.
: [drm] Loading RV620 Microcode
: radeon 0000:01:00.0: firmware: direct-loading firmware radeon/RV620_pfp.bin
: radeon 0000:01:00.0: firmware: direct-loading firmware radeon/RV620_me.bin
: radeon 0000:01:00.0: firmware: direct-loading firmware radeon/R600_rlc.bin
: [drm] Internal thermal controller with fan control
: [drm] radeon: power management initialized
: radeon 0000:01:00.0: firmware: direct-loading firmware radeon/R600_uvd.bin
: [drm] GART: num cpu pages 131072, num gpu pages 131072
: [drm] PCIE GART of 512M enabled (table at 0x0000000000254000).
: radeon 0000:01:00.0: WB enabled
: radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x0000000010000c00 
and cpu addr 0xffff8800c9c81c00
: radeon 0000:01:00.0: fence driver on ring 5 use gpu addr 0x00000000000521d0 
and cpu addr 0xffffc900010121d0
: [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
: [drm] Driver supports precise vblank timestamp query.
: radeon 0000:01:00.0: radeon: MSI limited to 32-bit
: radeon 0000:01:00.0: radeon: using MSI.
: [drm] radeon: irq initialized.
: [drm] ring test on 0 succeeded in 1 usecs
: [drm] ring test on 5 succeeded in 1 usecs
: [drm] UVD initialized successfully.
: [drm] ib test on ring 0 succeeded in 0 usecs
: [drm] ib test on ring 5 succeeded
: [drm] Radeon Display Connectors
: [drm] Connector 0:
: [drm]   DP-1
: [drm]   HPD2
: [drm]   DDC: 0x7e60 0x7e60 0x7e64 0x7e64 0x7e68 0x7e68 0x7e6c 0x7e6c
: [drm]   Encoders:
: [drm]     DFP1: INTERNAL_UNIPHY
: [drm] Connector 1:
: [drm]   DP-2
: [drm]   HPD4
: [drm]   DDC: 0x7e20 0x7e20 0x7e24 0x7e24 0x7e28 0x7e28 0x7e2c 0x7e2c
: [drm]   Encoders:
: [drm]     DFP2: INTERNAL_UNIPHY
: [drm] fb mappable at 0xD0355000
: [drm] vram apper at 0xD0000000
: [drm] size 3145728
: [drm] fb depth is 24
: [drm]    pitch is 4096
: fbcon: radeondrmfb (fb0) is primary device
: radeon 0000:01:00.0: fb0: radeondrmfb frame buffer device
: [drm] Initialized radeon 2.43.0 20080528 for 0000:01:00.0 on minor 0

