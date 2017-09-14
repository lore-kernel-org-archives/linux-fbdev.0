From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 14 Sep 2017 11:40:34 +0000
Subject: [GIT PULL] fbdev changes for v4.14
Message-Id: <2286981.Utx30C2Z1O@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170914114037epcas2p201ac90d7c5f9a0a8290d985778ba2c4c@epcas2p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev changes for v4.14. There is slightly more changes than
usual this time (especially fbcon changes stand out from the rest), please
see the signed tag description for details.

Test merge revealed a small merge conflict, the resolution is trivial:

diff --cc drivers/video/fbdev/core/fbmem.c
index 25e862c,a35f788b..f741ba8
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@@ -32,7 -32,7 +32,8 @@@
  #include <linux/device.h>
  #include <linux/efi.h>
  #include <linux/fb.h>
+ #include <linux/fbcon.h>
 +#include <linux/mem_encrypt.h>
 =20
  #include <asm/fb.h>
 =20

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit dd0c41f8a7e0babdadc61d5201ac8505a79dec05:

  efifb: allow user to disable write combined mapping. (2017-07-31 18:45:41=
 +0200)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.14

for you to fetch changes up to 23e9f4ef99dd313fc8d19c326f6518459a402d71:

  video/console: Update BIOS dates list for GPD win console rotation DMI qu=
irk (2017-09-07 13:18:33 +0200)

----------------------------------------------------------------
fbdev changes for v4.14:

- make fbcon a built-time depency for fbdev (fbcon was tristate option
  before, now it is a bool) - this is a first step in preparations for
  making console_lock usage saner (currently it acts like the BKL for
  all things fbdev/fbcon) (Daniel Vetter)

- add fbcon=3Dmargin:<color> command line option to select the fbcon margin
  color (David Lechner)

- add DMI quirk table for x86 systems which need fbcon rotation (devices
  like Asus T100HA, GPD Pocket, the GPD win and the I.T.Works TW891)
  (Hans de Goede)

- fix 1bpp logo support for unusual width (needed by LEGO MINDSTORMS EV3)
  (David Lechner)

- enable Xilinx FB driver for ARM ZynqMP platform (Michal Simek)

- fix use after free in the error path of udlfb driver (Anton Vasilyev)

- fix error return code handling in pxa3xx_gcu driver (Gustavo A. R. Silva)

- fix bootparams.screeninfo arguments checking in vgacon (Jan H. Sch=F6nher=
r)

- do not leak uninitialized padding in clk to userspace in the debug code of
  atyfb driver (Vladis Dronov)

- fix compiler warnings in fbcon code and matroxfb driver (Arnd Bergmann)

- convert fbdev susbsytem to using %pOF instead of full_name (Rob Herring)

- structures constifications (Arvind Yadav, Bhumika Goyal, Gustavo A. R.
  Silva, Julia Lawall)

- misc cleanups (Gustavo A. R. Silva, Hyun Kwon, Julia Lawall, Kuninori
  Morimoto, Lynn Lei)

----------------------------------------------------------------
Anton Vasilyev (1):
      video: fbdev: udlfb: Fix use after free on dlfb_usb_probe error path

Arnd Bergmann (2):
      fbcon: mark dummy functions 'inline'
      fbdev: matrox: hide unused 'hotplug' variable

Arvind Yadav (35):
      video: fbdev: uvesafb: constify attribute_group structures.
      omapfb: panel-tpo-td043mtea1: constify attribute_group structures.
      omapfb: panel-sony-acx565akm: constify attribute_group structures.
      video: fbdev: radeon: constify pci_device_id.
      video: fbdev: atyfb: constify pci_device_id.
      video: fbdev: aty128fb: constify pci_device_id.
      video: fbdev: sunxvr2500: constify pci_device_id.
      video: fbdev: asiliantfb: constify pci_device_id.
      video: fbdev: intelfb: constify pci_device_id.
      video: fbdev: pvr2fb: constify pci_device_id.
      video: fbdev: tridentfb: constify pci_device_id.
      video: fbdev: skeletonfb: constify pci_device_id.
      video: fbdev: via: constify pci_device_id.
      video: fbdev: savage: constify pci_device_id.
      video: fbdev: riva: constify pci_device_id.
      video: fbdev: i810: constify pci_device_id.
      video: fbdev: arkfb: constify pci_device_id.
      video: fbdev: kyro: constify pci_device_id.
      video: fbdev: vermilion: constify pci_device_id.
      video: fbdev: nvidia: constify pci_device_id.
      video: fbdev: mb862xx: constify pci_device_id.
      video: fbdev: tdfx: constify pci_device_id.
      video: fbdev: sunxvr500: constify pci_device_id.
      video: fbdev: imsttfb: constify pci_device_id.
      video: fbdev: pm2fb: constify pci_device_id.
      video: fbdev: gxfb: constify pci_device_id.
      video: fbdev: neofb: constify pci_device_id.
      video: fbdev: s3fb: constify pci_device_id.
      video: fbdev: pm3fb: constify pci_device_id.
      video: fbdev: matroxfb: constify pci_device_id.
      video: fbdev: vt8623fb: constify pci_device_id.
      video: fbdev: smscufx: constify usb_device_id.
      video: fbdev: udlfb: constify usb_device_id.
      video: fm2fb: constify zorro_device_id
      video: ARM CLCD: constify amba_id

Bhumika Goyal (7):
      drivers/video/fbdev/omap/lcd_mipid.c: add const to lcd_panel structure
      video: fbdev: add const to bin_attribute structures
      fbdev: matrox: make fb_ops const
      fbdev: i810: make fb_ops const
      video: fbdev: annotate fb_fix_screeninfo with const and __initconst
      video: fbdev: make fb_videomode const
      video: fbdev: make fb_var_screeninfo const

Daniel Vetter (2):
      fbcon: Make fbcon a built-time depency for fbdev
      fbdev: Nuke FBINFO_MODULE

David Lechner (3):
      fbdev: fix 1bpp logo for unusual width
      fbcon: add fbcon=3Dmargin:<color> command line option
      fbcon: remove restriction on margin color

Gustavo A. R. Silva (7):
      video/mbx: constify fb_fix_screeninfo and fb_var_screeninfo structures
      video/chips: constify fb_fix_screeninfo and fb_var_screeninfo structu=
res
      video: xilinxfb: constify fb_fix_screeninfo and fb_var_screeninfo str=
uctures
      video: cobalt_lcdfb: constify fb_fix_screeninfo structure
      video: bfin-lq035q1-fb: constify dev_pm_ops
      video: fbdev: pxa3xx_gcu: fix error return code in pxa3xx_gcu_probe()
      video: fbdev: sis: fix duplicated code for different branches

Hans de Goede (4):
      video/console: Add dmi quirk table for x86 systems which need fbcon r=
otation
      video/console: Add new BIOS date for GPD pocket to dmi quirk table
      video/console: Add rotated LCD-panel DMI quirk for the VIOS LTH17
      video/console: Update BIOS dates list for GPD win console rotation DM=
I quirk

Hyun Kwon (1):
      video: fbdev: Fix multiple style issues in xilinxfb

Jan H. Sch=F6nherr (1):
      vgacon: Prevent faulty bootparams.screeninfo from causing harm

Julia Lawall (4):
      fbdev: da8xx-fb: Drop unnecessary static
      video: fbdev: xilinxfb: constify copied structure
      video: fbdev: vt8623fb: constify vt8623_timing_regs
      omapfb: constify omap_video_timings structures

Kuninori Morimoto (1):
      omapfb: use of_graph_get_remote_endpoint()

Lynn Lei (4):
      video: fbdev: sm712fb.c: using __func__ macro for pr_debug
      video: fbdev: sm712fb.c: fix unaligned block comments warning
      video: fbdev: sm712fb.c: fixed prefer unsigned int warning
      video: fbdev: sm712fb.c: fixed constant-left comparison warning

Michal Simek (1):
      video: fbdev: Enable Xilinx FB for ZynqMP

Rob Herring (1):
      video: fbdev: Convert to using %pOF instead of full_name

Vladis Dronov (1):
      video: fbdev: aty: do not leak uninitialized padding in clk to usersp=
ace

 Documentation/fb/fbcon.txt                         |   7 +
 drivers/video/console/Kconfig                      |   2 +-
 drivers/video/console/Makefile                     |   8 --
 drivers/video/console/vgacon.c                     |   5 +-
 drivers/video/fbdev/68328fb.c                      |   2 +-
 drivers/video/fbdev/Kconfig                        |   2 +-
 drivers/video/fbdev/amba-clcd.c                    |   2 +-
 drivers/video/fbdev/arkfb.c                        |   2 +-
 drivers/video/fbdev/asiliantfb.c                   |   2 +-
 drivers/video/fbdev/atmel_lcdfb.c                  |   2 +-
 drivers/video/fbdev/aty/aty128fb.c                 |   4 +-
 drivers/video/fbdev/aty/atyfb_base.c               |   6 +-
 drivers/video/fbdev/aty/radeon_base.c              |   6 +-
 drivers/video/fbdev/bfin-lq035q1-fb.c              |   2 +-
 drivers/video/fbdev/bw2.c                          |   4 +-
 drivers/video/fbdev/cg14.c                         |   4 +-
 drivers/video/fbdev/cg3.c                          |   4 +-
 drivers/video/fbdev/cg6.c                          |   4 +-
 drivers/video/fbdev/chipsfb.c                      |   4 +-
 drivers/video/fbdev/cobalt_lcdfb.c                 |   2 +-
 drivers/video/fbdev/core/Makefile                  |  14 ++
 drivers/video/{console =3D> fbdev/core}/bitblit.c    |   8 +-
 drivers/video/{console =3D> fbdev/core}/fbcon.c      |  37 +++---
 drivers/video/{console =3D> fbdev/core}/fbcon.h      |   9 +-
 drivers/video/{console =3D> fbdev/core}/fbcon_ccw.c  |   8 +-
 drivers/video/{console =3D> fbdev/core}/fbcon_cw.c   |   8 +-
 drivers/video/fbdev/core/fbcon_dmi_quirks.c        | 145 +++++++++++++++++=
++++
 .../video/{console =3D> fbdev/core}/fbcon_rotate.c   |   4 -
 .../video/{console =3D> fbdev/core}/fbcon_rotate.h   |   0
 drivers/video/{console =3D> fbdev/core}/fbcon_ud.c   |   8 +-
 drivers/video/fbdev/core/fbmem.c                   |  12 +-
 drivers/video/fbdev/core/fbmon.c                   |   4 +-
 drivers/video/{console =3D> fbdev/core}/softcursor.c |   4 -
 drivers/video/{console =3D> fbdev/core}/tileblit.c   |   7 +-
 drivers/video/fbdev/cyber2000fb.c                  |   2 +-
 drivers/video/fbdev/da8xx-fb.c                     |   2 +-
 drivers/video/fbdev/dnfb.c                         |   2 +-
 drivers/video/fbdev/fb-puv3.c                      |   2 +-
 drivers/video/fbdev/ffb.c                          |   4 +-
 drivers/video/fbdev/fm2fb.c                        |   2 +-
 drivers/video/fbdev/geode/gxfb_core.c              |   2 +-
 drivers/video/fbdev/grvga.c                        |   2 +-
 drivers/video/fbdev/i810/i810_main.c               |   4 +-
 drivers/video/fbdev/imsttfb.c                      |   2 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c           |   2 +-
 drivers/video/fbdev/kyro/fbdev.c                   |   2 +-
 drivers/video/fbdev/leo.c                          |   4 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |  14 +-
 drivers/video/fbdev/maxinefb.c                     |   2 +-
 drivers/video/fbdev/mb862xx/mb862xxfbdrv.c         |   2 +-
 drivers/video/fbdev/mbx/mbxfb.c                    |   4 +-
 drivers/video/fbdev/neofb.c                        |   2 +-
 drivers/video/fbdev/nvidia/nvidia.c                |   2 +-
 drivers/video/fbdev/offb.c                         |  10 +-
 drivers/video/fbdev/omap/lcd_mipid.c               |   2 +-
 .../omapfb/displays/panel-lgphilips-lb035q02.c     |   2 +-
 .../omap2/omapfb/displays/panel-sony-acx565akm.c   |   2 +-
 .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   |   2 +-
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |   2 +-
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c      |   3 +-
 drivers/video/fbdev/p9100.c                        |   4 +-
 drivers/video/fbdev/pm2fb.c                        |   2 +-
 drivers/video/fbdev/pm3fb.c                        |   2 +-
 drivers/video/fbdev/pmag-aa-fb.c                   |   4 +-
 drivers/video/fbdev/pmag-ba-fb.c                   |   4 +-
 drivers/video/fbdev/pmagb-b-fb.c                   |   4 +-
 drivers/video/fbdev/ps3fb.c                        |   2 +-
 drivers/video/fbdev/pvr2fb.c                       |   4 +-
 drivers/video/fbdev/pxa3xx-gcu.c                   |   4 +-
 drivers/video/fbdev/q40fb.c                        |   2 +-
 drivers/video/fbdev/riva/fbdev.c                   |   2 +-
 drivers/video/fbdev/s3fb.c                         |   2 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |   2 +-
 drivers/video/fbdev/sis/init301.c                  |  15 +--
 drivers/video/fbdev/skeletonfb.c                   |   4 +-
 drivers/video/fbdev/sm501fb.c                      |   2 +-
 drivers/video/fbdev/sm712fb.c                      |  17 +--
 drivers/video/fbdev/smscufx.c                      |   2 +-
 drivers/video/fbdev/sunxvr1000.c                   |  10 +-
 drivers/video/fbdev/sunxvr2500.c                   |   2 +-
 drivers/video/fbdev/sunxvr500.c                    |   2 +-
 drivers/video/fbdev/tcx.c                          |   4 +-
 drivers/video/fbdev/tdfxfb.c                       |   2 +-
 drivers/video/fbdev/tridentfb.c                    |   2 +-
 drivers/video/fbdev/udlfb.c                        |   5 +-
 drivers/video/fbdev/uvesafb.c                      |   2 +-
 drivers/video/fbdev/vermilion/vermilion.c          |   4 +-
 drivers/video/fbdev/via/via-core.c                 |   2 +-
 drivers/video/fbdev/vt8623fb.c                     |   4 +-
 drivers/video/fbdev/xilinxfb.c                     |  62 ++++-----
 drivers/video/of_display_timing.c                  |  41 +++---
 drivers/video/of_videomode.c                       |   2 +-
 include/linux/fb.h                                 |  10 +-
 include/linux/fbcon.h                              |  12 ++
 94 files changed, 398 insertions(+), 269 deletions(-)
 rename drivers/video/{console =3D> fbdev/core}/bitblit.c (98%)
 rename drivers/video/{console =3D> fbdev/core}/fbcon.c (99%)
 rename drivers/video/{console =3D> fbdev/core}/fbcon.h (97%)
 rename drivers/video/{console =3D> fbdev/core}/fbcon_ccw.c (98%)
 rename drivers/video/{console =3D> fbdev/core}/fbcon_cw.c (98%)
 create mode 100644 drivers/video/fbdev/core/fbcon_dmi_quirks.c
 rename drivers/video/{console =3D> fbdev/core}/fbcon_rotate.c (95%)
 rename drivers/video/{console =3D> fbdev/core}/fbcon_rotate.h (100%)
 rename drivers/video/{console =3D> fbdev/core}/fbcon_ud.c (98%)
 rename drivers/video/{console =3D> fbdev/core}/softcursor.c (93%)
 rename drivers/video/{console =3D> fbdev/core}/tileblit.c (96%)
 create mode 100644 include/linux/fbcon.h

