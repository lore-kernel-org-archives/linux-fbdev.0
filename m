From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: fix unitialized
	pseudo_palette
Date: Sun, 11 May 2008 14:25:40 +0200
Message-ID: <20080511142540.b7f867e1.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JvAcD-0004xj-MR for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 May 2008 05:25:21 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JvAcB-0007Rt-70
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 May 2008 05:25:21 -0700
Received: from poczta.interia.pl (mi01.poczta.interia.pl [10.217.12.1])
	by smtp239.poczta.interia.pl (INTERIA.PL) with ESMTP id 1129D31AE0E
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 11 May 2008 14:25:15 +0200 (CEST)
Received: from krzysio.net (host-87-99-61-239.lanet.net.pl [87.99.61.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id 2D135769825
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 11 May 2008 14:25:16 +0200 (CEST)
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

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Initialize the pseudo_palette pointer properly. This fixes crash
when 16bpp or 32bpp mode is selected.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
This is ugly regression introduced by one of my earlier patches.

diff -urp linux-2.6.25/drivers/video/tridentfb.c linux-new/drivers/video/tridentfb.c
--- linux-2.6.25/drivers/video/tridentfb.c	2008-05-11 03:33:29.830636688 +0200
+++ linux-new/drivers/video/tridentfb.c	2008-05-11 03:31:32.614634551 +0200
@@ -1350,7 +1350,7 @@ static int __devinit trident_pci_probe(s
 
 	info->fix = tridentfb_fix;
 	info->fbops = &tridentfb_ops;
-
+	info->pseudo_palette = default_par->pseudo_pal;
 
 	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 #ifdef CONFIG_FB_TRIDENT_ACCEL

----------------------------------------------------------------------
Sprawdz, czy jestes prawdziwym internauta!
Kliknij http://link.interia.pl/f1d6e


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
