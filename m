From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Tue, 28 May 2019 09:02:31 +0000
Subject: [PATCH 00/33] fbcon notifier begone v3!
Message-Id: <20190528090304.9388-1-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, linux-fbdev@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>

Hi all,

I think we're slowly getting there. Previous cover letters with more
context:

https://lists.freedesktop.org/archives/dri-devel/2019-May/218362.html

tldr; I have a multi-year plan to improve fbcon locking, because the
current thing is a bit a mess.

Cover letter of this version, where I detail a bit more the details
fixed in this one here:

https://lists.freedesktop.org/archives/dri-devel/2019-May/218984.html

Note that the locking plan in this one is already outdated, I overlooked a
few fun issues around any printk() going back to console_lock.

I think remaining bits:

- Ack from Daniel Thompson for the backlight bits, he wanted to check the
  big picture.

- Hash out actual merge plan.

I'm also cc'ing the entire pile to a lot more people on request.

Thanks, Daniel

Daniel Vetter (33):
  dummycon: Sprinkle locking checks
  fbdev: locking check for fb_set_suspend
  vt: might_sleep() annotation for do_blank_screen
  vt: More locking checks
  fbdev/sa1100fb: Remove dead code
  fbdev/cyber2000: Remove struct display
  fbdev/aty128fb: Remove dead code
  fbcon: s/struct display/struct fbcon_display/
  fbcon: Remove fbcon_has_exited
  fbcon: call fbcon_fb_(un)registered directly
  fbdev/sh_mobile: remove sh_mobile_lcdc_display_notify
  fbdev/omap: sysfs files can't disappear before the device is gone
  fbdev: sysfs files can't disappear before the device is gone
  staging/olpc: lock_fb_info can't fail
  fbdev/atyfb: lock_fb_info can't fail
  fbdev: lock_fb_info cannot fail
  fbcon: call fbcon_fb_bind directly
  fbdev: make unregister/unlink functions not fail
  fbdev: unify unlink_framebuffer paths
  fbdev/sh_mob: Remove fb notifier callback
  fbdev: directly call fbcon_suspended/resumed
  fbcon: Call fbcon_mode_deleted/new_modelist directly
  fbdev: Call fbcon_get_requirement directly
  Revert "backlight/fbcon: Add FB_EVENT_CONBLANK"
  fbmem: pull fbcon_fb_blanked out of fb_blank
  fbdev: remove FBINFO_MISC_USEREVENT around fb_blank
  fb: Flatten control flow in fb_set_var
  fbcon: replace FB_EVENT_MODE_CHANGE/_ALL with direct calls
  vgaswitcheroo: call fbcon_remap_all directly
  fbcon: Call con2fb_map functions directly
  fbcon: Document what I learned about fbcon locking
  staging/olpc_dcon: Add drm conversion to TODO
  backlight: simplify lcd notifier

 arch/arm/mach-pxa/am200epd.c                  |  13 +-
 drivers/gpu/vga/vga_switcheroo.c              |  11 +-
 drivers/media/pci/ivtv/ivtvfb.c               |   6 +-
 drivers/staging/fbtft/fbtft-core.c            |   4 +-
 drivers/staging/olpc_dcon/TODO                |   7 +
 drivers/staging/olpc_dcon/olpc_dcon.c         |   6 +-
 drivers/tty/vt/vt.c                           |  18 +
 drivers/video/backlight/backlight.c           |   2 +-
 drivers/video/backlight/lcd.c                 |  12 -
 drivers/video/console/dummycon.c              |   6 +
 drivers/video/fbdev/aty/aty128fb.c            |  64 ---
 drivers/video/fbdev/aty/atyfb_base.c          |   3 +-
 drivers/video/fbdev/core/fbcmap.c             |   6 +-
 drivers/video/fbdev/core/fbcon.c              | 313 ++++++--------
 drivers/video/fbdev/core/fbcon.h              |   6 +-
 drivers/video/fbdev/core/fbmem.c              | 399 +++++++-----------
 drivers/video/fbdev/core/fbsysfs.c            |  20 +-
 drivers/video/fbdev/cyber2000fb.c             |   1 -
 drivers/video/fbdev/neofb.c                   |   9 +-
 .../video/fbdev/omap2/omapfb/omapfb-sysfs.c   |  21 +-
 drivers/video/fbdev/sa1100fb.c                |  25 --
 drivers/video/fbdev/savage/savagefb_driver.c  |   9 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c        | 132 +-----
 drivers/video/fbdev/sh_mobile_lcdcfb.h        |   5 -
 include/linux/console_struct.h                |   5 +-
 include/linux/fb.h                            |  45 +-
 include/linux/fbcon.h                         |  30 ++
 27 files changed, 396 insertions(+), 782 deletions(-)

-- 
2.20.1
