From: =?UTF-8?q?Urs=20F=C3=A4ssler?= <urs.fassler@bytesatwork.ch>
Date: Fri, 03 Jul 2015 08:38:14 +0000
Subject: [PATCH 1/3] video/logo: use list of logos to find logo
Message-Id: <1435912696-17546-2-git-send-email-urs.fassler@bytesatwork.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435912696-17546-1-git-send-email-urs.fassler@bytesatwork.ch>
In-Reply-To: <1435912696-17546-1-git-send-email-urs.fassler@bytesatwork.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, oliver.staebler@bytesatwork.ch, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, urs.fassler@bytesatwork.ch

Refactoring of fb_find_logo: declare list of logos explicit and loop over
it to find a match.

Signed-off-by: Urs F=C3=A4ssler <urs.fassler@bytesatwork.ch>
---
 drivers/video/logo/logo.c | 109 ++++++++++++++++++++++++++----------------=
----
 1 file changed, 62 insertions(+), 47 deletions(-)

diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 10fbfd8..d0a44db 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -36,82 +36,97 @@ static int __init fb_logo_late_init(void)
=20
 late_initcall(fb_logo_late_init);
=20
-/* logo's are marked __initdata. Use __init_refok to tell
- * modpost that it is intended that this function uses data
- * marked __initdata.
- */
-const struct linux_logo * __init_refok fb_find_logo(int depth)
-{
-	const struct linux_logo *logo =3D NULL;
=20
-	if (nologo || logos_freed)
-		return NULL;
-
-	if (depth >=3D 1) {
+static const struct linux_logo *logos[] __initconst =3D {
 #ifdef CONFIG_LOGO_LINUX_MONO
-		/* Generic Linux logo */
-		logo =3D &logo_linux_mono;
+	/* Generic Linux logo */
+	&logo_linux_mono,
 #endif
 #ifdef CONFIG_LOGO_SUPERH_MONO
-		/* SuperH Linux logo */
-		logo =3D &logo_superh_mono;
+	/* SuperH Linux logo */
+	&logo_superh_mono,
 #endif
-	}
-=09
-	if (depth >=3D 4) {
 #ifdef CONFIG_LOGO_LINUX_VGA16
-		/* Generic Linux logo */
-		logo =3D &logo_linux_vga16;
+	/* Generic Linux logo */
+	&logo_linux_vga16,
 #endif
 #ifdef CONFIG_LOGO_BLACKFIN_VGA16
-		/* Blackfin processor logo */
-		logo =3D &logo_blackfin_vga16;
+	/* Blackfin processor logo */
+	&logo_blackfin_vga16,
 #endif
 #ifdef CONFIG_LOGO_SUPERH_VGA16
-		/* SuperH Linux logo */
-		logo =3D &logo_superh_vga16;
+	/* SuperH Linux logo */
+	&logo_superh_vga16,
 #endif
-	}
-=09
-	if (depth >=3D 8) {
 #ifdef CONFIG_LOGO_LINUX_CLUT224
-		/* Generic Linux logo */
-		logo =3D &logo_linux_clut224;
+	/* Generic Linux logo */
+	&logo_linux_clut224,
 #endif
 #ifdef CONFIG_LOGO_BLACKFIN_CLUT224
-		/* Blackfin Linux logo */
-		logo =3D &logo_blackfin_clut224;
+	/* Blackfin Linux logo */
+	&logo_blackfin_clut224,
 #endif
 #ifdef CONFIG_LOGO_DEC_CLUT224
-		/* DEC Linux logo on MIPS/MIPS64 or ALPHA */
-		logo =3D &logo_dec_clut224;
+	/* DEC Linux logo on MIPS/MIPS64 or ALPHA */
+	&logo_dec_clut224,
 #endif
-#ifdef CONFIG_LOGO_MAC_CLUT224
-		/* Macintosh Linux logo on m68k */
-		if (MACH_IS_MAC)
-			logo =3D &logo_mac_clut224;
+#if defined(CONFIG_LOGO_MAC_CLUT224) && MACH_IS_MAC
+	/* Macintosh Linux logo on m68k */
+	&logo_mac_clut224,
 #endif
 #ifdef CONFIG_LOGO_PARISC_CLUT224
-		/* PA-RISC Linux logo */
-		logo =3D &logo_parisc_clut224;
+	/* PA-RISC Linux logo */
+	&logo_parisc_clut224,
 #endif
 #ifdef CONFIG_LOGO_SGI_CLUT224
-		/* SGI Linux logo on MIPS/MIPS64 */
-		logo =3D &logo_sgi_clut224;
+	/* SGI Linux logo on MIPS/MIPS64 */
+	&logo_sgi_clut224,
 #endif
 #ifdef CONFIG_LOGO_SUN_CLUT224
-		/* Sun Linux logo */
-		logo =3D &logo_sun_clut224;
+	/* Sun Linux logo */
+	&logo_sun_clut224,
 #endif
 #ifdef CONFIG_LOGO_SUPERH_CLUT224
-		/* SuperH Linux logo */
-		logo =3D &logo_superh_clut224;
+	/* SuperH Linux logo */
+	&logo_superh_clut224,
 #endif
 #ifdef CONFIG_LOGO_M32R_CLUT224
-		/* M32R Linux logo */
-		logo =3D &logo_m32r_clut224;
+	/* M32R Linux logo */
+	&logo_m32r_clut224,
 #endif
+	NULL
+};
+
+static bool type_depth_compatible(int type, int depth)
+{
+	switch (type) {
+	case LINUX_LOGO_MONO:
+		return depth >=3D 1;
+	case LINUX_LOGO_VGA16:
+		return depth >=3D 4;
+	case LINUX_LOGO_CLUT224:
+		return depth >=3D 8;
+	default:
+		return false;
 	}
+}
+
+/* logo's are marked __initdata. Use __init_refok to tell
+ * modpost that it is intended that this function uses data
+ * marked __initdata.
+ */
+const struct linux_logo * __init_refok fb_find_logo(int depth)
+{
+	const struct linux_logo *logo =3D NULL;
+	const struct linux_logo **logos_itr;
+
+	if (nologo || logos_freed)
+		return NULL;
+
+	for (logos_itr =3D logos; *logos_itr !=3D NULL; logos_itr++)
+		if (type_depth_compatible((*logos_itr)->type, depth))
+			logo =3D *logos_itr;
+
 	return logo;
 }
 EXPORT_SYMBOL_GPL(fb_find_logo);
--=20
2.1.4

