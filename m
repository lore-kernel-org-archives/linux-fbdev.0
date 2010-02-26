From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Date: Fri, 26 Feb 2010 12:04:54 +0000
Subject: [PATCH] backlight, blackfin: fix missing registration failure
Message-Id: <20100226130454.228af99a@neptune.home>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100221002831.689bace8@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Richard Purdie <rpurdie@linux.intel.com>, Mike Frysinger <vapier@gentoo.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Check newly registered backlight_device for error and properly
return error to parent
Mark struct backlight_ops as const.

Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
Acked-by: Mike Frysinger <vapier@gentoo.org> (constify struct backlight_ops)
---
 drivers/video/bf54x-lq043fb.c           |   10 +++++++++-
 drivers/video/bfin-t350mcqb-fb.c        |   10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/video/bf54x-lq043fb.c b/drivers/video/bf54x-lq043fb.c
index db4e6f7..a589216 100644
--- a/drivers/video/bf54x-lq043fb.c
+++ b/drivers/video/bf54x-lq043fb.c
@@ -463,7 +463,7 @@ static int bl_get_brightness(struct backlight_device *b=
d)
 	return 0;
 }
=20
-static struct backlight_ops bfin_lq043fb_bl_ops =3D {
+static const struct backlight_ops bfin_lq043fb_bl_ops =3D {
 	.get_brightness =3D bl_get_brightness,
 };
=20
@@ -678,6 +678,12 @@ static int __devinit bfin_bf54x_probe(struct platform_=
device *pdev)
 	bl_dev  	    backlight_device_register("bf54x-bl", NULL, NULL,
 				      &bfin_lq043fb_bl_ops);
+	if (IS_ERR(bl_dev)) {
+		printk(KERN_ERR DRIVER_NAME
+		       ": unable to register backlight.\n");
+		ret =3D -EINVAL;
+		goto out9;
+	}
 	bl_dev->props.max_brightness =3D 255;
=20
 	lcd_dev =3D lcd_device_register(DRIVER_NAME, &pdev->dev, NULL, &bfin_lcd_=
ops);
@@ -686,6 +692,8 @@ static int __devinit bfin_bf54x_probe(struct platform_d=
evice *pdev)
=20
 	return 0;
=20
+out9:
+	unregister_framebuffer(fbinfo);
 out8:
 	free_irq(info->irq, info);
 out7:
diff --git a/drivers/video/bfin-t350mcqb-fb.c b/drivers/video/bfin-t350mcqb=
-fb.c
index bc204c6..fe1492b 100644
--- a/drivers/video/bfin-t350mcqb-fb.c
+++ b/drivers/video/bfin-t350mcqb-fb.c
@@ -381,7 +381,7 @@ static int bl_get_brightness(struct backlight_device *b=
d)
 	return 0;
 }
=20
-static struct backlight_ops bfin_lq043fb_bl_ops =3D {
+static const struct backlight_ops bfin_lq043fb_bl_ops =3D {
 	.get_brightness =3D bl_get_brightness,
 };
=20
@@ -572,6 +572,12 @@ static int __devinit bfin_t350mcqb_probe(struct platfo=
rm_device *pdev)
 	bl_dev  	    backlight_device_register("bf52x-bl", NULL, NULL,
 				      &bfin_lq043fb_bl_ops);
+	if (IS_ERR(bl_dev)) {
+		printk(KERN_ERR DRIVER_NAME
+		       ": unable to register backlight.\n");
+		ret =3D -EINVAL;
+		goto out9;
+	}
 	bl_dev->props.max_brightness =3D 255;
=20
 	lcd_dev =3D lcd_device_register(DRIVER_NAME, NULL, &bfin_lcd_ops);
@@ -580,6 +586,8 @@ static int __devinit bfin_t350mcqb_probe(struct platfor=
m_device *pdev)
=20
 	return 0;
=20
+out9:
+	unregister_framebuffer(fbinfo);
 out8:
 	free_irq(info->irq, info);
 out7:
--=20
1.6.4.4

