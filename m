From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 22 Jun 2016 12:37:11 +0000
Subject: [PATCH] fbdev: atyfb: fix array overflow
Message-Id: <20160622123822.1262383-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@suse.com>, Borislav Petkov <bp@suse.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

When building with CONFIG_UBSAN_SANITIZE_ALL on ARM, I get this
gcc warning for atyfb:

drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_bl_update_status':
drivers/video/fbdev/aty/atyfb_base.c:167:33: warning: array subscript is above array bounds [-Warray-bounds]
drivers/video/fbdev/aty/atyfb_base.c:152:26: warning: array subscript is above array bounds [-Warray-bounds]

Apparently the warning is correct and there is indeed an overflow,
which was never caught. I could only reproduce this on ARM and
have opened a bug against the compiler for the lack of warning.

This patch makes the array larger, so we cover all possible
registers in the LCD controller without an overflow.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://bugs.linaro.org/show_bug.cgi?id#49
---
 drivers/video/fbdev/aty/atyfb_base.c | 2 +-
 include/video/mach64.h               | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 001d3d871800..36ffba152eab 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -134,7 +134,7 @@
 
 #if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
 defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIGHT)
-static const u32 lt_lcd_regs[] = {
+static const u32 lt_lcd_regs[LCD_REG_NUM] = {
 	CNFG_PANEL_LG,
 	LCD_GEN_CNTL_LG,
 	DSTN_CONTROL_LG,
diff --git a/include/video/mach64.h b/include/video/mach64.h
index 89e91c0cb737..9f74e9e0aeb8 100644
--- a/include/video/mach64.h
+++ b/include/video/mach64.h
@@ -1299,6 +1299,7 @@
 #define APC_LUT_KL		0x38
 #define APC_LUT_MN		0x39
 #define APC_LUT_OP		0x3A
+#define LCD_REG_NUM		0x3B /* total number */
 
 /* Values in LCD_GEN_CTRL */
 #define CRT_ON                          0x00000001ul
-- 
2.9.0

