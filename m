From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] pm2fb: free cmap memory on module remove
Date: Tue, 19 Aug 2008 21:45:25 +0200
Message-ID: <20080819214525.49643cde.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVXOW-0000h7-Cp for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 13:01:32 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KVXOU-0004js-Ry
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 13:01:32 -0700
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
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Release cmap memory allocated in the probe function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-ref/drivers/video/pm2fb.c linux-2.6/drivers/video/pm2fb.c
--- linux-ref/drivers/video/pm2fb.c	2008-08-09 05:09:05.000000000 +0200
+++ linux-2.6/drivers/video/pm2fb.c	2008-08-20 20:58:14.000000000 +0200
@@ -1746,6 +1746,7 @@ static void __devexit pm2fb_remove(struc
 	release_mem_region(fix->mmio_start, fix->mmio_len);
 
 	pci_set_drvdata(pdev, NULL);
+	fb_dealloc_cmap(&info->cmap);
 	kfree(info->pixmap.addr);
 	kfree(info);
 }

----------------------------------------------------------------------
Wygraj laptopa lub iPoda! Wez udzial w igrzyskach!
Kliknij >>> http://link.interia.pl/f1eda 





-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
