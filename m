From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 22:58:11 +0000
Subject: [PATCH 19/29] s3c-fb: use display information in info not in var for panning
Message-Id: <1306364301-8195-20-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: InKi Dae <inki.dae@samsung.com>
---
 drivers/video/s3c-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 3b6cdca..4fce307 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -882,7 +882,7 @@ static int s3c_fb_pan_display(struct fb_var_screeninfo *var,
 		}
 	}
 	/* Offset in bytes to the end of the displayed area */
-	end_boff = start_boff + var->yres * info->fix.line_length;
+	end_boff = start_boff + info->var.yres * info->fix.line_length;
 
 	/* Temporarily turn off per-vsync update from shadow registers until
 	 * both start and end addresses are updated to prevent corruption */
-- 
1.7.3.4

