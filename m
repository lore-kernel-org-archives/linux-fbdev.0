From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 25 Jan 2016 15:03:01 +0000
Subject: [PATCH] fbdev: mmp: print IRQ resource using %pR format string
Message-Id: <1453734191-1958245-1-git-send-email-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

resource_size_t cannot be printed using the %x format string
when we it is defined as u64:

drivers/video/fbdev/mmp/hw/mmp_ctrl.c: In function 'mmphw_probe':
drivers/video/fbdev/mmp/hw/mmp_ctrl.c:506:22: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]
   dev_err(ctrl->dev, "%s: res %x - %x map failed\n", __func__,
                      ^
drivers/video/fbdev/mmp/hw/mmp_ctrl.c:506:22: error: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t {aka long long unsigned int}' [-Werror=format=]

This changes the format string to %pR, which is interpreted
by the printk implementation to pretty-print a resource
structure.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
index de54a4748065..b6f83d5df9fd 100644
--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -503,8 +503,7 @@ static int mmphw_probe(struct platform_device *pdev)
 	ctrl->reg_base = devm_ioremap_nocache(ctrl->dev,
 			res->start, resource_size(res));
 	if (ctrl->reg_base = NULL) {
-		dev_err(ctrl->dev, "%s: res %x - %x map failed\n", __func__,
-			res->start, res->end);
+		dev_err(ctrl->dev, "%s: res %pR map failed\n", __func__, res);
 		ret = -ENOMEM;
 		goto failed;
 	}
-- 
2.7.0

