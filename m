From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:01 +0000
Subject: [PATCH v2 00/15] DRM fbconv helpers for converting fbdev drivers
Message-Id: <20191014140416.28517-1-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

(was: DRM driver for fbdev devices)

This is version 2 of the fbdev conversion helpers. It's more or less a
rewrite of the original patchset.

The fbdev subsystem is considered legacy and will probably be removed at
some point. This would mean the loss of a signifanct number of drivers.
Some of the affected hardware is not in use any longer, but some hardware
is still around and provides good(-enough) framebuffers.

The fbconv helpers allow for running the current DRM stack on top of fbdev
drivers. It's a set of functions that convert between fbdev interfaces and
DRM interfaces. Based on SHMEM and simple KMS helpers, it only offers the
basic functionality of a framebuffer, but should be compatible with most
existing fbdev drivers.

A DRM driver using fbconv helpers consists of

  * DRM stub code that calls into fbconv helpers, and
  * the original fbdev driver code.

The fbdev driver code has to be modified to register itself with the
stub driver instead of the fbdev core framework. A tutorial on how to use
the helpers is part of this patchset. The resulting driver hybrid can be
refactored into a first-class DRM driver. The fbconv helpers contain a
number of comments, labeled 'DRM porting note', which explain the required
steps.

I tested the current patchset with the following drivers: atyfb, aty128fb,
matroxfb, pm2fb, pm3fb, rivafb, s3fb, savagefb, sisfb, tdfxfb and tridentfb.
With each, I was able to successfully start with fbcon enabled, run weston and
X11. The drivers are available at [1]. For reference, the patchset includes
the Matrox stub driver.

v2:
	* rename to fbconv helpers
	* rewrite as helper library
	* switch over to simple KMS helpers
	* switch over to SHMEM
	* add documentation

[1] https://gitlab.freedesktop.org/tzimmermann/linux/commits/fbconv-plus-drivers

Thomas Zimmermann (15):
  fbdev: Export fb_check_foreignness()
  fbdev: Export FBPIXMAPSIZE
  drm/simple-kms-helper: Add mode_fixup() to simple display pipe
  drm: Add fbconv helper module
  drm/fbconv: Add DRM <-> fbdev pixel-format conversion
  drm/fbconv: Add mode conversion DRM <-> fbdev
  drm/fbconv: Add modesetting infrastructure
  drm/fbconv: Add plane-state check and update
  drm/fbconv: Mode-setting pipeline enable / disable
  drm/fbconv: Reimplement several fbdev interfaces
  drm/fbconv: Add helpers for init and cleanup of fb_info structures
  drm/fbconv: Add helper documentation
  staging: Add mgakms driver
  staging/mgakms: Import matroxfb driver source code
  staging/mgakms: Update matroxfb driver code for DRM

 Documentation/gpu/drm-kms-helpers.rst     |   12 +
 Documentation/gpu/todo.rst                |   15 +
 drivers/gpu/drm/Kconfig                   |   11 +
 drivers/gpu/drm/Makefile                  |    1 +
 drivers/gpu/drm/drm_fbconv_helper.c       | 2126 +++++++++++++++++
 drivers/gpu/drm/drm_simple_kms_helper.c   |   15 +
 drivers/staging/Kconfig                   |    2 +
 drivers/staging/Makefile                  |    1 +
 drivers/staging/mgakms/Kconfig            |   18 +
 drivers/staging/mgakms/Makefile           |   17 +
 drivers/staging/mgakms/g450_pll.c         |  539 +++++
 drivers/staging/mgakms/g450_pll.h         |   13 +
 drivers/staging/mgakms/i2c-matroxfb.c     |  238 ++
 drivers/staging/mgakms/matroxfb_DAC1064.c | 1082 +++++++++
 drivers/staging/mgakms/matroxfb_DAC1064.h |  174 ++
 drivers/staging/mgakms/matroxfb_Ti3026.c  |  746 ++++++
 drivers/staging/mgakms/matroxfb_Ti3026.h  |   10 +
 drivers/staging/mgakms/matroxfb_accel.c   |  519 +++++
 drivers/staging/mgakms/matroxfb_accel.h   |    9 +
 drivers/staging/mgakms/matroxfb_base.c    | 2592 +++++++++++++++++++++
 drivers/staging/mgakms/matroxfb_base.h    |  700 ++++++
 drivers/staging/mgakms/matroxfb_crtc2.h   |   35 +
 drivers/staging/mgakms/matroxfb_g450.c    |  640 +++++
 drivers/staging/mgakms/matroxfb_g450.h    |   10 +
 drivers/staging/mgakms/matroxfb_maven.h   |   21 +
 drivers/staging/mgakms/matroxfb_misc.c    |  815 +++++++
 drivers/staging/mgakms/matroxfb_misc.h    |   22 +
 drivers/staging/mgakms/mga_device.c       |   68 +
 drivers/staging/mgakms/mga_device.h       |   30 +
 drivers/staging/mgakms/mga_drv.c          |  129 +
 drivers/staging/mgakms/mga_drv.h          |   14 +
 drivers/video/fbdev/core/fbmem.c          |    5 +-
 include/drm/drm_fbconv_helper.h           |  150 ++
 include/drm/drm_simple_kms_helper.h       |   43 +
 include/linux/fb.h                        |    3 +
 35 files changed, 10822 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_fbconv_helper.c
 create mode 100644 drivers/staging/mgakms/Kconfig
 create mode 100644 drivers/staging/mgakms/Makefile
 create mode 100644 drivers/staging/mgakms/g450_pll.c
 create mode 100644 drivers/staging/mgakms/g450_pll.h
 create mode 100644 drivers/staging/mgakms/i2c-matroxfb.c
 create mode 100644 drivers/staging/mgakms/matroxfb_DAC1064.c
 create mode 100644 drivers/staging/mgakms/matroxfb_DAC1064.h
 create mode 100644 drivers/staging/mgakms/matroxfb_Ti3026.c
 create mode 100644 drivers/staging/mgakms/matroxfb_Ti3026.h
 create mode 100644 drivers/staging/mgakms/matroxfb_accel.c
 create mode 100644 drivers/staging/mgakms/matroxfb_accel.h
 create mode 100644 drivers/staging/mgakms/matroxfb_base.c
 create mode 100644 drivers/staging/mgakms/matroxfb_base.h
 create mode 100644 drivers/staging/mgakms/matroxfb_crtc2.h
 create mode 100644 drivers/staging/mgakms/matroxfb_g450.c
 create mode 100644 drivers/staging/mgakms/matroxfb_g450.h
 create mode 100644 drivers/staging/mgakms/matroxfb_maven.h
 create mode 100644 drivers/staging/mgakms/matroxfb_misc.c
 create mode 100644 drivers/staging/mgakms/matroxfb_misc.h
 create mode 100644 drivers/staging/mgakms/mga_device.c
 create mode 100644 drivers/staging/mgakms/mga_device.h
 create mode 100644 drivers/staging/mgakms/mga_drv.c
 create mode 100644 drivers/staging/mgakms/mga_drv.h
 create mode 100644 include/drm/drm_fbconv_helper.h

--
2.23.0
