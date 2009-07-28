From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: [PATCH] fbmon.c: variable err not needed
Date: Tue, 28 Jul 2009 18:31:28 +0200
Message-ID: <200907281831.28734.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <toralf.foerster@gmx.de>) id 1MVpad-0003Ey-15
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Jul 2009 16:31:47 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MVpaR-0004Ui-Rb for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Jul 2009 16:31:41 +0000
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Resend after checkpatch.pl doesn't complained about it :


Signed-off-by: Toralf Foerster <toralf.foerster@gmx.de>
---
drivers/video/fbmon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 9ae9cd3..e1b7073 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -277,17 +277,17 @@ static int edid_checksum(unsigned char *edid)
 =

 static int edid_check_header(unsigned char *edid)
 {
-	int i, err =3D 1, fix =3D check_edid(edid);
+	int i, fix =3D check_edid(edid);
 =

 	if (fix)
 		fix_edid(edid, fix);
 =

 	for (i =3D 0; i < 8; i++) {
 		if (edid[i] !=3D edid_v1_header[i])
-			err =3D 0;
+			return 0;
 	}
 =

-	return err;
+	return 1;
 }
 =

 static void parse_vendor_block(unsigned char *block, struct fb_monspecs *s=
pecs)

-- =

MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3


---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
