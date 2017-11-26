From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 20:43:52 +0000
Subject: [PATCH 2/2] video: fbdev-MMP: Improve a size determination in path_init()
Message-Id: <293fb9cb-3020-bded-b1bd-67bbb2820aa2@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <e2c5fe9e-8e01-7fef-a243-ff5d063787b0@users.sourceforge.net>
In-Reply-To: <e2c5fe9e-8e01-7fef-a243-ff5d063787b0@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 21:21:33 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index 9f912ea0bfce..fcdbb2df137f 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -406,7 +406,7 @@ static int path_init(struct mmphw_path_plat *path_plat,
 	dev_info(ctrl->dev, "%s: %s\n", __func__, config->name);
 
 	/* init driver data */
-	path_info = kzalloc(sizeof(struct mmp_path_info), GFP_KERNEL);
+	path_info = kzalloc(sizeof(*path_info), GFP_KERNEL);
 	if (!path_info)
 		return 0;
 
-- 
2.15.0

