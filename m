From: syrjala@sci.fi
Subject: [PATCH 07/10] atyfb: Improve blanking
Date: Fri,  9 Dec 2005 02:44:28 +0200 (EET)
Message-ID: <20051209004428.39183278@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkWNI-0004w6-UI
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:36 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkWNI-0002Sn-FQ
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:37 -0800
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
MIME-Version: 1.0
Content-Type: text; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: alex.kern@gmx.de
Cc: linux-fbdev-devel@lists.sourceforge.net

Force blanking signal and disable display requests when blanked.
Don't disable LCD backlight with FB_BLANK_NORMAL.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 atyfb_base.c |   24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff -urpN linux-6/drivers/video/aty/atyfb_base.c linux-7/drivers/video/aty=
/atyfb_base.c
--- linux-6/drivers/video/aty/atyfb_base.c	2005-12-09 02:54:45.000000000 +0=
200
+++ linux-7/drivers/video/aty/atyfb_base.c	2005-12-09 02:55:42.000000000 +0=
200
@@ -2645,16 +2645,16 @@ static int __init store_video_par(char *
 static int atyfb_blank(int blank, struct fb_info *info)
 {
 	struct atyfb_par *par =3D (struct atyfb_par *) info->par;
-	u8 gen_cntl;
+	u32 gen_cntl;
=20
 	if (par->lock_blank || par->asleep)
 		return 0;
=20
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if ((_machine =3D=3D _MACH_Pmac) && blank)
+	if ((_machine =3D=3D _MACH_Pmac) && blank > FB_BLANK_NORMAL)
 		set_backlight_enable(0);
 #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
-	if (par->lcd_table && blank &&
+	if (par->lcd_table && blank > FB_BLANK_NORMAL &&
 	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
 		u32 pm =3D aty_ld_lcd(POWER_MANAGEMENT, par);
 		pm &=3D ~PWR_BLON;
@@ -2662,31 +2662,31 @@ static int atyfb_blank(int blank, struct
 	}
 #endif
=20
-	gen_cntl =3D aty_ld_8(CRTC_GEN_CNTL, par);
+	gen_cntl =3D aty_ld_le32(CRTC_GEN_CNTL, par);
 	switch (blank) {
         	case FB_BLANK_UNBLANK:
-			gen_cntl &=3D ~(0x4c);
+			gen_cntl &=3D ~0x400004c;
 			break;
 		case FB_BLANK_NORMAL:
-			gen_cntl |=3D 0x40;
+			gen_cntl |=3D 0x4000040;
 			break;
 		case FB_BLANK_VSYNC_SUSPEND:
-			gen_cntl |=3D 0x8;
+			gen_cntl |=3D 0x4000048;
 			break;
 		case FB_BLANK_HSYNC_SUSPEND:
-			gen_cntl |=3D 0x4;
+			gen_cntl |=3D 0x4000044;
 			break;
 		case FB_BLANK_POWERDOWN:
-			gen_cntl |=3D 0x4c;
+			gen_cntl |=3D 0x400004c;
 			break;
 	}
-	aty_st_8(CRTC_GEN_CNTL, gen_cntl, par);
+	aty_st_le32(CRTC_GEN_CNTL, gen_cntl, par);
=20
 #ifdef CONFIG_PMAC_BACKLIGHT
-	if ((_machine =3D=3D _MACH_Pmac) && !blank)
+	if ((_machine =3D=3D _MACH_Pmac) && blank <=3D FB_BLANK_NORMAL)
 		set_backlight_enable(1);
 #elif defined(CONFIG_FB_ATY_GENERIC_LCD)
-	if (par->lcd_table && !blank &&
+	if (par->lcd_table && blank <=3D FB_BLANK_NORMAL &&
 	    (aty_ld_lcd(LCD_GEN_CNTL, par) & LCD_ON)) {
 		u32 pm =3D aty_ld_lcd(POWER_MANAGEMENT, par);
 		pm |=3D PWR_BLON;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
