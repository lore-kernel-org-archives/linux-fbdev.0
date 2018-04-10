From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 10 Apr 2018 10:55:31 +0000
Subject: [GIT PULL] fbdev changes for v4.17
Message-Id: <1961414.DdNXifHtXJ@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180410105533epcas1p2e9067100f36c0f943796597bb9c81216@epcas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev changes for v4.17. There is nothing really major here,
just a couple of small bugfixes, improvements and cleanups (please
see the signed tag description for details).

Test merge revealed a small merge conflict, the resolution is trivial:

diff --cc drivers/video/console/Kconfig
index 4110ba7,be63759..5dd51e0
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@@ -6,9 -6,10 +6,9 @@@ menu "Console display driver support
  
  config VGA_CONSOLE
  	bool "VGA text console" if EXPERT || !X86
- 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC &&  !SUPERH && \
 -	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
 -		!SUPERH && !BLACKFIN && !MN10300 && !CRIS && \
++	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !SUPERH && \
  		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
 -		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
 +		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !NDS32 && !S390
  	default y
  	help
  	  Saying Y here will allow you to use Linux in text mode through a


Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 250c6c49e3b68756b14983c076183568636e2bde:

  fbdev: Fixing arbitrary kernel leak in case FBIOGETCMAP_SPARC in sbusfb_ioctl_helper(). (2018-03-07 14:00:34 +0100)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.17

for you to fetch changes up to 7c9b845e79eadd074820e36d426502a9c54cafcf:

  video: fbdev: s3c-fb: remove dead platform code for Exynos and S5PV210 platforms (2018-03-28 16:34:29 +0200)

----------------------------------------------------------------
fbdev changes for v4.17:

- make it possible to load radeonfb driver when offb driver is loaded first
  (Mathieu Malaterre)

- fix memory leak in offb driver (Mathieu Malaterre)

- fix unaligned access in udlfb driver (Ladislav Michl)

- convert atmel_lcdfb driver to use GPIO descriptors (Ludovic Desroches)

- avoid mismatched prototypes in sisfb driver (Arnd Bergmann)

- remove VLA usage from viafb driver (Gustavo A. R. Silva)

- add missing help text to FB_I810_I2 config option (Ulf Magnusson)

- misc fixes (Gustavo A. R. Silva, Colin Ian King, Markus Elfring)

- remove dead code from s3c-fb driver for Exynos and S5PV210 platforms

- misc cleanups (Corentin Labbe, Ladislav Michl, Ulf Magnusson, Vladimir
  Zapolskiy, Markus Elfring)

----------------------------------------------------------------
Arnd Bergmann (1):
      video: fbdev: sis: avoid mismatched prototypes

Bartlomiej Zolnierkiewicz (1):
      video: fbdev: s3c-fb: remove dead platform code for Exynos and S5PV210 platforms

Colin Ian King (1):
      fbdev: aty: fix missing indentation in if statement

Corentin Labbe (1):
      video: remove unused kconfig SH_LCD_MIPI_DSI

Gustavo A. R. Silva (3):
      video: fbdev: vermilion: use 64-bit arithmetic instead of 32-bit
      video: fbdev: via: remove VLA usage
      video: fbdev: aty128fb: use true and false for boolean values

Ladislav Michl (2):
      video: udlfb: Fix unaligned access
      video: udlfb: Use already defined BPP constant

Ludovic Desroches (1):
      video: fbdev: atmel_lcdfb: convert to use GPIO descriptors

Markus Elfring (17):
      video/fbdev/stifb: Return -ENOMEM after a failed kzalloc() in stifb_init_fb()
      video/fbdev/stifb: Delete an error message for a failed memory allocation in stifb_init_fb()
      video: udlfb: Return an error code only as a constant in dlfb_realloc_framebuffer()
      video: smscufx: Less checks in ufx_usb_probe() after error detection
      video: smscufx: Return an error code only as a constant in ufx_realloc_framebuffer()
      video: smscufx: Delete an error message for a failed memory allocation in ufx_realloc_framebuffer()
      video: ssd1307fb: Improve a size determination in ssd1307fb_probe()
      video: fsl-diu-fb: Delete an error message for a failed memory allocation in fsl_diu_init()
      video: s3c-fb: Delete an error message for a failed memory allocation in s3c_fb_probe()
      video: s3c-fb: Improve a size determination in s3c_fb_probe()
      video: matroxfb: Delete an error message for a failed memory allocation in matroxfb_crtc2_probe()
      video: ARM CLCD: Delete an error message for a failed memory allocation in clcdfb_probe()
      video: ARM CLCD: Improve a size determination in clcdfb_probe()
      video/console/sticore: Delete an error message for a failed memory allocation in sti_try_rom_generic()
      video: au1100fb: Delete an error message for a failed memory allocation in au1100fb_drv_probe()
      video: au1100fb: Improve a size determination in au1100fb_drv_probe()
      video: au1100fb: Delete an unnecessary variable initialisation in au1100fb_drv_probe()

Mathieu Malaterre (2):
      fbdev: Fix loading of module radeonfb on PowerMac
      video: offb: Deallocate the color map

Ulf Magnusson (2):
      video: console: kconfig: Remove AVR32 dep. from VGA_CONSOLE
      video: fbdev: kconfig: Add help text to FB_I810_I2C

Vladimir Zapolskiy (1):
      video: of: display_timing: Remove of_display_timings_exist() function

 drivers/video/Kconfig                       |   3 -
 drivers/video/console/Kconfig               |   2 +-
 drivers/video/console/sticore.c             |   4 +-
 drivers/video/fbdev/Kconfig                 |   8 +-
 drivers/video/fbdev/amba-clcd.c             |   3 +-
 drivers/video/fbdev/atmel_lcdfb.c           |  31 +--
 drivers/video/fbdev/aty/aty128fb.c          |   2 +-
 drivers/video/fbdev/aty/mach64_ct.c         |   2 +-
 drivers/video/fbdev/aty/radeon_base.c       |  21 ++
 drivers/video/fbdev/au1100fb.c              |   9 +-
 drivers/video/fbdev/fsl-diu-fb.c            |   6 +-
 drivers/video/fbdev/matrox/matroxfb_crtc2.c |   5 +-
 drivers/video/fbdev/offb.c                  |   2 +
 drivers/video/fbdev/s3c-fb.c                | 168 +-------------
 drivers/video/fbdev/sis/init.h              |  76 -------
 drivers/video/fbdev/sis/init301.c           | 326 ++++++++++++++++++++++++++++
 drivers/video/fbdev/sis/init301.h           | 320 ---------------------------
 drivers/video/fbdev/sis/sis.h               | 131 +++++++++++
 drivers/video/fbdev/sis/sis_main.c          |  51 +++++
 drivers/video/fbdev/sis/sis_main.h          | 117 ----------
 drivers/video/fbdev/smscufx.c               |  59 ++---
 drivers/video/fbdev/ssd1307fb.c             |   3 +-
 drivers/video/fbdev/stifb.c                 |   6 +-
 drivers/video/fbdev/udlfb.c                 |  39 ++--
 drivers/video/fbdev/vermilion/vermilion.c   |   2 +-
 drivers/video/fbdev/via/via_aux_sii164.c    |   2 +-
 drivers/video/fbdev/via/via_aux_vt1631.c    |   2 +-
 drivers/video/fbdev/via/via_aux_vt1632.c    |   2 +-
 drivers/video/fbdev/via/via_aux_vt1636.c    |   2 +-
 drivers/video/of_display_timing.c           |  20 --
 include/video/of_display_timing.h           |   5 -
 31 files changed, 610 insertions(+), 819 deletions(-)

