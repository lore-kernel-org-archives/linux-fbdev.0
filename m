From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 07 Aug 2015 12:16:05 +0000
Subject: [PATCH 4/5] staging: sm750fb: rearrange code
Message-Id: <1438949046-18765-4-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438949046-18765-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1438949046-18765-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Rearrange the code to remove one exit label which also makes the code
less indented and more readable.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/sm750.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index fa2183d..e7fad0f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -261,22 +261,21 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
-	if (image->depth = 1) {
-		if (info->fix.visual = FB_VISUAL_TRUECOLOR ||
-		    info->fix.visual = FB_VISUAL_DIRECTCOLOR) {
-			fgcol = ((u32 *)info->pseudo_palette)[image->fg_color];
-			bgcol = ((u32 *)info->pseudo_palette)[image->bg_color];
-		} else {
-			fgcol = image->fg_color;
-			bgcol = image->bg_color;
-		}
-		goto _do_work;
-	}
 	/* TODO: Implement hardware acceleration for image->depth > 1 */
-	cfb_imageblit(info, image);
-	return;
+	if (image->depth != 1) {
+		cfb_imageblit(info, image);
+		return;
+	}
+
+	if (info->fix.visual = FB_VISUAL_TRUECOLOR ||
+	    info->fix.visual = FB_VISUAL_DIRECTCOLOR) {
+		fgcol = ((u32 *)info->pseudo_palette)[image->fg_color];
+		bgcol = ((u32 *)info->pseudo_palette)[image->bg_color];
+	} else {
+		fgcol = image->fg_color;
+		bgcol = image->bg_color;
+	}
 
-_do_work:
 	/*
 	 * If not use spin_lock, system will die if user load driver
 	 * and immediately unload driver frequently (dual)
-- 
1.9.1

