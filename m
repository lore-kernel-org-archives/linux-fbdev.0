From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] fbdev: bfin-t350mcqb-fb: handle all resources in suspend/resume
Date: Mon, 14 Sep 2009 13:49:08 -0400
Message-ID: <1252950549-9838-2-git-send-email-vapier@gentoo.org>
References: <1252950549-9838-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755222AbZINRte@vger.kernel.org>
In-Reply-To: <1252950549-9838-1-git-send-email-vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

The LCD commands DMA/timers as well as PPI which we need to save/restore.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/video/bfin-t350mcqb-fb.c |   28 +++++++++++++++++++++++-----
 1 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb-fb.c
index 5cc36cf..46cb07f 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -634,17 +634,35 @@ static int __devexit bfin_t350mcqb_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM
 static int bfin_t350mcqb_suspend(struct platform_device *pdev, pm_message_t state)
 {
-	bfin_t350mcqb_disable_ppi();
-	disable_dma(CH_PPI);
-	bfin_write_PPI_STATUS(0xFFFF);
+	struct fb_info *fbinfo = platform_get_drvdata(pdev);
+	struct bfin_t350mcqbfb_info *fbi = fbinfo->par;
+
+	if (fbi->lq043_open_cnt) {
+		bfin_t350mcqb_disable_ppi();
+		disable_dma(CH_PPI);
+		bfin_t350mcqb_stop_timers();
+		bfin_write_PPI_STATUS(-1);
+	}
+
 
 	return 0;
 }
 
 static int bfin_t350mcqb_resume(struct platform_device *pdev)
 {
-	enable_dma(CH_PPI);
-	bfin_t350mcqb_enable_ppi();
+	struct fb_info *fbinfo = platform_get_drvdata(pdev);
+	struct bfin_t350mcqbfb_info *fbi = fbinfo->par;
+
+	if (fbi->lq043_open_cnt) {
+		bfin_t350mcqb_config_dma(fbi);
+		bfin_t350mcqb_config_ppi(fbi);
+		bfin_t350mcqb_init_timers();
+
+		/* start dma */
+		enable_dma(CH_PPI);
+		bfin_t350mcqb_enable_ppi();
+		bfin_t350mcqb_start_timers();
+	}
 
 	return 0;
 }
-- 
1.6.4.2
