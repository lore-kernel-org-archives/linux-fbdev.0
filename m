From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 25 Feb 2015 13:25:20 +0000
Subject: [patch] fbdev: pm3fb: cleanup some confusing indenting
Message-Id: <20150225132520.GM19745@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This if statement should be pushed out one tab to line up with the rest.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/pm3fb.c b/drivers/video/fbdev/pm3fb.c
index 4bf3273..77b99ed 100644
--- a/drivers/video/fbdev/pm3fb.c
+++ b/drivers/video/fbdev/pm3fb.c
@@ -1479,9 +1479,9 @@ static void pm3fb_remove(struct pci_dev *dev)
 		fb_dealloc_cmap(&info->cmap);
 
 #ifdef CONFIG_MTRR
-	if (par->mtrr_handle >= 0)
-		mtrr_del(par->mtrr_handle, info->fix.smem_start,
-			 info->fix.smem_len);
+		if (par->mtrr_handle >= 0)
+			mtrr_del(par->mtrr_handle, info->fix.smem_start,
+				 info->fix.smem_len);
 #endif /* CONFIG_MTRR */
 		iounmap(info->screen_base);
 		release_mem_region(fix->smem_start, fix->smem_len);
