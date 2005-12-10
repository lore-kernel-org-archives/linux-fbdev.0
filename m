From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 11/18] atyfb: Fix interlaced modes
Date: Sat, 10 Dec 2005 14:12:16 +0800
Message-ID: <439A71C0.5070506@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky5S-0002qm-0O
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:20:02 -0800
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky5R-0004fR-Nb
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:20:01 -0800
Received: by zproxy.gmail.com with SMTP id r28so1047089nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:20:01 -0800 (PST)
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

Fix interlaced display modes.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_bas=
e.c
index 785829c..ae8f12d 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -967,16 +967,6 @@ static int aty_var_to_crtc(const struct=20
 		vdisplay =3D yres;
 		if(vmode & FB_VMODE_DOUBLE)
 			vdisplay <<=3D 1;
-		if(vmode & FB_VMODE_INTERLACED) {
-			vdisplay >>=3D 1;
-
-			/* The prefered mode for the LCD is not interlaced, so disable it if
-			   it was enabled. For doublescan there is no problem, because we can
-			   compensate for it in the hardware stretching (we stretch half as m=
uch)
-			 */
-			vmode &=3D ~FB_VMODE_INTERLACED;
-			/*crtc->gen_cntl &=3D ~CRTC_INTERLACE_EN;*/
-		}
 		crtc->gen_cntl &=3D ~(CRTC2_EN | CRTC2_PIX_WIDTH);
 		crtc->lcd_gen_cntl &=3D ~(HORZ_DIVBY2_EN | DIS_HOR_CRT_DIVBY2 |
 			/*TVCLK_PM_EN | VCLK_DAC_PM_EN |*/




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
