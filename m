From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: improve probe function
Date: Fri, 9 May 2008 22:17:13 +0200
Message-ID: <20080509221713.a9e000a1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuZNs-00030g-Kb for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 13:40:04 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JuZNo-0005qZ-UV
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 May 2008 13:40:04 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: akpm@linux-foundation.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Add missing release of allocated fb_info structure and 
move enable_mmio() to fix error path.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

diff -urp linux-2.6.25/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-2.6.25/drivers/video/tridentfb.c	2008-05-09 08:28:00.742612723 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-09 18:54:29.494355715 +0200
@@ -1287,6 +1291,7 @@ static int __devinit trident_pci_probe(s
 
 	if (!request_mem_region(tridentfb_fix.mmio_start, tridentfb_fix.mmio_len, "tridentfb")) {
 		debug("request_region failed!\n");
+		framebuffer_release(info);
 		return -1;
 	}
 
@@ -1299,8 +1304,6 @@ static int __devinit trident_pci_probe(s
 		goto out_unmap1;
 	}
 
-	enable_mmio();
-
 	/* setup framebuffer memory */
 	tridentfb_fix.smem_start = pci_resource_start(dev, 0);
 	tridentfb_fix.smem_len = get_memsize(default_par);
@@ -1312,6 +1315,8 @@ static int __devinit trident_pci_probe(s
 		goto out_unmap1;
 	}
 
+	enable_mmio();
+
 	info->screen_base = ioremap_nocache(tridentfb_fix.smem_start,
 					    tridentfb_fix.smem_len);
 

----------------------------------------------------------------------
Poprowadz swoj klub do zwyciestwa!
Sprawdz >>> http://link.interia.pl/f1d76


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
