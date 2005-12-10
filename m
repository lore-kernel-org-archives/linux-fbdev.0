From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 14/18] atyfb: Improve blanking
Date: Sat, 10 Dec 2005 14:13:19 +0800
Message-ID: <439A71FF.2040209@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky5y-0002rg-5R
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:20:34 -0800
Received: from zproxy.gmail.com ([64.233.162.203])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky5x-0007Ds-SC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:20:34 -0800
Received: by zproxy.gmail.com with SMTP id n29so1146262nzf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:20:32 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>

From: Ville Syrj=E4l=E4 <syrjala@sci.fi>

Force blanking signal and disable display requests when blanked.
Don't disable LCD backlight with FB_BLANK_NORMAL.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_bas=
e.c
index 77e7ca3..c4a953c 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
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
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
