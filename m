From: Steve Glendinning <steve.glendinning@shawell.net>
Date: Mon, 17 Dec 2012 11:24:21 +0000
Subject: [PATCH 1/2] smscufx: ensure framebuffer is byte-swapped to LE
Message-Id: <1355743462-2670-1-git-send-email-steve.glendinning@shawell.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes the smscufx driver on big endian platforms, by
ensuring the framebuffer is correctly byte-swapped before sending
to the device.

Register and control words were already correctly swapped, so
without this patch the device "works" but with obviously incorrect
RGB values displayed on the output device.

This is implemented as an ifdef so platforms that don't require
byte swapping can use the faster memcpy method.

Signed-off-by: Steve Glendinning <steve.glendinning@shawell.net>
---
 drivers/video/smscufx.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
index 97bd662..8009400 100644
--- a/drivers/video/smscufx.c
+++ b/drivers/video/smscufx.c
@@ -840,8 +840,16 @@ static void ufx_raw_rect(struct ufx_data *dev, u16 *cmd, int x, int y,
 	for (line = 0; line < height; line++) {
 		const int line_offset = dev->info->fix.line_length * (y + line);
 		const int byte_offset = line_offset + (x * BPP);
-		memcpy(&cmd[(24 + (packed_line_len * line)) / 2],
-			(char *)dev->info->fix.smem_start + byte_offset, width * BPP);
+		const int cmd_base = (24 + (packed_line_len * line)) / 2;
+		const u16 *source = (u16 *)((char *)dev->info->fix.smem_start + byte_offset);
+		u16 *dest = (u16 *)(&cmd[cmd_base]);
+#ifdef __BIG_ENDIAN
+		int pixel;
+		for (pixel = 0; pixel < width; pixel++)
+			dest[pixel] = cpu_to_le16(source[pixel]);
+#else /* __BIG_ENDIAN */
+		memcpy(dest, source, width * BPP);
+#endif /* __BIG_ENDIAN */
 	}
 }
 
-- 
1.7.10.4

