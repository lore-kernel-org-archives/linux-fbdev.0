From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 10 May 2019 16:50:23 +0000
Subject: [GIT PULL] fbdev changes for v5.2
Message-Id: <32ceb3b0-0bce-a585-8843-36e851b2a1aa@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190510165025eucas1p1158b6d87dde378cd9986a6e89125acf1@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org


Hi Linus,

Please pull fbdev changes for v5.2. They are:
- 4 small fixes for fb core
- updates for udlfb, sm712fb, macfb and atafb drivers
- redundant code removals from amba-clcd and atmel_lcdfb drivers
- minor fixes/cleanups for other fb drivers

Please see the signed tag description for details.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v5.2

for you to fetch changes up to d4a5611743a6f5d126f8cbfdbf29e12fd8d1b73f:

  video: fbdev: Use dev_get_drvdata() (2019-05-06 15:57:47 +0200)

----------------------------------------------------------------
fbdev changes for v5.2:

- fix regression in fbcon logo handling on 'quiet' boots (Andreas Schwab)

- fix divide-by-zero error in fb_var_to_videomode() (Shile Zhang)

- fix 'WARNING in __alloc_pages_nodemask' bug (Jiufei Xue)

- list all PCI memory BARs as conflicting apertures (Gerd Hoffmann)

- update udlfb driver - fix sleeping inside spinlock, add mutex around
  rendering calls and remove redundant code (Mikulas Patocka)

- update sm712fb driver - fix SM720 support related issues (Yifeng Li)

- update macfb driver - fix DAFB colour table pointer initialization and
  remove redundant code (Finn Thain)

- update atafb driver - fix kexec support, use dev_*() calls instead of
  printk() and remove obsolete module support (Geert Uytterhoeven)

- add support to mxsfb driver for skipping display initialization for
  flicker-free display takeover from bootloader (Melchior Franz)

- remove Versatile and Nomadik board families support from amba-clcd
  driver as they are handled by DRM driver nowadays (Linus Walleij)

- remove no longer needed AVR and platform_data support from atmel_lcdfb
  driver (Alexandre Belloni)

- misc fixes (Colin Ian King, Julia Lawall, Gustavo A. R. Silva, Aditya
  Pakki, Kangjie Lu, YueHaibing)

- misc cleanups (Enrico Weigelt, Kefeng Wang)

----------------------------------------------------------------
Aditya Pakki (1):
      omapfb: Fix potential NULL pointer dereference in kmalloc

Alexandre Belloni (1):
      video: fbdev: atmel_lcdfb: drop AVR and platform_data support

Andreas Schwab (1):
      fbcon: Don't reset logo_shown when logo is currently shown

Bartlomiej Zolnierkiewicz (1):
      Merge tag 'v5.1-rc3' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next

Colin Ian King (2):
      video: fbdev: vesafb: fix indentation issue
      video: fbdev: savage: fix indentation issue

Enrico Weigelt, metux IT consult (1):
      drivers: video: fbdev: Kconfig: pedantic cleanups

Finn Thain (3):
      video/macfb: Remove redundant code
      video/macfb: Call fb_invert_cmaps()
      video/macfb: Always initialize DAFB colour table pointer register

Geert Uytterhoeven (4):
      fbdev: atafb: Stop printing virtual screen_base
      fbdev: atafb: Remove obsolete module support
      fbdev: atafb: Fix broken frame buffer after kexec
      fbdev: atafb: Modernize printing of kernel messages

Gerd Hoffmann (1):
      fbdev: list all pci memory bars as conflicting apertures

Gustavo A. R. Silva (1):
      xen, fbfront: mark expected switch fall-through

Jiufei Xue (1):
      fbdev: fix WARNING in __alloc_pages_nodemask bug

Julia Lawall (1):
      omapfb: add missing of_node_put after of_device_is_available

Kangjie Lu (2):
      video: hgafb: fix potential NULL pointer dereference
      video: imsttfb: fix potential NULL pointer dereferences

Kefeng Wang (1):
      video: fbdev: Use dev_get_drvdata()

Linus Walleij (1):
      video: amba-clcd: Decomission Versatile and Nomadik

Melchior Franz (1):
      fbdev: mxsfb: implement FB_PRE_INIT_FB option

Mikulas Patocka (3):
      udlfb: delete the unused parameter for dlfb_handle_damage
      udlfb: fix sleeping inside spinlock
      udlfb: introduce a rendering mutex

Shile Zhang (1):
      fbdev: fix divide error in fb_var_to_videomode

Yifeng Li (9):
      fbdev: sm712fb: fix white screen of death on reboot, don't set CR3B-CR3F
      fbdev: sm712fb: fix brightness control on reboot, don't set SR30
      fbdev: sm712fb: fix VRAM detection, don't set SR70/71/74/75
      fbdev: sm712fb: fix boot screen glitch when sm712fb replaces VGA
      fbdev: sm712fb: fix crashes during framebuffer writes by correctly mapping VRAM
      fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting
      fbdev: sm712fb: fix support for 1024x768-16 mode
      fbdev: sm712fb: use 1024x768 by default on non-MIPS, fix garbled display
      fbdev: sm712fb: fix memory frequency by avoiding a switch/case fallthrough

YueHaibing (3):
      video: fbdev: pvr2fb: remove set but not used variable 'size'
      video: fbdev: mxsfb: remove set but not used variable 'line_count'
      video: fbdev: atmel_lcdfb: remove set but not used variable 'pdata'

 drivers/video/fbdev/Kconfig                        | 304 ++++++-----
 drivers/video/fbdev/Makefile                       |   2 -
 drivers/video/fbdev/amba-clcd-nomadik.c            | 251 ---------
 drivers/video/fbdev/amba-clcd-nomadik.h            |  24 -
 drivers/video/fbdev/amba-clcd-versatile.c          | 567 ---------------------
 drivers/video/fbdev/amba-clcd-versatile.h          |  17 -
 drivers/video/fbdev/amba-clcd.c                    |  98 +---
 drivers/video/fbdev/atafb.c                        |  67 ++-
 drivers/video/fbdev/atafb_iplan2p2.c               |  23 -
 drivers/video/fbdev/atafb_iplan2p4.c               |  23 -
 drivers/video/fbdev/atafb_iplan2p8.c               |  23 -
 drivers/video/fbdev/atafb_mfb.c                    |  23 -
 drivers/video/fbdev/atmel_lcdfb.c                  | 116 +----
 drivers/video/fbdev/core/fbcmap.c                  |   2 +
 drivers/video/fbdev/core/fbcon.c                   |   2 +-
 drivers/video/fbdev/core/fbmem.c                   |  29 +-
 drivers/video/fbdev/core/modedb.c                  |   3 +
 drivers/video/fbdev/hgafb.c                        |   2 +
 drivers/video/fbdev/imsttfb.c                      |   5 +
 drivers/video/fbdev/macfb.c                        |  29 +-
 drivers/video/fbdev/mmp/Kconfig                    |   6 +-
 drivers/video/fbdev/mxsfb.c                        |  14 +-
 drivers/video/fbdev/nuc900fb.c                     |   2 +-
 drivers/video/fbdev/omap/Kconfig                   |  20 +-
 drivers/video/fbdev/omap2/omapfb/Kconfig           |  18 +-
 drivers/video/fbdev/omap2/omapfb/displays/Kconfig  |  40 +-
 drivers/video/fbdev/omap2/omapfb/dss/Kconfig       |   6 +-
 .../fbdev/omap2/omapfb/dss/omapdss-boot-init.c     |   6 +-
 drivers/video/fbdev/pvr2fb.c                       |   2 -
 drivers/video/fbdev/s3c2410fb.c                    |   2 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |   6 +-
 drivers/video/fbdev/sm712.h                        |  12 +-
 drivers/video/fbdev/sm712fb.c                      | 243 +++++++--
 drivers/video/fbdev/udlfb.c                        | 114 ++++-
 drivers/video/fbdev/uvesafb.c                      |  16 +-
 drivers/video/fbdev/vesafb.c                       |   4 +-
 drivers/video/fbdev/xen-fbfront.c                  |   2 +-
 include/linux/amba/clcd.h                          |  31 --
 include/video/udlfb.h                              |   7 +
 39 files changed, 608 insertions(+), 1553 deletions(-)
 delete mode 100644 drivers/video/fbdev/amba-clcd-nomadik.c
 delete mode 100644 drivers/video/fbdev/amba-clcd-nomadik.h
 delete mode 100644 drivers/video/fbdev/amba-clcd-versatile.c
 delete mode 100644 drivers/video/fbdev/amba-clcd-versatile.h
