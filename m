From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Wed, 24 Apr 2013 12:12:07 +0000
Subject: [PATCH 5/6] ARM: davinci: dm365: enable fbdev driver
Message-Id: <1366804808-22720-6-git-send-email-prabhakar.csengg@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1366804808-22720-1-git-send-email-prabhakar.csengg@gmail.com>
In-Reply-To: <1366804808-22720-1-git-send-email-prabhakar.csengg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Lad, Prabhakar <prabhakar.csengg@gmail.com>

This patch enables fbdev driver by creating fbdev device and register it.

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/mach-davinci/dm365.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index ff771ce..b06623c 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1349,6 +1349,15 @@ static struct platform_device dm365_vpbe_display = {
 	},
 };
 
+static struct platform_device dm365_davincifb = {
+	.name           = "davinci-vpbe-fb",
+	.id             = -1,
+	.dev            = {
+		.dma_mask		= &dm365_video_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
 struct venc_platform_data dm365_venc_pdata = {
 	.setup_pinmux	= dm365_vpbe_setup_pinmux,
 	.setup_clock	= dm365_venc_setup_clock,
@@ -1392,6 +1401,7 @@ int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
 		platform_device_register(&dm365_venc_dev);
 		platform_device_register(&dm365_vpbe_dev);
 		platform_device_register(&dm365_vpbe_display);
+		platform_device_register(&dm365_davincifb);
 	}
 
 	return 0;
-- 
1.7.4.1

