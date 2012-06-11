From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 11 Jun 2012 02:26:41 +0000
Subject: [PATCH 1/2] video: s3c-fb: clear SHADOWCON register when clearing hardware window registers
Message-Id: <001801cd4779$a2c2c220$e8484660$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

All bits of SHADOWCON register should be cleared when clearing
hardware window registers; however, some bits of SHADOWCON register
are not cleared previously.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/s3c-fb.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 5f9d8e6..b5c2939 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1348,8 +1348,14 @@ static void s3c_fb_clear_win(struct s3c_fb *sfb, int win)
 	writel(0, regs + VIDOSD_A(win, sfb->variant));
 	writel(0, regs + VIDOSD_B(win, sfb->variant));
 	writel(0, regs + VIDOSD_C(win, sfb->variant));
-	reg = readl(regs + SHADOWCON);
-	writel(reg & ~SHADOWCON_WINx_PROTECT(win), regs + SHADOWCON);
+
+	if (sfb->variant.has_shadowcon) {
+		reg = readl(sfb->regs + SHADOWCON);
+		reg &= ~(SHADOWCON_WINx_PROTECT(win) |
+			SHADOWCON_CHx_ENABLE(win) |
+			SHADOWCON_CHx_LOCAL_ENABLE(win));
+		writel(reg, sfb->regs + SHADOWCON);
+	}
 }
 
 static int __devinit s3c_fb_probe(struct platform_device *pdev)
-- 
1.7.1


