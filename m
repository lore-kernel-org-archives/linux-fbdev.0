From: Ladislav Michl <ladis@linux-mips.org>
Date: Tue, 06 Feb 2018 20:09:39 +0000
Subject: [PATCH 2/2] video: udlfb: Use already defined BPP constant
Message-Id: <20180206200939.GB10897@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Replace const variable with already defined constant.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 drivers/video/fbdev/udlfb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 45081297efa5..7b53fefb4b94 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -428,7 +428,6 @@ static void dlfb_compress_hline(
 	const uint16_t *pixel = *pixel_start_ptr;
 	uint32_t dev_addr  = *device_address_ptr;
 	uint8_t *cmd = *command_buffer_ptr;
-	const int bpp = 2;
 
 	while ((pixel_end > pixel) &&
 	       (cmd_buffer_end - MIN_RLX_CMD_BYTES > cmd)) {
@@ -453,9 +452,9 @@ static void dlfb_compress_hline(
 
 		cmd_pixel_end = pixel + min(MAX_CMD_PIXELS + 1,
 			min((int)(pixel_end - pixel),
-			    (int)(cmd_buffer_end - cmd) / bpp));
+			    (int)(cmd_buffer_end - cmd) / BPP));
 
-		prefetch_range((void *) pixel, (cmd_pixel_end - pixel) * bpp);
+		prefetch_range((void *) pixel, (cmd_pixel_end - pixel) * BPP);
 
 		while (pixel < cmd_pixel_end) {
 			const uint16_t * const repeating_pixel = pixel;
@@ -490,7 +489,7 @@ static void dlfb_compress_hline(
 		}
 
 		*cmd_pixels_count_byte = (pixel - cmd_pixel_start) & 0xFF;
-		dev_addr += (pixel - cmd_pixel_start) * bpp;
+		dev_addr += (pixel - cmd_pixel_start) * BPP;
 	}
 
 	if (cmd_buffer_end <= MIN_RLX_CMD_BYTES + cmd) {
-- 
2.16.1

