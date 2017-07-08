From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Sat, 08 Jul 2017 01:15:52 +0000
Subject: [PATCH] video/chips: constify fb_fix_screeninfo and fb_var_screeninfo structures
Message-Id: <20170708011552.GA26138@embeddedgus>
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
 drivers/video/fbdev/chipsfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index 59abdc6..f103665 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -292,7 +292,7 @@ static void chips_hw_init(void)
 		write_fr(chips_init_fr[i].addr, chips_init_fr[i].data);
 }
 
-static struct fb_fix_screeninfo chipsfb_fix = {
+static const struct fb_fix_screeninfo chipsfb_fix = {
 	.id =		"C&T 65550",
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_PSEUDOCOLOR,
@@ -309,7 +309,7 @@ static struct fb_fix_screeninfo chipsfb_fix = {
 	.smem_len =	0x100000,	/* 1MB */
 };
 
-static struct fb_var_screeninfo chipsfb_var = {
+static const struct fb_var_screeninfo chipsfb_var = {
 	.xres = 800,
 	.yres = 600,
 	.xres_virtual = 800,
-- 
2.5.0

