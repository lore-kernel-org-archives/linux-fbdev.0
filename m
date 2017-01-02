From: Martin Kaiser <martin@kaiser.cx>
Date: Mon, 02 Jan 2017 22:20:04 +0000
Subject: [PATCH] video: imxfb: always allocate 256 entries for the color map
Message-Id: <1483395604-6931-1-git-send-email-martin@kaiser.cx>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The current code calculates the number of color map entries as
1 << info->var.bits_per_pixel. For 32bpp modes, 1 << 32 is 0 when
written to an int variable. As a consequence, the subsequent copying
of the default (non-empty) color map into our newly allocated color map
fails and imxfb's probe function returns an error.

On both imx1 and imx21 platforms, the color map is used only for modes
with <= 8bpp. By allocating 256 entries for the color map, we're on the
safe side.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/video/fbdev/imxfb.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index fe0c4ee..1b0faad 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -985,7 +985,11 @@ static int imxfb_probe(struct platform_device *pdev)
 	 */
 	imxfb_check_var(&info->var, info);
 
-	ret = fb_alloc_cmap(&info->cmap, 1 << info->var.bits_per_pixel, 0);
+	/*
+	 * For modes > 8bpp, the color map is bypassed.
+	 * Therefore, 256 entries are enough.
+	 */
+	ret = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (ret < 0)
 		goto failed_cmap;
 
-- 
1.7.10.4

