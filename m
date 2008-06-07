From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: hgafb: resource management fix
Date: Sun, 8 Jun 2008 00:06:12 +0200
Message-ID: <20080608000612.87685b5b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K56Vj-0004OH-EJ for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 15:03:43 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K56Vh-0002Vd-TV
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 07 Jun 2008 15:03:43 -0700
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

Release ports which are requested during detection
which are not freed if there is no hga card.
Otherwise there is a crash during cat /proc/ioports command. 

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

--- linux-rc2/drivers/video/hgafb.c	2008-06-02 20:09:20.139779110 +0200
+++ linux-new/drivers/video/hgafb.c	2008-06-02 20:01:45.030230800 +0200
@@ -279,7 +279,7 @@ static void hga_blank(int blank_mode)
 
 static int __init hga_card_detect(void)
 {
-	int count=0;
+	int count = 0;
 	void __iomem *p, *q;
 	unsigned short p_save, q_save;
 
@@ -303,20 +303,18 @@ static int __init hga_card_detect(void)
 	writew(0x55aa, p); if (readw(p) == 0x55aa) count++;
 	writew(p_save, p);
 
-	if (count != 2) {
-		return 0;
-	}
+	if (count != 2)
+		goto error;
 
 	/* Ok, there is definitely a card registering at the correct
 	 * memory location, so now we do an I/O port test.
 	 */
 	
-	if (!test_hga_b(0x66, 0x0f)) {	    /* cursor low register */
-		return 0;
-	}
-	if (!test_hga_b(0x99, 0x0f)) {     /* cursor low register */
-		return 0;
-	}
+	if (!test_hga_b(0x66, 0x0f))	    /* cursor low register */
+		goto error;
+
+	if (!test_hga_b(0x99, 0x0f))     /* cursor low register */
+		goto error;
 
 	/* See if the card is a Hercules, by checking whether the vsync
 	 * bit of the status register is changing.  This test lasts for
@@ -331,7 +329,7 @@ static int __init hga_card_detect(void)
 	}
 
 	if (p_save == q_save) 
-		return 0;
+		goto error;
 
 	switch (inb_p(HGA_STATUS_PORT) & 0x70) {
 		case 0x10:
@@ -348,6 +346,12 @@ static int __init hga_card_detect(void)
 			break;
 	}
 	return 1;
+error:
+	if (release_io_ports)
+		release_region(0x3b0, 12);
+	if (release_io_port)
+		release_region(0x3bf, 1);
+	return 0;
 }
 
 /**

---------------------------------------------------------------
Sprawdz jak zdobyc zdrowy usmiech!
Kliknij >> http://link.interia.pl/f1e26


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
