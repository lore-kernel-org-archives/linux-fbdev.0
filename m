From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Thu, 10 Jun 2010 14:33:11 +0000
Subject: Re: REGRESSION: dpms-on broken (drm_radeon,displayport)
Message-Id: <1276180391.11359.85.camel@thor.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201006101601.30483.lars.doelle@on-line.de>
In-Reply-To: <201006101601.30483.lars.doelle@on-line.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lars Doelle <lars.doelle@on-line.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, dri-devel@lists.freedesktop.org


Moving to the dri-devel list as you're using KMS.

On Don, 2010-06-10 at 16:01 +0200, Lars Doelle wrote: 
> Hi Benjamin,
> Hi All,
> 
> 
> i write to report a regression that happened after 2.6.34-rc3 and before
> or including 2.6.34-rc4 and still persists on 2.6.35-rc2.
> 
> The effect is, that after DPMS-OFF, the monitor cannot be reactivated
> locally by a key press or remotely via `xset dpms force on´.
> 
> I can work around the issue switching the monitor off and on again.
> 
> For the technical details of the local environment see below.
> I can provide more information on request and offer help testing patches.
> 
> 
> 
> Kind regards
> 
>   Lars
> 
> 
> --------------------------------
> 
> 
> - config.gz attached, below some lines.
> 
> CONFIG_X86_64=y
> 
> CONFIG_DRM=y
> CONFIG_DRM_KMS_HELPER=y
> CONFIG_DRM_TTM=y
> CONFIG_DRM_RADEON=y
> CONFIG_DRM_RADEON_KMS=y
> CONFIG_VIDEO_OUTPUT_CONTROL=y
> 
> 
> - X11: find attached the Xorg.0.log for full information
> 
> X.Org X Server 1.7.7
> Release Date: 2010-05-04
> [..]
> (**) |-->Screen "Default Screen" (0)
> (**) |   |-->Monitor "DELL 2408WFP"
> (**) |   |-->Device "ATI FireMV 2260"
> [..]
> (II) RADEON(0): Output DisplayPort-0 using monitor section DELL 2408WFP
> [..]
> (**) RADEON(0): DPMS enabled
> 
> 
> - Notes from the kernel.log
> 
> following messages occur only >= 2.6.34-rc4. I think they are issued
> when i `xset dpms force off´ or dpms is used automatically.
> 
> ...
> 
> : [drm:dp_link_train] *ERROR* clock recovery tried 5 times
> : [drm:dp_link_train] *ERROR* clock recovery failed
> : [drm:dp_link_train] *ERROR* channel eq failed: 5 tries
> : [drm:dp_link_train] *ERROR* channel eq failed
> 
> ...
> 
> The following messages might be unrelated to the problem and occur
> on 2.6.34-rc3 too, when i switch the monitor off/on.
> 
> : [drm:atom_dp_get_link_status] *ERROR* displayport link status failed
> : [drm:atom_dp_get_link_status] *ERROR* displayport link status failed
> : [drm:atom_dp_get_link_status] *ERROR* displayport link status failed
> 
> Below stuff from the initiation ...
> 
> ...
> 
> : [drm] Initialized drm 1.1.0 20060810
> : [drm] radeon defaulting to kernel modesetting.
> : [drm] radeon kernel modesetting enabled.
> : radeon 0000:01:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> : radeon 0000:01:00.0: setting latency timer to 64
> : [drm] radeon: Initializing kernel modesetting.
> : [drm] register mmio base: 0x90200000
> : [drm] register mmio size: 65536
> : ATOM BIOS: 113
> : [drm] Clocks initialized !
> : [drm] Internal thermal controller with fan control
> : [drm] 3 Power State(s)
> : [drm] State 0 Default (default)
> : [drm] 	16 PCIE Lanes
> : [drm] 	3 Clock Mode(s)
> : [drm] 		0 engine/memory: 500000/500000
> : [drm] 		1 engine/memory: 500000/500000
> : [drm] 		2 engine/memory: 500000/500000
> : [drm] State 1 Performance 
> : [drm] 	16 PCIE Lanes
> : [drm] 	3 Clock Mode(s)
> : [drm] 		0 engine/memory: 110000/252000
> : [drm] 		1 engine/memory: 300000/396000
> : [drm] 		2 engine/memory: 500000/500000
> : [drm] State 2 Performance 
> : [drm] 	16 PCIE Lanes
> : [drm] 	3 Clock Mode(s)
> : [drm] 		0 engine/memory: 450000/500000
> : [drm] 		1 engine/memory: 450000/500000
> : [drm] 		2 engine/memory: 500000/500000
> : [drm] radeon: power management initialized
> : radeon 0000:01:00.0: VRAM: 256M 0x00000000 - 0x0FFFFFFF (256M used)
> : radeon 0000:01:00.0: GTT: 512M 0x10000000 - 0x2FFFFFFF
> : [drm] Detected VRAM RAM%6M, BAR%6M
> : [drm] RAM width 64bits DDR
> : Available graphics memory: 1017548 kiB.
> : [drm] radeon: 256M of VRAM memory ready
> : [drm] radeon: 512M of GTT memory ready.
> : radeon 0000:01:00.0: irq 30 for MSI/MSI-X
> : [drm] radeon: using MSI.
> : [drm] radeon: irq initialized.
> : [drm] GART: num cpu pages 131072, num gpu pages 131072
> : [drm] Loading RV620 Microcode
> : platform radeon_cp.0: firmware: using built-in firmware radeon/RV620_pfp.bin
> : platform radeon_cp.0: firmware: using built-in firmware radeon/RV620_me.bin
> : platform radeon_cp.0: firmware: using built-in firmware radeon/R600_rlc.bin
> : [drm] ring test succeeded in 1 usecs
> : [drm] radeon: ib pool ready.
> : [drm] ib test succeeded in 0 usecs
> : [drm] Enabling audio support
> : [drm] Radeon Display Connectors
> : [drm] Connector 0:
> : [drm]   DisplayPort
> : [drm]   HPD2
> : [drm]   DDC: 0x7e60 0x7e60 0x7e64 0x7e64 0x7e68 0x7e68 0x7e6c 0x7e6c
> : [drm]   Encoders:
> : [drm]     DFP1: INTERNAL_UNIPHY
> : [drm] Connector 1:
> : [drm]   DisplayPort
> : [drm]   HPD4
> : [drm]   DDC: 0x7e20 0x7e20 0x7e24 0x7e24 0x7e28 0x7e28 0x7e2c 0x7e2c
> : [drm]   Encoders:
> : [drm]     DFP2: INTERNAL_UNIPHY
> : [drm] fb mappable at 0x80141000
> : [drm] vram apper at 0x80000000
> : [drm] size 9216000
> : [drm] fb depth is 24
> : [drm]    pitch is 7680
> : Console: switching to colour frame buffer device 240x75
> : fb0: radeondrmfb frame buffer device
> : registered panic notifier
> : [drm] Initialized radeon 2.2.0 20080528 for 0000:01:00.0 on minor 0


-- 
Earthling Michel Dänzer           |                http://www.vmware.com
Libre software enthusiast         |          Debian, X and DRI developer
