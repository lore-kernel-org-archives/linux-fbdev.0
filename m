From: Wan ZongShun <mcuos.com@gmail.com>
Subject: [PATCH] NUC900/lcd: patch to fix nuc900 lcd build error
Date: Thu, 24 Jun 2010 13:30:39 +0800
Message-ID: <4C22ED7F.8050706@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Qiang Wang <rurality.wq@gmail.com>, linux-fbdev-devel@lists.sourceforge.net

Hi Andrew,

This patch is to fix nuc900 lcd build error.
Since the 'nuc900_driver_clksrc_div()' API can not be
merged into mainline successfully, so I remove this clock
source selection hook in this driver. That means nuc900
lcd driver has to select default clock source from external
crystal now.

Thanks!

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
---
 drivers/video/nuc900fb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/video/nuc900fb.c b/drivers/video/nuc900fb.c
index d4cde79..81687ed 100644
--- a/drivers/video/nuc900fb.c
+++ b/drivers/video/nuc900fb.c
@@ -596,8 +596,6 @@ static int __devinit nuc900fb_probe(struct platform_device *pdev)
 		goto release_regs;
 	}

-	nuc900_driver_clksrc_div(&pdev->dev, "ext", 0x2);
-
 	fbi->clk = clk_get(&pdev->dev, NULL);
 	if (!fbi->clk || IS_ERR(fbi->clk)) {
 		printk(KERN_ERR "nuc900-lcd:failed to get lcd clock source\n");
-- 
1.6.3.3
