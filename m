From: Yoichi Yuasa <yuasa@linux-mips.org>
Date: Sat, 03 Apr 2010 07:42:50 +0000
Subject: cobalt_lcdfb: fix section mismatch cobalt_lcdfb_fix
Message-Id: <20100403164250.0a1d59fe.yuasa@linux-mips.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

WARNING: drivers/video/built-in.o(.devinit.text+0x78): Section mismatch in reference from the function cobalt_lcdfb_probe() to the variable .init.data:cobalt_lcdfb_fix
The function __devinit cobalt_lcdfb_probe() references
a variable __initdata cobalt_lcdfb_fix.
If cobalt_lcdfb_fix is only used by cobalt_lcdfb_probe then
annotate cobalt_lcdfb_fix with a matching annotation.

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 drivers/video/cobalt_lcdfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/cobalt_lcdfb.c b/drivers/video/cobalt_lcdfb.c
index 5eb61b5..42fe155 100644
--- a/drivers/video/cobalt_lcdfb.c
+++ b/drivers/video/cobalt_lcdfb.c
@@ -123,7 +123,7 @@ static void lcd_clear(struct fb_info *info)
 	lcd_write_control(info, LCD_RESET);
 }
 
-static struct fb_fix_screeninfo cobalt_lcdfb_fix __initdata = {
+static struct fb_fix_screeninfo cobalt_lcdfb_fix __devinitdata = {
 	.id		= "cobalt-lcd",
 	.type		= FB_TYPE_TEXT,
 	.type_aux	= FB_AUX_TEXT_MDA,
-- 
1.7.0.4

