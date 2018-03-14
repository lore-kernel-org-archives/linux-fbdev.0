From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 14 Mar 2018 15:35:31 +0000
Subject: [PATCH 18/47] fbdev: s1d13xxxfb: remove m32r specific hacks
Message-Id: <20180314153603.3127932-19-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180314153603.3127932-1-arnd@arndb.de>
In-Reply-To: <20180314153603.3127932-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

The m32r architecture is being removed, so this is no longer needed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/s1d13xxxfb.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index 5d6179ef0298..e04efb567b5c 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -96,18 +96,12 @@ static const struct fb_fix_screeninfo s1d13xxxfb_fix = {
 static inline u8
 s1d13xxxfb_readreg(struct s1d13xxxfb_par *par, u16 regno)
 {
-#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_OPSPUT) || defined(CONFIG_PLAT_MAPPI3)
-	regno=((regno & 1) ? (regno & ~1L) : (regno + 1));
-#endif
 	return readb(par->regs + regno);
 }
 
 static inline void
 s1d13xxxfb_writereg(struct s1d13xxxfb_par *par, u16 regno, u8 value)
 {
-#if defined(CONFIG_PLAT_M32700UT) || defined(CONFIG_PLAT_OPSPUT) || defined(CONFIG_PLAT_MAPPI3)
-	regno=((regno & 1) ? (regno & ~1L) : (regno + 1));
-#endif
 	writeb(value, par->regs + regno);
 }
 
@@ -296,11 +290,7 @@ s1d13xxxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			dbg("s1d13xxxfb_setcolreg: pseudo %d, val %08x\n",
 				    regno, pseudo_val);
 
-#if defined(CONFIG_PLAT_MAPPI)
-			((u32 *)info->pseudo_palette)[regno] = cpu_to_le16(pseudo_val);
-#else
 			((u32 *)info->pseudo_palette)[regno] = pseudo_val;
-#endif
 
 			break;
 		case FB_VISUAL_PSEUDOCOLOR:
-- 
2.9.0

