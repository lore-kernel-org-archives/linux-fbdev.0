From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] s3c2410fb: fix incorrect argument type
	in resume function
Date: Fri, 11 Jan 2008 22:29:58 +0100
Message-ID: <20080111222958.3478d5db.krzysztof.h1@poczta.fm>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JDRes-0005aN-1l for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 13:43:22 -0800
Received: from smtp35.poczta.interia.pl ([80.48.65.35]
	helo=smtp4.poczta.interia.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JDReq-0005IU-Hl
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 11 Jan 2008 13:43:22 -0800
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Ben Dooks <ben-linux-arm@fluff.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes wrong pointer type passed into
the s3c2410fb_init_registers() function.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
The kernel may crash on resume of display
as the pointer used for registers restoration is wrong.


diff -urp linux-ref/drivers/video/s3c2410fb.c linux-new/drivers/video/s3c2410fb.c
--- linux-ref/drivers/video/s3c2410fb.c	2007-10-18 22:32:51.353010872 +0200
+++ linux-new/drivers/video/s3c2410fb.c	2007-10-18 22:35:25.141774794 +0200
@@ -1026,7 +1026,7 @@ static int s3c2410fb_resume(struct platf
 	clk_enable(info->clk);
 	msleep(1);
 
-	s3c2410fb_init_registers(info);
+	s3c2410fb_init_registers(fbinfo);
 
 	return 0;
 }


----------------------------------------------------------------------
Stworz najlepsza modelke na swiecie!
Sprawdz >>> http://link.interia.pl/f1cc4


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
