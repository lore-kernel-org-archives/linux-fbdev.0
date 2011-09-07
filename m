From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Wed, 07 Sep 2011 09:34:06 +0000
Subject: [PATCH] smscufx: reduce number of casts in ufx_raw_rect
Message-Id: <1315388046-1175-1-git-send-email-steve.glendinning@smsc.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 drivers/video/smscufx.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
index c6b86e7..44c8cab 100644
--- a/drivers/video/smscufx.c
+++ b/drivers/video/smscufx.c
@@ -807,7 +807,7 @@ static int ufx_ops_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	return 0;
 }
 
-static void ufx_raw_rect(struct ufx_data *dev, char *cmd, int x, int y,
+static void ufx_raw_rect(struct ufx_data *dev, u16 *cmd, int x, int y,
 	int width, int height)
 {
 	size_t packed_line_len = ALIGN((width * 2), 4);
@@ -821,27 +821,27 @@ static void ufx_raw_rect(struct ufx_data *dev, char *cmd, int x, int y,
 	*((u32 *)&cmd[0]) = cpu_to_le32(0x01);
 
 	/* length word */
-	*((u32 *)&cmd[4]) = cpu_to_le32(packed_rect_len + 16);
+	*((u32 *)&cmd[2]) = cpu_to_le32(packed_rect_len + 16);
 
-	*((u16 *)&cmd[8]) = cpu_to_le16(x);
-	*((u16 *)&cmd[10]) = cpu_to_le16(y);
-	*((u16 *)&cmd[12]) = cpu_to_le16(width);
-	*((u16 *)&cmd[14]) = cpu_to_le16(height);
+	cmd[4] = cpu_to_le16(x);
+	cmd[5] = cpu_to_le16(y);
+	cmd[6] = cpu_to_le16(width);
+	cmd[7] = cpu_to_le16(height);
 
 	/* frame base address */
-	*((u32 *)&cmd[16]) = cpu_to_le32(0 & 0xffffff80);
+	*((u32 *)&cmd[8]) = cpu_to_le32(0);
 
 	/* color mode and horizontal resolution */
-	*((u16 *)&cmd[20]) = cpu_to_le16(0x4000 | dev->info->var.xres);
+	cmd[10] = cpu_to_le16(0x4000 | dev->info->var.xres);
 
 	/* vertical resolution */
-	*((u16 *)&cmd[22]) = cpu_to_le16(dev->info->var.yres);
+	cmd[11] = cpu_to_le16(dev->info->var.yres);
 
 	/* packed data */
 	for (line = 0; line < height; line++) {
 		const int line_offset = dev->info->fix.line_length * (y + line);
 		const int byte_offset = line_offset + (x * BPP);
-		memcpy(&cmd[24 + (packed_line_len * line)],
+		memcpy(&cmd[(24 + (packed_line_len * line)) / 2],
 			(char *)dev->info->fix.smem_start + byte_offset, width * BPP);
 	}
 }
-- 
1.7.2.5

