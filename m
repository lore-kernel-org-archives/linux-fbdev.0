From: syrjala@sci.fi
Subject: [patch 4/9] atyfb: Fix blanking level
	transitions
Date: Mon, 04 Sep 2006 01:06:51 +0300
Message-ID: <20060903220701.269355173@proteus.korsu.shacknet.nu>
References: <20060903220646.894202994@proteus.korsu.shacknet.nu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1380067247=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GK00v-0008RG-Gf for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 15:00:25 -0700
Received: from smtp3.pp.htv.fi ([213.243.153.36])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GK00u-0004qH-Hv
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 15:00:25 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: alex.kern@gmx.de, Ville Syrjala <syrjala@sci.fi>

--===============1380067247==
Content-Disposition: inline;
	filename=atyfb_fix_blanking_level_transitions.patch

Fix a minor problem in blanking level transitions. Reducing the blanking level
gradually was impossible.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 drivers/video/aty/atyfb_base.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
@@ -2821,9 +2821,9 @@ static int atyfb_blank(int blank, struct
 #endif
 
 	gen_cntl = aty_ld_le32(CRTC_GEN_CNTL, par);
+	gen_cntl &= ~0x400004c;
 	switch (blank) {
-        	case FB_BLANK_UNBLANK:
-			gen_cntl &= ~0x400004c;
+		case FB_BLANK_UNBLANK:
 			break;
 		case FB_BLANK_NORMAL:
 			gen_cntl |= 0x4000040;

-- 
Ville Syrj������l������
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============1380067247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1380067247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1380067247==--
