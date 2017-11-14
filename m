From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 14 Nov 2017 06:12:28 +0000
Subject: [PATCH] OMAPFB: prevent buffer underflow in omapfb_parse_vram_param()
Message-Id: <20171114061228.iv5irewl6ougl4zm@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, kernel-janitors@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

We cap the upper bound of "fbnum" but we also need to check for
negatives or make the type unsigned.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
index 1d7c012f09db..e08e5664e330 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-main.c
@@ -1477,7 +1477,7 @@ static int omapfb_alloc_fbmem_display(struct fb_info *fbi, unsigned long size,
 static int omapfb_parse_vram_param(const char *param, int max_entries,
 		unsigned long *sizes, unsigned long *paddrs)
 {
-	int fbnum;
+	unsigned int fbnum;
 	unsigned long size;
 	unsigned long paddr = 0;
 	char *p, *start;
