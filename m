From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 14 Jun 2011 09:24:56 +0000
Subject: [PATCH v2 18/29] pm3fb: use display information in info not in var for panning
Message-Id: <1308043507-11083-19-git-send-email-laurent.pinchart@ideasonboard.com>
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
 drivers/video/pm3fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 6666f45..8221b5b 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -1147,9 +1147,9 @@ static int pm3fb_pan_display(struct fb_var_screeninfo *var,
 				 struct fb_info *info)
 {
 	struct pm3_par *par = info->par;
-	const u32 xres = (var->xres + 31) & ~31;
+	const u32 xres = (info->var.xres + 31) & ~31;
 
-	par->base = pm3fb_shift_bpp(var->bits_per_pixel,
+	par->base = pm3fb_shift_bpp(info->var.bits_per_pixel,
 					(var->yoffset * xres)
 					+ var->xoffset);
 	PM3_WAIT(par, 1);
-- 
1.7.3.4

