From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 08 Jun 2011 10:43:49 +0000
Subject: [PATCH] video: s3c-fb: move enabling channel for window
Message-Id: <1307529829-31612-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch moves enabling channel for window, because there should
be enabling channel before enabling window. If the sequence is
reversed, it makes the problem in displaying images to lcd panel.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 0352afa..4f1bc39 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -558,6 +558,13 @@ static int s3c_fb_set_par(struct fb_info *info)
 	vidosd_set_alpha(win, alpha);
 	vidosd_set_size(win, data);
 
+	/* Enable DMA channel for this window */
+	if (sfb->variant.has_shadowcon) {
+		data = readl(sfb->regs + SHADOWCON);
+		data |= SHADOWCON_CHx_ENABLE(win_no);
+		writel(data, sfb->regs + SHADOWCON);
+	}
+
 	data = WINCONx_ENWIN;
 
 	/* note, since we have to round up the bits-per-pixel, we end up
@@ -637,13 +644,6 @@ static int s3c_fb_set_par(struct fb_info *info)
 	writel(data, regs + sfb->variant.wincon + (win_no * 4));
 	writel(0x0, regs + sfb->variant.winmap + (win_no * 4));
 
-	/* Enable DMA channel for this window */
-	if (sfb->variant.has_shadowcon) {
-		data = readl(sfb->regs + SHADOWCON);
-		data |= SHADOWCON_CHx_ENABLE(win_no);
-		writel(data, sfb->regs + SHADOWCON);
-	}
-
 	shadow_protect_win(win, 0);
 
 	return 0;
-- 
1.7.1

