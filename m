From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 25/33] sm501fb: Call fb suspend function
 during suspend and resume
Date: Thu, 26 Jul 2007 20:30:09 +0800
Message-ID: <46A893D1.5080604@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2vk-0001BN-LZ for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:59:00 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2vk-0000Ts-Ev
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:59:00 -0700
Received: by wa-out-1112.google.com with SMTP id k22so615223waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:58:59 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ben Dooks <ben-linux@fluff.org>

From: Ben Dooks <ben-linux@fluff.org>

Call the fb_set_suspend() over suspend and resume.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/sm501fb.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index fc0cdc8..d97edd7 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -28,6 +28,7 @@ #include <linux/workqueue.h>
 #include <linux/wait.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/console.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -1697,6 +1698,10 @@ static int sm501fb_suspend_fb(struct sm5
 	/* blank the relevant interface to ensure unit power minimised */
 	(par->ops.fb_blank)(FB_BLANK_POWERDOWN, fbi);
 
+	acquire_console_sem();
+	fb_set_suspend(fbi, 1);
+	release_console_sem();
+
 	return 0;
 
  err_nocursor:
@@ -1732,6 +1737,10 @@ static void sm501fb_resume_fb(struct sm5
 		memcpy_toio(par->cursor.k_addr, par->store_cursor,
 			    par->cursor.size);
 
+	acquire_console_sem();
+	fb_set_suspend(fbi, 0);
+	release_console_sem();
+
 	vfree(par->store_fb);
 	vfree(par->store_cursor);
 }


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
