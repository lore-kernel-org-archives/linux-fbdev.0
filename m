From: tom.cooksey@arm.com
Date: Thu, 25 Jul 2013 17:17:27 +0000
Subject: [RFC 0/1] drm/pl111: Initial drm/kms driver for pl111
Message-Id: <1374772648-19151-1-git-send-email-tom.cooksey@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org, pawel.moll@arm.com, linux-arm-kernel@lists.infradead.org, Tom Cooksey <tom.cooksey@arm.com>

From: Tom Cooksey <tom.cooksey@arm.com>

Please find below the current state of our pl111 DRM/KMS driver. This
is lightly tested on a Versatile Express using X running the
xf86-video-armsoc DDX driver[i] with the patches applied to drm-next
as of ~last week. To actually see anything on the DVI output, you
must also apply Pawel Moll's VExpress DVI mux driver[ii] to select
the video signal from the ca9x4 core tile.

[i] <https://git.linaro.org/gitweb?p=arm/xorg/driver/xf86-video-armsoc.git;a=summary>
[ii] <https://patchwork.kernel.org/patch/1765981/>


Known issues:
 * It uses KDS. We intend to switch to whatever implicit per-buffer
   synchronisation mechanism gets merged, once something is merged.
 * It abuses flags parameter of DRM_IOCTL_MODE_CREATE_DUMB to also
   allocate buffers for the GPU. Still not sure how to resolve this
   as we don't use DRM for our GPU driver.
 * Doesn't handle page flip event sequence numbers and timestamps
 * The v_sync handling needs work in general - a work queue is a
   little overkill
 * Doesn't support the import half of PRIME properly, only export
 * Need to validate src rectangle size in
   pl111_drm_cursor_plane_update()
 * Only supports 640x480 mode, which is hard-coded. We intend to
   rebase on top of CDF once it is merged, which hopefully will
   handle a lot of the EDID parsing & mode setting for us (once
   Pawel's CDF patches for VExpress also land).

I appreciate that's a fairly hefty list of known issues already!
However, we're waiting for both CDF & dma_buf sync mechanisms to land
before we can address some of those. So in the mean-time, I thought
someone might be interested in taking a look at what we have so far,
which is why I'm posting this now. Needless to say the code will need
to be refactored a fair bit, however I'm keen to get and additional
feedback anyone cares to give.


Cheers,

Tom

Tom Cooksey (1):
  drm/pl111: Initial drm/kms driver for pl111 display controller

 drivers/gpu/drm/Kconfig                     |    2 +
 drivers/gpu/drm/Makefile                    |    1 +
 drivers/gpu/drm/pl111/Kbuild                |   14 +
 drivers/gpu/drm/pl111/Kconfig               |    9 +
 drivers/gpu/drm/pl111/pl111_clcd_ext.h      |   78 ++++
 drivers/gpu/drm/pl111/pl111_drm.h           |  227 ++++++++++++
 drivers/gpu/drm/pl111/pl111_drm_connector.c |  166 +++++++++
 drivers/gpu/drm/pl111/pl111_drm_crtc.c      |  432 ++++++++++++++++++++++
 drivers/gpu/drm/pl111/pl111_drm_cursor.c    |   97 +++++
 drivers/gpu/drm/pl111/pl111_drm_device.c    |  319 +++++++++++++++++
 drivers/gpu/drm/pl111/pl111_drm_dma_buf.c   |  339 ++++++++++++++++++
 drivers/gpu/drm/pl111/pl111_drm_encoder.c   |  106 ++++++
 drivers/gpu/drm/pl111/pl111_drm_fb.c        |  152 ++++++++
 drivers/gpu/drm/pl111/pl111_drm_funcs.h     |  127 +++++++
 drivers/gpu/drm/pl111/pl111_drm_gem.c       |  287 +++++++++++++++
 drivers/gpu/drm/pl111/pl111_drm_pl111.c     |  513 +++++++++++++++++++++++++++
 drivers/gpu/drm/pl111/pl111_drm_platform.c  |  150 ++++++++
 drivers/gpu/drm/pl111/pl111_drm_suspend.c   |   35 ++
 drivers/gpu/drm/pl111/pl111_drm_vma.c       |  214 +++++++++++
 19 files changed, 3268 insertions(+)
 create mode 100644 drivers/gpu/drm/pl111/Kbuild
 create mode 100644 drivers/gpu/drm/pl111/Kconfig
 create mode 100644 drivers/gpu/drm/pl111/pl111_clcd_ext.h
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm.h
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_connector.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_crtc.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_cursor.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_device.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_dma_buf.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_encoder.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_fb.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_funcs.h
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_gem.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_pl111.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_platform.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_suspend.c
 create mode 100644 drivers/gpu/drm/pl111/pl111_drm_vma.c

-- 
1.7.9.5


