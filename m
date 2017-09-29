From: Russell King <rmk+kernel@armlinux.org.uk>
Date: Fri, 29 Sep 2017 10:51:33 +0000
Subject: [PATCH 8/8] video: sa1100fb: move pseudo palette into sa1100fb_info structure
Message-Id: <E1dxstJ-0006jc-Ne@rmk-PC.armlinux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170929105004.GY20805@n2100.armlinux.org.uk>
In-Reply-To: <20170929105004.GY20805@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Move the pseudo palette inside the driver private data structure so we
don't have to play tricks to cater for it.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/video/fbdev/sa1100fb.c | 9 +++------
 drivers/video/fbdev/sa1100fb.h | 2 ++
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/sa1100fb.c b/drivers/video/fbdev/sa1100fb.c
index 56d514b5d252..15ae50063296 100644
--- a/drivers/video/fbdev/sa1100fb.c
+++ b/drivers/video/fbdev/sa1100fb.c
@@ -323,13 +323,11 @@ sa1100fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 		 * according to the RGB bitfield information.
 		 */
 		if (regno < 16) {
-			u32 *pal = fbi->fb.pseudo_palette;
-
 			val  = chan_to_field(red, &fbi->fb.var.red);
 			val |= chan_to_field(green, &fbi->fb.var.green);
 			val |= chan_to_field(blue, &fbi->fb.var.blue);
 
-			pal[regno] = val;
+			fbi->pseudo_palette[regno] = val;
 			ret = 0;
 		}
 		break;
@@ -1132,8 +1130,7 @@ static struct sa1100fb_info *sa1100fb_init_fbinfo(struct device *dev)
 	struct sa1100fb_info *fbi;
 	unsigned i;
 
-	fbi = devm_kzalloc(dev, sizeof(struct sa1100fb_info) + sizeof(u32) * 16,
-			   GFP_KERNEL);
+	fbi = devm_kzalloc(dev, sizeof(struct sa1100fb_info), GFP_KERNEL);
 	if (!fbi)
 		return NULL;
 
@@ -1158,7 +1155,7 @@ static struct sa1100fb_info *sa1100fb_init_fbinfo(struct device *dev)
 	fbi->fb.fbops		= &sa1100fb_ops;
 	fbi->fb.flags		= FBINFO_DEFAULT;
 	fbi->fb.monspecs	= monspecs;
-	fbi->fb.pseudo_palette	= (fbi + 1);
+	fbi->fb.pseudo_palette	= fbi->pseudo_palette;
 
 	fbi->rgb[RGB_4]		= &rgb_4;
 	fbi->rgb[RGB_8]		= &rgb_8;
diff --git a/drivers/video/fbdev/sa1100fb.h b/drivers/video/fbdev/sa1100fb.h
index 0139d13377a5..7a1a9ca33cec 100644
--- a/drivers/video/fbdev/sa1100fb.h
+++ b/drivers/video/fbdev/sa1100fb.h
@@ -69,6 +69,8 @@ struct sa1100fb_info {
 
 	const struct sa1100fb_mach_info *inf;
 	struct clk *clk;
+
+	u32 pseudo_palette[16];
 };
 
 #define TO_INF(ptr,member)	container_of(ptr,struct sa1100fb_info,member)
-- 
2.7.4

