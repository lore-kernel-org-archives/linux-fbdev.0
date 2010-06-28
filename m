From: Rui Santos <rsantos@grupopie.com>
Date: Mon, 28 Jun 2010 17:59:26 +0000
Subject: DRM dual head
Message-Id: <4C28E2FE.10803@grupopie.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

  Hi all,

     I am aware that this is a Development List. However I didn't find 
any FB-User list. If this is not the correct place to post this subject, 
please redirect me to the correct one.

     I'm trying to get an Intel 82852/855GM to work on a Dual-Head mode 
in a non-clone mode. What I want if for both connected monitors to work 
"independently".
     I'm able to do this with DRM but only when using XServer. When I do 
not use X, only one framebuffer is made available through /dev/fb0 by 
inteldrmfb, although both VGA-1 and LVDS-1 are "seen" by DRM (with a few 
errors though).
     I've tried the fbpercrtc=1 parameter (not sure if this has anything 
to do with it), but without any success.
     Is it even possible to do it without X ?
     Here is the kernel's relevant output log:

Linux agpgart interface v0.103
agpgart-intel 0000:00:00.0: Intel 855GM Chipset
agpgart-intel 0000:00:00.0: detected 8060K stolen memory
agpgart-intel 0000:00:00.0: AGP aperture is 128M @ 0xe8000000
[drm] Initialized drm 1.1.0 20060810
[drm:drm_init],
[drm:drm_get_dev],
i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
i915 0000:00:02.0: setting latency timer to 64
[drm:drm_get_minor],
[drm:drm_get_minor], new minor assigned 64
[drm:drm_get_minor],
[drm:drm_get_minor], new minor assigned 0
[drm] set up 7M of stolen space
[drm:drm_agp_bind_pages],
ACPI: Battery Slot [BAT2] (battery absent)
[drm:drm_sysfs_connector_add], adding "VGA-1" to sysfs
[drm:drm_sysfs_hotplug_event], generating hotplug event
[drm:drm_edid_block_valid] *ERROR* EDID checksum is invalid, remainder 
is 158
[drm:drm_edid_block_valid] *ERROR* Raw EDID:
55 aa 80 0c 00 80 00 00 00 00 03 00 00 00 20 03  U............. .
58 02 0f 00 01 05 4c 51 31 32 31 53 31 4c 47 36  X.....LQ121S1LG6
31 5f 33 00 00 00 00 00 00 00 00 00 00 00 20 03  1_3........... .
58 02 06 00 80 bb 00 00 3e 00 3b 00 70 94 00 00  X.......>.;.p...
de 03 32 00 5a 00 32 00 74 02 74 02 a8 02 03 00  ..2.Z.2.t.t.....
02 00 17 00 07 00 1e da da 1e c2 01 ff 01 00 00  ................
07 00 08 33 01 33 01 00 00 00 00 00 00 00 00 00  ...3.3..........
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

[drm:drm_edid_block_valid] *ERROR* EDID checksum is invalid, remainder 
is 158
[drm:drm_edid_block_valid] *ERROR* Raw EDID:
55 aa 80 0c 00 80 00 00 00 00 03 00 00 00 20 03  U............. .
58 02 0f 00 01 05 4c 51 31 32 31 53 31 4c 47 36  X.....LQ121S1LG6
31 5f 33 00 00 00 00 00 00 00 00 00 00 00 20 03  1_3........... .
58 02 06 00 80 bb 00 00 3e 00 3b 00 70 94 00 00  X.......>.;.p...
de 03 32 00 5a 00 32 00 74 02 74 02 a8 02 03 00  ..2.Z.2.t.t.....
02 00 17 00 07 00 1e da da 1e c2 01 ff 01 00 00  ................
07 00 08 33 01 33 01 00 00 00 00 00 00 00 00 00  ...3.3..........
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

[drm:drm_edid_block_valid] *ERROR* EDID checksum is invalid, remainder 
is 158
[drm:drm_edid_block_valid] *ERROR* Raw EDID:
55 aa 80 0c 00 80 00 00 00 00 03 00 00 00 20 03  U............. .
58 02 0f 00 01 05 4c 51 31 32 31 53 31 4c 47 36  X.....LQ121S1LG6
31 5f 33 00 00 00 00 00 00 00 00 00 00 00 20 03  1_3........... .
58 02 06 00 80 bb 00 00 3e 00 3b 00 70 94 00 00  X.......>.;.p...
de 03 32 00 5a 00 32 00 74 02 74 02 a8 02 03 00  ..2.Z.2.t.t.....
02 00 17 00 07 00 1e da da 1e c2 01 ff 01 00 00  ................
07 00 08 33 01 33 01 00 00 00 00 00 00 00 00 00  ...3.3..........
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

[drm:drm_edid_block_valid] *ERROR* EDID checksum is invalid, remainder 
is 158
[drm:drm_edid_block_valid] *ERROR* Raw EDID:
55 aa 80 0c 00 80 00 00 00 00 03 00 00 00 20 03  U............. .
58 02 0f 00 01 05 4c 51 31 32 31 53 31 4c 47 36  X.....LQ121S1LG6
31 5f 33 00 00 00 00 00 00 00 00 00 00 00 20 03  1_3........... .
58 02 06 00 80 bb 00 00 3e 00 3b 00 70 94 00 00  X.......>.;.p...
de 03 32 00 5a 00 32 00 74 02 74 02 a8 02 03 00  ..2.Z.2.t.t.....
02 00 17 00 07 00 1e da da 1e c2 01 ff 01 00 00  ................
07 00 08 33 01 33 01 00 00 00 00 00 00 00 00 00  ...3.3..........
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................

i915 0000:00:02.0: LVDS-1: EDID block 0 invalid.
[drm:drm_sysfs_connector_add], adding "LVDS-1" to sysfs
[drm:drm_sysfs_hotplug_event], generating hotplug event
[drm] initialized overlay support
[drm:drm_irq_install], irq
[drm:drm_agp_bind_pages],
fbcon: inteldrmfb (fb0) is primary device
[drm:drm_vblank_get], enabling vblank on crtc 0, ret: -22
[drm:drm_crtc_helper_set_mode], DAC-6: set mode 800x600 17
[drm:drm_vblank_get], enabling vblank on crtc 1, ret: -22
[drm:drm_crtc_helper_set_mode], LVDS-8: set mode 800x600 18
Console: switching to colour frame buffer device 100x37
fb0: inteldrmfb frame buffer device
drm: registered panic notifier
Slow work thread pool: Starting up
Slow work thread pool: Ready
[drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0

Thanks a lot for your help,
Rui Santos

