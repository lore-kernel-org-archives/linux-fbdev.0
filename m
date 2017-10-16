From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Mon, 16 Oct 2017 19:04:50 +0000
Subject: [PATCH 4/8] video: fbdev: au1200fb: Fix error handling path
Message-Id: <1adea6270ddbf00b84b82b7dfe1301e61a319522.1508179264.git.christophe.jaillet@wanadoo.fr>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1508179264.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: b.zolnierkie@samsung.com, tj@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'au1200fb_drv_probe()' can not fail after a succesful call to
'request_irq()'. So there is no point to call 'free_irq()' in the error
handling path.

Moreover, the hard coded AU1200_LCD_INT looks boggus since commit
1630d85a8312 ("au1200fb: fix hardcoded IRQ")

So, remove it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/fbdev/au1200fb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/au1200fb.c b/drivers/video/fbdev/au1200fb.c
index cf54168d44dc..0d8ed0ef9183 100644
--- a/drivers/video/fbdev/au1200fb.c
+++ b/drivers/video/fbdev/au1200fb.c
@@ -1766,8 +1766,6 @@ static int au1200fb_drv_probe(struct platform_device *dev)
 			fb_dealloc_cmap(&fbi->cmap);
 		kfree(fbi->pseudo_palette);
 	}
-	if (plane = 0)
-		free_irq(AU1200_LCD_INT, (void*)dev);
 	return ret;
 }
 
-- 
2.11.0

