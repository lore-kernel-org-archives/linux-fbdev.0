From: Damien Cassou <damien.cassou@lifl.fr>
Date: Fri, 03 Aug 2012 15:40:12 +0000
Subject: [PATCH 2/5] drivers/video/bf54x-lq043fb.c: use devm_ functions
Message-Id: <1344008414-2894-4-git-send-email-damien.cassou@lifl.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344008414-2894-1-git-send-email-damien.cassou@lifl.fr>
In-Reply-To: <1344008414-2894-1-git-send-email-damien.cassou@lifl.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Damien Cassou <damien.cassou@lifl.fr>

The various devm_ functions allocate memory that is released when a driver
detaches. This patch replaces the use of kzalloc by devm_kzalloc.

Signed-off-by: Damien Cassou <damien.cassou@lifl.fr>

---
 drivers/video/bf54x-lq043fb.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index dc2f004..47702ee 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -601,7 +601,8 @@ static int __devinit bfin_bf54x_probe(struct platform_device *pdev)

 	fbinfo->fbops = &bfin_bf54x_fb_ops;

-	fbinfo->pseudo_palette = kzalloc(sizeof(u32) * 16, GFP_KERNEL);
+	fbinfo->pseudo_palette = devm_kzalloc(&pdev->dev, sizeof(u32) * 16,
+					      GFP_KERNEL);
 	if (!fbinfo->pseudo_palette) {
 		printk(KERN_ERR DRIVER_NAME
 		       "Fail to allocate pseudo_palette\n");
@@ -616,7 +617,7 @@ static int __devinit bfin_bf54x_probe(struct platform_device *pdev)
 		       "Fail to allocate colormap (%d entries)\n",
 		       BFIN_LCD_NBR_PALETTE_ENTRIES);
 		ret = -EFAULT;
-		goto out5;
+		goto out4;
 	}

 	if (request_ports(info)) {
@@ -671,8 +672,6 @@ out7:
 	free_ports(info);
 out6:
 	fb_dealloc_cmap(&fbinfo->cmap);
-out5:
-	kfree(fbinfo->pseudo_palette);
 out4:
 	dma_free_coherent(NULL, fbinfo->fix.smem_len, info->fb_buffer,
 			  info->dma_handle);
@@ -699,7 +698,6 @@ static int __devexit bfin_bf54x_remove(struct platform_device *pdev)
 		dma_free_coherent(NULL, fbinfo->fix.smem_len, info->fb_buffer,
 				  info->dma_handle);

-	kfree(fbinfo->pseudo_palette);
 	fb_dealloc_cmap(&fbinfo->cmap);

 #ifndef NO_BL_SUPPORT
