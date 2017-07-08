From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Sat, 08 Jul 2017 01:09:56 +0000
Subject: [PATCH] video/mbx: constify fb_fix_screeninfo and fb_var_screeninfo structures
Message-Id: <20170708010956.GA22914@embeddedgus>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

These structures are only used to copy into other structures,
so declare them as const.

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

The semantic patch for fb_var_screeninfo is analogous.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/video/fbdev/mbx/mbxfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/mbx/mbxfb.c b/drivers/video/fbdev/mbx/mbxfb.c
index 698df954..539b85d 100644
--- a/drivers/video/fbdev/mbx/mbxfb.c
+++ b/drivers/video/fbdev/mbx/mbxfb.c
@@ -79,7 +79,7 @@ struct mbxfb_info {
 
 };
 
-static struct fb_var_screeninfo mbxfb_default = {
+static const struct fb_var_screeninfo mbxfb_default = {
 	.xres = 640,
 	.yres = 480,
 	.xres_virtual = 640,
@@ -102,7 +102,7 @@ static struct fb_var_screeninfo mbxfb_default = {
 	.sync = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 };
 
-static struct fb_fix_screeninfo mbxfb_fix = {
+static const struct fb_fix_screeninfo mbxfb_fix = {
 	.id = "MBX",
 	.type = FB_TYPE_PACKED_PIXELS,
 	.visual = FB_VISUAL_TRUECOLOR,
-- 
2.5.0

