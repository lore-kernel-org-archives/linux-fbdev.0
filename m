From: Michal Januszewski <spock@gentoo.org>
Subject: [PATCH] uvesafb: documentation update
Date: Mon, 30 Mar 2009 23:53:18 +0200
Message-ID: <20090330215318.GB6540@spock.one.pl>
Reply-To: spock@gentoo.org
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758609AbZC3Vxk@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>

Update the uvesafb documentation to accurately reflect the default
options used by the driver.

Signed-off-by: Michal Januszewski <spock@gentoo.org>
---
diff --git a/Documentation/fb/uvesafb.txt b/Documentation/fb/uvesafb.txt
index 7ac3c40..a254920 100644
--- a/Documentation/fb/uvesafb.txt
+++ b/Documentation/fb/uvesafb.txt
@@ -59,7 +59,8 @@ Accepted options:
 ypan    Enable display panning using the VESA protected mode
         interface.  The visible screen is just a window of the
         video memory, console scrolling is done by changing the
-        start of the window.  Available on x86 only.
+        start of the window.  This option is available on x86
+        only and is the default option on that architecture.
 
 ywrap   Same as ypan, but assumes your gfx board can wrap-around
         the video memory (i.e. starts reading from top if it
@@ -67,7 +68,7 @@ ywrap   Same as ypan, but assumes your gfx board can wrap-around
         Available on x86 only.
 
 redraw  Scroll by redrawing the affected part of the screen, this
-        is the safe (and slow) default.
+        is the default on non-x86.
 
 (If you're using uvesafb as a module, the above three options are
  used a parameter of the scroll option, e.g. scroll=ypan.)
@@ -182,7 +183,7 @@ from the Video BIOS if you set pixclock to 0 in fb_var_screeninfo.
 
 --
  Michal Januszewski <spock@gentoo.org>
- Last updated: 2007-06-16
+ Last updated: 2009-03-30
 
  Documentation of the uvesafb options is loosely based on vesafb.txt.
 
