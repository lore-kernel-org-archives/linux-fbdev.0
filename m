From: "Pieter \"PoroCYon\" Sluys" <pcy@national.shitposting.agency>
Date: Wed, 20 Dec 2017 14:53:00 +0000
Subject: Re: [PATCH] vfb: fix video mode and line_length being set when loaded
Message-Id: <81bf0d1e-ee7a-29ea-d19e-ffeb41d285fe@national.shitposting.agency>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------78D131A0C3556277D4625C94"
List-Id: <linux-fbdev.vger.kernel.org>
References: <39a57338-18ac-c64f-1cf1-70a5f905990a@national.shitposting.agency>
 <CAMuHMdXjkY=6=CDMPNFtxtjw8g52ivV-HdnKX3-mao0TPTabMw@mail.gmail.com>
In-Reply-To: <CAMuHMdXjkY=6=CDMPNFtxtjw8g52ivV-HdnKX3-mao0TPTabMw@mail.gmail.com>
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>

This is a multi-part message in MIME format.
--------------78D131A0C3556277D4625C94
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Geert Uytterhoeven:
> Please add your "Signed-off-by", cfr.
> Documentation/process/submitting-patches.rst.

Sorry I knew I would've messed up *something*.

> You can drop the tests for 2 and 4, as these are no longer used by the driver.

Done that.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Pieter "PoroCYon" Sluys <pcy@national.shitposting.agency>

---
 drivers/video/fbdev/vfb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index da653a080394..5fb360283c6b 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -239,8 +239,23 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
  */
 static int vfb_set_par(struct fb_info *info)
 {
+	switch (info->var.bits_per_pixel) {
+		case 1:
+			info->fix.visual = FB_VISUAL_MONO01;
+			break;
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

@@ -450,6 +465,8 @@ static int vfb_probe(struct platform_device *dev)
 		goto err2;
 	platform_set_drvdata(dev, info);

+	vfb_set_par(info);
+
 	fb_info(info, "Virtual frame buffer device, using %ldK of video memory\n",
 		videomemorysize >> 10);
 	return 0;
--
2.15.1


--------------78D131A0C3556277D4625C94
Content-Type: text/plain; charset=UTF-8;
 name="README"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="README"

Rml4IHZmYiBub3Qgc2V0dGluZyB0aGUgdmlkZW8gbW9kZSBhbmQgbGluZV9sZW5ndGggd2hl
biBsb2FkZWQuCkNvcHlyaWdodCAyMDE3IFBpZXRlciAiUG9yb0NZb24iIFNsdXlzIDxwY3lA
bmF0aW9uYWwuc2hpdHBvc3RpbmcuYWdlbmN5Pgp1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdQ
THYyCg==
--------------78D131A0C3556277D4625C94
Content-Type: text/x-patch;
 name="vfb.c.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="vfb.c.patch"

---
 drivers/video/fbdev/vfb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index da653a080394..5fb360283c6b 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -239,8 +239,23 @@ static int vfb_check_var(struct fb_var_screeninfo *v=
ar,
  */
 static int vfb_set_par(struct fb_info *info)
 {
+	switch (info->var.bits_per_pixel) {
+		case 1:
+			info->fix.visual =3D FB_VISUAL_MONO01;
+			break;
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
@@ -450,6 +465,8 @@ static int vfb_probe(struct platform_device *dev)
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

--------------78D131A0C3556277D4625C94--
