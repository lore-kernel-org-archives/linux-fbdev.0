From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 01/33] fbcon: Fix typo and bogus logic
	in get_default_font
Date: Thu, 26 Jul 2007 19:45:34 +0800
Message-ID: <46A8895E.8000505@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IE2s7-0000kG-FF for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:55:15 -0700
Received: from wa-out-1112.google.com ([209.85.146.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IE2s5-0007HM-3t
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 26 Jul 2007 05:55:15 -0700
Received: by wa-out-1112.google.com with SMTP id k22so613963waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 26 Jul 2007 05:55:12 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Reported in: Bugzilla Bug 8727

Fix typo and bogus logic in get_default_font(). The bug results in
get_default_font() returning a font that may not be displayed properly by a
framebuffer driver.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/fonts.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/console/fonts.c b/drivers/video/console/fonts.c
index a6828d0..96979c3 100644
--- a/drivers/video/console/fonts.c
+++ b/drivers/video/console/fonts.c
@@ -133,8 +133,8 @@ #endif
 	if ((yres < 400) == (f->height <= 8))
 	    c += 1000;
 
-	if (!(font_w & (1 << (f->width - 1))) ||
-	    !(font_w & (1 << (f->height - 1))))
+	if ((font_w & (1 << (f->width - 1))) &&
+	    (font_h & (1 << (f->height - 1))))
 	    c += 1000;
 
 	if (c > cc) {


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
