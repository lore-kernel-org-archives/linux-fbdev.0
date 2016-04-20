From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Date: Wed, 20 Apr 2016 15:25:21 +0000
Subject: [PATCH 0/8] drm: Add fbdev deferred io support to helpers
Message-Id: <1461165929-11344-1-git-send-email-noralf@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org

This patchset adds fbdev deferred io support to drm_fb_helper and
drm_fb_cma_helper.

It defers fbdev mmap and fb_{write,fillrect,copyarea,imageblit} damage and
channels it through the (struct drm_framebuffer_funcs)->dirty callback on
the fb_helper framebuffer which will always run in process context.

I have also added patches that converts qxl and udl to use this
deferred io support. I have only compile tested it, no functional testing.
I know that qxl is purely a software thing so I could actually test it, but
I have never used qemu so I'm not keen on spending a lot of time on that.

This was originally part of the tinydrm patchset.

Changes since RFC:
- Fix drm_clip_rect use to be exclusive on x2/y2
- Put drm_clip_rect functions in drm_rect.{h,c}
- Take into account that (struct fb_ops *)->fb_{write,...}() can be called
  from atomic context (spin_lock_irqsave)
- Export fb_deferred_io_mmap()
- Add some more documentation
- Add qxl and udl patches

Noralf Tr=C3=B8nnes (8):
  drm/rect: Add some drm_clip_rect utility functions
  drm/udl: Change drm_fb_helper_sys_*() calls to sys_*()
  drm/qxl: Change drm_fb_helper_sys_*() calls to sys_*()
  drm/fb-helper: Add fb_deferred_io support
  fbdev: fb_defio: Export fb_deferred_io_mmap
  drm/fb-cma-helper: Add fb_deferred_io support
  drm/qxl: Use drm_fb_helper deferred_io support
  drm/udl: Use drm_fb_helper deferred_io support

 drivers/gpu/drm/drm_fb_cma_helper.c | 190 +++++++++++++++++++++++++++++--
 drivers/gpu/drm/drm_fb_helper.c     | 119 ++++++++++++++++++-
 drivers/gpu/drm/drm_rect.c          |  67 +++++++++++
 drivers/gpu/drm/qxl/qxl_display.c   |   9 +-
 drivers/gpu/drm/qxl/qxl_drv.h       |   7 +-
 drivers/gpu/drm/qxl/qxl_fb.c        | 220 +++++++++-----------------------=
----
 drivers/gpu/drm/qxl/qxl_kms.c       |   4 -
 drivers/gpu/drm/udl/udl_drv.h       |   2 -
 drivers/gpu/drm/udl/udl_fb.c        | 152 ++-----------------------
 drivers/video/fbdev/core/fb_defio.c |   3 +-
 include/drm/drm_fb_cma_helper.h     |  14 +++
 include/drm/drm_fb_helper.h         |  15 +++
 include/drm/drm_rect.h              |  69 +++++++++++
 include/linux/fb.h                  |   1 +
 14 files changed, 538 insertions(+), 334 deletions(-)

--
2.2.2

