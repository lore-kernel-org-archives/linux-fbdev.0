From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 13 Nov 2019 11:52:30 +0000
Subject: [PATCH v4 0/3] drm/udl: Replace fbdev by generic emulation
Message-Id: <20191113115233.18483-1-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, noralf@tronnes.org, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

The udl driver can use the generic fbdev emulation. After conversion,
a number of cleanups can be applied.

The fbdev conversion is in patch 1. As udl was the only remaining
external user of unlink_framebuffer(), that function now becomes an
internal interface of the fbdev code (Patches 2 + 3).

V4 of the patchset keeps udl_gem_object_free_object(). The function
is still required to clean up after the damage handler mapped a BO.

The patchset has been tested by running the console, X11 and Weston
on a DisplayLink adapter.

v4:
	* go back to 24 bpp by default, 16 bpp for console
	* keep udl_gem_object_free_object(); required by damage handler
v3:
	* use 32 bpp by default
	* use defaults for several callback functions
	* remove all fb module parameters
	* remove udl_fbdev_init()
v2:
	* converted udl to SHMEM and recreated fbdev patchset on top

Thomas Zimmermann (3):
  drm/udl: Replace fbdev code with generic emulation
  drm/fb-helper: Remove drm_fb_helper_unlink_fbi()
  fbdev: Unexport unlink_framebuffer()

 drivers/gpu/drm/drm_fb_helper.c   |  16 +-
 drivers/gpu/drm/udl/udl_drv.c     |   1 -
 drivers/gpu/drm/udl/udl_drv.h     |   6 -
 drivers/gpu/drm/udl/udl_fb.c      | 282 ------------------------------
 drivers/gpu/drm/udl/udl_main.c    |   5 +-
 drivers/gpu/drm/udl/udl_modeset.c |   1 -
 drivers/video/fbdev/core/fbmem.c  |   3 +-
 include/drm/drm_fb_helper.h       |   6 -
 include/linux/fb.h                |   1 -
 9 files changed, 4 insertions(+), 317 deletions(-)

--
2.23.0
