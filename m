From: Pawel Osciak <p.osciak@samsung.com>
Date: Fri, 09 Jul 2010 08:50:05 +0000
Subject: [PATCH 17/19] s3c-fb: Protect window-specific registers during updates
Message-Id: <1278665407-18002-18-git-send-email-p.osciak@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
In-Reply-To: <1278665407-18002-1-git-send-email-p.osciak@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Newer hardware (S3C6410, S5P) have the ability to block updates from shadow
registers during reconfiguration. Add protect calls for set_par and clear
protection when resetting.

Signed-off-by: Pawel Osciak <p.osciak@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/video/s3c-fb.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 2173869..b10d16d 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -450,6 +450,8 @@ static int s3c_fb_set_par(struct fb_info *info)
 
 	dev_dbg(sfb->dev, "setting framebuffer parameters\n");
 
+	shadow_protect_win(win, 1);
+
 	switch (var->bits_per_pixel) {
 	case 32:
 	case 24:
@@ -632,6 +634,8 @@ static int s3c_fb_set_par(struct fb_info *info)
 	writel(data, regs + sfb->variant.wincon + (win_no * 4));
 	writel(0x0, regs + sfb->variant.winmap + (win_no * 4));
 
+	shadow_protect_win(win, 0);
+
 	return 0;
 }
 
@@ -1228,11 +1232,14 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 static void s3c_fb_clear_win(struct s3c_fb *sfb, int win)
 {
 	void __iomem *regs = sfb->regs;
+	u32 reg;
 
 	writel(0, regs + sfb->variant.wincon + (win * 4));
 	writel(0, regs + VIDOSD_A(win, sfb->variant));
 	writel(0, regs + VIDOSD_B(win, sfb->variant));
 	writel(0, regs + VIDOSD_C(win, sfb->variant));
+	reg = readl(regs + SHADOWCON);
+	writel(reg & ~SHADOWCON_WINx_PROTECT(win), regs + SHADOWCON);
 }
 
 static int __devinit s3c_fb_probe(struct platform_device *pdev)
-- 
1.7.1.569.g6f426

