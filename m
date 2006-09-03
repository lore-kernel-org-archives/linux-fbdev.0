From: syrjala@sci.fi
Subject: [patch 1/9] atyfb: Remove FIXME
Date: Mon, 04 Sep 2006 01:06:48 +0300
Message-ID: <20060903220646.894202994@proteus.korsu.shacknet.nu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1552896508=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GK00v-0008RC-9x for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 15:00:25 -0700
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GK00t-0004pb-AU
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

--===============1552896508==
Content-Disposition: inline; filename=atyfb_remove_fixme.patch

atyfb has used the auxiliary register aperture for a long time.
Remove a related FIXME which was accidentally left in.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 drivers/video/aty/atyfb_base.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
@@ -2600,9 +2600,8 @@ static int __devinit aty_init(struct fb_
 		par->pll_ops->init_pll(info, &par->pll);
 
 	/*
-	 *  Last page of 8 MB (4 MB on ISA) aperture is MMIO
-	 *  FIXME: we should use the auxiliary aperture instead so we can access
-	 *  the full 8 MB of video RAM on 8 MB boards
+	 *  Last page of 8 MB (4 MB on ISA) aperture is MMIO,
+	 *  unless the auxiliary register aperture is used.
 	 */
 
 	if (!par->aux_start &&

-- 
Ville Syrj������l������
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============1552896508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1552896508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1552896508==--
