From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] intelfb: fix spelling of "CLOCK"
Date: Tue, 21 Apr 2009 17:07:30 -0400
Message-ID: <20090421210730.10927.73712.stgit@mj.roinet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757885AbZDUVHn@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 drivers/gpu/drm/i915/intel_fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_fb.c b/drivers/gpu/drm/i915/intel_fb.c
index 3e094be..4b6d463 100644
--- a/drivers/gpu/drm/i915/intel_fb.c
+++ b/drivers/gpu/drm/i915/intel_fb.c
@@ -207,7 +207,7 @@ static int intelfb_set_par(struct fb_info *info)
 
 	if (var->pixclock != -1) {
 
-		DRM_ERROR("PIXEL CLCOK SET\n");
+		DRM_ERROR("PIXEL CLOCK SET\n");
 		return -EINVAL;
 	} else {
 		struct drm_crtc *crtc;
