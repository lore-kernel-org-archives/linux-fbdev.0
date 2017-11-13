From: Johan Hovold <johan@kernel.org>
Date: Mon, 13 Nov 2017 10:27:19 +0000
Subject: [PATCH] video: fbdev: atmel_lcdfb: fix display-timings lookup
Message-Id: <20171113102719.9634-1-johan@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, stable <stable@vger.kernel.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent display node was also prematurely
freed.

Note that the display and timings node references are never put after a
successful dt-initialisation so the nodes would leak on later probe
deferrals and on driver unbind.

Fixes: b985172b328a ("video: atmel_lcdfb: add device tree suport")
Cc: stable <stable@vger.kernel.org>     # 3.13
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/video/fbdev/atmel_lcdfb.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index e06358da4b99..3dee267d7c75 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -1119,7 +1119,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 		goto put_display_node;
 	}
 
-	timings_np = of_find_node_by_name(display_np, "display-timings");
+	timings_np = of_get_child_by_name(display_np, "display-timings");
 	if (!timings_np) {
 		dev_err(dev, "failed to find display-timings node\n");
 		ret = -ENODEV;
@@ -1140,6 +1140,12 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 		fb_add_videomode(&fb_vm, &info->modelist);
 	}
 
+	/*
+	 * FIXME: Make sure we are not referencing any fields in display_np
+	 * and timings_np and drop our references to them before returning to
+	 * avoid leaking the nodes on probe deferral and driver unbind.
+	 */
+
 	return 0;
 
 put_timings_node:
-- 
2.15.0

