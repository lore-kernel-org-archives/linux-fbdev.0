From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 14 Jun 2011 09:24:55 +0000
Subject: [PATCH v2 17/29] pm2fb: use display information in info not in var for panning
Message-Id: <1308043507-11083-18-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/pm2fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
index 27f93aa..f4f8ce8 100644
--- a/drivers/video/pm2fb.c
+++ b/drivers/video/pm2fb.c
@@ -973,8 +973,8 @@ static int pm2fb_pan_display(struct fb_var_screeninfo *var,
 {
 	struct pm2fb_par *p = info->par;
 	u32 base;
-	u32 depth = (var->bits_per_pixel + 7) & ~7;
-	u32 xres = (var->xres + 31) & ~31;
+	u32 depth = (info->var.bits_per_pixel + 7) & ~7;
+	u32 xres = (info->var.xres + 31) & ~31;
 
 	depth = (depth > 32) ? 32 : depth;
 	base = to3264(var->yoffset * xres + var->xoffset, depth, 1);
-- 
1.7.3.4

