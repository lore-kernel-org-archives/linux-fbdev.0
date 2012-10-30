From: Pantelis Antoniou <panto@antoniou-consulting.com>
Date: Tue, 30 Oct 2012 18:19:29 +0000
Subject: [PATCH] da8xx: Add standard panel definition
Message-Id: <1351698994-4091-1-git-send-email-panto@antoniou-consulting.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Pantelis Antoniou <panto@antoniou-consulting.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Koen Kooi <koen@dominion.thruhere.net>, Matt Porter <mporter@ti.com>, Russ Dill <Russ.Dill@ti.com>, linux-omap@vger.kernel.org

Add standard panel definition that can work for the beaglebone
DVI cape.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 drivers/video/da8xx-fb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 866d804..4462d9e 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -270,6 +270,20 @@ static struct da8xx_panel known_lcd_panels[] = {
 		.pxl_clk = 7833600,
 		.invert_pxl_clk = 0,
 	},
+	[3] = {
+		 /* 1024 x 768 @ 60 Hz  Reduced blanking VESA CVT 0.79M3-R */
+		.name = "1024x768@60",
+		.width = 1024,
+		.height = 768,
+		.hfp = 48,
+		.hbp = 80,
+		.hsw = 32,
+		.vfp = 3,
+		.vbp = 15,
+		.vsw = 4,
+		.pxl_clk = 56000000,
+		.invert_pxl_clk = 0,
+	},
 };
 
 /* Enable the Raster Engine of the LCD Controller */
-- 
1.7.12

