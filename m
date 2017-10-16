From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 16 Oct 2017 19:04:47 +0000
Subject: [PATCH 1/8] video: fbdev: au1200fb: Fix a potential double free
Message-Id: <73dc8ec4bf94cb2f81ee264225ba0f509c96bebd.1508179264.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

If 'fb_alloc_cmap()' fails, 'fbi->pseudo_palette' is freed and an error
code is returned by 'au1200fb_init_fbinfo()'.
The only caller, 'au1200fb_drv_probe()' goes to an error handling path
where resources allocated in 'fb_alloc_cmap()' are freed.
This leads to a double free of 'fbi->pseudo_palette'.

Fix it by letting the caller free all resources in case of failure in
'au1200fb_init_fbinfo()'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/au1200fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index 5f04b4096c42..a5facc2ad90b 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1553,7 +1553,6 @@ static int au1200fb_init_fbinfo(struct au1200fb_device *fbdev)
 	if (fb_alloc_cmap(&fbi->cmap, AU1200_LCD_NBR_PALETTE_ENTRIES, 0) < 0) {
 		print_err("Fail to allocate colormap (%d entries)",
 			   AU1200_LCD_NBR_PALETTE_ENTRIES);
-		kfree(fbi->pseudo_palette);
 		return -EFAULT;
 	}
 
-- 
2.11.0

