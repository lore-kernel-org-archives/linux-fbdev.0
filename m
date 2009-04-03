From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH] fbdev: move logo externs to header file
Date: Fri, 3 Apr 2009 13:45:40 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0904031157550.32353@vixen.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932193AbZDCLqW@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="ks_c_5601-1987"
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Krzysztof Helt <krzysztof.h1@wp.pl>, Andrew Morton <akpm@linux-foundation.org>, James Simmons <jsimm>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>

Now we have __initconst, we can finally move the external declarations =
for the
various Linux logo structures to <linux/linux_logo.h>.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Acked-By: James Simmons <jsimmons@infradead.org>
---
James' ack dates back to the previous submission (way to long ago), whe=
n the
logos were still __initdata, which caused failures on some platforms wi=
th some
toolchain versions.

Note: you have to remove the generated logos, as they're not automatica=
lly
regenerated if scripts/pnmtologo.c changes.

 arch/powerpc/kernel/prom_init.c        |    3 ---
 arch/powerpc/platforms/cell/spu_base.c |   11 +----------
 arch/um/include/shared/init.h          |    2 +-
 drivers/video/logo/logo.c              |   15 ---------------
 include/linux/init.h                   |    2 +-
 include/linux/linux_logo.h             |   16 ++++++++++++++++
 scripts/pnmtologo.c                    |   18 +++++++++---------
 7 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom=
_init.c
index 2e026c0..55d35ba 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -44,10 +44,7 @@
 #include <asm/sections.h>
 #include <asm/machdep.h>
=20
-#ifdef CONFIG_LOGO_LINUX_CLUT224
 #include <linux/linux_logo.h>
-extern const struct linux_logo logo_linux_clut224;
-#endif
=20
 /*
  * Properties whose value is longer than this get excluded from our
diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/plat=
forms/cell/spu_base.c
index 9abd210..8547e86 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -752,17 +752,8 @@ static int __init init_spu_base(void)
 		goto out_unregister_sysdev_class;
 	}
=20
-	if (ret > 0) {
-		/*
-		 * We cannot put the forward declaration in
-		 * <linux/linux_logo.h> because of conflicting session type
-		 * conflicts for const and __initdata with different compiler
-		 * versions
-		 */
-		extern const struct linux_logo logo_spe_clut224;
-
+	if (ret > 0)
 		fb_append_extra_logo(&logo_spe_clut224, ret);
-	}
=20
 	mutex_lock(&spu_full_list_mutex);
 	xmon_register_spus(&spu_full_list);
diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/ini=
t.h
index 37dd097..b3906f8 100644
--- a/arch/um/include/shared/init.h
+++ b/arch/um/include/shared/init.h
@@ -27,7 +27,7 @@
  * sign followed by value, e.g.:
  *
  * static int init_variable __initdata =3D 0;
- * static char linux_logo[] __initdata =3D { 0x32, 0x36, ... };
+ * static const char linux_logo[] __initconst =3D { 0x32, 0x36, ... };
  *
  * Don't forget to initialize data not at file scope, i.e. within a fu=
nction,
  * as gcc otherwise puts the data into the bss section and not into th=
e init
diff --git a/drivers/video/logo/logo.c b/drivers/video/logo/logo.c
index 2e85a2b..ea7a8cc 100644
--- a/drivers/video/logo/logo.c
+++ b/drivers/video/logo/logo.c
@@ -21,21 +21,6 @@
 #include <asm/bootinfo.h>
 #endif
=20
-extern const struct linux_logo logo_linux_mono;
-extern const struct linux_logo logo_linux_vga16;
-extern const struct linux_logo logo_linux_clut224;
-extern const struct linux_logo logo_blackfin_vga16;
-extern const struct linux_logo logo_blackfin_clut224;
-extern const struct linux_logo logo_dec_clut224;
-extern const struct linux_logo logo_mac_clut224;
-extern const struct linux_logo logo_parisc_clut224;
-extern const struct linux_logo logo_sgi_clut224;
-extern const struct linux_logo logo_sun_clut224;
-extern const struct linux_logo logo_superh_mono;
-extern const struct linux_logo logo_superh_vga16;
-extern const struct linux_logo logo_superh_clut224;
-extern const struct linux_logo logo_m32r_clut224;
-
 static int nologo;
 module_param(nologo, bool, 0);
 MODULE_PARM_DESC(nologo, "Disables startup logo");
diff --git a/include/linux/init.h b/include/linux/init.h
index 68cb026..978fd7e 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -29,7 +29,7 @@
  * sign followed by value, e.g.:
  *
  * static int init_variable __initdata =3D 0;
- * static char linux_logo[] __initdata =3D { 0x32, 0x36, ... };
+ * static const char linux_logo[] __initconst =3D { 0x32, 0x36, ... };
  *
  * Don't forget to initialize data not at file scope, i.e. within a fu=
nction,
  * as gcc otherwise puts the data into the bss section and not into th=
e init
diff --git a/include/linux/linux_logo.h b/include/linux/linux_logo.h
index 08a9296..ca5bd91 100644
--- a/include/linux/linux_logo.h
+++ b/include/linux/linux_logo.h
@@ -32,6 +32,22 @@ struct linux_logo {
 	const unsigned char *data;
 };
=20
+extern const struct linux_logo logo_linux_mono;
+extern const struct linux_logo logo_linux_vga16;
+extern const struct linux_logo logo_linux_clut224;
+extern const struct linux_logo logo_blackfin_vga16;
+extern const struct linux_logo logo_blackfin_clut224;
+extern const struct linux_logo logo_dec_clut224;
+extern const struct linux_logo logo_mac_clut224;
+extern const struct linux_logo logo_parisc_clut224;
+extern const struct linux_logo logo_sgi_clut224;
+extern const struct linux_logo logo_sun_clut224;
+extern const struct linux_logo logo_superh_mono;
+extern const struct linux_logo logo_superh_vga16;
+extern const struct linux_logo logo_superh_clut224;
+extern const struct linux_logo logo_m32r_clut224;
+extern const struct linux_logo logo_spe_clut224;
+
 extern const struct linux_logo *fb_find_logo(int depth);
 #ifdef CONFIG_FB_LOGO_EXTRA
 extern void fb_append_extra_logo(const struct linux_logo *logo,
diff --git a/scripts/pnmtologo.c b/scripts/pnmtologo.c
index 6aa2a24..64f5ddb 100644
--- a/scripts/pnmtologo.c
+++ b/scripts/pnmtologo.c
@@ -237,22 +237,22 @@ static void write_header(void)
     fprintf(out, " *  Linux logo %s\n", logoname);
     fputs(" */\n\n", out);
     fputs("#include <linux/linux_logo.h>\n\n", out);
-    fprintf(out, "static unsigned char %s_data[] __initdata =3D {\n",
+    fprintf(out, "static const unsigned char %s_data[] __initconst =3D=
 {\n",
 	    logoname);
 }
=20
 static void write_footer(void)
 {
     fputs("\n};\n\n", out);
-    fprintf(out, "struct linux_logo %s __initdata =3D {\n", logoname);
-    fprintf(out, "    .type\t=3D %s,\n", logo_types[logo_type]);
-    fprintf(out, "    .width\t=3D %d,\n", logo_width);
-    fprintf(out, "    .height\t=3D %d,\n", logo_height);
+    fprintf(out, "const struct linux_logo %s __initconst =3D {\n", log=
oname);
+    fprintf(out, "\t.type\t\t=3D %s,\n", logo_types[logo_type]);
+    fprintf(out, "\t.width\t\t=3D %d,\n", logo_width);
+    fprintf(out, "\t.height\t\t=3D %d,\n", logo_height);
     if (logo_type =3D=3D LINUX_LOGO_CLUT224) {
-	fprintf(out, "    .clutsize\t=3D %d,\n", logo_clutsize);
-	fprintf(out, "    .clut\t=3D %s_clut,\n", logoname);
+	fprintf(out, "\t.clutsize\t=3D %d,\n", logo_clutsize);
+	fprintf(out, "\t.clut\t\t=3D %s_clut,\n", logoname);
     }
-    fprintf(out, "    .data\t=3D %s_data\n", logoname);
+    fprintf(out, "\t.data\t\t=3D %s_data\n", logoname);
     fputs("};\n\n", out);
=20
     /* close logo file */
@@ -374,7 +374,7 @@ static void write_logo_clut224(void)
     fputs("\n};\n\n", out);
=20
     /* write logo clut */
-    fprintf(out, "static unsigned char %s_clut[] __initdata =3D {\n",
+    fprintf(out, "static const unsigned char %s_clut[] __initconst =3D=
 {\n",
 	    logoname);
     write_hex_cnt =3D 0;
     for (i =3D 0; i < logo_clutsize; i++) {
--=20
1.6.0.4

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village =B7 Da Vincilaan 7-D1 =B7 B-1935 Zaventem =B7 Bel=
gium

Phone:    +32 (0)2 700 8453
=46ax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 =B7 RPR Brussels
=46ortis =B7 BIC GEBABEBB =B7 IBAN BE41293037680010
