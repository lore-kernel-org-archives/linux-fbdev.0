From: Jingoo Han <jg1.han@samsung.com>
Date: Wed, 20 Jul 2011 22:54:04 +0000
Subject: [PATCH V8 1/5] ARM: EXYNOS4: Change clock name for FIMD
Message-Id: <1311202444-18137-1-git-send-email-jg1.han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kukjin Kim <kgene.kim@samsung.com>, Paul Mundt <lethal@linux-sh.org>, linux-samsung-soc@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Jonghun Han <jonghun.han@samsung.com>, Ben Dooks <ben-linux@fluff.org>, Jingoo Han <jg1.han@samsung.com>

This patch changes clock for FIMD from 'fimd' to 'lcd'.
Also, devname for FIMD is changed from 's5pv310-fb' to 'exynos4-fb'.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/mach-exynos4/clock.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index 98b5cc4..778a202 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -405,13 +405,13 @@ static struct clk init_clocks_off[] = {
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
-		.name		= "fimd",
-		.devname	= "s5pv310-fb.0",
+		.name		= "lcd",
+		.devname	= "exynos4-fb.0",
 		.enable		= exynos4_clk_ip_lcd0_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
-		.name		= "fimd",
-		.devname	= "s5pv310-fb.1",
+		.name		= "lcd",
+		.devname	= "exynos4-fb.1",
 		.enable		= exynos4_clk_ip_lcd1_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
@@ -909,7 +909,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_fimd",
-			.devname	= "s5pv310-fb.0",
+			.devname	= "exynos4-fb.0",
 			.enable		= exynos4_clksrc_mask_lcd0_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
@@ -919,7 +919,7 @@ static struct clksrc_clk clksrcs[] = {
 	}, {
 		.clk		= {
 			.name		= "sclk_fimd",
-			.devname	= "s5pv310-fb.1",
+			.devname	= "exynos4-fb.1",
 			.enable		= exynos4_clksrc_mask_lcd1_ctrl,
 			.ctrlbit	= (1 << 0),
 		},
-- 
1.7.1

