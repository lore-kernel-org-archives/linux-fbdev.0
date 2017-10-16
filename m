From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 16 Oct 2017 19:04:54 +0000
Subject: [PATCH 8/8] video: fbdev: au1200fb: Style clean up
Message-Id: <b794f519c83f40d08795b9745aeb311cfe649780.1508179264.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Style clean-up.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/au1200fb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 687ea2a8f810..87d5a62bf6ca 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1546,14 +1546,13 @@ static int au1200fb_init_fbinfo(struct au1200fb_device *fbdev)
 	}
 
 	fbi->pseudo_palette = kcalloc(16, sizeof(u32), GFP_KERNEL);
-	if (!fbi->pseudo_palette) {
+	if (!fbi->pseudo_palette)
 		return -ENOMEM;
-	}
 
 	ret = fb_alloc_cmap(&fbi->cmap, AU1200_LCD_NBR_PALETTE_ENTRIES, 0);
 	if (ret < 0) {
 		print_err("Fail to allocate colormap (%d entries)",
-			   AU1200_LCD_NBR_PALETTE_ENTRIES);
+			  AU1200_LCD_NBR_PALETTE_ENTRIES);
 		return ret;
 	}
 
@@ -1717,7 +1716,8 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 		print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);
 
 		/* Init FB data */
-		if ((ret = au1200fb_init_fbinfo(fbdev)) < 0)
+		ret = au1200fb_init_fbinfo(fbdev);
+		if (ret < 0)
 			goto failed;
 
 		/* Register new framebuffer */
-- 
2.11.0

