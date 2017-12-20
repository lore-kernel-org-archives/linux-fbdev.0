From: "Pieter \"PoroCYon\" Sluys" <pcy@national.shitposting.agency>
Date: Wed, 20 Dec 2017 00:24:00 +0000
Subject: [PATCH] vfb: fix video mode and line_length being set when loaded
Message-Id: <39a57338-18ac-c64f-1cf1-70a5f905990a@national.shitposting.agency>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------95A30F142133BF5C8EF98DAD"
List-Id: <linux-fbdev.vger.kernel.org>
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>

This is a multi-part message in MIME format.
--------------95A30F142133BF5C8EF98DAD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Currently, when loading the vfb module, the newly created fbdev
has a line_length of 0, and its video mode would be PSEUDOCOLOR
regardless of color depth. (The former could be worked around by
calling the FBIOPUT_VSCREENINFO ioctl with having the FBACTIVIATE_FORCE
flag set.) This patch automatically sets the line_length correctly,
and the video mode is derived from the bit depth now as well.

Thanks to Geert Uytterhoeven for confirming the bug and helping me with
the patch.

Output of `fbset -i' before the patch:
mode "1366x768-60"
    # D: 72.432 MHz, H: 47.403 kHz, V: 60.004 Hz
    geometry 1366 768 1366 768 32
    timings 13806 120 10 14 3 32 5
    rgba 8/0,8/8,8/16,8/24
endmode

Frame buffer device information:
    Name        : Virtual FB
    Address     : 0xffffaa1405d85000
    Size        : 4196352
    Type        : PACKED PIXELS
    Visual      : PSEUDOCOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 1
    LineLength  : 0                    <-- note this
    Accelerator : No

After:
mode "1366x768-60"
    # D: 72.432 MHz, H: 47.403 kHz, V: 60.004 Hz
    geometry 1366 768 1366 768 32
    timings 13806 120 10 14 3 32 5
    rgba 8/0,8/8,8/16,8/24
endmode

Frame buffer device information:
    Name        : Virtual FB
    Address     : 0xffffaa1405d85000
    Size        : 4196352
    Type        : PACKED PIXELS
    Visual      : TRUECOLOR
    XPanStep    : 1
    YPanStep    : 1
    YWrapStep   : 1
    LineLength  : 5464
    Accelerator : No

Thanks for your consideration,
Pieter "PoroCYon" Sluys

---
 drivers/video/fbdev/vfb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index da653a080394..6e866fbaab8a 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -239,8 +239,25 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
  */
 static int vfb_set_par(struct fb_info *info)
 {
+	switch (info->var.bits_per_pixel) {
+		case 1:
+			info->fix.visual = FB_VISUAL_MONO01;
+			break;
+		case 2:
+		case 4:
+		case 8:
+			info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+			break;
+		case 16:
+		case 24:
+		case 32:
+			info->fix.visual = FB_VISUAL_TRUECOLOR;
+			break;
+	}
+
 	info->fix.line_length = get_line_length(info->var.xres_virtual,
 						info->var.bits_per_pixel);
+
 	return 0;
 }

@@ -450,6 +467,8 @@ static int vfb_probe(struct platform_device *dev)
 		goto err2;
 	platform_set_drvdata(dev, info);

+	vfb_set_par(info);
+
 	fb_info(info, "Virtual frame buffer device, using %ldK of video memory\n",
 		videomemorysize >> 10);
 	return 0;
--
2.15.1

--------------95A30F142133BF5C8EF98DAD
Content-Type: text/plain; charset=UTF-8;
 name="README"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="README"

Rml4IHZmYiBub3Qgc2V0dGluZyB0aGUgdmlkZW8gbW9kZSBhbmQgbGluZV9sZW5ndGggd2hl
biBsb2FkZWQuCkNvcHlyaWdodCAyMDE3IFBpZXRlciAiUG9yb0NZb24iIFNsdXlzIDxwY3lA
bmF0aW9uYWwuc2hpdHBvc3RpbmcuYWdlbmN5Pgp1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdQ
THYyCg==
--------------95A30F142133BF5C8EF98DAD
Content-Type: text/x-patch;
 name="vfb.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="vfb.c.patch"

---
 drivers/video/fbdev/vfb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index da653a080394..6e866fbaab8a 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -239,8 +239,25 @@ static int vfb_check_var(struct fb_var_screeninfo *v=
ar,
  */
 static int vfb_set_par(struct fb_info *info)
 {
+	switch (info->var.bits_per_pixel) {
+		case 1:
+			info->fix.visual =3D FB_VISUAL_MONO01;
+			break;
+		case 2:
+		case 4:
+		case 8:
+			info->fix.visual =3D FB_VISUAL_PSEUDOCOLOR;
+			break;
+		case 16:
+		case 24:
+		case 32:
+			info->fix.visual =3D FB_VISUAL_TRUECOLOR;
+			break;
+	}
+
 	info->fix.line_length =3D get_line_length(info->var.xres_virtual,
 						info->var.bits_per_pixel);
+
 	return 0;
 }
=20
@@ -450,6 +467,8 @@ static int vfb_probe(struct platform_device *dev)
 		goto err2;
 	platform_set_drvdata(dev, info);
=20
+	vfb_set_par(info);
+
 	fb_info(info, "Virtual frame buffer device, using %ldK of video memory\=
n",
 		videomemorysize >> 10);
 	return 0;
--
2.15.1

--------------95A30F142133BF5C8EF98DAD--
