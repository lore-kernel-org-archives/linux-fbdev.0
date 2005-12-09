From: syrjala@sci.fi
Subject: [PATCH 01/10] atyfb: Fix spelling
Date: Fri,  9 Dec 2005 02:44:27 +0200 (EET)
Message-ID: <20051209004427.6ADFE1F3@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkWNI-0004vn-ES
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:36 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkWNG-0002Qz-OY
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:36 -0800
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

Fix some spelling mistakes.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 atyfb_base.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff -urpN linux-0/drivers/video/aty/atyfb_base.c linux-1/drivers/video/aty=
/atyfb_base.c
--- linux-0/drivers/video/aty/atyfb_base.c	2005-12-09 00:37:20.000000000 +0=
200
+++ linux-1/drivers/video/aty/atyfb_base.c	2005-12-09 00:42:04.000000000 +0=
200
@@ -692,7 +692,7 @@ static void aty_set_crtc(const struct at
 		aty_st_lcd(LCD_GEN_CNTL, (crtc->lcd_gen_cntl & ~CRTC_RW_SELECT) |
 			(SHADOW_EN | SHADOW_RW_EN), par);
=20
-		DPRINTK("set secondary CRT to %ix%i %c%c\n",
+		DPRINTK("set shadow CRT to %ix%i %c%c\n",
 		    ((((crtc->shadow_h_tot_disp>>16) & 0xff) + 1)<<3), (((crtc->shadow_v=
_tot_disp>>16) & 0x7ff) + 1),
 		    (crtc->shadow_h_sync_strt_wid & 0x200000)?'N':'P', (crtc->shadow_v_s=
ync_strt_wid & 0x200000)?'N':'P');
=20
@@ -840,11 +840,11 @@ static int aty_var_to_crtc(const struct=20
 			   know if one is connected. So it's better to fail then.
 			 */
 			if (crtc->lcd_gen_cntl & CRT_ON) {
-				PRINTKI("Disable lcd panel, because video mode does not fit.\n");
+				PRINTKI("Disable LCD panel, because video mode does not fit.\n");
 				crtc->lcd_gen_cntl &=3D ~LCD_ON;
 				/*aty_st_lcd(LCD_GEN_CNTL, crtc->lcd_gen_cntl, par);*/
 			} else {
-				FAIL("Video mode exceeds size of lcd panel.\nConnect this computer to =
a conventional monitor if you really need this mode.");
+				FAIL("Video mode exceeds size of LCD panel.\nConnect this computer to =
a conventional monitor if you really need this mode.");
 			}
 		}
 	}
@@ -858,9 +858,9 @@ static int aty_var_to_crtc(const struct=20
 		vmode &=3D ~(FB_VMODE_DOUBLE | FB_VMODE_INTERLACED);
=20
 		/* This is horror! When we simulate, say 640x480 on an 800x600
-		   lcd monitor, the CRTC should be programmed 800x600 values for
+		   LCD monitor, the CRTC should be programmed 800x600 values for
 		   the non visible part, but 640x480 for the visible part.
-		   This code has been tested on a laptop with it's 1400x1050 lcd
+		   This code has been tested on a laptop with it's 1400x1050 LCD
 		   monitor and a conventional monitor both switched on.
 		   Tested modes: 1280x1024, 1152x864, 1024x768, 800x600,
 		    works with little glitches also with DOUBLESCAN modes
@@ -958,7 +958,7 @@ static int aty_var_to_crtc(const struct=20
 		if(vmode & FB_VMODE_INTERLACED) {
 			vdisplay >>=3D 1;
=20
-			/* The prefered mode for the lcd is not interlaced, so disable it if
+			/* The prefered mode for the LCD is not interlaced, so disable it if
 			   it was enabled. For doublescan there is no problem, because we can
 			   compensate for it in the hardware stretching (we stretch half as muc=
h)
 			 */
@@ -3153,15 +3153,15 @@ static void aty_init_lcd(struct atyfb_pa
 			refresh_rates_buf, lcd_refresh_rates[default_refresh_rate]);
 		par->lcd_refreshrate =3D lcd_refresh_rates[default_refresh_rate];
 		/* We now need to determine the crtc parameters for the
-		 * lcd monitor. This is tricky, because they are not stored
+		 * LCD monitor. This is tricky, because they are not stored
 		 * individually in the BIOS. Instead, the BIOS contains a
 		 * table of display modes that work for this monitor.
 		 *
 		 * The idea is that we search for a mode of the same dimensions
-		 * as the dimensions of the lcd monitor. Say our lcd monitor
+		 * as the dimensions of the LCD monitor. Say our LCD monitor
 		 * is 800x600 pixels, we search for a 800x600 monitor.
 		 * The CRTC parameters we find here are the ones that we need
-		 * to use to simulate other resolutions on the lcd screen.
+		 * to use to simulate other resolutions on the LCD screen.
 		 */
 		lcdmodeptr =3D (u16 *)(par->lcd_table + 64);
 		while (*lcdmodeptr !=3D 0) {



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
