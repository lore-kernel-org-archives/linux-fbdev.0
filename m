From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 19/22] uvesafb: add info about pmipal,
 yrap and ypan being available only on x86
Date: Mon, 13 Aug 2007 20:42:14 +0800
Message-ID: <46C051A6.9010404@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IKZNv-0004ut-9P for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:51:03 -0700
Received: from rv-out-0910.google.com ([209.85.198.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IKZLG-0005O6-Or
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Aug 2007 05:48:19 -0700
Received: by rv-out-0910.google.com with SMTP id k15so3930196rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Aug 2007 05:48:18 -0700 (PDT)
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
Cc: Michal Januszewski <spock@gentoo.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Michal Januszewski <spock@gentoo.org>

Features that use the Protected Mode Interface are available on x86 only.
Document this in the uvesafb description.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 Documentation/fb/uvesafb.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/fb/uvesafb.txt b/Documentation/fb/uvesafb.txt
index cfc4e55..bcfc233 100644
--- a/Documentation/fb/uvesafb.txt
+++ b/Documentation/fb/uvesafb.txt
@@ -59,11 +59,12 @@ Accepted options:
 ypan    Enable display panning using the VESA protected mode
         interface.  The visible screen is just a window of the
         video memory, console scrolling is done by changing the
-        start of the window.
+        start of the window.  Available on x86 only.
 
 ywrap   Same as ypan, but assumes your gfx board can wrap-around
         the video memory (i.e. starts reading from top if it
         reaches the end of video memory).  Faster than ypan.
+        Available on x86 only.
 
 redraw  Scroll by redrawing the affected part of the screen, this
         is the safe (and slow) default.
@@ -75,7 +76,7 @@ vgapal  Use the standard VGA registers f
 
 pmipal  Use the protected mode interface for palette changes.
         This is the default if the protected mode interface is
-        available.
+        available.  Available on x86 only.
 
 mtrr:n  Setup memory type range registers for the framebuffer
         where n:


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
