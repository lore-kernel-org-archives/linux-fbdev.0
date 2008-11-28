From: Hannes Eder <hannes@hanneseder.net>
Subject: [PATCH] pm3fb: fix sparse warning
Date: Fri, 28 Nov 2008 18:16:20 +0100
Message-ID: <493050da.02e2660a.5173.ffffbf69@mx.google.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755434AbYK1UN3@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, trivial@kernel.org

Fix this sparse warning:

  drivers/video/pm3fb.c:543:3: warning: returning void-valued expression

Signed-off-by: Hannes Eder <hannes@hanneseder.net>
---
 drivers/video/pm3fb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index 68089d1..6666f45 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -539,8 +539,10 @@ static void pm3fb_imageblit(struct fb_info *info, const struct fb_image *image)
 		bgx = par->palette[image->bg_color];
 		break;
 	}
-	if (image->depth != 1)
-		return cfb_imageblit(info, image);
+	if (image->depth != 1) {
+		cfb_imageblit(info, image);
+		return;
+	}
 
 	if (info->var.bits_per_pixel == 8) {
 		fgx |= fgx << 8;
-- 
1.5.6.3
