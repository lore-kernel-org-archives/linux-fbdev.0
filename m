From: Rob Herring <robh@kernel.org>
Date: Wed, 05 Sep 2018 19:37:38 +0000
Subject: [PATCH 21/21] fbdev: fsl-diu: get cpu node with of_get_cpu_node
Message-Id: <20180905193738.19325-22-robh@kernel.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Timur Tabi <timur@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

"device_type" use is deprecated for FDT though it has continued to be used
for nodes like cpu nodes. Use of_get_cpu_node() instead which works using
node names by default. This will allow the eventually removal of cpu
device_type properties.

Cc: Timur Tabi <timur@kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 drivers/video/fbdev/fsl-diu-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index bc9eb8afc313..332a56b6811f 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1925,7 +1925,7 @@ static int __init fsl_diu_init(void)
 	pr_info("Freescale Display Interface Unit (DIU) framebuffer driver\n");

 #ifdef CONFIG_NOT_COHERENT_CACHE
-	np = of_find_node_by_type(NULL, "cpu");
+	np = of_get_cpu_node(0, NULL);
 	if (!np) {
 		pr_err("fsl-diu-fb: can't find 'cpu' device node\n");
 		return -ENODEV;
--
2.17.1
