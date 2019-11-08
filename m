From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 08 Nov 2019 12:33:29 +0000
Subject: [PATCH 0/4] drm/udl: Replace fbdev by generic emulation
Message-Id: <20191108123333.25274-1-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, noralf@tronnes.org, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

The udl driver can use the generic fbdev emulation. After conversion,
a number of cleanups can be applied.

The fbdev conversion is in patch 1. The original fbdev code in udl
mapped the framebuffer's GEM object memory unconditionally, and
unmapped the memory in the object's free() function. The respective
code in free() can now be removed (Patch 2). And as udl was the
only remaining external user of unlink_framebuffer(), that function
now becomes an internal interface of the fbdev code.

The patchset has been tested by running the console, X11 and Weston
on a DisplayLink adapter.

Thomas Zimmermann (4):
  drm/udl: Replace fbdev code with generic emulation
  drm/udl: Remove udl implementation of GEM's free_object()
  drm/fb-helper: Remove drm_fb_helper_unlink_fbi()
  fbdev: Unexport unlink_framebuffer()

 drivers/gpu/drm/drm_fb_helper.c   |  16 +-
 drivers/gpu/drm/udl/udl_drv.c     |   4 +-
 drivers/gpu/drm/udl/udl_drv.h     |   5 -
 drivers/gpu/drm/udl/udl_fb.c      | 270 +-----------------------------
 drivers/gpu/drm/udl/udl_gem.c     |  18 +-
 drivers/gpu/drm/udl/udl_main.c    |   2 -
 drivers/gpu/drm/udl/udl_modeset.c |   3 +-
 drivers/video/fbdev/core/fbmem.c  |   3 +-
 include/drm/drm_fb_helper.h       |   6 -
 include/linux/fb.h                |   1 -
 10 files changed, 10 insertions(+), 318 deletions(-)

--
2.23.0
