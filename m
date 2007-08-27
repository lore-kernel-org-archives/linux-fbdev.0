From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] cirrusfb: checkpatch.pl cleanup PPC fix
Date: Mon, 27 Aug 2007 19:37:35 +0200
Message-ID: <20070827193735.290dfc84.krzysztof.h1@wp.pl>
References: <46D18888.10902@gmail.com>
	<Pine.LNX.4.64.0708270913170.19656@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPiRX-0000T4-Li for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 10:32:03 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IPiRU-0002ka-Vv
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Aug 2007 10:32:03 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	27 Aug 2007 19:31:52 +0200
In-Reply-To: <Pine.LNX.4.64.0708270913170.19656@anakin>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Whitcroft <apw@shadowen.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes the error spotted by Geert Uytterhoeven
in the "cirrusfb: checkpatch.pl cleanup" patch.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-sparc/drivers/video/cirrusfb.c	2007-08-27 19:32:30.632860728 +0200
+++ linux-2.6.23/drivers/video/cirrusfb.c	2007-08-27 19:31:29.137356299 +0200
@@ -58,7 +58,7 @@
 #endif
 #ifdef CONFIG_PPC_PREP
 #include <asm/machdep.h>
-#define isPReP(machine_is(prep))
+#define isPReP machine_is(prep)
 #else
 #define isPReP 0
 #endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
