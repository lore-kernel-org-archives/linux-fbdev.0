From: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Sat, 04 Aug 2012 12:00:30 +0000
Subject: [PATCH 1/3] drivers/video/auo_k190x.c: drop kfree of devm_kzalloc's data
Message-Id: <1344081632-4729-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Using kfree to free data allocated with devm_kzalloc causes double frees.

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
expression x;
@@

x = devm_kzalloc(...)
...
?-kfree(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/video/auo_k190x.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/auo_k190x.c b/drivers/video/auo_k190x.c
index 77da6a2..c03ecdd 100644
--- a/drivers/video/auo_k190x.c
+++ b/drivers/video/auo_k190x.c
@@ -987,7 +987,6 @@ err_regfb:
 	fb_dealloc_cmap(&info->cmap);
 err_cmap:
 	fb_deferred_io_cleanup(info);
-	kfree(info->fbdefio);
 err_defio:
 	vfree((void *)info->screen_base);
 err_irq:
@@ -1022,7 +1021,6 @@ int  __devexit auok190x_common_remove(struct platform_device *pdev)
 	fb_dealloc_cmap(&info->cmap);
 
 	fb_deferred_io_cleanup(info);
-	kfree(info->fbdefio);
 
 	vfree((void *)info->screen_base);
 

