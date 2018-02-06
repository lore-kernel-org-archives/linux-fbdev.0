From: Ladislav Michl <ladis@linux-mips.org>
Date: Tue, 06 Feb 2018 20:08:38 +0000
Subject: [PATCH 1/2] video: udlfb: Fix unaligned access
Message-Id: <20180206200838.GA10897@lenoch>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Driver generates lots of alignment trap exceptions on ARM.
Fix that by replacing typecasting of odd addresses with
byte shifting and remove uneccessary typecasting.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 Here's what happens on at91sam9g20 few minutes after boot:
 $ cat /proc/cpu/alignment
 User:           0
 System:         10747836 (dlfb_render_hline+0x22c/0x2f0 [udlfb])
 Skipped:        0
 Half:           10747971
 Word:           159
 DWord:          0
 Multi:          0
 Each hline transfer causes dozens alignment exceptions and
 few are in dlfb_parse_vendor_descriptor function.

 drivers/video/fbdev/udlfb.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 452a4207ac1b..45081297efa5 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -441,9 +441,9 @@ static void dlfb_compress_hline(
 
 		*cmd++ = 0xAF;
 		*cmd++ = 0x6B;
-		*cmd++ = (uint8_t) ((dev_addr >> 16) & 0xFF);
-		*cmd++ = (uint8_t) ((dev_addr >> 8) & 0xFF);
-		*cmd++ = (uint8_t) ((dev_addr) & 0xFF);
+		*cmd++ = dev_addr >> 16;
+		*cmd++ = dev_addr >> 8;
+		*cmd++ = dev_addr;
 
 		cmd_pixels_count_byte = cmd++; /*  we'll know this later */
 		cmd_pixel_start = pixel;
@@ -460,8 +460,8 @@ static void dlfb_compress_hline(
 		while (pixel < cmd_pixel_end) {
 			const uint16_t * const repeating_pixel = pixel;
 
-			*(uint16_t *)cmd = cpu_to_be16p(pixel);
-			cmd += 2;
+			*cmd++ = *pixel >> 8;
+			*cmd++ = *pixel;
 			pixel++;
 
 			if (unlikely((pixel < cmd_pixel_end) &&
@@ -1531,15 +1531,16 @@ static int dlfb_parse_vendor_descriptor(struct dlfb_data *dlfb,
 			u8 length;
 			u16 key;
 
-			key = le16_to_cpu(*((u16 *) desc));
-			desc += sizeof(u16);
-			length = *desc;
-			desc++;
+			key = *desc++;
+			key |= (u16)*desc++ << 8;
+			length = *desc++;
 
 			switch (key) {
 			case 0x0200: { /* max_area */
-				u32 max_area;
-				max_area = le32_to_cpu(*((u32 *)desc));
+				u32 max_area = *desc++;
+				max_area |= (u32)*desc++ << 8;
+				max_area |= (u32)*desc++ << 16;
+				max_area |= (u32)*desc++ << 24;
 				dev_warn(&intf->dev,
 					 "DL chip limited to %d pixel modes\n",
 					 max_area);
-- 
2.16.1

