From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 29 Jul 2020 13:41:43 +0000
Subject: [RFC][PATCH 0/5] Support GEM object mappings from I/O memory
Message-Id: <20200729134148.6855-1-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@redhat.com, daniel@ffwll.ch, sam@ravnborg.org, kraxel@redhat.com, b.zolnierkie@samsung.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, jani.nikula@intel.com, peda@axentia.se, dan.carpenter@oracle.com, natechancellor@gmail.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

DRM's fbdev console uses regular load and store operations to update
framebuffer memory. The bochs driver on sparc64 requires the use of
I/O-specific load and store operations. We have a workaround, but need
a long-term sulotion tothe problem.

This patchset adds a GEM object function that returns framebuffers as
I/O memory. It further updates fbdev to use the new functionality and
implements vmap_iomem for VRAM helpers.

This is an RFC patchset to discuss the approach. It still needs testing
and polish. Patch #4 has to be rebased onto the recent workaround.

Thomas Zimmermann (5):
  fbdev: Remove trailing whitespace
  fbdev/core: Export framebuffer read and write code as cfb_ function
  drm: Add infrastructure for vmap operations of I/O memory
  drm/fb_helper: Use I/O-memory mappings if available
  drm/vram_helper: Implement struct drm_gem_object_funcs.vmap_iomem

 drivers/gpu/drm/ast/ast_cursor.c      |  12 ++-
 drivers/gpu/drm/drm_client.c          |  52 +++++++++-
 drivers/gpu/drm/drm_fb_helper.c       | 132 ++++++++++++++++++++++----
 drivers/gpu/drm/drm_gem.c             |  19 ++++
 drivers/gpu/drm/drm_gem_vram_helper.c | 106 +++++++++++++++++++--
 drivers/gpu/drm/drm_internal.h        |   1 +
 drivers/video/fbdev/core/fbmem.c      |  61 ++++++++----
 include/drm/drm_client.h              |   8 +-
 include/drm/drm_gem.h                 |  17 +++-
 include/drm/drm_gem_vram_helper.h     |   1 +
 include/linux/fb.h                    |  23 +++--
 11 files changed, 369 insertions(+), 63 deletions(-)

--
2.27.0
