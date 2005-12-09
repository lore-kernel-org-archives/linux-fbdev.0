From: syrjala@sci.fi
Subject: [PATCH 05/10] atyfb: Don't stretch with CRT
Date: Fri,  9 Dec 2005 02:44:27 +0200 (EET)
Message-ID: <20051209004427.E26661FD@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkWNI-0004w4-Qt
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:36 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkWNI-0002RT-Fr
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

The overlay on 3D Rage LT Pro doesn't work correctly if stretching is=20
enabled when using only a CRT.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 atyfb_base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -urpN linux-4/drivers/video/aty/atyfb_base.c linux-5/drivers/video/aty=
/atyfb_base.c
--- linux-4/drivers/video/aty/atyfb_base.c	2005-12-09 02:52:56.000000000 +0=
200
+++ linux-5/drivers/video/aty/atyfb_base.c	2005-12-09 02:53:55.000000000 +0=
200
@@ -982,7 +982,7 @@ static int aty_var_to_crtc(const struct=20
 		crtc->horz_stretching &=3D
 			~(HORZ_STRETCH_RATIO | HORZ_STRETCH_LOOP | AUTO_HORZ_RATIO |
 			HORZ_STRETCH_MODE | HORZ_STRETCH_EN);
-		if (xres < par->lcd_width) {
+		if (xres < par->lcd_width && crtc->lcd_gen_cntl & LCD_ON) {
 			do {
 				/*
 				* The horizontal blender misbehaves when HDisplay is less than a
@@ -1044,7 +1044,7 @@ static int aty_var_to_crtc(const struct=20
 			} while (0);
 		}
=20
-		if (vdisplay < par->lcd_height) {
+		if (vdisplay < par->lcd_height && crtc->lcd_gen_cntl & LCD_ON) {
 			crtc->vert_stretching =3D (VERT_STRETCH_USE0 | VERT_STRETCH_EN |
 				(((vdisplay * (VERT_STRETCH_RATIO0 + 1)) / par->lcd_height) & VERT_STR=
ETCH_RATIO0));
=20



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
