From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 27 Apr 2018 11:21:42 +0000
Subject: [PATCH 0/3] fbdev/drm: sh_mobile: remove unused MERAM support
Message-Id: <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180427112213epcas2p3ed6890af75e679b537121f2655aa91d8@epcas2p3.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org

Hi,

This patchset removes unused MERAM support (last user was removed
3 years ago) from shmobile fbdev & drm drivers and then removes
MERAM driver itself.

If it is okay to merge this patches I would like patch #1 to go
through fbdev tree and patch #2 to go through drm tree. Once they
are both upstream (v4.18) I will apply patch #3 to fbdev tree.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (3):
  video: fbdev: sh_mobile_lcdcfb: remove unused MERAM support
  drm: shmobile: remove unused MERAM support
  video: fbdev: remove unused sh_mobile_meram driver

 drivers/gpu/drm/shmobile/Kconfig           |   1 -
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c  |  42 --
 drivers/gpu/drm/shmobile/shmob_drm_crtc.h  |   1 -
 drivers/gpu/drm/shmobile/shmob_drm_drv.h   |   2 -
 drivers/gpu/drm/shmobile/shmob_drm_kms.c   |  11 -
 drivers/gpu/drm/shmobile/shmob_drm_kms.h   |   1 -
 drivers/gpu/drm/shmobile/shmob_drm_plane.c |   2 -
 drivers/video/fbdev/Kconfig                |  13 -
 drivers/video/fbdev/Makefile               |   1 -
 drivers/video/fbdev/sh_mobile_lcdcfb.c     |  63 +--
 drivers/video/fbdev/sh_mobile_lcdcfb.h     |   1 -
 drivers/video/fbdev/sh_mobile_meram.c      | 754 -----------------------------
 include/linux/platform_data/shmob_drm.h    |   4 -
 include/video/sh_mobile_lcdc.h             |   3 -
 include/video/sh_mobile_meram.h            |  95 ----
 15 files changed, 1 insertion(+), 993 deletions(-)
 delete mode 100644 drivers/video/fbdev/sh_mobile_meram.c
 delete mode 100644 include/video/sh_mobile_meram.h

-- 
1.9.1
