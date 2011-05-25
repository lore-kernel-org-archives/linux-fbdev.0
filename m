From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 22:58:16 +0000
Subject: [PATCH 24/29] tridentfb: use display information in info not in var for panning
Message-Id: <1306364301-8195-25-git-send-email-laurent.pinchart@ideasonboard.com>
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
 drivers/video/tridentfb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
index c6c7756..34cf019 100644
--- a/drivers/video/tridentfb.c
+++ b/drivers/video/tridentfb.c
@@ -987,8 +987,8 @@ static int tridentfb_pan_display(struct fb_var_screeninfo *var,
 	unsigned int offset;
 
 	debug("enter\n");
-	offset = (var->xoffset + (var->yoffset * var->xres_virtual))
-		* var->bits_per_pixel / 32;
+	offset = (var->xoffset + (var->yoffset * info->var.xres_virtual))
+		* info->var.bits_per_pixel / 32;
 	set_screen_start(par, offset);
 	debug("exit\n");
 	return 0;
-- 
1.7.3.4

