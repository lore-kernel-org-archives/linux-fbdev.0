From: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 04/16] viafb: Retain GEMODE reserved bits
Date: Thu,  8 Apr 2010 11:15:34 -0600
Message-ID: <1270746946-12467-5-git-send-email-corbet@lwn.net>
References: <1270746946-12467-1-git-send-email-corbet@lwn.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1270746946-12467-1-git-send-email-corbet@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Harald Welte <laforge@gnumonks.org>, JosephChan@via.com.tw, ScottFang@viatech.com.cn, Deepak Saxena <dsaxena@laptop.org>, linux-fbdev-devel@lists.sourceforge.net

Commit c3e25673843153ea75fda79a47cf12f10a25ca37 (viafb: 2D engine rewrite)
changed the setting of the GEMODE register so that the reserved bits are no
longer preserved.  Fix that; at the same time, move this code to its own
function and restore the use of symbolic constants.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 drivers/video/via/accel.c |   48 ++++++++++++++++++++++++++++++---------------
 1 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
index d5077df..78c0a2b 100644
--- a/drivers/video/via/accel.c
+++ b/drivers/video/via/accel.c
@@ -165,12 +165,41 @@ static int hw_bitblt_1(void __iomem *engine, u8 op, u32 width, u32 height,
 	return 0;
 }
 
+/*
+ * Figure out an appropriate bytes-per-pixel setting.
+ */
+static int viafb_set_bpp(void __iomem *engine, u8 bpp)
+{
+	u32 gemode;
+
+	/* Preserve the reserved bits */
+	gemode = readl(engine + VIA_REG_GEMODE) & 0xfffffcff;
+	switch (bpp) {
+	case 8:
+		gemode |= VIA_GEM_8bpp;
+		break;
+	case 16:
+		gemode |= VIA_GEM_16bpp;
+		break;
+	case 32:
+		gemode |= VIA_GEM_32bpp;
+		break;
+	default:
+		printk(KERN_WARNING "hw_bitblt_2: Unsupported bpp %d\n", bpp);
+		return -EINVAL;
+	}
+	writel(gemode, engine + VIA_REG_GEMODE);
+	return 0;
+}
+
+
 static int hw_bitblt_2(void __iomem *engine, u8 op, u32 width, u32 height,
 	u8 dst_bpp, u32 dst_addr, u32 dst_pitch, u32 dst_x, u32 dst_y,
 	u32 *src_mem, u32 src_addr, u32 src_pitch, u32 src_x, u32 src_y,
 	u32 fg_color, u32 bg_color, u8 fill_rop)
 {
 	u32 ge_cmd = 0, tmp, i;
+	int ret;
 
 	if (!op || op > 3) {
 		printk(KERN_WARNING "hw_bitblt_2: Invalid operation: %d\n", op);
@@ -204,22 +233,9 @@ static int hw_bitblt_2(void __iomem *engine, u8 op, u32 width, u32 height,
 		}
 	}
 
-	switch (dst_bpp) {
-	case 8:
-		tmp = 0x00000000;
-		break;
-	case 16:
-		tmp = 0x00000100;
-		break;
-	case 32:
-		tmp = 0x00000300;
-		break;
-	default:
-		printk(KERN_WARNING "hw_bitblt_2: Unsupported bpp %d\n",
-			dst_bpp);
-		return -EINVAL;
-	}
-	writel(tmp, engine + 0x04);
+	ret = viafb_set_bpp(engine, dst_bpp);
+	if (ret)
+		return ret;
 
 	if (op == VIA_BITBLT_FILL)
 		tmp = 0;
-- 
1.7.0.1
