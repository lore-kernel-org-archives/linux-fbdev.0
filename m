From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 13 Jul 2018 14:55:55 +0000
Subject: [PATCH] fbdev: omapfb: off by one in omapfb_register_client()
Message-Id: <20180713145555.sprrr4rl6eqspirz@kili.mountain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Imre Deak <imre.deak@solidboot.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org

The omapfb_register_client[] array has OMAPFB_PLANE_NUM elements so the
> should be >= or we are one element beyond the end of the array.

Fixes: 8b08cf2b64f5 ("OMAP: add TI OMAP framebuffer driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index 585f39efcff6..1c75f4806ed3 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -958,7 +958,7 @@ int omapfb_register_client(struct omapfb_notifier_block *omapfb_nb,
 {
 	int r;
 
-	if ((unsigned)omapfb_nb->plane_idx > OMAPFB_PLANE_NUM)
+	if ((unsigned)omapfb_nb->plane_idx >= OMAPFB_PLANE_NUM)
 		return -EINVAL;
 
 	if (!notifier_inited) {
