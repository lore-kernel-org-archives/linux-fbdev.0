From: Toralf =?iso-8859-15?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: [PATCH] remove needless variable from drivers/video/fbmon.c
Date: Sat, 25 Jul 2009 19:44:34 +0200
Message-ID: <200907251944.35148.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752104AbZGYRoi@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

fbmon.c: integer err is not needed

Signed-off-by: Toralf Foerster <toralf.foerster@gmx.de>
---
 drivers/video/fbmon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 9ae9cd3..e1b7073 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -277,17 +277,17 @@ static int edid_checksum(unsigned char *edid)

 static int edid_check_header(unsigned char *edid)
 {
-       int i, err =3D 1, fix =3D check_edid(edid);
+       int i, fix =3D check_edid(edid);

        if (fix)
                fix_edid(edid, fix);

        for (i =3D 0; i < 8; i++) {
                if (edid[i] !=3D edid_v1_header[i])
-                       err =3D 0;
+                       return 0;
        }

-       return err;
+       return 1;
 }

 static void parse_vendor_block(unsigned char *block, struct fb_monspec=
s *specs)
--=20
MfG/Sincerely

Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
