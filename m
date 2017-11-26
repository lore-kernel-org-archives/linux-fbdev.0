From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 10:22:07 +0000
Subject: [PATCH 4/4] video: sm501fb: Adjust 15 checks for null pointers
Message-Id: <f3586631-ca60-61af-151e-41b4584daba0@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <efb981db-e9a0-d6f7-00d4-c76e1162770c@users.sourceforge.net>
In-Reply-To: <efb981db-e9a0-d6f7-00d4-c76e1162770c@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bhumika Goyal <bhumirks@gmail.com>, Colin Ian King <colin.king@canonical.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 26 Nov 2017 10:56:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written !…

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/sm501fb.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index f38e3773ccc0..313acc83bb71 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1484,7 +1484,7 @@ static int sm501_init_cursor(struct fb_info *fbi, unsigned int reg_base)
 	struct sm501fb_info *info;
 	int ret;
 
-	if (fbi = NULL)
+	if (!fbi)
 		return 0;
 
 	par = fbi->par;
@@ -1532,7 +1532,7 @@ static int sm501fb_start(struct sm501fb_info *info,
 	/* allocate, reserve and remap resources for display
 	 * controller registers */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res = NULL) {
+	if (!res) {
 		dev_err(dev, "no resource definition for registers\n");
 		ret = -ENOENT;
 		goto err_release;
@@ -1541,15 +1541,14 @@ static int sm501fb_start(struct sm501fb_info *info,
 	info->regs_res = request_mem_region(res->start,
 					    resource_size(res),
 					    pdev->name);
-
-	if (info->regs_res = NULL) {
+	if (!info->regs_res) {
 		dev_err(dev, "cannot claim registers\n");
 		ret = -ENXIO;
 		goto err_release;
 	}
 
 	info->regs = ioremap(res->start, resource_size(res));
-	if (info->regs = NULL) {
+	if (!info->regs) {
 		dev_err(dev, "cannot remap registers\n");
 		ret = -ENXIO;
 		goto err_regs_res;
@@ -1558,7 +1557,7 @@ static int sm501fb_start(struct sm501fb_info *info,
 	/* allocate, reserve and remap resources for 2d
 	 * controller registers */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (res = NULL) {
+	if (!res) {
 		dev_err(dev, "no resource definition for 2d registers\n");
 		ret = -ENOENT;
 		goto err_regs_map;
@@ -1567,15 +1566,14 @@ static int sm501fb_start(struct sm501fb_info *info,
 	info->regs2d_res = request_mem_region(res->start,
 					      resource_size(res),
 					      pdev->name);
-
-	if (info->regs2d_res = NULL) {
+	if (!info->regs2d_res) {
 		dev_err(dev, "cannot claim registers\n");
 		ret = -ENXIO;
 		goto err_regs_map;
 	}
 
 	info->regs2d = ioremap(res->start, resource_size(res));
-	if (info->regs2d = NULL) {
+	if (!info->regs2d) {
 		dev_err(dev, "cannot remap registers\n");
 		ret = -ENXIO;
 		goto err_regs2d_res;
@@ -1583,7 +1581,7 @@ static int sm501fb_start(struct sm501fb_info *info,
 
 	/* allocate, reserve resources for framebuffer */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
-	if (res = NULL) {
+	if (!res) {
 		dev_err(dev, "no memory resource defined\n");
 		ret = -ENXIO;
 		goto err_regs2d_map;
@@ -1592,14 +1590,14 @@ static int sm501fb_start(struct sm501fb_info *info,
 	info->fbmem_res = request_mem_region(res->start,
 					     resource_size(res),
 					     pdev->name);
-	if (info->fbmem_res = NULL) {
+	if (!info->fbmem_res) {
 		dev_err(dev, "cannot claim framebuffer\n");
 		ret = -ENXIO;
 		goto err_regs2d_map;
 	}
 
 	info->fbmem = ioremap(res->start, resource_size(res));
-	if (info->fbmem = NULL) {
+	if (!info->fbmem) {
 		dev_err(dev, "cannot remap framebuffer\n");
 		ret = -ENXIO;
 		goto err_mem_res;
@@ -1862,13 +1860,13 @@ static int sm501fb_probe_one(struct sm501fb_info *info,
 	pd = (head = HEAD_CRT) ? info->pdata->fb_crt : info->pdata->fb_pnl;
 
 	/* Do not initialise if we've not been given any platform data */
-	if (pd = NULL) {
+	if (!pd) {
 		dev_info(info->dev, "no data for fb %s (disabled)\n", name);
 		return 0;
 	}
 
 	fbi = framebuffer_alloc(sizeof(struct sm501fb_par), info->dev);
-	if (fbi = NULL) {
+	if (!fbi) {
 		dev_err(info->dev, "cannot allocate %s framebuffer\n", name);
 		return -ENOMEM;
 	}
@@ -1944,7 +1942,7 @@ static int sm501fb_probe(struct platform_device *pdev)
 		info->pdata = pd->fb;
 	}
 
-	if (info->pdata = NULL) {
+	if (!info->pdata) {
 		int found = 0;
 #if defined(CONFIG_OF)
 		struct device_node *np = pdev->dev.parent->of_node;
@@ -1987,8 +1985,7 @@ static int sm501fb_probe(struct platform_device *pdev)
 		goto err_probed_crt;
 	}
 
-	if (info->fb[HEAD_PANEL] = NULL &&
-	    info->fb[HEAD_CRT] = NULL) {
+	if (!info->fb[HEAD_PANEL] && !info->fb[HEAD_CRT]) {
 		dev_err(dev, "no framebuffers found\n");
 		ret = -ENODEV;
 		goto err_alloc;
-- 
2.15.0

