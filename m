From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] pm2fb: lowsyncs section mismatch fix
Date: Fri, 10 Aug 2007 21:44:07 +0200
Message-ID: <20070810214407.34639217.krzysztof.h1@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJaKu-0007i3-3S for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 12:39:56 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IJaKs-0003fp-N9
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 10 Aug 2007 12:39:52 -0700
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
Cc: linux-fbdev-devel@lists.sourceforge.net

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes sections mismatch in pm2fb found in the -mm tree.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- linux-2.6.22.new/drivers/video/pm2fb.c	2007-08-10 21:19:55.436496086 +0200
+++ linux-2.6.23/drivers/video/pm2fb.c	2007-08-10 21:38:58.061610582 +0200
@@ -77,8 +78,8 @@ static char *mode __devinitdata;
  * these flags allow the user to specify that requests for +ve sync
  * should be silently turned in -ve sync.
  */
-static int lowhsync __devinitdata;
-static int lowvsync __devinitdata;
+static int lowhsync;
+static int lowvsync;
 static int noaccel __devinitdata;
 /* mtrr option */
 #ifdef CONFIG_MTRR

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
