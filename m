From: <cfreeman@nvidia.com>
Date: Wed, 26 Mar 2014 22:35:37 +0000
Subject: [PATCH] video: Check EDID for HDMI connection
Message-Id: <1395873337-41305-1-git-send-email-cfreeman@nvidia.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: David Ung <davidu@nvidia.com>

Check EDID Vendor Specific Data Block bytes to see if the connection
is HDMI and set FB_MISC_HDMI.

Signed-off-by: David Ung <davidu@nvidia.com>
Signed-off-by: Christopher Freeman<cfreeman@nvidia.com>
---
 drivers/video/fbmon.c | 9 ++++++++-
 include/linux/fb.h    | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 6103fa6..3ac6367 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -1012,13 +1012,20 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	while (pos < edid[2]) {
 		u8 len = edid[pos] & 0x1f, type = (edid[pos] >> 5) & 7;
 		pr_debug("Data block %u of %u bytes\n", type, len);
-		if (type = 2)
+		if (type = 2) {
 			for (i = pos; i < pos + len; i++) {
 				u8 idx = edid[pos + i] & 0x7f;
 				svd[svd_n++] = idx;
 				pr_debug("N%sative mode #%d\n",
 					 edid[pos + i] & 0x80 ? "" : "on-n", idx);
 			}
+		} else if (type = 3 && len >= 3) {
+			/* Check Vendor Specific Data Block.  For HDMI,
+			   it is always 00-0C-03 for HDMI Licensing, LLC. */
+			if (edid[pos + 1] = 3 && edid[pos + 2] = 0xc &&
+			    edid[pos + 3] = 0)
+				specs->misc |= FB_MISC_HDMI;
+		}
 		pos += len + 1;
 	}
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index d49c60f..427d49d 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -47,6 +47,7 @@ struct device_node;
 
 #define FB_MISC_PRIM_COLOR	1
 #define FB_MISC_1ST_DETAIL	2	/* First Detailed Timing is preferred */
+#define FB_MISC_HDMI		4
 struct fb_chroma {
 	__u32 redx;	/* in fraction of 1024 */
 	__u32 greenx;
-- 
1.8.3.2


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
