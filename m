From: Steve Glendinning <steve.glendinning@shawell.net>
Date: Mon, 17 Dec 2012 11:24:22 +0000
Subject: [PATCH 2/2] smscufx: fix EDID parsing on big-endian systems
Message-Id: <1355743462-2670-2-git-send-email-steve.glendinning@shawell.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch allows smscufx to correctly detect the resolution of a
connected monitor on big-endian systems.

Signed-off-by: Steve Glendinning <steve.glendinning@shawell.net>
---
 drivers/video/smscufx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/smscufx.c b/drivers/video/smscufx.c
index 8009400..bdf7d36 100644
--- a/drivers/video/smscufx.c
+++ b/drivers/video/smscufx.c
@@ -1465,8 +1465,9 @@ static int ufx_read_edid(struct ufx_data *dev, u8 *edid, int edid_len)
 
 		for (j = 0; j < 16; j++) {
 			u32 data_reg_addr = 0x1110 + (j * 4);
-			status = ufx_reg_read(dev, data_reg_addr, edid_u32++);
+			status = ufx_reg_read(dev, data_reg_addr, &temp);
 			check_warn_return(status, "Error reading i2c data");
+			*edid_u32++ = cpu_to_le32(temp);
 		}
 	}
 
-- 
1.7.10.4

