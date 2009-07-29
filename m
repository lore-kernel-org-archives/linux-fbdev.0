From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: fbmon.c: err not needed in edid_checksum()
Date: Wed, 29 Jul 2009 10:30:03 +0200
Message-ID: <200907291030.03277.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751662AbZG2IaI@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

IMO that variable isn't needed.

Signed-off-by: Toralf Foerster <toralf.foerster@gmx.de>
---
drivers/video/fbmon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index e1b7073..cea7561 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -257,7 +257,7 @@ static void fix_edid(unsigned char *edid, int fix)
 static int edid_checksum(unsigned char *edid)
 {
 	unsigned char csum =3D 0, all_null =3D 0;
-	int i, err =3D 0, fix =3D check_edid(edid);
+	int i, fix =3D check_edid(edid);
=20
 	if (fix)
 		fix_edid(edid, fix);
@@ -269,10 +269,10 @@ static int edid_checksum(unsigned char *edid)
=20
 	if (csum =3D=3D 0x00 && all_null) {
 		/* checksum passed, everything's good */
-		err =3D 1;
+		return 1;
 	}
=20
-	return err;
+	return 0;
 }
=20
 static int edid_check_header(unsigned char *edid)

--=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
