From: mathijs@mmohlmann.demon.nl (Mathijs Mohlmann)
Subject: [trivial] timer initialization
Date: Tue, 26 Nov 2002 20:51:41 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021126195141.GA26539@mmohlmann.demon.nl>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mmohlmann.demon.nl ([212.238.27.16] helo=brand.mmohlmann.demon.nl)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Glpz-0003M9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 26 Nov 2002 11:57:40 -0800
Received: from heineken (heineken.mmohlmann.demon.nl [192.168.1.4])
	by brand.mmohlmann.demon.nl (Postfix) with ESMTP id 46579A6F3
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 26 Nov 2002 20:57:34 +0100 (MET)
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net


	hi,

The following is against 2.5 current and fixes an timer
warning I'm getting during boot.

	Mathijs

diff -Nru a/drivers/video/fbcon.c b/drivers/video/fbcon.c
--- a/drivers/video/fbcon.c	Wed Nov 27 10:42:53 2002
+++ b/drivers/video/fbcon.c	Wed Nov 27 10:42:54 2002
@@ -230,9 +230,8 @@
 
 static void cursor_timer_handler(unsigned long dev_addr);
 
-static struct timer_list cursor_timer = {
-    function: cursor_timer_handler
-};
+static struct timer_list cursor_timer = 
+      TIMER_INITIALIZER(cursor_timer_handler, 0, 0);
 
 static void cursor_timer_handler(unsigned long dev_addr)
 {


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
