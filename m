From: syrjala@sci.fi
Subject: [patch 5/9] atyfb: Remove pointless aty_init()
	argument
Date: Mon, 04 Sep 2006 01:06:52 +0300
Message-ID: <20060903220702.367122502@proteus.korsu.shacknet.nu>
References: <20060903220646.894202994@proteus.korsu.shacknet.nu>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============1477616203=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GK00v-0008RE-F2 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 03 Sep 2006 15:00:25 -0700
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GK00v-0004qS-9V
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

--===============1477616203==
Content-Disposition: inline;
	filename=atyfb_remove_pointless_aty_init_argument.patch

The 'name' argument of aty_init() is pointless because the bus type can
be queried from the hardware.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---

 drivers/video/aty/atyfb_base.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/video/aty/atyfb_base.c
+++ linux-2.6.18-rc4/drivers/video/aty/atyfb_base.c
@@ -249,7 +249,7 @@ static int atyfb_sync(struct fb_info *in
      *  Internal routines
      */
 
-static int aty_init(struct fb_info *info, const char *name);
+static int aty_init(struct fb_info *info);
 #ifdef CONFIG_ATARI
 static int store_video_par(char *videopar, unsigned char m64_num);
 #endif
@@ -2340,7 +2340,7 @@ static int __devinit atyfb_get_timings_f
 }
 #endif /* defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD) */
 
-static int __devinit aty_init(struct fb_info *info, const char *name)
+static int __devinit aty_init(struct fb_info *info)
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	const char *ramname = NULL, *xtal;
@@ -2744,7 +2744,7 @@ static int __devinit aty_init(struct fb_
 	fb_list = info;
 
 	PRINTKI("fb%d: %s frame buffer device on %s\n",
-	       info->node, info->fix.id, name);
+		info->node, info->fix.id, par->bus_type == ISA ? "ISA" : "PCI");
 	return 0;
 
 aty_init_exit:
@@ -3589,7 +3589,7 @@ static int __devinit atyfb_pci_probe(str
 	pci_set_drvdata(pdev, info);
 
 	/* Init chip & register framebuffer */
-	if (aty_init(info, "PCI"))
+	if (aty_init(info))
 		goto err_release_io;
 
 #ifdef __sparc__
@@ -3689,7 +3689,7 @@ static int __devinit atyfb_atari_probe(v
 			break;
 		}
 
-		if (aty_init(info, "ISA bus")) {
+		if (aty_init(info)) {
 			framebuffer_release(info);
 			/* This is insufficient! kernel_map has added two large chunks!! */
 			return -ENXIO;

-- 
Ville Syrj������l������
syrjala@sci.fi
http://www.sci.fi/~syrjala/


--===============1477616203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1477616203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============1477616203==--
