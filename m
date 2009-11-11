From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] video: Fix error return
Date: Wed, 11 Nov 2009 23:21:18 +0100
Message-ID: <4AFB38DE.6040408@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759491AbZKKWJQ@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: sudhakar.raj@ti.com, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>

The return should be negative on errors

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 drivers/video/da8xx-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index d065894..035d568 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -704,7 +704,7 @@ static int __init fb_probe(struct platform_device *device)
 
 	if (i == ARRAY_SIZE(known_lcd_panels)) {
 		dev_err(&device->dev, "GLCD: No valid panel found\n");
-		ret = ENODEV;
+		ret = -ENODEV;
 		goto err_clk_disable;
 	} else
 		dev_info(&device->dev, "GLCD: Found %s panel\n",
