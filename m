From: syrjala@sci.fi
Subject: [PATCH 4/5] matroxfb: Kill a useless message
Date: Tue,  1 Nov 2005 00:12:20 +0200 (EET)
Message-ID: <20051031221220.AB5D6319@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWhtF-0004Rb-4H
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Oct 2005 14:12:29 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EWhtC-0005au-6j
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Oct 2005 14:12:29 -0800
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
To: vandrove@vc.cvut.cz
Cc: linux-fbdev-devel@lists.sourceforge.net

No point in spamming the logs with a message about xres rounding.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 matroxfb_base.c |    4 ----
 1 file changed, 4 deletions(-)

diff -uprN linux-2.6.14-3/drivers/video/matrox/matroxfb_base.c linux-2.6.14=
-4/drivers/video/matrox/matroxfb_base.c
--- linux-2.6.14-3/drivers/video/matrox/matroxfb_base.c	2005-10-31 19:40:02=
.000000000 +0200
+++ linux-2.6.14-4/drivers/video/matrox/matroxfb_base.c	2005-10-31 19:41:50=
.000000000 +0200
@@ -498,10 +498,6 @@ static int matroxfb_pitch_adjust(CPMINFO
 	} else {
 		xres_new =3D matroxfb_test_and_set_rounding(PMINFO xres, bpp);
 	}
-	if (!xres_new) return 0;
-	if (xres !=3D xres_new) {
-		printk(KERN_INFO "matroxfb: cannot set xres to %d, rounded up to %d\n", =
xres, xres_new);
-	}
 	return xres_new;
 }
=20



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
