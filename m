From: Prabhakar Lad <prabhakar.csengg@gmail.com>
Date: Wed, 24 Apr 2013 12:12:08 +0000
Subject: [PATCH 6/6] ARM: davinci: dm644x: enable fbdev driver
Message-Id: <1366804808-22720-7-git-send-email-prabhakar.csengg@gmail.com>
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
 arch/arm/mach-davinci/dm644x.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index c2a9273..a4fee07 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -745,6 +745,15 @@ static struct platform_device dm644x_vpbe_display = {
 	},
 };
 
+static struct platform_device dm644x_davincifb = {
+	.name           = "davinci-vpbe-fb",
+	.id             = -1,
+	.dev            = {
+		.dma_mask		= &dm644x_video_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+};
+
 static struct venc_platform_data dm644x_venc_pdata = {
 	.setup_clock	= dm644x_venc_setup_clock,
 };
@@ -909,6 +918,7 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 		platform_device_register(&dm644x_venc_dev);
 		platform_device_register(&dm644x_vpbe_dev);
 		platform_device_register(&dm644x_vpbe_display);
+		platform_device_register(&dm644x_davincifb);
 	}
 
 	return 0;
-- 
1.7.4.1

