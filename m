From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] tdfxfb: replace busy waiting with
	cpu_relax
Date: Wed, 5 Sep 2007 22:02:08 +0200
Message-ID: <20070905220208.5b29cd08.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IT0yY-0001eD-Jb for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Sep 2007 12:55:46 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IT0yX-0005aC-BW
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 05 Sep 2007 12:55:46 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO krzysio.net)
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>; 5 Sep 2007 21:55:41 +0200
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

This patch replaces busy waiting with cpu_relax() call.
This makes scrolling faster.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
The scrolling is 5% faster on Voodoo3 2000 and 333MHz CPU.

The patch is done against 2.6.23-rc4-mm1 tree.

--- linux-2.6.22.old/drivers/video/tdfxfb.c	2007-09-05 21:03:56.000000000 +0200
+++ linux-2.6.22/drivers/video/tdfxfb.c	2007-09-05 21:40:53.000000000 +0200
@@ -273,7 +273,8 @@ static inline void banshee_make_room(str
 {
 	/* Note: The Voodoo3's onboard FIFO has 32 slots. This loop
 	 * won't quit if you ask for more. */
- 	while ((tdfx_inl(par, STATUS) & 0x1f) < size - 1) ;
+	while ((tdfx_inl(par, STATUS) & 0x1f) < size - 1)
+		cpu_relax();
 }
  
 static int banshee_wait_idle(struct fb_info *info)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
