From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH 4/7] uvesafb: add info about pmipal,
	yrap and ypan being	available only on x86
Date: Sat, 11 Aug 2007 16:40:50 +0200
Message-ID: <20070811144050.GE13632@spock.one.pl>
Reply-To: spock@gentoo.org, linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IJs9T-0005aL-OI for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Aug 2007 07:41:16 -0700
Received: from ipn26-148.piekary.net ([83.238.26.148] helo=spock.one.pl)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IJs9S-00048i-B5
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Aug 2007 07:41:15 -0700
Content-Disposition: inline
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
Cc: linux-kernel@vger.kernel.org

Features that use the Protected Mode Interface are available on x86 only.
Document this in the uvesafb description.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/Documentation/fb/uvesafb.txt b/Documentation/fb/uvesafb.txt
index cfc4e55..1a3b65b 100644
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
@@ -75,7 +76,7 @@ vgapal  Use the standard VGA registers for palette changes.
 
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
