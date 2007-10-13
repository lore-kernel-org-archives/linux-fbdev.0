From: Antonino Daplas <adaplas@gmail.com>
Subject: [PATCH 03/15] ps3fb: Clean up includes
Date: Sat, 13 Oct 2007 08:23:47 +0800
Message-ID: <47101013.6050100@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgUxp-0005IH-JM for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:34:45 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgUxp-0002xt-CJ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:34:45 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3588679rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 12 Oct 2007 17:34:45 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Clean up includes

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/ps3fb.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/drivers/video/ps3fb.c b/drivers/video/ps3fb.c
index 49069db..74de53a 100644
--- a/drivers/video/ps3fb.c
+++ b/drivers/video/ps3fb.c
@@ -22,22 +22,14 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
-#include <linux/slab.h>
-#include <linux/vmalloc.h>
-#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/console.h>
 #include <linux/ioctl.h>
-#include <linux/notifier.h>
-#include <linux/reboot.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
-
-#include <linux/uaccess.h>
 #include <linux/fb.h>
 #include <linux/init.h>
-#include <asm/time.h>
+#include <linux/uaccess.h>
 
 #include <asm/abs_addr.h>
 #include <asm/lv1call.h>


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
