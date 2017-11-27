From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 18:01:14 +0000
Subject: [PATCH 3/3] video: au1100fb: Delete an unnecessary variable initialisation in au1100fb_drv_probe()
Message-Id: <37b97970-6cd7-5c85-a613-8c558b8d4fa0@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
In-Reply-To: <980dc009-429b-ad88-966b-0e75808cbacc@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 27 Nov 2017 18:40:23 +0100

The local variable "fbdev" will be reassigned by a following statement.
Thus omit the explicit initialisation at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/au1100fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 1e5b872f0da6..7c9a672e9811 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -410,7 +410,7 @@ static int au1100fb_setup(struct au1100fb_device *fbdev)
 
 static int au1100fb_drv_probe(struct platform_device *dev)
 {
-	struct au1100fb_device *fbdev = NULL;
+	struct au1100fb_device *fbdev;
 	struct resource *regs_res;
 	unsigned long page;
 	struct clk *c;
-- 
2.15.0

