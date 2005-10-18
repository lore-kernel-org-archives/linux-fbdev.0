From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/17] atyfb: Get initial mode timings from LCD BIOS
Date: Tue, 18 Oct 2005 17:17:36 +0800
Message-ID: <4354BDB0.2070103@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyIR-0000c9-HM
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:55 -0700
Received: from zproxy.gmail.com ([64.233.162.199])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyIR-0000fc-AU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:55 -0700
Received: by zproxy.gmail.com with SMTP id 14so1395717nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:42:55 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Reported by: Jean-Philippe Gu=E9rard (Bugzilla Bug 1782)

"I've tried with video=3Datyfb:debug and video=3Datyfb:debug,mode:1280x60=
0, \
nomtrr.

In both case, the screen stays black, but seems divided into 4 vertical
bands. Some white lines pop up randomly on each vertical band."

The problem is a combination of an incorrect xclk plus lack of timing
information.  The adapter is attached to an LCD device that can do
1280x600 (which is not a standard resolution).  The global mode database
does not have an entry for it.  Fortunately, the Video BIOS contains the
complete timing info for this display, however, atyfb is not making use
of it.

Add support to get the timing information from the BIOS, if available.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 atyfb_base.c |   58 ++++++++++++++++++++++++++++++++++++++++++++--------=
------
 1 files changed, 44 insertions(+), 14 deletions(-)


diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_bas=
e.c
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2156,11 +2156,38 @@ static void __init aty_calc_mem_refresh(
=20
 static struct fb_info *fb_list =3D NULL;
=20
+#if defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD)
+static int __devinit atyfb_get_timings_from_lcd(struct atyfb_par *par,
+						struct fb_var_screeninfo *var)
+{
+	int ret =3D -EINVAL;
+
+	if (par->lcd_table !=3D 0 && (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) =
{
+		*var =3D default_var;
+		var->xres =3D var->xres_virtual =3D par->lcd_hdisp;
+		var->right_margin =3D par->lcd_right_margin;
+		var->left_margin =3D par->lcd_hblank_len -
+			(par->lcd_right_margin + par->lcd_hsync_dly +
+			 par->lcd_hsync_len);
+		var->hsync_len =3D par->lcd_hsync_len + par->lcd_hsync_dly;
+		var->yres =3D var->yres_virtual =3D par->lcd_vdisp;
+		var->lower_margin =3D par->lcd_lower_margin;
+		var->upper_margin =3D par->lcd_vblank_len -
+			(par->lcd_lower_margin + par->lcd_vsync_len);
+		var->vsync_len =3D par->lcd_vsync_len;
+		var->pixclock =3D par->lcd_pixclock;
+		ret =3D 0;
+	}
+
+	return ret;
+}
+#endif /* defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD) */
+
 static int __init aty_init(struct fb_info *info, const char *name)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
 	const char *ramname =3D NULL, *xtal;
-	int gtb_memsize;
+	int gtb_memsize, has_var =3D 0;
 	struct fb_var_screeninfo var;
 	u8 pll_ref_div;
 	u32 i;
@@ -2468,8 +2495,8 @@ static int __init aty_init(struct fb_inf
 		 *         applies to all Mac video cards
 		 */
 		if (mode) {
-			if (!mac_find_mode(&var, info, mode, 8))
-				var =3D default_var;
+			if (mac_find_mode(&var, info, mode, 8))
+				has_var =3D 1;
 		} else {
 			if (default_vmode =3D=3D VMODE_CHOOSE) {
 				if (M64_HAS(G3_PB_1024x768))
@@ -2491,20 +2518,23 @@ static int __init aty_init(struct fb_inf
 				default_vmode =3D VMODE_640_480_60;
 			if (default_cmode < CMODE_8 || default_cmode > CMODE_32)
 				default_cmode =3D CMODE_8;
-			if (mac_vmode_to_var(default_vmode, default_cmode, &var))
-				var =3D default_var;
+			if (!mac_vmode_to_var(default_vmode, default_cmode,
+					       &var))
+				has_var =3D 1;
 		}
-	} else
+	}
+
 #endif /* !CONFIG_PPC */
-	if (
-#if defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
-	   /* On Sparc, unless the user gave a specific mode
-	    * specification, use the PROM probed values in
-	    * default_var.
-	    */
-	    !mode ||
+
+#if defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD)
+	if (!atyfb_get_timings_from_lcd(par, &var))
+		has_var =3D 1;
 #endif
-	    !fb_find_mode(&var, info, mode, NULL, 0, &defmode, 8))
+
+	if (mode && fb_find_mode(&var, info, mode, NULL, 0, &defmode, 8))
+		has_var =3D 1;
+
+	if (!has_var)
 		var =3D default_var;
=20
 	if (noaccel)




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
