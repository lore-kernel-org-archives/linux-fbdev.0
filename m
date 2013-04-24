From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Wed, 24 Apr 2013 12:12:06 +0000
Subject: [PATCH 4/6] ARM: davinci: dm355: enable fbdev driver
Message-Id: <1366804808-22720-5-git-send-email-prabhakar.csengg@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366804808-22720-1-git-send-email-prabhakar.csengg@gmail.com>
In-Reply-To: <1366804808-22720-1-git-send-email-prabhakar.csengg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Lad, Prabhakar <prabhakar.csengg@gmail.com>

This patch enables fbdev driver by creating fbdev device and register it.
Alongside renames 'vpfe_capture_dma_mask' to 'dm355_video_dma_mask' for better
clarity since it was reused by capture and diplay aswell.

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/mach-davinci/dm355.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index bf9a9d4..fe50814 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -714,7 +714,7 @@ static struct resource vpfe_resources[] = {
 	},
 };
 
-static u64 vpfe_capture_dma_mask = DMA_BIT_MASK(32);
+static u64 dm355_video_dma_mask = DMA_BIT_MASK(32);
 static struct resource dm355_ccdc_resource[] = {
 	/* CCDC Base address */
 	{
@@ -729,7 +729,7 @@ static struct platform_device dm355_ccdc_dev = {
 	.num_resources  = ARRAY_SIZE(dm355_ccdc_resource),
 	.resource       = dm355_ccdc_resource,
 	.dev = {
-		.dma_mask               = &vpfe_capture_dma_mask,
+		.dma_mask               = &dm355_video_dma_mask,
 		.coherent_dma_mask      = DMA_BIT_MASK(32),
 		.platform_data		= dm355_ccdc_setup_pinmux,
 	},
@@ -741,7 +741,7 @@ static struct platform_device vpfe_capture_dev = {
 	.num_resources	= ARRAY_SIZE(vpfe_resources),
 	.resource	= vpfe_resources,
 	.dev = {
-		.dma_mask		= &vpfe_capture_dma_mask,
+		.dma_mask		= &dm355_video_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
@@ -760,7 +760,7 @@ static struct platform_device dm355_osd_dev = {
 	.num_resources	= ARRAY_SIZE(dm355_osd_resources),
 	.resource	= dm355_osd_resources,
 	.dev		= {
-		.dma_mask		= &vpfe_capture_dma_mask,
+		.dma_mask		= &dm355_video_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
@@ -855,7 +855,16 @@ static struct platform_device dm355_vpbe_display = {
 	.num_resources	= ARRAY_SIZE(dm355_v4l2_disp_resources),
 	.resource	= dm355_v4l2_disp_resources,
 	.dev		= {
-		.dma_mask		= &vpfe_capture_dma_mask,
+		.dma_mask		= &dm355_video_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
+static struct platform_device dm355_davincifb = {
+	.name		= "davinci-vpbe-fb",
+	.id		= -1,
+	.dev		= {
+		.dma_mask		= &dm355_video_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
@@ -871,7 +880,7 @@ static struct platform_device dm355_venc_dev = {
 	.num_resources	= ARRAY_SIZE(dm355_venc_resources),
 	.resource	= dm355_venc_resources,
 	.dev		= {
-		.dma_mask		= &vpfe_capture_dma_mask,
+		.dma_mask		= &dm355_video_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data		= (void *)&dm355_venc_pdata,
 	},
@@ -881,7 +890,7 @@ static struct platform_device dm355_vpbe_dev = {
 	.name		= "vpbe_controller",
 	.id		= -1,
 	.dev		= {
-		.dma_mask		= &vpfe_capture_dma_mask,
+		.dma_mask		= &dm355_video_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
 	},
 };
@@ -1023,6 +1032,7 @@ int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
 		platform_device_register(&dm355_venc_dev);
 		platform_device_register(&dm355_vpbe_dev);
 		platform_device_register(&dm355_vpbe_display);
+		platform_device_register(&dm355_davincifb);
 	}
 
 	return 0;
-- 
1.7.4.1

