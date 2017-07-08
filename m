From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Sat, 08 Jul 2017 01:30:23 +0000
Subject: [PATCH] video: cobalt_lcdfb: constify fb_fix_screeninfo structure
Message-Id: <20170708013023.GA4842@embeddedgus>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

This structure is only used to copy into other structures,
so declare it as const.

This issue was detected using Coccinelle and the following semantic patch:

@r disable optional_qualifier@
identifier i;
position p;
@@
static struct fb_fix_screeninfo i@p = { ... };

@ok@
identifier r.i;
expression e;
position p;
@@
e = i@p

@bad@
position p != {r.p,ok.p};
identifier r.i;
struct fb_fix_screeninfo e;
@@
e@i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
static
+const
 struct fb_fix_screeninfo i = { ... };

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/video/fbdev/cobalt_lcdfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/cobalt_lcdfb.c b/drivers/video/fbdev/cobalt_lcdfb.c
index 9da90bd..0ef633e 100644
--- a/drivers/video/fbdev/cobalt_lcdfb.c
+++ b/drivers/video/fbdev/cobalt_lcdfb.c
@@ -126,7 +126,7 @@ static void lcd_clear(struct fb_info *info)
 	lcd_write_control(info, LCD_RESET);
 }
 
-static struct fb_fix_screeninfo cobalt_lcdfb_fix = {
+static const struct fb_fix_screeninfo cobalt_lcdfb_fix = {
 	.id		= "cobalt-lcd",
 	.type		= FB_TYPE_TEXT,
 	.type_aux	= FB_AUX_TEXT_MDA,
-- 
2.5.0

