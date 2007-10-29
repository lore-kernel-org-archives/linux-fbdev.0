From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] gbefb: fix section mismatch warnings
Date: Mon, 29 Oct 2007 11:19:36 -0700
Message-ID: <20071029111936.7232eadb.rdunlap@xenotime.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ImZDC-0008Qo-BU for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Oct 2007 11:19:42 -0700
Received: from xenotime.net ([66.160.160.81])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1ImZDA-0000RC-QY
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 29 Oct 2007 11:19:42 -0700
Received: from midway.site ([71.117.233.180]) by xenotime.net for
	<linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 29 Oct 2007 11:19:36 -0700
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
Cc: vivien.chappelier@linux-mips.org, akpm <akpm@linux-foundation.org>, adaplas@gmail.com

From: Randy Dunlap <randy.dunlap@oracle.com>

Make 'default_mode' and 'default_var' be __initdata.
Fixes these section warnings:

WARNING: vmlinux.o(.data+0x128e0): Section mismatch: reference to .init.data:default_mode_CRT (between 'default_mode' and 'default_var')
WARNING: vmlinux.o(.data+0x128e4): Section mismatch: reference to .init.data:default_var_CRT (between 'default_var' and 'dev_attr_size')

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/video/gbefb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.24-rc1-git4.orig/drivers/video/gbefb.c
+++ linux-2.6.24-rc1-git4/drivers/video/gbefb.c
@@ -183,8 +183,8 @@ static struct fb_videomode default_mode_
 	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-struct fb_videomode *default_mode = &default_mode_CRT;
-struct fb_var_screeninfo *default_var = &default_var_CRT;
+struct fb_videomode *default_mode __initdata = &default_mode_CRT;
+struct fb_var_screeninfo *default_var __initdata = &default_var_CRT;
 
 static int flat_panel_enabled = 0;
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
