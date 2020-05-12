From: Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
Date: Tue, 12 May 2020 20:52:47 +0000
Subject: [PATCH 1/3] video: fbdev: ssd1307fb: Added support to Column offset
Message-Id: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com, alencar.fmce@imbel.gov.br, Rodrigo Alencar <455.rodrigo.alencar@gmail.com>

This patch provides support for displays like VGM128064B0W10,
which requires a column offset of 2, i.e., its segments starts
in SEG2 and ends in SEG129.

Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
---
 Documentation/devicetree/bindings/display/ssd1307fb.txt | 1 +
 drivers/video/fbdev/ssd1307fb.c                         | 8 ++++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
index 27333b9551b3..74a7b228bcef 100644
--- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
@@ -23,6 +23,7 @@ Optional properties:
   - solomon,com-lrremap: Display uses left-right COM pin remap
   - solomon,com-invdir: Display uses inverted COM pin scan direction
   - solomon,com-offset: Number of the COM pin wired to the first display line
+  - solomon,col-offset: Offset of columns (SEG) that the screen is mapped to.
   - solomon,prechargep1: Length of deselect period (phase 1) in clock cycles.
   - solomon,prechargep2: Length of precharge period (phase 2) in clock cycles.
                          This needs to be the higher, the higher the capacitance
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 12fa1050f3eb..ac88bbe174b6 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -77,6 +77,7 @@ struct ssd1307fb_par {
 	struct fb_info *info;
 	u8 lookup_table[4];
 	u32 page_offset;
+	u32 col_offset;
 	u32 prechargep1;
 	u32 prechargep2;
 	struct pwm_device *pwm;
@@ -468,11 +469,11 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, 0x0);
+	ret = ssd1307fb_write_cmd(par->client, par->col_offset);
 	if (ret < 0)
 		return ret;
 
-	ret = ssd1307fb_write_cmd(par->client, par->width - 1);
+	ret = ssd1307fb_write_cmd(par->client, par->col_offset + par->width - 1);
 	if (ret < 0)
 		return ret;
 
@@ -644,6 +645,9 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	if (of_property_read_u32(node, "solomon,page-offset", &par->page_offset))
 		par->page_offset = 1;
 
+	if (of_property_read_u32(node, "solomon,col-offset", &par->col_offset))
+		par->col_offset = 0;
+
 	if (of_property_read_u32(node, "solomon,com-offset", &par->com_offset))
 		par->com_offset = 0;
 
-- 
2.23.0.rc1
