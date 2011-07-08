From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Jul 2011 11:14:30 +0000
Subject: [PATCH v3 16/29] neofb: use display information in info not in var for panning
Message-Id: <1310123683-8064-17-git-send-email-laurent.pinchart@ideasonboard.com>
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
 drivers/video/neofb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/neofb.c b/drivers/video/neofb.c
index 588527a..feea7b1 100644
--- a/drivers/video/neofb.c
+++ b/drivers/video/neofb.c
@@ -1185,8 +1185,8 @@ static int neofb_pan_display(struct fb_var_screeninfo *var,
 
 	DBG("neofb_update_start");
 
-	Base = (var->yoffset * var->xres_virtual + var->xoffset) >> 2;
-	Base *= (var->bits_per_pixel + 7) / 8;
+	Base = (var->yoffset * info->var.xres_virtual + var->xoffset) >> 2;
+	Base *= (info->var.bits_per_pixel + 7) / 8;
 
 	neoUnlock();
 
-- 
1.7.3.4

