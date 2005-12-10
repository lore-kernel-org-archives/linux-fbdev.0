From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 10/18] atyfb: Fix CRTC_FIFO_LWM mask
Date: Sat, 10 Dec 2005 14:12:00 +0800
Message-ID: <439A71B0.7080809@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eky5N-0002qC-89
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:19:57 -0800
Received: from zproxy.gmail.com ([64.233.162.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1Eky5K-0004fR-Vi
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 09 Dec 2005 22:19:57 -0800
Received: by zproxy.gmail.com with SMTP id r28so1047089nza
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 09 Dec 2005 22:19:54 -0800 (PST)
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

CRTC_FIFO_LWM was incorrectly masked.

Signed-off-by: Ville Syrj=E4l=E4 <syrjala@sci.fi>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_bas=
e.c
index fcb252f..785829c 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -1077,9 +1077,8 @@ static int aty_var_to_crtc(const struct=20
 #endif /* CONFIG_FB_ATY_GENERIC_LCD */
=20
 	if (M64_HAS(MAGIC_FIFO)) {
-		/* Not VTB/GTB */
-		/* FIXME: magic FIFO values */
-		crtc->gen_cntl |=3D (aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC2_PIX_WIDTH=
);
+		/* FIXME: display FIFO low watermark values */
+		crtc->gen_cntl |=3D (aty_ld_le32(CRTC_GEN_CNTL, par) & CRTC_FIFO_LWM);
 	}
 	crtc->dp_pix_width =3D dp_pix_width;
 	crtc->dp_chain_mask =3D dp_chain_mask;




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
