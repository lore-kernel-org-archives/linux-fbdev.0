From: wolzstefan@web.de
Date: Thu, 23 Jun 2016 12:00:13 +0000
Subject: [PATCH 4/4] sm750fb/sm750_hw.c: split assignment & long lines
Message-Id: <1466683213-17477-5-git-send-email-wolzstefan@web.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1466683213-17477-1-git-send-email-wolzstefan@web.de>
In-Reply-To: <1466683213-17477-1-git-send-email-wolzstefan@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de, Stefan Wolz <wolzstefan@web.de>, Christian Halder <christian.halder@fau.de>, Sebastian Handwerker <sebastian.handwerker@posteo.de>

From: Stefan Wolz <wolzstefan@web.de>

Split lines over 80 characters and separated assignments.

Signed-off-by: Stefan Wolz <wolzstefan@web.de>
Signed-off-by: Christian Halder <christian.halder@fau.de>
Signed-off-by: Sebastian Handwerker <sebastian.handwerker@posteo.de>
---
 drivers/staging/sm750fb/sm750_hw.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index f2ed82e..1de9f81 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -212,7 +212,8 @@ int hw_sm750_output_setMode(struct lynxfb_output *output,
 	return ret;
 }
 
-int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc, struct fb_var_screeninfo *var)
+int hw_sm750_crtc_checkMode(struct lynxfb_crtc *crtc,
+			    struct fb_var_screeninfo *var)
 {
 	struct sm750_dev *sm750_dev;
 	struct lynxfb_par *par = container_of(crtc, struct lynxfb_par, crtc);
@@ -280,11 +281,13 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 	modparm.horizontal_display_end = var->xres;
 	modparm.horizontal_sync_width = var->hsync_len;
 	modparm.horizontal_sync_start = var->xres + var->right_margin;
-	modparm.horizontal_total = var->xres + var->left_margin + var->right_margin + var->hsync_len;
+	modparm.horizontal_total = var->xres + var->left_margin +
+				   var->right_margin + var->hsync_len;
 	modparm.vertical_display_end = var->yres;
 	modparm.vertical_sync_height = var->vsync_len;
 	modparm.vertical_sync_start = var->yres + var->lower_margin;
-	modparm.vertical_total = var->yres + var->upper_margin + var->lower_margin + var->vsync_len;
+	modparm.vertical_total = var->yres + var->upper_margin +
+				 var->lower_margin + var->vsync_len;
 
 	/* choose pll */
 	if (crtc->channel != sm750_secondary)
@@ -413,7 +416,9 @@ int hw_sm750_setBLANK(struct lynxfb_output *output, int blank)
 {
 	unsigned int dpms, pps, crtdb;
 
-	dpms = pps = crtdb = 0;
+	dpms = 0;
+	pps = 0;
+	crtdb = 0;
 
 	switch (blank) {
 	case FB_BLANK_UNBLANK:
-- 
1.9.1

