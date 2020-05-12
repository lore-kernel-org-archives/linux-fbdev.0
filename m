From: Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
Date: Tue, 12 May 2020 20:52:48 +0000
Subject: [PATCH 2/3] video: fbdev: ssd1307fb: Support to pixel inversion
Message-Id: <1589316769-13277-2-git-send-email-alencar.fmce@imbel.gov.br>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589316769-13277-1-git-send-email-alencar.fmce@imbel.gov.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, maxime.ripard@free-electrons.com, alencar.fmce@imbel.gov.br, Rodrigo Alencar <455.rodrigo.alencar@gmail.com>

Pixel inversion in hardware is performed by issuing the
command 0xa7. This patch adds a boolean  property to control
color inversion.

Signed-off-by: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
---
 .../devicetree/bindings/display/ssd1307fb.txt         |  1 +
 drivers/video/fbdev/ssd1307fb.c                       | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/ssd1307fb.txt b/Documentation/devicetree/bindings/display/ssd1307fb.txt
index 74a7b228bcef..3076b71ede68 100644
--- a/Documentation/devicetree/bindings/display/ssd1307fb.txt
+++ b/Documentation/devicetree/bindings/display/ssd1307fb.txt
@@ -22,6 +22,7 @@ Optional properties:
   - solomon,com-seq: Display uses sequential COM pin configuration
   - solomon,com-lrremap: Display uses left-right COM pin remap
   - solomon,com-invdir: Display uses inverted COM pin scan direction
+  - solomon,color-inv: Set Inverse display mode (invert pixel color)
   - solomon,com-offset: Number of the COM pin wired to the first display line
   - solomon,col-offset: Offset of columns (SEG) that the screen is mapped to.
   - solomon,prechargep1: Length of deselect period (phase 1) in clock cycles.
diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index ac88bbe174b6..748c21c0567b 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -31,8 +31,9 @@
 #define SSD1307FB_SET_LOOKUP_TABLE	0x91
 #define	SSD1307FB_CHARGE_PUMP		0x8d
 #define SSD1307FB_SEG_REMAP_ON		0xa1
-#define SSD1307FB_DISPLAY_OFF		0xae
+#define SSD1307FB_DISPLAY_NORMAL	0xa6
 #define SSD1307FB_SET_MULTIPLEX_RATIO	0xa8
+#define SSD1307FB_DISPLAY_OFF		0xae
 #define SSD1307FB_DISPLAY_ON		0xaf
 #define SSD1307FB_START_PAGE_ADDRESS	0xb0
 #define SSD1307FB_SET_DISPLAY_OFFSET	0xd3
@@ -62,6 +63,7 @@ struct ssd1307fb_deviceinfo {
 struct ssd1307fb_par {
 	unsigned area_color_enable : 1;
 	unsigned com_invdir : 1;
+	unsigned color_inv : 1;
 	unsigned com_lrremap : 1;
 	unsigned com_seq : 1;
 	unsigned lookup_table_set : 1;
@@ -492,6 +494,12 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
 
+	/* Set normal or inverse */
+	ret = ssd1307fb_write_cmd(par->client,
+				  SSD1307FB_DISPLAY_NORMAL | (par->color_inv & 0x1));
+	if (ret < 0)
+		return ret;
+
 	/* Clear the screen */
 	ssd1307fb_update_display(par);
 
@@ -666,6 +674,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	par->com_seq = of_property_read_bool(node, "solomon,com-seq");
 	par->com_lrremap = of_property_read_bool(node, "solomon,com-lrremap");
 	par->com_invdir = of_property_read_bool(node, "solomon,com-invdir");
+	par->color_inv = of_property_read_bool(node, "solomon,color-inv");
 	par->area_color_enable  		of_property_read_bool(node, "solomon,area-color-enable");
 	par->low_power = of_property_read_bool(node, "solomon,low-power");
-- 
2.23.0.rc1
