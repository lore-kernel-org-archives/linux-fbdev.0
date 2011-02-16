From: "Justin P. Mattock" <justinmattock@gmail.com>
Date: Wed, 16 Feb 2011 06:55:38 +0000
Subject: [PATCH 3/3]drivers:video:aty:radeon_base Fix typo occationally to occasionally
Message-Id: <1297839338-3198-1-git-send-email-justinmattock@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trivial@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, "Justin P. Mattock" <justinmattock@gmail.com>

The below patch fixes a typo occationally to occasionally.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/gpu/drm/radeon/radeon_legacy_crtc.c |    2 +-
 drivers/video/aty/radeon_base.c             |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
index cf0638c..a883902 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_crtc.c
@@ -888,7 +888,7 @@ static void radeon_set_pll(struct drm_crtc *crtc, struct drm_display_mode *mode)
 		}
 
 		if (rdev->flags & RADEON_IS_MOBILITY) {
-			/* A temporal workaround for the occational blanking on certain laptop panels.
+			/* A temporal workaround for the occasional blanking on certain laptop panels.
 			   This appears to related to the PLL divider registers (fail to lock?).
 			   It occurs even when all dividers are the same with their old settings.
 			   In this case we really don't need to fiddle with PLL registers.
diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 3c1e13e..32f8cf6 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -1248,7 +1248,7 @@ static void radeon_write_pll_regs(struct radeonfb_info *rinfo, struct radeon_reg
 
 	/* Workaround from XFree */
 	if (rinfo->is_mobility) {
-	        /* A temporal workaround for the occational blanking on certain laptop
+	        /* A temporal workaround for the occasional blanking on certain laptop
 		 * panels. This appears to related to the PLL divider registers
 		 * (fail to lock?). It occurs even when all dividers are the same
 		 * with their old settings. In this case we really don't need to
-- 
1.6.5.2.180.gc5b3e

