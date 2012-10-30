From: Pantelis Antoniou <panto@antoniou-consulting.com>
Date: Tue, 30 Oct 2012 18:17:45 +0000
Subject: [PATCH] da8xx-fb: add panel definition for beaglebone LCD7 cape
Message-Id: <1351698999-4133-1-git-send-email-panto@antoniou-consulting.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Koen Kooi <koen@dominion.thruhere.net>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org

From: Koen Kooi <koen@dominion.thruhere.net>

Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
---
 drivers/video/da8xx-fb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 4462d9e..c661665 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -284,6 +284,20 @@ static struct da8xx_panel known_lcd_panels[] = {
 		.pxl_clk = 56000000,
 		.invert_pxl_clk = 0,
 	},
+	/* ThreeFive S9700RTWV35TR */
+	[4] = {
+		.name = "TFC_S9700RTWV35TR_01B",
+		.width = 800,
+		.height = 480,
+		.hfp = 39,
+		.hbp = 39,
+		.hsw = 47,
+		.vfp = 13,
+		.vbp = 29,
+		.vsw = 2,
+		.pxl_clk = 30000000,
+		.invert_pxl_clk = 0,
+	},
 };
 
 /* Enable the Raster Engine of the LCD Controller */
-- 
1.7.12

