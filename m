From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/4] i810fb: Update i810fb documentation
Date: Mon, 12 Sep 2005 09:18:12 +0800
Message-ID: <4324D754.9040901@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EEd0u-00043L-Hy
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Sep 2005 18:21:40 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EEd0t-0006Te-4M
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 11 Sep 2005 18:21:40 -0700
Received: by zproxy.gmail.com with SMTP id 9so1571464nzo
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 11 Sep 2005 18:21:32 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Update i810fb documentation to describe new features and configuration
changes.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 intel810.txt |   56 ++++++++++++++++++++++++++++++--------------------------
 1 files changed, 30 insertions(+), 26 deletions(-)


diff --git a/Documentation/fb/intel810.txt b/Documentation/fb/intel810.txt
--- a/Documentation/fb/intel810.txt
+++ b/Documentation/fb/intel810.txt
@@ -5,6 +5,7 @@ Intel 810/815 Framebuffer driver
 	March 17, 2002
 
 	First Released: July 2001
+	Last Update:    September 12, 2005
 ================================================================
 
 A. Introduction
@@ -44,6 +45,8 @@ B.  Features
 
 	- Hardware Cursor Support
  
+	- Supports EDID probing either by DDC/I2C or through the BIOS
+
 C.  List of available options
 	
    a. "video=i810fb"  
@@ -52,14 +55,17 @@ C.  List of available options
 	Recommendation: required
  
    b. "xres:<value>"  
-	select horizontal resolution in pixels
+	select horizontal resolution in pixels. (This parameter will be
+	ignored if 'mode_option' is specified.  See 'o' below).
 
 	Recommendation: user preference 
 	(default = 640)
 
    c. "yres:<value>"
 	select vertical resolution in scanlines. If Discrete Video Timings
-	is enabled, this will be ignored and computed as 3*xres/4.  
+	is enabled, this will be ignored and computed as 3*xres/4.  (This
+	parameter will be ignored if 'mode_option' is specified.  See 'o'
+	below)  
 
 	Recommendation: user preference
 	(default = 480)
@@ -86,7 +92,8 @@ C.  List of available options
    g. "hsync1/hsync2:<value>" 
 	select the minimum and maximum Horizontal Sync Frequency of the 
 	monitor in KHz.  If a using a fixed frequency monitor, hsync1 must 
-	be equal to hsync2. 
+	be equal to hsync2. If EDID probing is successful, these will be
+	ignored and values will be taken from the EDID block.
 
 	Recommendation: check monitor manual for correct values
 	default (29/30)
@@ -94,7 +101,8 @@ C.  List of available options
    h. "vsync1/vsync2:<value>" 
 	select the minimum and maximum Vertical Sync Frequency of the monitor
 	in Hz. You can also use this option to lock your monitor's refresh 
-	rate.
+	rate. If EDID probing is successful, these will be ignored and values
+	will be taken from the EDID block.
 
 	Recommendation: check monitor manual for correct values
 	(default = 60/60)
@@ -154,7 +162,11 @@ C.  List of available options
 
 	Recommendation: do not set
 	(default = not set)
-			
+   o. <xres>x<yres>[-<bpp>][@<refresh>]
+	The driver will now accept specification of boot mode option.  If this
+	is specified, the options 'xres' and 'yres' will be ignored. See
+	Documentation/fb/modedb.txt for usage.
+
 D. Kernel booting
 
 Separate each option/option-pair by commas (,) and the option from its value
@@ -176,7 +188,10 @@ will be computed based on the hsync1/hsy
 
 IMPORTANT:
 You must include hsync1, hsync2, vsync1 and vsync2 to enable video modes
-better than 640x480 at 60Hz.
+better than 640x480 at 60Hz. HOWEVER, if your chipset/display combination
+supports I2C and has an EDID block, you can safely exclude hsync1, hsync2,
+vsync1 and vsync2 parameters.  These parameters will be taken from the EDID
+block.
 
 E.  Module options
 	
@@ -217,32 +232,21 @@ F.  Setup
 	   This is required.  The option is under "Character Devices"
 
 	d. Under "Graphics Support", select "Intel 810/815" either statically
-	   or as a module.  Choose "use VESA GTF for video timings"  if you 
-	   need to maximize the capability of your display.  To be on the 
+	   or as a module.  Choose "use VESA Generalized Timing Formula" if
+	   you need to maximize the capability of your display.  To be on the 
 	   safe side, you can leave this unselected.  
   
-        e. If you want a framebuffer console, enable it under "Console 
+	e. If you want support for DDC/I2C probing (Plug and Play Displays),
+	   set 'Enable DDC Support' to 'y'. To make this option appear, set
+	   'use VESA Generalized Timing Formula' to 'y'.
+
+        f. If you want a framebuffer console, enable it under "Console 
 	   Drivers"
 
-	f. Compile your kernel. 
+	g. Compile your kernel. 
 	  	
-	g. Load the driver as described in section D and E.
+	h. Load the driver as described in section D and E.
 	
-	Optional:	
-	h.  If you are going to run XFree86 with its native drivers, the 
-	    standard XFree86 4.1.0 and 4.2.0 drivers should work as is.
-            However, there's a bug in the XFree86 i810 drivers.  It attempts 
-	    to use XAA even when switched to the console. This will crash
-	    your server. I have a fix at this site:  
-	    
-	    http://i810fb.sourceforge.net.  
-
-	    You can either use the patch, or just replace 
-	    
-            /usr/X11R6/lib/modules/drivers/i810_drv.o
-
-	    with the one provided at the website. 	
-
 	i.  Try the DirectFB (http://www.directfb.org) + the i810 gfxdriver
 	    patch to see the chipset in action (or inaction :-).
 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
