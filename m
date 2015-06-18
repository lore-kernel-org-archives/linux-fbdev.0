From: "Gujulan Elango, Hari Prasath (H.)" <hgujulan@visteon.com>
Date: Thu, 18 Jun 2015 12:56:54 +0000
Subject: [PATCH] staging: sm750fb: convert pr_err to pr_info
Message-Id: <20150618125052.GA21893@IND12F0122>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Hari Prasath Gujulan Elango <hgujulan@visteon.com>

This patch modifies few debug prints from pr_err() to pr_info() as they
fall under that category.

Signed-off-by: Hari Prasath Gujulan Elango <hgujulan@visteon.com>
---
 drivers/staging/sm750fb/sm750.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 6b642d7..3f30bc0 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -338,7 +338,7 @@ static int lynxfb_ops_set_par(struct fb_info *info)
 	line_length = var->xres_virtual * var->bits_per_pixel / 8;
 	line_length = PADDING(crtc->line_pad, line_length);
 	fix->line_length = line_length;
-	pr_err("fix->line_length = %d\n", fix->line_length);
+	pr_info("fix->line_length = %d\n", fix->line_length);
 
 	/* var->red,green,blue,transp are need to be set by driver
 	 * and these data should be set before setcolreg routine
@@ -1021,8 +1021,8 @@ static void sm750fb_setup(struct lynx_share *share, char *src)
 	}
 
 	while ((opt = strsep(&src, ":")) != NULL && *opt != 0) {
-		pr_err("opt=%s\n", opt);
-		pr_err("src=%s\n", src);
+		pr_info("opt=%s\n", opt);
+		pr_info("src=%s\n", src);
 
 		if (!strncmp(opt, "swap", strlen("swap")))
 			swap = 1;
-- 
1.9.1
