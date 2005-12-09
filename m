From: syrjala@sci.fi
Subject: [PATCH 04/10] atyfb: Fix interlaced modes
Date: Fri,  9 Dec 2005 02:44:27 +0200 (EET)
Message-ID: <20051209004427.C67DD1FB@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkWNI-0004vj-3F
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:36 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkWNG-0002RI-Rf
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

Fix interlaced display modes.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 atyfb_base.c |   10 ----------
 1 file changed, 10 deletions(-)

diff -urpN linux-3/drivers/video/aty/atyfb_base.c linux-4/drivers/video/aty=
/atyfb_base.c
--- linux-3/drivers/video/aty/atyfb_base.c	2005-12-09 02:51:32.000000000 +0=
200
+++ linux-4/drivers/video/aty/atyfb_base.c	2005-12-09 02:52:56.000000000 +0=
200
@@ -967,16 +967,6 @@ static int aty_var_to_crtc(const struct=20
 		vdisplay =3D yres;
 		if(vmode & FB_VMODE_DOUBLE)
 			vdisplay <<=3D 1;
-		if(vmode & FB_VMODE_INTERLACED) {
-			vdisplay >>=3D 1;
-
-			/* The prefered mode for the LCD is not interlaced, so disable it if
-			   it was enabled. For doublescan there is no problem, because we can
-			   compensate for it in the hardware stretching (we stretch half as muc=
h)
-			 */
-			vmode &=3D ~FB_VMODE_INTERLACED;
-			/*crtc->gen_cntl &=3D ~CRTC_INTERLACE_EN;*/
-		}
 		crtc->gen_cntl &=3D ~(CRTC2_EN | CRTC2_PIX_WIDTH);
 		crtc->lcd_gen_cntl &=3D ~(HORZ_DIVBY2_EN | DIS_HOR_CRT_DIVBY2 |
 			/*TVCLK_PM_EN | VCLK_DAC_PM_EN |*/



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
