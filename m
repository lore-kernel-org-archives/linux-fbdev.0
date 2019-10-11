From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Fri, 11 Oct 2019 11:24:41 +0000
Subject: [PATCH] staging: fbtft: fbtft-core: Fix last line displayed on fbcon
Message-Id: <20191011112441.31003-1-alexandru.ardelean@analog.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc: nishadkamdar@gmail.com, Michael Hennerich <michael.hennerich@analog.com>, gregkh@linuxfoundation.org, bhanusreemahesh@gmail.com, daniel.vetter@ffwll.ch, Alexandru Ardelean <alexandru.ardelean@analog.com>, preid@electromag.com.au

From: Michael Hennerich <michael.hennerich@analog.com>

For the special case when fbtft_mkdirty() is called with with -1 for the y
coordinate, the height is truncated by 1.

This isn't required, and causes the last line to not update.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/fbtft/fbtft-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index cf5700a2ea66..90eec45d11fc 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -317,7 +317,7 @@ static void fbtft_mkdirty(struct fb_info *info, int y, int height)
 	/* special case, needed ? */
 	if (y = -1) {
 		y = 0;
-		height = info->var.yres - 1;
+		height = info->var.yres;
 	}
 
 	/* Mark display lines/area as dirty */
-- 
2.20.1
