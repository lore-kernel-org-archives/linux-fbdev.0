From: Kees Cook <keescook@chromium.org>
Date: Tue, 20 Dec 2016 20:10:49 +0000
Subject: [PATCH v2] video: fbdev: sh_mobile_lcdcfb: use designated initializers
Message-Id: <20161220201049.GA18463@beast>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org

Prepare to mark sensitive kernel structures for randomization by making
sure they're using designated initializers. These were identified during
allyesconfig builds of x86, arm, and arm64, with most initializer fixes
extracted from grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
- vertical columns, Bartlomiej Zolnierkiewicz
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 82c0a8caa9b8..93469f94c09d 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -439,9 +439,9 @@ static unsigned long lcdc_sys_read_data(void *handle)
 }
 
 static struct sh_mobile_lcdc_sys_bus_ops sh_mobile_lcdc_sys_bus_ops = {
-	lcdc_sys_write_index,
-	lcdc_sys_write_data,
-	lcdc_sys_read_data,
+	.write_index	= lcdc_sys_write_index,
+	.write_data	= lcdc_sys_write_data,
+	.read_data	= lcdc_sys_read_data,
 };
 
 static int sh_mobile_lcdc_sginit(struct fb_info *info,
-- 
2.7.4


-- 
Kees Cook
Nexus Security
