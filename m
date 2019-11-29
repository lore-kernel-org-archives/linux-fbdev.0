From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 29 Nov 2019 10:29:35 +0000
Subject: [PATCH v2 05/14] video: fbdev: vesafb: modify the static fb_ops directly
Message-Id: <9e34c1d9a81690cbd75af7969fc4baf60a64b13f.1575022735.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, Daniel Vetter <daniel.vetter@ffwll.ch>, intel-gfx@lists.freedesktop.org

Avoid modifying the fb_ops via info->fbops to let us make the pointer
const in the future.

Cc: linux-fbdev@vger.kernel.org
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/vesafb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index d9c08f6c2155..a1fe24ea869b 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -447,15 +447,15 @@ static int vesafb_probe(struct platform_device *dev)
 	       vesafb_fix.smem_start, info->screen_base,
 	       size_remap/1024, size_total/1024);
 
+	if (!ypan)
+		vesafb_ops.fb_pan_display = NULL;
+
 	info->fbops = &vesafb_ops;
 	info->var = vesafb_defined;
 	info->fix = vesafb_fix;
 	info->flags = FBINFO_FLAG_DEFAULT | FBINFO_MISC_FIRMWARE |
 		(ypan ? FBINFO_HWACCEL_YPAN : 0);
 
-	if (!ypan)
-		info->fbops->fb_pan_display = NULL;
-
 	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
 		err = -ENOMEM;
 		goto err;
-- 
2.20.1
