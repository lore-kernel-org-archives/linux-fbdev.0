From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 12/18] atyfb: Don't stretch with CRT
Date: Sat, 10 Dec 2005 14:12:30 +0800
Message-ID: <439A71CE.5040208@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky5g-0002r5-4K
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:20:16 -0800
Received: from zproxy.gmail.com ([64.233.162.201])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky5f-0004n4-SW
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:20:16 -0800
Received: by zproxy.gmail.com with SMTP id v1so1114984nzb
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:20:15 -0800 (PST)
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

The overlay on 3D Rage LT Pro doesn't work correctly if stretching is
enabled when using only a CRT.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_bas=
e.c
index ae8f12d..af4a09d 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
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
 				(((vdisplay * (VERT_STRETCH_RATIO0 + 1)) / par->lcd_height) & VERT_S=
TRETCH_RATIO0));
=20




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
