From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 04/11] pvr2fb: update
	Documentation/fb/pvr2fb.txt
Date: Wed, 01 Aug 2007 15:37:48 +0800
Message-ID: <46B0384C.4080403@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IG9Nb-0003FN-BO for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:27 -0700
Received: from rv-out-0910.google.com ([209.85.198.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IG9Nb-0000Mg-1H
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Aug 2007 01:16:27 -0700
Received: by rv-out-0910.google.com with SMTP id g11so308468rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 01 Aug 2007 01:16:26 -0700 (PDT)
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
To: Andrew Morton K <akpm@osdl.org>
Cc: Adrian McMenamin <adrian@mcmen.demon.co.uk>, Paul Mundt <lethal@linux-sh.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Adrian McMenamin <adrian@mcmen.demon.co.uk>

The current version is very old and does not correctly specify how to
set the video mode.

Signed-off by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 Documentation/fb/pvr2fb.txt |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/fb/pvr2fb.txt b/Documentation/fb/pvr2fb.txt
index 2bf6c23..36bdeff 100644
--- a/Documentation/fb/pvr2fb.txt
+++ b/Documentation/fb/pvr2fb.txt
@@ -9,14 +9,13 @@ one found in the Dreamcast.
 Advantages:
 
  * It provides a nice large console (128 cols + 48 lines with 1024x768)
-   without using tiny, unreadable fonts.
+   without using tiny, unreadable fonts (NOT on the Dreamcast)
  * You can run XF86_FBDev on top of /dev/fb0
  * Most important: boot logo :-)
 
 Disadvantages:
 
- * Driver is currently limited to the Dreamcast PowerVR 2 implementation
-   at the time of this writing.
+ * Driver is largely untested on non-Dreamcast systems.
 
 Configuration
 =============
@@ -29,11 +28,16 @@ Accepted options:
 font:X    - default font to use. All fonts are supported, including the
             SUN12x22 font which is very nice at high resolutions.
 
-mode:X    - default video mode. The following video modes are supported:
-            640x240-60, 640x480-60.
 	    
+mode:X    - default video mode with format [xres]x[yres]-<bpp>@<refresh rate>
+            The following video modes are supported:
+            640x640-16@60, 640x480-24@60, 640x480-32@60. The Dreamcast
+            defaults to 640x480-16@60. At the time of writing the
+            24bpp and 32bpp modes function poorly. Work to fix that is
+            ongoing
+
             Note: the 640x240 mode is currently broken, and should not be
-            used for any reason. It is only mentioned as a reference.
+            used for any reason. It is only mentioned here as a reference.
 
 inverse   - invert colors on screen (for LCD displays)
 
@@ -52,10 +56,10 @@ output:X  - output type. This can be any
 X11
 ===
 
-XF86_FBDev should work, in theory. At the time of this writing it is
-totally untested and may or may not even portray the beginnings of
-working. If you end up testing this, please let me know!
+XF86_FBDev has been shown to work on the Dreamcast in the past - though not yet
+on any 2.6 series kernel.
 
 --
 Paul Mundt <lethal@linuxdc.org>
+Updated by Adrian McMenamin <adrian@mcmen.demon.co.uk>
 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
