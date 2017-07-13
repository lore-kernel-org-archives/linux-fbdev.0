From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 13 Jul 2017 13:52:40 +0000
Subject: [GIT PULL] fbdev changes for v4.13
Message-Id: <1632483.QGZKEaCAg3@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170713135243epcas1p2cc3fb7d2817de70613a4079fcb83e2b1@epcas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev changes for v4.13.  There is nothing really major here,
just a couple of small bugfixes, improvements and cleanups.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 32c1431eea4881a6b17bd7c639315010aeefa452:

  Linux 4.12-rc5 (2017-06-11 16:48:20 -0700)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.13

for you to fetch changes up to 4c99ceda0d067c06f228a27b6870f548d3218cc6:

  fbdev: make get_fb_unmapped_area depends of !MMU (2017-07-12 18:28:11 +0200)

----------------------------------------------------------------
fbdev changes for v4.13:

- fix get_fb_unmapped_area() helper handling (Benjamin Gaignard)
- check return value of clk_prepare_enable() in pxafb driver (Arvind Yadav)
- fix error path handling in vmlfb driver (Alexey Khoroshilov)
- printks fixes/cleanups for uvesafb driver (Joe Perches)
- fix unusued variable warning in atyfb driver (Arnd Bergmann)
- constifications for sh_mobile_lcdcfb, fsl-diu-fb, omapfb (Arvind Yadav)
- mdacon driver cleanups (Jiri Slaby)
- misc cleanups
  (Andy Shevchenko, Karim Eshapa, Gustavo A. R. Silva, Dan Carpenter)

----------------------------------------------------------------
Alexey Khoroshilov (1):
      vmlfb: Fix error handling in cr_pll_init()

Andy Shevchenko (1):
      omapfb: Use sysfs_match_string() helper

Arnd Bergmann (1):
      atyfb: hide unused variable

Arvind Yadav (5):
      video: fbdev: pxafb: Handle return value of clk_prepare_enable
      video: fbdev: sh_mobile_lcdcfb: constify sh_mobile_lcdc_bl_ops.
      video: fbdev: fsl-diu-fb: constify mfb_template and fsl_diu_match.
      omapfb: panel-dsi-cm: constify dsicm_attr_group
      fbdev: omapfb: constify ctrl_caps, color_caps, panel_attr_grp and ctrl_attr_grp

Bartlomiej Zolnierkiewicz (1):
      Merge tag 'v4.12-rc5' of git://git.kernel.org/.../torvalds/linux into fbdev-for-next

Benjamin Gaignard (1):
      fbdev: make get_fb_unmapped_area depends of !MMU

Dan Carpenter (1):
      video: fbdev: matrox: the list iterator can't be NULL

Gustavo A. R. Silva (1):
      video: fbdev: aty: remove useless variable assignments in aty_var_to_crtc()

Jiri Slaby (3):
      mdacon: align code in mda_detect properly
      mdacon: make mda_vram_base u16 *
      mdacon: replace MDA_ADDR macro by inline function

Joe Perches (1):
      uvesafb: Fix continuation printks without KERN_LEVEL to pr_cont, neatening

Karim Eshapa (1):
      video: fbdev: omap2: omapfb: displays: panel-dsi-cm: Use time comparison kernel macro.

 drivers/video/console/mdacon.c                     |  89 +++++++------
 drivers/video/fbdev/aty/atyfb_base.c               |  10 +-
 drivers/video/fbdev/core/fbmem.c                   |   5 +-
 drivers/video/fbdev/fsl-diu-fb.c                   |   4 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |   2 +-
 drivers/video/fbdev/omap/omapfb_main.c             |   8 +-
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     |   4 +-
 .../video/fbdev/omap2/omapfb/dss/manager-sysfs.c   |  14 +-
 drivers/video/fbdev/pxafb.c                        |   5 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |   2 +-
 drivers/video/fbdev/uvesafb.c                      | 148 +++++++++------------
 drivers/video/fbdev/vermilion/cr_pll.c             |   1 +
 12 files changed, 137 insertions(+), 155 deletions(-)

