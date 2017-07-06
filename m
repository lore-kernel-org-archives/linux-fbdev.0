From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 06 Jul 2017 12:57:31 +0000
Subject: [PATCH 0/4] Make fbcon a built-time depency for fbdev, take 2
Message-Id: <20170706125735.28299-1-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, Intel Graphics Development <intel-gfx@lists.freedesktop.org>

Hi all,

So the original simple hack failed and we need to do a bit more. This time
tested including depmod for all combos. And since I had the pleasure to read
more fbdev code, 3 simple patches on top to clean up some more.

Cheers, Daniel

Daniel Vetter (4):
  fbcon: Make fbcon a built-time depency for fbdev
  fbdev: Nuke FBINFO_MODULE
  drm/qxl: Drop fbdev hwaccel flags
  drm/<drivers>: Drop fbdev info flags

 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c               |  1 -
 drivers/gpu/drm/armada/armada_fbdev.c                |  1 -
 drivers/gpu/drm/ast/ast_fb.c                         |  1 -
 drivers/gpu/drm/bochs/bochs_fbdev.c                  |  1 -
 drivers/gpu/drm/cirrus/cirrus_fbdev.c                |  1 -
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c    |  1 -
 drivers/gpu/drm/i915/intel_fbdev.c                   |  1 -
 drivers/gpu/drm/mgag200/mgag200_fb.c                 |  1 -
 drivers/gpu/drm/msm/msm_fbdev.c                      |  1 -
 drivers/gpu/drm/omapdrm/omap_fbdev.c                 |  1 -
 drivers/gpu/drm/qxl/qxl_fb.c                         |  1 -
 drivers/gpu/drm/radeon/radeon_fb.c                   |  1 -
 drivers/gpu/drm/udl/udl_fb.c                         |  1 -
 drivers/gpu/drm/virtio/virtgpu_fb.c                  |  1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c                   |  1 -
 drivers/video/console/Kconfig                        |  2 +-
 drivers/video/console/Makefile                       |  8 --------
 drivers/video/fbdev/core/Makefile                    | 11 +++++++++++
 drivers/video/{console => fbdev/core}/bitblit.c      |  4 ----
 drivers/video/{console => fbdev/core}/fbcon.c        | 15 ++++-----------
 drivers/video/{console => fbdev/core}/fbcon.h        |  0
 drivers/video/{console => fbdev/core}/fbcon_ccw.c    |  4 ----
 drivers/video/{console => fbdev/core}/fbcon_cw.c     |  4 ----
 drivers/video/{console => fbdev/core}/fbcon_rotate.c |  4 ----
 drivers/video/{console => fbdev/core}/fbcon_rotate.h |  0
 drivers/video/{console => fbdev/core}/fbcon_ud.c     |  4 ----
 drivers/video/fbdev/core/fbmem.c                     | 10 ++++++++--
 drivers/video/{console => fbdev/core}/softcursor.c   |  4 ----
 drivers/video/{console => fbdev/core}/tileblit.c     |  5 -----
 include/linux/fb.h                                   |  7 +------
 include/linux/fbcon.h                                | 12 ++++++++++++
 31 files changed, 37 insertions(+), 72 deletions(-)
 rename drivers/video/{console => fbdev/core}/bitblit.c (98%)
 rename drivers/video/{console => fbdev/core}/fbcon.c (99%)
 rename drivers/video/{console => fbdev/core}/fbcon.h (100%)
 rename drivers/video/{console => fbdev/core}/fbcon_ccw.c (98%)
 rename drivers/video/{console => fbdev/core}/fbcon_cw.c (98%)
 rename drivers/video/{console => fbdev/core}/fbcon_rotate.c (95%)
 rename drivers/video/{console => fbdev/core}/fbcon_rotate.h (100%)
 rename drivers/video/{console => fbdev/core}/fbcon_ud.c (98%)
 rename drivers/video/{console => fbdev/core}/softcursor.c (93%)
 rename drivers/video/{console => fbdev/core}/tileblit.c (96%)
 create mode 100644 include/linux/fbcon.h

-- 
2.13.2

