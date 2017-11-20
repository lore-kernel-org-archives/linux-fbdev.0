From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 20 Nov 2017 13:52:24 +0000
Subject: [GIT PULL] fbdev changes for v4.15
Message-Id: <2543232.dkZFGG5Tsa@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171120135226epcas1p297dd4a390fdc985b2fddca177715acc3@epcas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Kees Cook <keescook@chromium.org>


Hi Linus,

Please pull fbdev changes for v4.15.  There is nothing really major here
(though removal of the dead igafb driver stands out in diffstat), please
see the signed tag description for details.

Test merge revealed a small merge conflict in include/video/iga.h caused
by SPDX tags addition (the resolution is trivial, just remove the file).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.15

for you to fetch changes up to 5f215d252496543ba22299bccef5062d30d63cfe:

  OMAPFB: prevent buffer underflow in omapfb_parse_vram_param() (2017-11-17 17:21:49 +0100)

----------------------------------------------------------------
fbdev changes for v4.15:

- convert timers to use timer_setup() (Kees Cook, Thierry Reding)

- fix panels support on iMX boards in mxsfb driver (Stefan Agner)

- fix timeout on EDID read in udlfb driver (Ladislav Michl)

- add missing modes to fix out of bounds access in controlfb driver
  (Geert Uytterhoeven)

- update initialisation paths in sa1100fb driver to be more robust
  (Russell King)

- fix error handling path of ->probe method in au1200fb driver
  (Christophe JAILLET)

- fix handling of cases when either panel or crt is defined in sm501fb
  driver (Sudip Mukherjee, Colin Ian King)

- add ability to the Goldfish FB driver to be recognized by OS via DT
  (Aleksandar Markovic)

- structures constifications (Bhumika Goyal)

- misc fixes (Allen Pais, Gustavo A. R. Silva, Dan Carpenter)

- misc cleanups (Colin Ian King, Himanshu Jha, Markus Elfring)

- remove dead igafb driver

----------------------------------------------------------------
Aleksandar Markovic (2):
      Documentation: Add device tree binding for Goldfish FB driver
      video: goldfishfb: Add support for device tree bindings

Allen Pais (1):
      video: fbdev: matroxfb: return -ENOMEM on allocation failure

Bartlomiej Zolnierkiewicz (2):
      Merge tag 'v4.14-rc4' of git://git.kernel.org/.../torvalds/linux into fbdev-for-next
      video: fbdev: remove dead igafb driver

Bhumika Goyal (1):
      video: fbdev: dnfb: make fb_var_screeninfo static and const

Christophe JAILLET (8):
      video: fbdev: au1200fb: Fix a potential double free
      video: fbdev: au1200fb: Return an error code if a memory allocation fails
      video: fbdev: au1200fb: Release some resources if a memory allocation fails
      video: fbdev: au1200fb: Fix incorrect IRQ freeing
      video: fbdev: au1200fb: Fix error handling path
      video: fbdev: au1200fb: Remove some dead code
      video: fbdev: au1200fb: Propagate an error code
      video: fbdev: au1200fb: Style clean up

Colin Ian King (5):
      video: fbdev: aty: make const arrays static, reduces object code size
      video: fbdev: sis: make const array specialtv static, reduces object code size
      video: fbdev: radeon: make const array post_divs static, reduces object code size
      video: fbdev: intelfb: remove redundant variables
      video: fbdev: sm501fb: fix potential null pointer dereference on fbi

Dan Carpenter (1):
      OMAPFB: prevent buffer underflow in omapfb_parse_vram_param()

Geert Uytterhoeven (1):
      fbdev: controlfb: Add missing modes to fix out of bounds access

Gustavo A. R. Silva (4):
      video: fbdev: sm501fb: mark expected switch fall-through in sm501fb_blank_crt
      video: fbdev: aty: radeon_pm: mark expected switch fall-throughs
      video: fbdev: cirrusfb: mark expected switch fall-throughs
      video: fbdev: sis_main: mark expected switch fall-throughs

Himanshu Jha (1):
      video: fbdev: pxa3xx_gcu: Use setup_timer and mod_timer

Kees Cook (2):
      video: fbdev: pxa3xx_gcu: Convert timers to use timer_setup()
      video: fbdev: Convert timers to use timer_setup()

Ladislav Michl (1):
      video: udlfb: Fix read EDID timeout

Markus Elfring (1):
      video/fbdev/dnfb: Use common error handling code in dnfb_probe()

Russell King (8):
      video: sa1100fb: use devm_kzalloc()
      video: sa1100fb: use devm_clk_get()
      video: sa1100fb: use devm_ioremap_resource()
      video: sa1100fb: use devm_request_irq()
      video: sa1100fb: use devm_gpio_request_one()
      video: sa1100fb: clean up failure path
      video: sa1100fb: fix video memory allocation leak
      video: sa1100fb: move pseudo palette into sa1100fb_info structure

Stefan Agner (1):
      video: fbdev: mxsfb: fix pixelclock polarity

Sudip Mukherjee (3):
      sm501fb: deallocate colormap only if allocated
      sm501fb: unregister framebuffer only if registered
      sm501fb: suspend and resume fb if it exists

Thierry Reding (1):
      fbcon: Initialize ops->info early

 .../bindings/display/google,goldfish-fb.txt        |  17 +
 drivers/video/fbdev/Kconfig                        |  10 -
 drivers/video/fbdev/Makefile                       |   1 -
 drivers/video/fbdev/aty/atyfb_base.c               |   4 +-
 drivers/video/fbdev/aty/radeon_base.c              |  10 +-
 drivers/video/fbdev/aty/radeon_pm.c                |   3 +
 drivers/video/fbdev/au1200fb.c                     |  43 +-
 drivers/video/fbdev/cirrusfb.c                     |   6 +-
 drivers/video/fbdev/controlfb.h                    |   2 +
 drivers/video/fbdev/core/fbcon.c                   |  11 +-
 drivers/video/fbdev/core/fbcon.h                   |   1 +
 drivers/video/fbdev/dnfb.c                         |  15 +-
 drivers/video/fbdev/goldfishfb.c                   |   8 +-
 drivers/video/fbdev/igafb.c                        | 579 ---------------------
 drivers/video/fbdev/intelfb/intelfbhw.c            |   9 +-
 drivers/video/fbdev/matrox/matroxfb_base.c         |   2 +-
 drivers/video/fbdev/mxsfb.c                        |  13 +-
 drivers/video/fbdev/omap/hwa742.c                  |   6 +-
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c         |   6 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c     |   2 +-
 drivers/video/fbdev/pxa3xx-gcu.c                   |  24 +-
 drivers/video/fbdev/sa1100fb.c                     |  75 +--
 drivers/video/fbdev/sa1100fb.h                     |   2 +
 drivers/video/fbdev/sis/init301.c                  |   2 +-
 drivers/video/fbdev/sis/sis_main.c                 |   4 +
 drivers/video/fbdev/sm501fb.c                      |  22 +-
 drivers/video/fbdev/udlfb.c                        |  10 +-
 include/video/iga.h                                |  24 -
 28 files changed, 164 insertions(+), 747 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/google,goldfish-fb.txt
 delete mode 100644 drivers/video/fbdev/igafb.c
 delete mode 100644 include/video/iga.h

