From: Pavel Machek <pavel@ucw.cz>
Date: Tue, 03 Nov 2015 23:15:49 +0000
Subject: Re: Mobility Radeon HD 4530/4570/545v: flicker in 1920x1080
Message-Id: <20151103231548.GA3656@amd>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20151031201344.GA30459@amd> <563522C5.1000206@amd.com>
 <20151031212259.GA6253@amd>
 <CADnq5_MoThbrDADBHBRXiEGWC8jukwOLyfjfX9-7d0fB0kbpMA@mail.gmail.com>
 <20151103220919.GA4824@amd>
 <CADnq5_P8TOQ14NiWKgV-YUy0_8P+K842pZ4h7WuU6XBu4o9fyQ@mail.gmail.com>
In-Reply-To: <CADnq5_P8TOQ14NiWKgV-YUy0_8P+K842pZ4h7WuU6XBu4o9fyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, kernel list <linux-kernel@vger.kernel.org>

Hi!

> >> Unfortunately, it can't be applied as is because we had a similar
> >> patch which was reverted because it regressed a bunch of other
> >> systems.  The actual pll limits probably need to be tweaked.
> >
> > Any ideas how to tweak the pll limits?
> 
> Adjust the the algorithm in radeon_compute_pll_avivo() in radeon_display.c

Hmm. Two values have diff = 0, I guess that leaves little room for
improvement, as we already tried both with the PREFER_... setting.
[    1.236229] Linux agpgart interface v0.103
[    1.236829] [drm] Initialized drm 1.1.0 20060810
[    1.237013] [drm] radeon kernel modesetting enabled.
[    1.238284] [drm] initializing kernel modesetting (RV710
0x1002:0x9553 0x1025:0x0212)
.
[    1.238362] [drm] register mmio base: 0xD6200000
[    1.238417] [drm] register mmio size: 65536
[    1.238622] ATOM BIOS: BR34582.001
[    1.238789] radeon 0000:01:00.0: VRAM: 512M 0x0000000000000000 -
0x000000001FFFFFFF (
512M used)
[    1.238856] radeon 0000:01:00.0: GTT: 1024M 0x0000000020000000 -
0x000000005FFFFFFF
[    1.238915] [drm] Detected VRAM RAMQ2M, BAR%6M
[    1.238970] [drm] RAM width 64bits DDR
[    1.239266] [TTM] Zone  kernel: Available graphics memory: 431276
kiB
[    1.239323] [TTM] Zone highmem: Available graphics memory: 1546602
kiB
[    1.239380] [TTM] Initializing pool allocator
[    1.240936] [TTM] Initializing DMA pool allocator
[    1.241174] [drm] radeon: 512M of VRAM memory ready
[    1.241231] [drm] radeon: 1024M of GTT memory ready.
[    1.241345] [drm] Loading RV710 Microcode
[    1.241483] radeon 0000:01:00.0: Direct firmware load for
radeon/RV710_smc.bin failed
 with error -2
 [    1.241553] smc: error loading firmware "radeon/RV710_smc.bin"
 [    1.241638] [drm] radeon: power management initialized
 [    1.241754] radeon 0000:01:00.0: Direct firmware load for
 radeon/RV710_uvd.bin failed
  with error -2
  [    1.241823] radeon 0000:01:00.0: radeon_uvd: Can't load firmware
  "radeon/RV710_uvd.bi
n"
[    1.241885] [drm] GART: num cpu pages 262144, num gpu pages 262144
[    1.257273] [drm] PCIE GART of 1024M enabled (table at
0x0000000000040000).
[    1.257456] radeon 0000:01:00.0: WB enabled
[    1.257514] radeon 0000:01:00.0: fence driver on ring 0 use gpu
addr 0x0000000020000c
00 and cpu addr 0xffc01c00
[    1.257582] radeon 0000:01:00.0: fence driver on ring 3 use gpu
addr 0x0000000020000c0c and cpu addr 0xffc01c0c
[    1.257655] [drm] Supports vblank timestamp caching Rev 2
(21.10.2013).
[    1.257713] [drm] Driver supports precise vblank timestamp query.
[    1.257770] radeon 0000:01:00.0: radeon: MSI limited to 32-bit
[    1.257921] [drm] radeon: irq initialized.
[    1.304343] [drm] ring test on 0 succeeded in 1 usecs
[    1.304403] [drm] ring test on 3 succeeded in 2 usecs
[    1.304835] [drm] ib test on ring 0 succeeded in 0 usecs
[    1.304912] [drm] ib test on ring 3 succeeded in 0 usecs
[    1.307453] [drm] Radeon Display Connectors
[    1.307511] [drm] Connector 0:
[    1.307565] [drm]   VGA-1
[    1.307619] [drm]   DDC: 0x7e40 0x7e40 0x7e44 0x7e44 0x7e48 0x7e48
0x7e4c 0x7e4c
[    1.307677] [drm]   Encoders:
[    1.307730] [drm]     CRT1: INTERNAL_KLDSCP_DAC1
[    1.336107] ACPI: Deprecated procfs I/F for battery is loaded,
please retry with CONFIG_ACPI_PROCFS_POWER cleared
[    1.336209] ACPI: Battery Slot [BAT0] (battery absent)
[    1.342090] [drm] fb mappable at 0xC0241000
[    1.342146] [drm] vram apper at 0xC0000000
[    1.342201] [drm] size 8294400
[    1.342254] [drm] fb depth is 24
[    1.342307] [drm]    pitch is 7680
[    1.342777] fbcon: radeondrmfb (fb0) is primary device
[    1.344374] post_div = 5, diff = 270
[    1.344375] post_div = 6, diff = 0
[    1.344375] post_div = 7, diff = 192
[    1.344376] post_div = 8, diff = 0
[    1.344377] Selected post_div = 8
[    1.344378] 148500 - 148500, pll dividers - fb: 88.0 ref: 2, post 8
[    1.381561] Console: switching to colour frame buffer device 192x60
[    1.391454] radeon 0000:01:00.0: fb0: radeondrmfb frame buffer
device
[    1.404499] [drm] Initialized radeon 2.43.0 20080528 for
0000:01:00.0 on minor 0
[    1.404669] [drm] amdgpu kernel modesetting enabled.
[    1.416219] loop: module loaded
[    1.418413] nbd: registered device at major 43

The "error loading firmware" messages confuse me a bit, but I do have
some firmware built into kernel,  and 3D acceleration seems to work.

pavel@half:/data/l/linux$ grep FIRMWARE .config
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE="radeon/R700_rlc.bin"
CONFIG_EXTRA_FIRMWARE_DIR="/lib/firmware"
# CONFIG_CYPRESS_FIRMWARE is not set
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
CONFIG_FIRMWARE_EDID=y
CONFIG_FIRMWARE_MEMMAP=y
# CONFIG_GOOGLE_FIRMWARE is not set
# CONFIG_TEST_FIRMWARE is not set
pavel@half:/data/l/linux$

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
