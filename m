From: Fabio Coatti <fabio.coatti@gmail.com>
Date: Mon, 19 Mar 2012 18:25:58 +0000
Subject: Radeon fb issue: invalid framebuffer id kernel 3.2.12
Message-Id: <CADpTngU6fL3r3cHsH3B6Hx68Bm4R_baoBeVmvGf6bUJPV3CXbA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi all,
I'm setting up a new laptot with Advanced Micro Devices [AMD] nee ATI
Seymour [Radeon HD 6400M Series] card, using radeon drivers. I'm
facing an issue for wich I found a lot of references but no actual
solution, so I'm asking here for some help

Basically it works quite fine, except for fb.

description of the issue:

at boot, once fb is fired up i get a black screen, afer some usual
boot messages. Connecting via ssh I can launch X and all works just
fine; however with ctrl-alt-F1 the screen freezes immediately with
this error in dmesg:
drm:drm_mode_getfb] *ERROR* invalid framebuffer id

some more debug lines:

[drm:drm_helper_probe_single_connector_modes], [CONNECTOR:23:VGA-1]
[drm:radeon_atom_dac_detect], Bios 0 scratch 40000 00000001
[drm:radeon_atombios_connected_scratch_regs], CRT1 disconnected
[drm:drm_helper_probe_single_connector_modes], [CONNECTOR:23:VGA-1] disconnected
[drm:radeon_lvds_set_property],
[drm:drm_mode_getfb] *ERROR* invalid framebuffer id


If I hit ctrl-alt-F7 all work just fine: screen unfreezes and I can
work without other issues.

Perfectly repeatable.

I can provide more debug logs and data, if needed; just place me in
CC: list as I'm not subscribed to this list.

Kernel: 3.2.12 3.2.12 #1 SMP PREEMPT Mon Mar 19 18:54:30 CET 2012
x86_64 Intel(R) Core(TM) i5-2520M CPU @ 2.50GHz GenuineIntel GNU/Linux

dmesg excerpt:

Mar 19 19:01:58 calvin kernel: [drm] radeon kernel modesetting enabled.
Mar 19 19:01:58 calvin kernel: radeon 0000:01:00.0: PCI INT A -> GSI
16 (level, low) -> IRQ 16
Mar 19 19:01:58 calvin kernel: radeon 0000:01:00.0: setting latency timer to 64
Mar 19 19:01:58 calvin kernel: [drm] initializing kernel modesetting
(CAICOS 0x1002:0x6760 0x103C:0x161E).
Mar 19 19:01:58 calvin kernel: [drm] register mmio base: 0xD4400000
Mar 19 19:01:58 calvin kernel: [drm] register mmio size: 131072
Mar 19 19:01:58 calvin kernel: ATOM BIOS: HP
Mar 19 19:01:58 calvin kernel: radeon 0000:01:00.0: VRAM: 1024M
0x0000000000000000 - 0x000000003FFFFFFF (1024M used)
Mar 19 19:01:58 calvin kernel: radeon 0000:01:00.0: GTT: 512M
0x0000000040000000 - 0x000000005FFFFFFF
Mar 19 19:01:58 calvin kernel: [drm] Detected VRAM RAM24M, BAR%6M
Mar 19 19:01:58 calvin kernel: [drm] RAM width 64bits DDR
Mar 19 19:01:58 calvin kernel: [TTM] Zone  kernel: Available graphics
memory: 4059236 kiB.
Mar 19 19:01:58 calvin kernel: [TTM] Zone   dma32: Available graphics
memory: 2097152 kiB.
Mar 19 19:01:58 calvin kernel: [TTM] Initializing pool allocator.
Mar 19 19:01:58 calvin kernel: [drm] radeon: 1024M of VRAM memory ready
Mar 19 19:01:58 calvin kernel: [drm] radeon: 512M of GTT memory ready.
Mar 19 19:01:58 calvin kernel: [drm] Supports vblank timestamp caching
Rev 1 (10.10.2010).
Mar 19 19:01:58 calvin kernel: [drm] Driver supports precise vblank
timestamp query.
Mar 19 19:01:58 calvin kernel: radeon 0000:01:00.0: irq 54 for MSI/MSI-X
Mar 19 19:01:58 calvin kernel: radeon 0000:01:00.0: radeon: using MSI.
Mar 19 19:01:58 calvin kernel: [drm] radeon: irq initialized.
Mar 19 19:01:58 calvin kernel: [drm] GART: num cpu pages 131072, num
gpu pages 131072
Mar 19 19:01:58 calvin kernel: [drm] Loading CAICOS Microcode
[...]
Mar 19 19:01:58 calvin kernel: [drm] ring test succeeded in 3 usecs
Mar 19 19:01:58 calvin kernel: [drm] radeon: ib pool ready.
Mar 19 19:01:58 calvin kernel: [drm] ib test succeeded in 0 usecs
Mar 19 19:01:58 calvin kernel: [drm:radeon_process_aux_ch], dp_aux_ch
flags not zero
Mar 19 19:01:58 calvin kernel: [drm:radeon_process_aux_ch], dp_aux_ch
flags not zero
Mar 19 19:01:58 calvin kernel: [drm:radeon_process_aux_ch], dp_aux_ch
flags not zero
Mar 19 19:01:58 calvin kernel: [drm:radeon_process_aux_ch], dp_aux_ch
flags not zero
Mar 19 19:01:58 calvin kernel: [drm:radeon_dp_i2c_aux_ch], aux i2c too
many retries, giving up
Mar 19 19:01:58 calvin kernel: [drm:radeon_process_aux_ch], dp_aux_ch
flags not zero
Mar 19 19:01:58 calvin kernel: [drm:radeon_process_aux_ch], dp_aux_ch
flags not zero
[repeated several times]
Mar 19 19:01:58 calvin kernel: [drm:radeon_process_aux_ch], dp_aux_ch
flags not zero
Mar 19 19:01:58 calvin kernel: [drm:radeon_process_aux_ch], dp_aux_ch
flags not zero
Mar 19 19:01:58 calvin kernel: [drm:radeon_process_aux_ch], dp_aux_ch
flags not zero
Mar 19 19:01:58 calvin kernel: [drm:radeon_dp_i2c_aux_ch], aux i2c too
many retries, giving up
Mar 19 19:01:58 calvin kernel: [drm] Radeon Display Connectors
Mar 19 19:01:58 calvin kernel: [drm] Connector 0:
Mar 19 19:01:58 calvin kernel: [drm]   LVDS
Mar 19 19:01:58 calvin kernel: [drm]   DDC: 0x6430 0x6430 0x6434
0x6434 0x6438 0x6438 0x643c 0x643c
Mar 19 19:01:58 calvin kernel: [drm]   Encoders:
Mar 19 19:01:58 calvin kernel: [drm]     LCD1: INTERNAL_UNIPHY
Mar 19 19:01:58 calvin kernel: [drm] Connector 1:
Mar 19 19:01:58 calvin kernel: [drm]   DisplayPort
Mar 19 19:01:58 calvin kernel: [drm]   HPD1
Mar 19 19:01:58 calvin kernel: [drm]   DDC: 0x6460 0x6460 0x6464
0x6464 0x6468 0x6468 0x646c 0x646c
Mar 19 19:01:58 calvin kernel: [drm]   Encoders:
Mar 19 19:01:58 calvin kernel: [drm]     DFP1: INTERNAL_UNIPHY1
Mar 19 19:01:58 calvin kernel: [drm] Connector 2:
Mar 19 19:01:58 calvin kernel: [drm]   DisplayPort
Mar 19 19:01:58 calvin kernel: [drm]   HPD2
Mar 19 19:01:58 calvin kernel: [drm]   DDC: 0x6440 0x6440 0x6444
0x6444 0x6448 0x6448 0x644c 0x644c
Mar 19 19:01:58 calvin kernel: [drm]   Encoders:
Mar 19 19:01:58 calvin kernel: [drm]     DFP2: INTERNAL_UNIPHY1
Mar 19 19:01:58 calvin kernel: [drm] Connector 3:
Mar 19 19:01:58 calvin kernel: [drm]   DisplayPort
Mar 19 19:01:58 calvin kernel: [drm]   HPD3
Mar 19 19:01:58 calvin kernel: [drm]   DDC: 0x6450 0x6450 0x6454
0x6454 0x6458 0x6458 0x645c 0x645c
Mar 19 19:01:58 calvin kernel: [drm]   Encoders:
Mar 19 19:01:58 calvin kernel: [drm]     DFP3: INTERNAL_UNIPHY2
Mar 19 19:01:58 calvin kernel: [drm] Connector 4:
Mar 19 19:01:58 calvin kernel: [drm]   VGA
Mar 19 19:01:58 calvin kernel: [drm]   DDC: 0x64d8 0x64d8 0x64dc
0x64dc 0x64e0 0x64e0 0x64e4 0x64e4
Mar 19 19:01:58 calvin kernel: [drm]   Encoders:
Mar 19 19:01:58 calvin kernel: [drm]     CRT1: INTERNAL_KLDSCP_DAC1
Mar 19 19:01:58 calvin kernel: [drm] Internal thermal controller with
fan control
Mar 19 19:01:58 calvin kernel: [drm] radeon: power management initialized
Mar 19 19:01:58 calvin kernel: [drm:radeon_atom_encoder_dpms], encoder
dpms 30 to mode 3, devices 00000002, active_devices 00000000


Thanks for any hint or pointer  and forgive me if I missed some
obvious solution while googling :)

PS: just in case: CC:me as I'm not subscribed to this list. Thanks again.
-- 
Fabio
