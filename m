From: syrjala@sci.fi
Subject: [PATCH 03/10] atyfb: Fix CRTC_FIFO_LWM mask
Date: Fri,  9 Dec 2005 02:44:27 +0200 (EET)
Message-ID: <20051209004427.A63AF1F8@kuori.saunalahti.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EkWNI-0004vk-4R
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 08 Dec 2005 16:44:36 -0800
Received: from gw01.mail.saunalahti.fi ([195.197.172.115])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EkWNG-0004lP-RI
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

CRTC_FIFO_LWM was incorrectly masked.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
---

 atyfb_base.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff -urpN linux-2/drivers/video/aty/atyfb_base.c linux-3/drivers/video/aty=
/atyfb_base.c
--- linux-2/drivers/video/aty/atyfb_base.c	2005-12-09 02:43:28.000000000 +0=
200
+++ linux-3/drivers/video/aty/atyfb_base.c	2005-12-09 02:51:32.000000000 +0=
200
@@ -1077,9 +1077,8 @@ static int aty_var_to_crtc(const struct=20
 #endif /* CONFIG_FB_ATY_GENERIC_LCD */
=20
 	if (M64_HAS(MAGIC_FIFO)) {
-		/* Not VTB/GTB */
-		/* FIXME: magic FIFO values */
-		crtc->gen_cntl |=3D (aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC2_PIX_WIDTH);
+		/* FIXME: display FIFO low watermark values */
+		crtc->gen_cntl |=3D (aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_FIFO_LWM);
 	}
 	crtc->dp_pix_width =3D dp_pix_width;
 	crtc->dp_chain_mask =3D dp_chain_mask;



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
