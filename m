From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: removal of pm2fb_par fields
Date: Wed, 02 May 2007 21:39:17 +0200
Message-ID: <4638e8e5cd83c@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HjKfc-0004rk-PF for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 12:39:24 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1HjKfZ-0007KY-VB
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 02 May 2007 12:39:24 -0700
Received: from poczta-1.free.wp-sa.pl (HELO localhost) ([10.1.1.170])
	(envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 2 May 2007 21:39:17 +0200
Content-Disposition: inline
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
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch removes two redudant fields in the pm2fb_par =

structure.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

This is a patch against mm tree with already sent pm2fb patches =

applied.

Regards,
Krzysztof

--- linux-2.6.21.orig/drivers/video/pm2fb.c	2007-05-01 11:38:
55.000000000 +0200
+++ linux-2.6.21/drivers/video/pm2fb.c	2007-05-02 21:14:25.
000000000 +0200
@@ -81,8 +81,6 @@ static int lowvsync;
 struct pm2fb_par
 {
 	pm2type_t	type;		/* Board type */
-	u32		fb_size;	/* framebuffer memory size */
-	unsigned char	__iomem *v_fb;  /* virtual address of =

frame buffer */
 	unsigned char	__iomem *v_regs;/* virtual address of =

p_regs */
 	u32 	   	memclock;	/* memclock */
 	u32		video;		/* video flags before blanking */
@@ -1169,20 +1167,20 @@ static int __devinit pm2fb_probe(struct =

 	/* Now work out how big lfb is going to be. */
 	switch(default_par->mem_config & PM2F_MEM_CONFIG_RAM_MASK) =

{
 	case PM2F_MEM_BANKS_1:
-		default_par->fb_size=3D0x200000;
+		pm2fb_fix.smem_len=3D0x200000;
 		break;
 	case PM2F_MEM_BANKS_2:
-		default_par->fb_size=3D0x400000;
+		pm2fb_fix.smem_len=3D0x400000;
 		break;
 	case PM2F_MEM_BANKS_3:
-		default_par->fb_size=3D0x600000;
+		pm2fb_fix.smem_len=3D0x600000;
 		break;
 	case PM2F_MEM_BANKS_4:
-		default_par->fb_size=3D0x800000;
+		pm2fb_fix.smem_len=3D0x800000;
 		break;
 	}
 	pm2fb_fix.smem_start =3D pci_resource_start(pdev, 1);
-	pm2fb_fix.smem_len =3D default_par->fb_size;
+	pm2fb_fix.smem_len =3D pm2fb_fix.smem_len;
 =

 	/* Linear frame buffer - request region and map it. */
 	if ( !request_mem_region(pm2fb_fix.smem_start, pm2fb_fix.
smem_len,
@@ -1190,9 +1188,9 @@ static int __devinit pm2fb_probe(struct =

 		printk(KERN_WARNING "pm2fb: Can't reserve smem.\n");
 		goto err_exit_mmio;
 	}
-	info->screen_base =3D default_par->v_fb =3D
+	info->screen_base =3D
 		ioremap_nocache(pm2fb_fix.smem_start, pm2fb_fix.
smem_len);
-	if ( !default_par->v_fb ) {
+	if ( !info->screen_base ) {
 		printk(KERN_WARNING "pm2fb: Can't ioremap smem area.\n")
;
 		release_mem_region(pm2fb_fix.smem_start, pm2fb_fix.
smem_len);
 		goto err_exit_mmio;
@@ -1218,7 +1216,7 @@ static int __devinit pm2fb_probe(struct =

 		goto err_exit_both;
 =

 	printk(KERN_INFO "fb%d: %s frame buffer device, memory =3D %
dK.\n",
-	       info->node, info->fix.id, default_par->fb_size / 1024)
;
+	       info->node, info->fix.id, pm2fb_fix.smem_len / 1024);
 =

 	/*
 	 * Our driver data


----------------------------------------------------
P.S.
Masz bardzo du=BFe szanse, aby wygra=E6 nawet kilka z 1200 nagr=F3d!
Kino domowe, kamery cyfrowe, internetowe, filmy DVD... Kliknij:
http://klik.wp.pl/?adr=3Dwww.poczta.wp.pl%2Fkonkursintro.html&sid=3D1123



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
