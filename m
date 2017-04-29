From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Sat, 29 Apr 2017 19:33:39 +0000
Subject: [PATCH] m501fb: don't return zero on failure path in sm501fb_start()
Message-Id: <1493494419-3917-1-git-send-email-khoroshilov@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

If fbmem iomemory mapping failed, sm501fb_start() breaks off
initialization, deallocates resources, but returns zero.
As a result, double deallocation can happen in sm501fb_stop().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/video/fbdev/sm501fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index d80bc8a3200f..67e314fdd947 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1600,6 +1600,7 @@ static int sm501fb_start(struct sm501fb_info *info,
 	info->fbmem = ioremap(res->start, resource_size(res));
 	if (info->fbmem = NULL) {
 		dev_err(dev, "cannot remap framebuffer\n");
+		ret = -ENXIO;
 		goto err_mem_res;
 	}
 
-- 
2.7.4

