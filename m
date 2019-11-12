From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 12 Nov 2019 14:04:26 +0000
Subject: [PATCH v3 0/5] drm/udl: Replace fbdev by generic emulation
Message-Id: <20191112140431.7895-1-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@redhat.com, sean@poorly.run, daniel@ffwll.ch, b.zolnierkie@samsung.com, noralf@tronnes.org, kraxel@redhat.com, sam@ravnborg.org, emil.velikov@collabora.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

The udl driver can use the generic fbdev emulation. After conversion,
a number of cleanups can be applied.

Patch 1 prepares the prefered defaults. 32 bpp work well with driver,
console and X11. The fbdev conversion is in patch 2. The original fbdev
code in udl mapped the framebuffer's GEM object memory unconditionally,
and unmapped the memory in the object's free() function. The respective
code in free() can now be removed (Patch 3). And as udl was the
only remaining external user of unlink_framebuffer(), that function
now becomes an internal interface of the fbdev code (Patches 4 + 5).

The patchset has been tested by running the console, X11 and Weston
on a DisplayLink adapter.

v3:
	* use 32 bpp by default
	* use defaults for several callback functions
	* remove all fb module parameters
	* remove udl_fbdev_init()
v2:
	* converted udl to SHMEM and recreated fbdev patchset on top

Thomas Zimmermann (5):
  drm/udl: Set default color depth to 32 bpp
  drm/udl: Replace fbdev code with generic emulation
  drm/udl: Remove udl implementation of GEM's free_object()
  drm/fb-helper: Remove drm_fb_helper_unlink_fbi()
  fbdev: Unexport unlink_framebuffer()

 drivers/gpu/drm/drm_fb_helper.c   |  16 +-
 drivers/gpu/drm/udl/udl_drv.c     |   1 -
 drivers/gpu/drm/udl/udl_drv.h     |   6 -
 drivers/gpu/drm/udl/udl_fb.c      | 282 ------------------------------
 drivers/gpu/drm/udl/udl_gem.c     |  18 +-
 drivers/gpu/drm/udl/udl_main.c    |   5 +-
 drivers/gpu/drm/udl/udl_modeset.c |   3 +-
 drivers/video/fbdev/core/fbmem.c  |   3 +-
 include/drm/drm_fb_helper.h       |   6 -
 include/linux/fb.h                |   1 -
 10 files changed, 6 insertions(+), 335 deletions(-)

--
2.23.0
