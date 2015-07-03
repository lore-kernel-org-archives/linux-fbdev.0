From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bytesatwork.ch>
Date: Fri, 03 Jul 2015 08:38:15 +0000
Subject: [PATCH 2/3] logo: add option to return largest logo for a given resolution
Message-Id: <1435912696-17546-3-git-send-email-urs.fassler@bytesatwork.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435912696-17546-1-git-send-email-urs.fassler@bytesatwork.ch>
In-Reply-To: <1435912696-17546-1-git-send-email-urs.fassler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, oliver.staebler@bytesatwork.ch, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, urs.fassler@bytesatwork.ch

New method to return the largest (in number of pixels) logo for a given
resolution.
One use case is for embedded systems when one kernel binary is compiled
but used on different machines (i.e. different device trees) with
different display resolutions.

Signed-off-by: Urs F=C3=A4ssler <urs.fassler@bytesatwork.ch>
---
 drivers/video/logo/Kconfig |  7 +++++++
 drivers/video/logo/logo.c  | 43 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/linux_logo.h |  4 ++++
 3 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
index 0037104..72bd185 100644
--- a/drivers/video/logo/Kconfig
+++ b/drivers/video/logo/Kconfig
@@ -15,6 +15,13 @@ config FB_LOGO_EXTRA
 	depends on FB=3Dy
 	default y if SPU_BASE
=20
+config FB_LOGO_LARGEST
+	bool "Use largest"
+	default n
+	help
+	  Returns the largest available bootup logo that fits the given
+	  resolution.
+
 config LOGO_LINUX_MONO
 	bool "Standard black and white Linux logo"
 	default y
diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index d0a44db..4a6da90 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -111,11 +111,35 @@ static bool type_depth_compatible(int type, int depth)
 	}
 }
=20
+#ifdef CONFIG_FB_LOGO_LARGEST
+static bool resolution_compatible(const struct linux_logo *logo,
+	unsigned int width, unsigned int height)
+{
+	if (width && height)
+		return (logo->width <=3D width) && (logo->height <=3D height);
+	else
+		return true;
+}
+
+static const struct linux_logo * __init_refok fb_logo_larger(
+		const struct linux_logo *logo1, const struct linux_logo *logo2)
+{
+	if (logo1->width*logo1->height > logo2->width*logo2->height)
+		return logo1;
+	else
+		return logo2;
+}
+#else
+#define fb_logo_larger(logo1, logo2, w, h)	(logo1)
+#define resolution_compatible(logo, w, h)	(true)
+#endif
+
 /* logo's are marked __initdata. Use __init_refok to tell
  * modpost that it is intended that this function uses data
  * marked __initdata.
  */
-const struct linux_logo * __init_refok fb_find_logo(int depth)
+const struct linux_logo * __init_refok fb_find_logo_largest(int depth,
+	unsigned int width, unsigned int height)
 {
 	const struct linux_logo *logo =3D NULL;
 	const struct linux_logo **logos_itr;
@@ -124,9 +148,22 @@ const struct linux_logo * __init_refok fb_find_logo(in=
t depth)
 		return NULL;
=20
 	for (logos_itr =3D logos; *logos_itr !=3D NULL; logos_itr++)
-		if (type_depth_compatible((*logos_itr)->type, depth))
-			logo =3D *logos_itr;
+		if (type_depth_compatible((*logos_itr)->type, depth) &&
+		    resolution_compatible(*logos_itr, width, height)) {
+			if (logo)
+				logo =3D fb_logo_larger(logo, *logos_itr);
+			else
+				logo =3D *logos_itr;
+		}
=20
 	return logo;
 }
+#ifdef CONFIG_FB_LOGO_LARGEST
+EXPORT_SYMBOL_GPL(fb_find_logo_largest);
+#endif
+
+const struct linux_logo * __init_refok fb_find_logo(int depth)
+{
+	return fb_find_logo_largest(depth, 0, 0);
+}
 EXPORT_SYMBOL_GPL(fb_find_logo);
diff --git a/include/linux/linux_logo.h b/include/linux/linux_logo.h
index ca5bd91..f497e97 100644
--- a/include/linux/linux_logo.h
+++ b/include/linux/linux_logo.h
@@ -49,6 +49,10 @@ extern const struct linux_logo logo_m32r_clut224;
 extern const struct linux_logo logo_spe_clut224;
=20
 extern const struct linux_logo *fb_find_logo(int depth);
+#ifdef CONFIG_FB_LOGO_LARGEST
+extern const struct linux_logo *fb_find_logo_largest(int depth,
+				unsigned int width, unsigned int height);
+#endif
 #ifdef CONFIG_FB_LOGO_EXTRA
 extern void fb_append_extra_logo(const struct linux_logo *logo,
 				 unsigned int n);
--=20
2.1.4

