From: Timur Tabi <timur@freescale.com>
Date: Thu, 15 Sep 2011 21:44:49 +0000
Subject: [PATCH 04/13] drivers/video: fsl-diu-fb: fix compilation warning
Message-Id: <1316123098-30967-5-git-send-email-timur@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fix this compilation warning in the Freescale DIU framebuffer driver:

warning: 'dummy_ad_addr' may be used uninitialized in this function

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/video/fsl-diu-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fsl-diu-fb.c b/drivers/video/fsl-diu-fb.c
index 226f4bc..6c544cf 100644
--- a/drivers/video/fsl-diu-fb.c
+++ b/drivers/video/fsl-diu-fb.c
@@ -1429,7 +1429,7 @@ static int __devinit fsl_diu_probe(struct platform_device *ofdev)
 {
 	struct device_node *np = ofdev->dev.of_node;
 	struct mfb_info *mfbi;
-	phys_addr_t dummy_ad_addr;
+	phys_addr_t dummy_ad_addr = 0;
 	int ret, i, error = 0;
 	struct resource res;
 	struct fsl_diu_data *machine_data;
-- 
1.7.3.4


