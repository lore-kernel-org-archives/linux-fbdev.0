From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 14 Jun 2018 11:06:29 +0000
Subject: [GIT PULL] fbdev changes for v4.18
Message-Id: <4529972.sH8mM7iiAP@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180614110629eucas1p2205094587cda711188f72d8dd8395ac9@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev changes for v4.18. There is nothing really major
here, few small fixes, some cleanups and dead drivers removal (please
see the signed tag description for details).

Test merge revealed a small merge conflict, the resolution is trivial:

diff --cc drivers/video/fbdev/mmp/fb/mmpfb.c
index f27697e,292b3e4..ee212be
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@@ -493,12 -493,11 +493,11 @@@ static int modes_setup(struct mmpfb_inf
  		return 0;
  	}
  	/* put videomode list to info structure */
 -	videomodes = kzalloc(sizeof(struct fb_videomode) * videomode_num,
 -			GFP_KERNEL);
 +	videomodes = kcalloc(videomode_num, sizeof(struct fb_videomode),
 +			     GFP_KERNEL);
- 	if (!videomodes) {
- 		dev_err(fbi->dev, "can't malloc video modes\n");
+ 	if (!videomodes)
  		return -ENOMEM;
- 	}
+ 
  	for (i = 0; i < videomode_num; i++)
  		mmpmode_to_fbmode(&videomodes[i], &mmp_modes[i]);
  	fb_videomode_to_modelist(videomodes, videomode_num, &info->modelist);


Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.18

for you to fetch changes up to 85ebd164de56c5146e0f65cebee7fcc4babe52e3:

  fb_omap2: add gpiolib dependency (2018-06-08 18:08:12 +0200)

----------------------------------------------------------------
fbdev changes for v4.18:

- mark omapfb drivers as orphans in MAINTAINERS file (Tomi Valkeinen)

- add missing module license tags to omap/omapfb driver (Arnd Bergmann)

- add missing GPIOLIB dependendy to omap2/omapfb driver (Arnd Bergmann)

- convert savagefb, aty128fb & radeonfb drivers to use msleep & co.
  (Jia-Ju Bai)

- allow COMPILE_TEST build for viafb driver (media part was reviewed by
  media subsystem Maintainer)

- remove unused MERAM support from sh_mobile_lcdcfb and shmob-drm drivers
  (drm parts were acked by shmob-drm driver Maintainer)

- remove unused auo_k190xfb drivers

- misc cleanups (Souptick Joarder, Wolfram Sang, Markus Elfring, Andy
  Shevchenko, Colin Ian King)

----------------------------------------------------------------
Andy Shevchenko (1):
      video: fbdev: pxafb: Convert to use match_string() helper

Arnd Bergmann (2):
      video/omap: add module license tags
      fb_omap2: add gpiolib dependency

Bartlomiej Zolnierkiewicz (7):
      Merge tag 'v4.17-rc2' of git://git.kernel.org/.../torvalds/linux into fbdev-for-next
      video: fbdev: remove unused auo_k190xfb drivers
      video: fbdev: sh_mobile_lcdcfb: remove unused MERAM support
      drm: shmobile: remove unused MERAM support
      video: fbdev: remove unused sh_mobile_meram driver
      video: fbdev: via: allow COMPILE_TEST build
      video: fbdev: pxafb: match_string() conversion fixup

Colin Ian King (2):
      video: fbdev: fix spelling mistake: "frambuffer" -> "framebuffer"
      video: fbdev: nvidia: fix spelling mistake: "scaleing" -> "scaling"

Geert Uytterhoeven (1):
      video: fbdev: sh_mobile_meram: Drop SUPERH platform dependency

Jia-Ju Bai (3):
      video: fbdev: savage: Replace mdelay with usleep_range in savage_init_hw
      video: fbdev: aty: aty128fb: Replace mdelay with msleep in aty128_set_suspend
      video: fbdev: aty: radeon_pm: Replace mdelay with msleep in radeonfb_pci_suspend

Markus Elfring (7):
      video: sh_mobile_meram: Delete an error message for a failed memory allocation in sh_mobile_meram_probe()
      video: sh_mobile_lcdcfb: Delete an error message for a failed memory allocation in two functions
      video: auo_k190x: Delete an error message for a failed memory allocation in auok190x_common_probe()
      video: fbdev-MMP: Delete an error message for a failed memory allocation in two functions
      video: fbdev-MMP: Improve a size determination in path_init()
      video: sm501fb: Improve a size determination in sm501fb_probe()
      video: omap: Improve a size determination in omapfb_do_probe()

Souptick Joarder (1):
      video: fbdev: core: Change return type to vm_fault_t

Tomi Valkeinen (1):
      MAINTAINERS: make omapfb orphan

Wolfram Sang (2):
      video: fbdev: simplify getting .drvdata
      video: fbdev: omap2: omapfb: displays: simplify getting .drvdata

 MAINTAINERS                                        |    6 +-
 drivers/gpu/drm/shmobile/Kconfig                   |    1 -
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c          |   42 -
 drivers/gpu/drm/shmobile/shmob_drm_crtc.h          |    1 -
 drivers/gpu/drm/shmobile/shmob_drm_drv.h           |    2 -
 drivers/gpu/drm/shmobile/shmob_drm_kms.c           |   11 -
 drivers/gpu/drm/shmobile/shmob_drm_kms.h           |    1 -
 drivers/gpu/drm/shmobile/shmob_drm_plane.c         |    2 -
 drivers/media/platform/via-camera.c                |    5 +
 drivers/video/fbdev/Kconfig                        |   48 +-
 drivers/video/fbdev/Makefile                       |    4 -
 drivers/video/fbdev/aty/aty128fb.c                 |    2 +-
 drivers/video/fbdev/aty/radeon_pm.c                |    8 +-
 drivers/video/fbdev/au1100fb.c                     |    2 +-
 drivers/video/fbdev/au1200fb.c                     |    2 +-
 drivers/video/fbdev/auo_k1900fb.c                  |  204 ----
 drivers/video/fbdev/auo_k1901fb.c                  |  257 -----
 drivers/video/fbdev/auo_k190x.c                    | 1195 --------------------
 drivers/video/fbdev/auo_k190x.h                    |  129 ---
 drivers/video/fbdev/core/fb_defio.c                |    4 +-
 drivers/video/fbdev/mmp/fb/mmpfb.c                 |    5 +-
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |    8 +-
 drivers/video/fbdev/nvidia/nvidia.c                |    2 +-
 drivers/video/fbdev/omap/lcd_ams_delta.c           |    4 +
 drivers/video/fbdev/omap/lcd_h3.c                  |    4 +
 drivers/video/fbdev/omap/lcd_htcherald.c           |    4 +
 drivers/video/fbdev/omap/lcd_inn1510.c             |    4 +
 drivers/video/fbdev/omap/lcd_inn1610.c             |    4 +
 drivers/video/fbdev/omap/lcd_osk.c                 |    4 +
 drivers/video/fbdev/omap/lcd_palmte.c              |    4 +
 drivers/video/fbdev/omap/lcd_palmtt.c              |    4 +
 drivers/video/fbdev/omap/lcd_palmz71.c             |    4 +
 drivers/video/fbdev/omap/omapfb_main.c             |    2 +-
 drivers/video/fbdev/omap2/omapfb/Kconfig           |    1 +
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     |   18 +-
 drivers/video/fbdev/pxafb.c                        |    8 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |    8 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |   77 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.h             |    1 -
 drivers/video/fbdev/sh_mobile_meram.c              |  758 -------------
 drivers/video/fbdev/sm501fb.c                      |    3 +-
 drivers/video/fbdev/via/global.h                   |    6 +
 drivers/video/fbdev/via/hw.c                       |    1 -
 drivers/video/fbdev/via/via-core.c                 |    1 -
 drivers/video/fbdev/via/via_clock.c                |    2 +-
 drivers/video/fbdev/via/viafbdev.c                 |    1 -
 include/linux/platform_data/shmob_drm.h            |    4 -
 include/video/auo_k190xfb.h                        |  107 --
 include/video/sh_mobile_lcdc.h                     |    3 -
 include/video/sh_mobile_meram.h                    |   95 --
 50 files changed, 87 insertions(+), 2986 deletions(-)
 delete mode 100644 drivers/video/fbdev/auo_k1900fb.c
 delete mode 100644 drivers/video/fbdev/auo_k1901fb.c
 delete mode 100644 drivers/video/fbdev/auo_k190x.c
 delete mode 100644 drivers/video/fbdev/auo_k190x.h
 delete mode 100644 drivers/video/fbdev/sh_mobile_meram.c
 delete mode 100644 include/video/auo_k190xfb.h
 delete mode 100644 include/video/sh_mobile_meram.h

