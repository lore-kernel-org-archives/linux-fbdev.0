From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 16 Oct 2017 19:04:53 +0000
Subject: [PATCH 7/8] video: fbdev: au1200fb: Propagate an error code
Message-Id: <8d0ecf56237b27dc4d19bd4eb78d87231a7df86a.1508179264.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

We should propagate the error code returned by 'fb_alloc_cmap()' instead
of returning -EFAULT.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/au1200fb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 970ce761ff89..687ea2a8f810 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1518,7 +1518,7 @@ static irqreturn_t au1200fb_handle_irq(int irq, void* dev_id)
 static int au1200fb_init_fbinfo(struct au1200fb_device *fbdev)
 {
 	struct fb_info *fbi = fbdev->fb_info;
-	int bpp;
+	int bpp, ret;
 
 	fbi->fbops = &au1200fb_fb_ops;
 
@@ -1550,10 +1550,11 @@ static int au1200fb_init_fbinfo(struct au1200fb_device *fbdev)
 		return -ENOMEM;
 	}
 
-	if (fb_alloc_cmap(&fbi->cmap, AU1200_LCD_NBR_PALETTE_ENTRIES, 0) < 0) {
+	ret = fb_alloc_cmap(&fbi->cmap, AU1200_LCD_NBR_PALETTE_ENTRIES, 0);
+	if (ret < 0) {
 		print_err("Fail to allocate colormap (%d entries)",
 			   AU1200_LCD_NBR_PALETTE_ENTRIES);
-		return -EFAULT;
+		return ret;
 	}
 
 	strncpy(fbi->fix.id, "AU1200", sizeof(fbi->fix.id));
-- 
2.11.0

