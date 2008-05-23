From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] tridentfb: documentation update
Date: Fri, 23 May 2008 09:43:47 +0200
Message-ID: <20080523094347.7d6206d6.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JzRui-0005HV-Hf for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 May 2008 00:42:08 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JzRug-0002IN-KX
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 23 May 2008 00:42:08 -0700
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Make the tridentfb documentation closer to current state
of the tridentfb driver.
Fix also some formatting.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>


diff -urp linux-2.6.25/Documentation/fb/tridentfb.txt linux-new/Documentation/fb/tridentfb.txt
--- linux-2.6.25/Documentation/fb/tridentfb.txt	2008-04-17 04:49:44.000000000 +0200
+++ linux-new/Documentation/fb/tridentfb.txt	2008-05-23 09:42:45.728334920 +0200
@@ -3,11 +3,25 @@ Tridentfb is a framebuffer driver for so
 The following list of chips is thought to be supported although not all are
 tested:
 
-those from the Image series with Cyber in their names - accelerated
-those with Blade in their names (Blade3D,CyberBlade...) - accelerated
-the newer CyberBladeXP family  - nonaccelerated
-
-Only PCI/AGP based cards are supported, none of the older Tridents.
+those from the TGUI series 9440/96XX and with Cyber in their names
+those from the Image series and with Cyber in their names
+those with Blade in their names (Blade3D,CyberBlade...)
+the newer CyberBladeXP family
+
+All families are accelerated. Only PCI/AGP based cards are supported,
+none of the older Tridents.
+The driver supports 8, 16 and 32 bits per pixel depths.
+The TGUI family requires a line length to be power of 2 if acceleration
+is enabled. This means that range of possible resolutions and bpp is
+limited comparing to the range if acceleration is disabled (see list
+of parameters below).
+
+Known bugs:
+1. The driver randomly locks up on 3DImage975 chip with acceleration
+   enabled. The same happens in X11 (Xorg).
+2. The ramdac speeds require some more fine tuning. It is possible to
+   switch resolution which the chip does not support at some depths for
+   older chips.
 
 How to use it?
 ==============
@@ -17,12 +31,11 @@ video=tridentfb
 
 The parameters for tridentfb are concatenated with a ':' as in this example.
 
-video=tridentfb:800x600,bpp=16,noaccel
+video=tridentfb:800x600-16@75,noaccel
 
 The second level parameters that tridentfb understands are:
 
 noaccel - turns off acceleration (when it doesn't work for your card)
-accel - force text acceleration (for boards which by default are noacceled)
 
 fp	- use flat panel related stuff
 crt 	- assume monitor is present instead of fp
@@ -31,21 +44,24 @@ center 	- for flat panels and resolution
 	  image, otherwise use
 stretch
 
-memsize - integer value in Kb, use if your card's memory size is misdetected.
+memsize - integer value in KB, use if your card's memory size is misdetected.
 	  look at the driver output to see what it says when initializing.
-memdiff - integer value in Kb,should be nonzero if your card reports
-	  more memory than it actually has.For instance mine is 192K less than
+
+memdiff - integer value in KB, should be nonzero if your card reports
+	  more memory than it actually has. For instance mine is 192K less than
 	  detection says in all three BIOS selectable situations 2M, 4M, 8M.
 	  Only use if your video memory is taken from main memory hence of
-	  configurable size.Otherwise use memsize.
-	  If in some modes which barely fit the memory you see garbage at the bottom
-	  this might help by not letting change to that mode anymore.
+	  configurable size. Otherwise use memsize.
+	  If in some modes which barely fit the memory you see garbage
+	  at the bottom this might help by not letting change to that mode
+	  anymore.
 
 nativex - the width in pixels of the flat panel.If you know it (usually 1024
 	  800 or 1280) and it is not what the driver seems to detect use it.
 
-bpp  - bits per pixel (8,16 or 32)
-mode - a mode name like 800x600 (as described in Documentation/fb/modedb.txt)
+bpp	- bits per pixel (8,16 or 32)
+mode	- a mode name like 800x600-8@75 as described in
+	  Documentation/fb/modedb.txt
 
 Using insane values for the above parameters will probably result in driver
 misbehaviour so take care(for instance memsize=12345678 or memdiff=23784 or

----------------------------------------------------------------------
Dlugi weekend w deszczu?.. Lepiej sprawdz pogode! 	
http://link.interia.pl/f1dcd


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
