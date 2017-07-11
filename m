From: Rob Clark <robdclark@gmail.com>
Date: Tue, 11 Jul 2017 13:38:19 +0000
Subject: [PATCH 0/3] drm/msm: hijack firmware fb's memory
Message-Id: <20170711133822.31978-1-robdclark@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The first patch I've already sent to list and plan to include in a
v4.13-fixes pull request, but I'm resending as part of this patchset
since 3/3 depends on it.

The 2nd patch exports get_fb_info()/put_fb_info() so that in the 3rd
patch we can iterate over the registered fb's (before kicking out fw
fb) and find the stolen memory from bootloader display.

Note that the firmware fb might either be efifb or simplefb, depending
on EFI boot or not.  So a devicetree based solution to this is not
useful.

This is prep-work for a larger patchset for drm/msm to readback and
take over display setup by bootloader (although that also requires
some CCF and other changes.. RFC patchset coming soon).  In the RFC
patchset, drm/msm will wrap the stolen mem in a GEM object and use
that to create a drm_framebuffer object for the read-back plane state
(and if the drm fbdev emulation layer is enabled, it will try to re-
use this for the fbdev scanout buffer).

If no objections to the 2nd patch, I guess it is probably easiest if
it is merged via msm-next for 4.14.

Rob Clark (3):
  drm/msm: kick out firmware framebuffer
  fbdev: fbmem: export get/put_fb_info()
  drm/msm: hijack firmware fb's memory

 drivers/gpu/drm/msm/msm_drv.c    | 102 ++++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/msm/msm_drv.h    |   2 +
 drivers/gpu/drm/msm/msm_fbdev.c  |   2 +-
 drivers/video/fbdev/core/fbmem.c |   6 ++-
 include/linux/fb.h               |   2 +
 5 files changed, 93 insertions(+), 21 deletions(-)

-- 
2.13.0

