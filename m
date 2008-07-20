From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH]: tridentfb: remove warning message that
 cyblafb driver should be used
Date: Sun, 20 Jul 2008 08:45:58 +0200
Message-ID: <20080720084558.cfa4854c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKSvt-0001FK-0L for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 00:02:13 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KKSvq-0007Bd-GI
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 00:02:12 -0700
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

The tridentfb driver should handle now all chipsets
handled by the cyblafb driver. Remove the message
which claims that support will be removed.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

I would like to see this patch in the 2.6.27 along other
tridentfb patches to help with testing the new tridentfb
driver on more chipsets. It is also a step toward removing
the cyblafb driver which will be replaced by more generic
the tridentfb.

--- linux-mm/drivers/video/tridentfb.c.orig	2008-07-20 07:38:31.654411754 +0200
+++ linux-mm/drivers/video/tridentfb.c	2008-07-20 07:38:49.494412410 +0200
@@ -1359,10 +1359,6 @@ static int __devinit trident_pci_probe(s
 
 	chip_id = id->device;
 
-	if (chip_id == CYBERBLADEi1)
-		output("*** Please do use cyblafb, Cyberblade/i1 support "
-		       "will soon be removed from tridentfb!\n");
-
 #ifndef CONFIG_FB_TRIDENT_ACCEL
 	noaccel = 1;
 #endif

----------------------------------------------------------------------
Partyjka w Chinczyka?
Graj >>> http://link.interia.pl/f1e67


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
