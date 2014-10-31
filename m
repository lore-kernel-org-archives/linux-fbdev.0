From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Fri, 31 Oct 2014 22:40:47 +0000
Subject: [PATCH] m501fb: don't return zero on failure path in sm501fb_probe()
Message-Id: <1414795247-14686-1-git-send-email-khoroshilov@ispras.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

If no framebuffers found, sm501fb_probe() breaks off initialization,
deallocates sm501fb_info, but returns zero. As a result, use after free
can happen in sm501fb_remove().

The patch adds -ENODEV as a return value in this case.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/video/fbdev/sm501fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 9e74e8fbe074..8b98b011fc04 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1988,6 +1988,7 @@ static int sm501fb_probe(struct platform_device *pdev)
 	if (info->fb[HEAD_PANEL] = NULL &&
 	    info->fb[HEAD_CRT] = NULL) {
 		dev_err(dev, "no framebuffers found\n");
+		ret = -ENODEV;
 		goto err_alloc;
 	}
 
-- 
1.9.1

