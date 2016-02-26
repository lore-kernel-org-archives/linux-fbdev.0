From: Alan <alan@linux.intel.com>
Date: Fri, 26 Feb 2016 18:42:30 +0000
Subject: [PATCH 5/5] Subject: goldfishfb: simplify framebuffer format selection.
Message-Id: <20160226184230.2731.4181.stgit@localhost.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Nicolas Capens <capn@google.com>

Signed-off-by: Nicolas Capens <capn@google.com>
Signed-off-by: Jin Qian <jinqian@android.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---
 drivers/video/fbdev/goldfishfb.c |   34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index cddc91d..2a5fe71 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -53,39 +53,35 @@ enum {
 	HAL_PIXEL_FORMAT_RGB_888            = 3,
 	HAL_PIXEL_FORMAT_RGB_565            = 4,
 	HAL_PIXEL_FORMAT_BGRA_8888          = 5,
-	HAL_PIXEL_FORMAT_RGBA_5551          = 6,
-	HAL_PIXEL_FORMAT_RGBA_4444          = 7,
 };
 
 struct framebuffer_config {
-	u8 format;
 	u8 bytes_per_pixel;
-	u8 transp_offset;
-	u8 transp_length;
 	u8 red_offset;
 	u8 red_length;
 	u8 green_offset;
 	u8 green_length;
 	u8 blue_offset;
 	u8 blue_length;
+	u8 transp_offset;
+	u8 transp_length;
+};
+
+static const struct framebuffer_config fb_configs[] = {
+	{ 0, 0,  0, 0, 0, 0,  0, 0,  0 }, /* Invalid, assume RGB_565 */
+	{ 4, 0,  8, 8, 8, 16, 8, 24, 8 }, /* HAL_PIXEL_FORMAT_RGBA_8888 */
+	{ 4, 0,  8, 8, 8, 16, 8, 0,  0 }, /* HAL_PIXEL_FORMAT_RGBX_8888 */
+	{ 3, 0,  8, 8, 8, 16, 8, 0,  0 }, /* HAL_PIXEL_FORMAT_RGB_888 */
+	{ 2, 11, 5, 5, 6, 0,  5, 0,  0 }, /* HAL_PIXEL_FORMAT_RGB_565 */
+	{ 4, 16, 8, 8, 8, 0,  8, 24, 8 }, /* HAL_PIXEL_FORMAT_BGRA_8888 */
 };
 
 static const struct framebuffer_config *get_fb_config_from_format(int format)
 {
-	/* Only configurations supported by the emulator. */
-	static const struct framebuffer_config fb_configs[] = {
-		{ HAL_PIXEL_FORMAT_RGB_565, 2, 0, 0, 11, 5, 5, 6, 0, 5 },
-		{ HAL_PIXEL_FORMAT_RGBX_8888, 4, 0, 0, 16, 8, 8, 8, 0, 8 },
-		{ HAL_PIXEL_FORMAT_RGBA_8888, 4, 24, 8, 16, 8, 8, 8, 0, 8 },
-	};
-	const int fb_configs_size = ARRAY_SIZE(fb_configs);
-	int n;
-
-	for (n = 0; n < fb_configs_size; ++n) {
-		if (format = fb_configs[n].format)
-			return &fb_configs[n];
-	}
-	return &fb_configs[0]; /* default to RGB565 */
+	if (format > 0 && format < ARRAY_SIZE(fb_configs))
+		return &fb_configs[format];
+
+	return &fb_configs[HAL_PIXEL_FORMAT_RGB_565]; /* legacy default */
 }
 
 struct goldfish_fb {

