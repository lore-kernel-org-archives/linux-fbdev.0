From: Jani Nikula <jani.nikula@intel.com>
Date: Tue, 03 Dec 2019 16:38:46 +0000
Subject: [PATCH v3 04/12] video: fbdev: uvesafb: modify the static fb_ops directly
Message-Id: <af63cda5de9fee3acd28e7d264f920338298bc0a.1575390740.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575390740.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org

Avoid modifying the fb_ops via info->fbops to let us make the pointer
const in the future.

Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/uvesafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 439565cae7ab..53d08d1b56f5 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1440,7 +1440,7 @@ static void uvesafb_init_info(struct fb_info *info, struct vbe_mode_ib *mode)
 
 	/* Disable blanking if the user requested so. */
 	if (!blank)
-		info->fbops->fb_blank = NULL;
+		uvesafb_ops.fb_blank = NULL;
 
 	/*
 	 * Find out how much IO memory is required for the mode with
@@ -1510,7 +1510,7 @@ static void uvesafb_init_info(struct fb_info *info, struct vbe_mode_ib *mode)
 			(par->ypan ? FBINFO_HWACCEL_YPAN : 0);
 
 	if (!par->ypan)
-		info->fbops->fb_pan_display = NULL;
+		uvesafb_ops.fb_pan_display = NULL;
 }
 
 static void uvesafb_init_mtrr(struct fb_info *info)
-- 
2.20.1
