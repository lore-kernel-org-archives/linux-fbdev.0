From: akpm@osdl.org
Subject: [patch 21/25] atyfb: Remove pointless
	aty_init() argument
Date: Wed, 01 Nov 2006 21:50:31 -0800
Message-ID: <200611020550.kA25oWvA002351@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GfVUO-0007g5-UD for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:51:44 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GfVUN-0000Hf-Jd
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Nov 2006 21:51:43 -0800
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
Cc: akpm@osdl.org, adaplas@pol.net, syrjala@sci.fi

From: Ville Syrjala <syrjala@sci.fi>

The 'name' argument of aty_init() is pointless because the bus type can be
queried from the hardware.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/aty/atyfb_base.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff -puN drivers/video/aty/atyfb_base.c~atyfb-remove-pointless-aty_init drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c~atyfb-remove-pointless-aty_init
+++ a/drivers/video/aty/atyfb_base.c
@@ -249,7 +249,7 @@ static int atyfb_sync(struct fb_info *in
      *  Internal routines
      */
 
-static int aty_init(struct fb_info *info, const char *name);
+static int aty_init(struct fb_info *info);
 #ifdef CONFIG_ATARI
 static int store_video_par(char *videopar, unsigned char m64_num);
 #endif
@@ -2344,7 +2344,7 @@ static int __devinit atyfb_get_timings_f
 }
 #endif /* defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD) */
 
-static int __devinit aty_init(struct fb_info *info, const char *name)
+static int __devinit aty_init(struct fb_info *info)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	const char *ramname = NULL, *xtal;
@@ -2748,7 +2748,7 @@ static int __devinit aty_init(struct fb_
 	fb_list = info;
 
 	PRINTKI("fb%d: %s frame buffer device on %s\n",
-	       info->node, info->fix.id, name);
+		info->node, info->fix.id, par->bus_type == ISA ? "ISA" : "PCI");
 	return 0;
 
 aty_init_exit:
@@ -3597,7 +3597,7 @@ static int __devinit atyfb_pci_probe(str
 	pci_set_drvdata(pdev, info);
 
 	/* Init chip & register framebuffer */
-	if (aty_init(info, "PCI"))
+	if (aty_init(info))
 		goto err_release_io;
 
 #ifdef __sparc__
@@ -3697,7 +3697,7 @@ static int __devinit atyfb_atari_probe(v
 			break;
 		}
 
-		if (aty_init(info, "ISA bus")) {
+		if (aty_init(info)) {
 			if (info->screen_base)
 				iounmap(info->screen_base);
 			if (par->ati_regbase)
_

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
