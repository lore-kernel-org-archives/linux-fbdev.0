From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:33 +0000
Subject: [RFC][PATCH 00/11] DRM driver for fbdev devices
Message-Id: <20190326091744.11542-1-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

Hi,

this RFC patch set implements fbdevdrm, a DRM driver on top of fbdev
drivers. I'd appreciate feedback on the code and the idea in general.

The fbdev subsystem is considered legacy and will probably be removed at
some point. This would mean the loss of a signifanct number of drivers.
Some of the affected hardware is probably not in use any longer, but some
hardware is still around and provides good(-enough) framebuffers.

OTOH, userspace programs that want to support a wide range of graphics
hardware have to implement support for both DRM and fbdev interfaces. Such
software would benefit from a single interface.

The fbdevdrm driver provides a way of running drivers for old and new
hardware from the DRM subsystem and interfaces.

It's not intended to add new features or drivers to fbdev. Instead fbdevdrm
is supposed to be a template for converting fbdev drivers to DRM. It contains
a number of comments (labeled 'DRM porting note') that explain the required
steps. The license is fairly liberal to allow for combination with existing
fbdev code.

I tested the current patch set with the following drivers: atyfb, aty128fb,
matroxfb, pm2fb, s3fb, savagefb, sisfb, tdfxfb and tridentfb. I was able to
successfully start with fbcon enabled and then run weston or X.

Thomas Zimmermann (11):
  drm/fbdevdrm: Add driver skeleton
  drm/fbdevdrm: Add fbdevdrm device
  drm/fbdevdrm: Add memory management
  drm/fbdevdrm: Add file operations
  drm/fbdevdrm: Add GEM and dumb interfaces
  drm/fbdevdrm: Add modesetting infrastructure
  drm/fbdevdrm: Add DRM <-> fbdev pixel-format conversion
  drm/fbdevdrm: Add mode conversion DRM <-> fbdev
  drm/fbdevdrm: Add primary plane
  drm/fbdevdrm: Add CRTC
  drm/fbdevdrm: Detect and validate display modes

 drivers/gpu/drm/Kconfig                     |   2 +
 drivers/gpu/drm/Makefile                    |   1 +
 drivers/gpu/drm/fbdevdrm/Kconfig            |  13 +
 drivers/gpu/drm/fbdevdrm/Makefile           |  11 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c      | 276 ++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h      |  58 ++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c  |  96 +++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h  |  55 ++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c     | 347 +++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c  | 441 ++++++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h  |  26 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c   | 195 +++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h   |  53 ++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c | 746 ++++++++++++++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h |  38 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c | 498 +++++++++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h |  27 +
 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c     | 202 ++++++
 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h     |  35 +
 19 files changed, 3120 insertions(+)
 create mode 100644 drivers/gpu/drm/fbdevdrm/Kconfig
 create mode 100644 drivers/gpu/drm/fbdevdrm/Makefile
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_bo.h
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_device.h
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_format.h
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modes.h
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_modeset.h
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_primary.h
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.c
 create mode 100644 drivers/gpu/drm/fbdevdrm/fbdevdrm_ttm.h

--
2.21.0
