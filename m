From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bytesatwork.ch>
Date: Tue, 07 Jul 2015 14:24:11 +0000
Subject: [PATCH 1/2] logo: add option to return largest logo for a given resolution
Message-Id: <1436279052-17237-2-git-send-email-urs.fassler@bytesatwork.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1436279052-17237-1-git-send-email-urs.fassler@bytesatwork.ch>
In-Reply-To: <1436279052-17237-1-git-send-email-urs.fassler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, oliver.staebler@bytesatwork.ch, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, urs.fassler@bytesatwork.ch, geert@linux-m68k.org

New method to return the largest (in number of pixels) logo for a given
resolution.
One use case is for embedded systems when one kernel binary is compiled
but used on different machines (i.e. different device trees) with
different display resolutions.

Signed-off-by: Urs F=C3=A4ssler <urs.fassler@bytesatwork.ch>
---
 drivers/video/logo/Kconfig |  7 ++++
 drivers/video/logo/logo.c  | 86 +++++++++++++++++++++++++++++++++++++-----=
----
 include/linux/linux_logo.h |  4 +++
 3 files changed, 80 insertions(+), 17 deletions(-)

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
index 10fbfd8..1b0d4c5 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -36,11 +36,55 @@ static int __init fb_logo_late_init(void)
=20
 late_initcall(fb_logo_late_init);
=20
+#ifdef CONFIG_FB_LOGO_LARGEST
+bool fb_logo_valid(const struct linux_logo *logo, unsigned int width,
+		   unsigned int height)
+{
+	if (!logo)
+		return false;
+	if (logo->width > width)
+		return false;
+	if (logo->height > height)
+		return false;
+
+	return true;
+}
+
+const struct linux_logo * __init_refok fb_logo_larger(
+		const struct linux_logo *logo1, const struct linux_logo *logo2,
+		unsigned int width, unsigned int height)
+{
+	bool logo1_valid;
+	bool logo2_valid;
+
+	if (!width || !height)
+		return logo1;
+
+	logo1_valid =3D fb_logo_valid(logo1, width, height);
+	logo2_valid =3D fb_logo_valid(logo2, width, height);
+
+	if (!logo1_valid && !logo2_valid)
+		return NULL;
+	if (logo1_valid && !logo2_valid)
+		return logo1;
+	if (!logo1_valid && logo2_valid)
+		return logo2;
+
+	if (logo1->width*logo1->height > logo2->width*logo2->height)
+		return logo1;
+	else
+		return logo2;
+}
+#else
+#define fb_logo_larger(logo1, logo2, w, h)	(logo1)
+#endif
+
 /* logo's are marked __initdata. Use __init_refok to tell
  * modpost that it is intended that this function uses data
  * marked __initdata.
  */
-const struct linux_logo * __init_refok fb_find_logo(int depth)
+const struct linux_logo * __init_refok fb_find_logo_largest(int depth,
+					unsigned int w, unsigned int h)
 {
 	const struct linux_logo *logo =3D NULL;
=20
@@ -50,68 +94,76 @@ const struct linux_logo * __init_refok fb_find_logo(int=
 depth)
 	if (depth >=3D 1) {
 #ifdef CONFIG_LOGO_LINUX_MONO
 		/* Generic Linux logo */
-		logo =3D &logo_linux_mono;
+		logo =3D fb_logo_larger(&logo_linux_mono, logo, w, h);
 #endif
 #ifdef CONFIG_LOGO_SUPERH_MONO
 		/* SuperH Linux logo */
-		logo =3D &logo_superh_mono;
+		logo =3D fb_logo_larger(&logo_superh_mono, logo, w, h);
 #endif
 	}
-=09
+
 	if (depth >=3D 4) {
 #ifdef CONFIG_LOGO_LINUX_VGA16
 		/* Generic Linux logo */
-		logo =3D &logo_linux_vga16;
+		logo =3D fb_logo_larger(&logo_linux_vga16, logo, w, h);
 #endif
 #ifdef CONFIG_LOGO_BLACKFIN_VGA16
 		/* Blackfin processor logo */
-		logo =3D &logo_blackfin_vga16;
+		logo =3D fb_logo_larger(&logo_blackfin_vga16, logo, w, h);
 #endif
 #ifdef CONFIG_LOGO_SUPERH_VGA16
 		/* SuperH Linux logo */
-		logo =3D &logo_superh_vga16;
+		logo =3D fb_logo_larger(&logo_superh_vga16, logo, w, h);
 #endif
 	}
-=09
+
 	if (depth >=3D 8) {
 #ifdef CONFIG_LOGO_LINUX_CLUT224
 		/* Generic Linux logo */
-		logo =3D &logo_linux_clut224;
+		logo =3D fb_logo_larger(&logo_linux_clut224, logo, w, h);
 #endif
 #ifdef CONFIG_LOGO_BLACKFIN_CLUT224
 		/* Blackfin Linux logo */
-		logo =3D &logo_blackfin_clut224;
+		logo =3D fb_logo_larger(&logo_blackfin_clut224, logo, w, h);
 #endif
 #ifdef CONFIG_LOGO_DEC_CLUT224
 		/* DEC Linux logo on MIPS/MIPS64 or ALPHA */
-		logo =3D &logo_dec_clut224;
+		logo =3D fb_logo_larger(&logo_dec_clut224, logo, w, h);
 #endif
 #ifdef CONFIG_LOGO_MAC_CLUT224
 		/* Macintosh Linux logo on m68k */
 		if (MACH_IS_MAC)
-			logo =3D &logo_mac_clut224;
+			logo =3D fb_logo_larger(&logo_mac_clut224, logo, w, h);
 #endif
 #ifdef CONFIG_LOGO_PARISC_CLUT224
 		/* PA-RISC Linux logo */
-		logo =3D &logo_parisc_clut224;
+		logo =3D fb_logo_larger(&logo_parisc_clut224, logo, w, h);
 #endif
 #ifdef CONFIG_LOGO_SGI_CLUT224
 		/* SGI Linux logo on MIPS/MIPS64 */
-		logo =3D &logo_sgi_clut224;
+		logo =3D fb_logo_larger(&logo_sgi_clut224, logo, w, h);
 #endif
 #ifdef CONFIG_LOGO_SUN_CLUT224
 		/* Sun Linux logo */
-		logo =3D &logo_sun_clut224;
+		logo =3D fb_logo_larger(&logo_sun_clut224, logo, w, h);
 #endif
 #ifdef CONFIG_LOGO_SUPERH_CLUT224
 		/* SuperH Linux logo */
-		logo =3D &logo_superh_clut224;
+		logo =3D fb_logo_larger(&logo_superh_clut224, logo, w, h);
 #endif
 #ifdef CONFIG_LOGO_M32R_CLUT224
 		/* M32R Linux logo */
-		logo =3D &logo_m32r_clut224;
+		logo =3D fb_logo_larger(&logo_m32r_clut224, logo, w, h);
 #endif
 	}
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

