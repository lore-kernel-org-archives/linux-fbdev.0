From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 23 Aug 2018 11:58:52 +0000
Subject: [GIT PULL] fbdev changes for v4.19
Message-Id: <3194400.CnyYvb8CBI@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180823115854eucas1p19532b92296003cb4fed2e7ed70015072@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev changes for v4.19. There are mostly small fixes and
cleanups for fb drivers (the biggest updates are for udlfb and pxafb
drivers). This PR also adds deferred console takeover support to the
console code and efifb driver. Please see the signed tag description
for details.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 334bb8972a131e604a741e9b284d8867190c723e:

  console: dummycon: export dummycon_[un]register_output_notifier (2018-06-29 11:46:19 +0200)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.19

for you to fetch changes up to f39684524b391c5a7ed0ac44db4fec3357af1c5d:

  Documentation/fb: corrections for fbcon.txt (2018-08-10 17:23:02 +0200)

----------------------------------------------------------------
fbdev changes for v4.19:

- add support for deferred console takeover, when enabled defers
  fbcon taking over the console from the dummy console until the
  first text is displayed on the console - together with the "quiet"
  kernel commandline option this allows fbcon to still be used
  together with a smooth graphical bootup (Hans de Goede)

- improve console locking debugging code (Thomas Zimmermann)

- copy the ACPI BGRT boot graphics to the framebuffer when deferred
  console takeover support is used in efifb driver (Hans de Goede)

- update udlfb driver - fix lost console when the user unplugs a USB
  adapter, fix the screen corruption issue, fix locking and add some
  performance optimizations (Mikulas Patocka)

- update pxafb driver - fix using uninitialized memory, switch to
  devm_* API, handle initialization errors and add support for
  lcd-supply regulator (Daniel Mack)

- add support for boards booted with a DeviceTree in pxa3xx_gcu
  driver (Daniel Mack)

- rename omap2 module to omap2fb.ko to avoid conflicts with omap1
  driver (Arnd Bergmann)

- enable ACPI-based enumeration for goldfishfb driver (Yu Ning)

- fix goldfishfb driver to make user space Android code use 60 fps
  (Christoffer Dall)

- print big fat warning when nomodeset kernel parameter is used in
  vgacon driver (Lyude Paul)

- remove VLA usage from fsl-diu-fb driver (Kees Cook)

- misc fixes (Julia Lawall, Geert Uytterhoeven, Fredrik Noring,
  Yisheng Xie, Dan Carpenter, Daniel Vetter, Anton Vasilyev, Randy
  Dunlap, Gustavo A. R. Silva, Colin Ian King, Fengguang Wu)

- misc cleanups (Roman Kiryanov, Yisheng Xie, Colin Ian King)

----------------------------------------------------------------
Anton Vasilyev (1):
      video: goldfishfb: fix memory leak on driver remove

Arnd Bergmann (1):
      omapfb: rename omap2 module to omap2fb.ko

Bartlomiej Zolnierkiewicz (3):
      Merge tag 'v4.18-rc2' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next
      Merge tag 'ib-fbdev-drm-v4.19-deferred-console-takeover' of https://github.com/bzolnier/linux into fbdev-for-next
      Merge tag 'ib-fbdev-drm-v4.19-deferred-console-takeover-fixup' of https://github.com/bzolnier/linux into fbdev-for-next

Christoffer Dall (1):
      video: fbdev: Set pixclock = 0 in goldfishfb

Colin Ian King (2):
      video: fbdev: tridentfb: remove deadcode on unreachable case statement
      omapfb: encoder-tpd12s015: remove redundant pointer 'in'

Dan Carpenter (2):
      video: fbdev: metronomefb: fix some off by one bugs
      fbdev: omapfb: off by one in omapfb_register_client()

Daniel Mack (6):
      dt-bindings: display: add devicetree bindings for pxa300-gcu
      video: fbdev: pxa3xx_gcu: add devicetree bindings
      video: fbdev: pxafb: clear allocated memory for video modes
      video: fbdev: pxafb: switch to devm_* API
      video: fbdev: pxafb: handle errors from pxafb_init_fbinfo() correctly
      video: fbdev: pxafb: Add support for lcd-supply regulator

Daniel Vetter (1):
      fbdev: fix modedb docs in fb_find_mode

Fredrik Noring (1):
      fbdev: Distinguish between interlaced and progressive modes

Geert Uytterhoeven (1):
      video: fbdev: simplefb: Stop including <linux/clk-provider.h>

Gustavo A. R. Silva (3):
      fbdev: fbmem: mark expected switch fall-through
      omapfb: Mark expected switch fall-throughs
      video: fbdev: mark expected switch fall-throughs

Hans de Goede (7):
      efi/bgrt: Drop __initdata from bgrt_image_size
      efifb: Copy the ACPI BGRT boot graphics to the framebuffer
      efifb: BGRT: Do not copy the boot graphics for non native resolutions
      fbcon: Only allow FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER if fbdev is builtin
      fbcon: Only defer console takeover if the current console driver is the dummycon
      dummycon: Stop exporting dummycon_[un]register_output_notifier
      fbcon: Do not takeover the console from atomic context

Julia Lawall (1):
      omapfb: encoder-tpd12s015: fix error return code

Kees Cook (1):
      video: fbdev: fsl-diu-fb: Remove VLA usage

Lyude Paul (1):
      video/console/vgacon: Print big fat warning with nomodeset

Mikulas Patocka (12):
      fb: fix lost console when the user unplugs a USB adapter
      udlfb: fix semaphore value leak
      udlfb: fix display corruption of the last line
      udlfb: don't switch if we are switching to the same videomode
      udlfb: make a local copy of fb_ops
      udlfb: set optimal write delay
      udlfb: handle allocation failure
      udlfb: set line_length in dlfb_ops_set_par
      udlfb: allow reallocating the framebuffer
      udlfb: optimization - test the backing buffer
      udlfb: avoid prefetch
      udlfb: use spin_lock_irq instead of spin_lock_irqsave

Randy Dunlap (4):
      fbdev/via: fix defined but not used warning
      fbdev: fix omap2/omapfb/dss/ indentation warning
      fb: amifb: fix build warnings when not builtin
      Documentation/fb: corrections for fbcon.txt

Roman Kiryanov (1):
      video: fbdev: Fix checkpatch warnings in goldfishfb.c

Thomas Zimmermann (2):
      console: Replace #if 0 with atomic var 'ignore_console_lock_warning'
      fbdev/core: Disable console-lock warnings when fb.lockless_register_fb is set

Yisheng Xie (2):
      fbcon: introduce for_each_registered_fb() helper
      fbdev: fix typo in comment

Yu Ning (1):
      video: fbdev: Enable ACPI-based enumeration for goldfishfb

kbuild test robot (3):
      fbdev: omap2: omapfb: fix boolreturn.cocci warnings
      fbdev: omap2: omapfb: fix bugon.cocci warnings
      fbdev: omap2: omapfb: fix ifnullfree.cocci warnings

 .../bindings/display/marvell,pxa2xx-lcdc.txt       |   3 +
 .../bindings/display/marvell,pxa300-gcu.txt        |  17 ++
 Documentation/fb/fbcon.txt                         |  29 +--
 drivers/firmware/efi/efi-bgrt.c                    |   2 +-
 drivers/video/console/Kconfig                      |   2 +-
 drivers/video/console/dummycon.c                   |   2 -
 drivers/video/console/vgacon.c                     |   5 +
 drivers/video/fbdev/amifb.c                        |   4 +-
 drivers/video/fbdev/core/fbcon.c                   |  70 +++----
 drivers/video/fbdev/core/fbmem.c                   |  56 +++--
 drivers/video/fbdev/core/modedb.c                  |  93 +++++----
 drivers/video/fbdev/efifb.c                        | 183 ++++++++++++++++
 drivers/video/fbdev/fsl-diu-fb.c                   |  23 ++-
 drivers/video/fbdev/goldfishfb.c                   |  15 +-
 drivers/video/fbdev/i740fb.c                       |   1 +
 drivers/video/fbdev/metronomefb.c                  |  10 +-
 drivers/video/fbdev/omap/omapfb_main.c             |   2 +-
 drivers/video/fbdev/omap2/omapfb/Makefile          |   4 +-
 .../omap2/omapfb/displays/encoder-tpd12s015.c      |  17 +-
 drivers/video/fbdev/omap2/omapfb/dss/core.c        |   3 +-
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c       |   4 +-
 .../video/fbdev/omap2/omapfb/dss/dss_features.c    |   3 +-
 drivers/video/fbdev/omap2/omapfb/omapfb-main.c     |   3 +-
 drivers/video/fbdev/pm2fb.c                        |   2 +
 drivers/video/fbdev/pxa3xx-gcu.c                   |  10 +
 drivers/video/fbdev/pxafb.c                        |  97 ++++-----
 drivers/video/fbdev/pxafb.h                        |   3 +
 drivers/video/fbdev/simplefb.c                     |   2 +-
 drivers/video/fbdev/tdfxfb.c                       |   1 +
 drivers/video/fbdev/tridentfb.c                    |   3 -
 drivers/video/fbdev/udlfb.c                        | 230 +++++++++++++--------
 drivers/video/fbdev/via/lcd.c                      |   1 +
 drivers/video/fbdev/via/viafbdev.c                 |   3 +-
 include/linux/console.h                            |  14 +-
 include/linux/fb.h                                 |  10 +-
 include/video/udlfb.h                              |   6 +-
 kernel/printk/printk.c                             |   3 +
 37 files changed, 640 insertions(+), 296 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/marvell,pxa300-gcu.txt
