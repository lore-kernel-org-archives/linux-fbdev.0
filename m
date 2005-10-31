From: syrjala@sci.fi
Subject: [PATCH 5/5] matroxfb: Set maxhipri to 0
Date: Tue,  1 Nov 2005 00:12:20 +0200 (EET)
Message-ID: <20051031221220.CD1A831A@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWhtH-0004Ry-Cb
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Oct 2005 14:12:31 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EWhtG-0005aw-Jc
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 31 Oct 2005 14:12:31 -0800
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

The current init code sets hiprilvl to 0 and maxhipri to 5. According to=20
the specs those values are illegal on both G200 and G400. It also causes=20
distortions on the TV-out at least when CRTC2 is in YUV mode as is the=20
case with DirectFB. This patch resets both values to 0.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 matroxfb_DAC1064.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -uprN linux-2.6.14-4/drivers/video/matrox/matroxfb_DAC1064.c linux-2.6=
.14-5/drivers/video/matrox/matroxfb_DAC1064.c
--- linux-2.6.14-4/drivers/video/matrox/matroxfb_DAC1064.c	2005-10-31 19:41=
:30.000000000 +0200
+++ linux-2.6.14-5/drivers/video/matrox/matroxfb_DAC1064.c	2005-10-31 22:10=
:22.000000000 +0200
@@ -978,7 +978,7 @@ static void MGAG100_reset(WPMINFO2) {
 				hw->MXoptionReg |=3D 0x40;	/* FIXME... */
 				pci_write_config_dword(ACCESS_FBINFO(pcidev), PCI_OPTION_REG, hw->MXop=
tionReg);
 			}
-			mga_setr(M_EXTVGA_INDEX, 0x06, 0x50);
+			mga_setr(M_EXTVGA_INDEX, 0x06, 0x00);
 		}
 	}
 	if (ACCESS_FBINFO(devflags.g450dac)) {



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
