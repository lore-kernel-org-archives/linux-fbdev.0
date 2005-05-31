From: sylvain.meyer@worldonline.fr
Subject: [patch 2/2] intelfb documentation
Date: Tue, 31 May 2005 19:34:08 +0200
Message-ID: <20050531173408.AF22B1C000B1@mwinf1104.wanadoo.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DdAd8-0004NE-2T
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 May 2005 10:34:18 -0700
Received: from smtp11.wanadoo.fr ([193.252.22.31])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DdAd6-0006oY-NB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 May 2005 10:34:17 -0700
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1104.wanadoo.fr (SMTP Server) with ESMTP id 60EB61C000BA
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 31 May 2005 19:34:09 +0200 (CEST)
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org, adaplas@pol.net, sylvain.meyer@worldonline.fr


From: Sylvain Meyer <sylvain.meyer@worldonline.fr>

Add a small documentation of the driver parameters.

Signed-off-by: Sylvain Meyer <sylvain.meyer@worldonline.fr>
---

 linux-2.6.12-rc4-root/Documentation/fb/intelfb.txt |  135 +++++++++++++++++++++
 1 files changed, 135 insertions(+)

diff -puN /dev/null Documentation/fb/intelfb.txt
--- /dev/null	2004-07-17 12:19:20.000000000 +0200
+++ linux-2.6.12-rc4-root/Documentation/fb/intelfb.txt	2005-05-31 19:32:46.000000000 +0200
@@ -0,0 +1,135 @@
+Intel 830M/845G/852GM/855GM/865G/915G Framebuffer driver
+================================================================
+
+A. Introduction
+	This is a framebuffer driver for various Intel compatible
+graphics devices.  These would include:
+
+	Intel 830M
+	Intel 845G
+	Intel 852GM
+	Intel 855GM
+	Intel 865G
+	Intel 915G
+
+B.  List of available options
+
+   a. "video=intelfb"  
+	enables the intelfb driver
+
+	Recommendation: required
+ 
+   b. "mode=<xres>x<yres>[-<bpp>][@<refresh>]"  
+	select mode
+
+	Recommendation: user preference 
+	(default = 1024x768-32@70)
+
+   c. "vram=<value>"
+	select amount of system RAM in MB to allocate for the video memory
+	if no enough RAM was already allocated by the BIOS.
+
+	Recommendation: 1 - 4 MB.
+	(default = 4 MB)
+
+   d. "voffset=<value>"	
+        select at what offset in MB of the logical memory to allocate the 
+	framebuffer memory.  The intent is to avoid the memory blocks
+	used by standard graphics applications (XFree86). Depending on your 
+        usage, adjust the value up or down, (0 for maximum usage, 63/127 MB 
+        for the least amount).  Note, an arbitrary setting may conflict 
+        with XFree86.
+
+	Recommendation: do not set
+	(default = 48 MB)
+      
+   e. "accel" 
+	enable text acceleration.  This can be enabled/reenabled anytime 
+	by using 'fbset -accel true/false'. 
+
+	Recommendation: enable
+	(default = set) 
+
+   f. "hwcursor" 
+	enable cursor acceleration. 
+
+	Recommendation: enable
+	(default = set) 
+
+   g. "mtrr" 
+	enable MTRR.  This allows data transfers to the framebuffer memory
+	to occur in bursts which can significantly increase performance.
+	Not very helpful with the intel chips because of 'shared memory'. 
+
+	Recommendation: set
+	(default = set) 
+
+   h. "fixed"
+	disable mode switching. 
+
+	Recommendation: do not set
+	(default = not set)
+				
+   The binary parameters can be unset with a "no" prefix, example "noaccel".
+   The default parameter (not named) is the mode.
+	
+C. Kernel booting
+
+Separate each option/option-pair by commas (,) and the option from its value
+with an equal (=) as in the following:
+
+video=i810fb:option1,option2=value2
+
+Sample Usage
+------------
+
+In /etc/lilo.conf, add the line:
+
+append="video=intelfb:800x600-32@75,accel,hwcursor,vram=8"
+
+This will initialize the framebuffer to 800x600 at 32bpp and 75Hz. The 
+framebuffer will use 8 MB of System RAM. hw acceleration of text and cursor
+will be enabled.  
+
+D.  Module options
+	
+	The module parameters are essentially similar to the kernel 
+parameters. The main difference is that you need to include a Boolean value 
+(1 for TRUE, and 0 for FALSE) for those options which don't need a value. 
+
+Example, to enable MTRR, include "mtrr=1".
+
+Sample Usage
+------------
+
+Using the same setup as described above, load the module like this:
+
+	modprobe intelfb mode=800x600-32@75 vram=8 accel=1 hwcursor=1
+
+Or just add the following to /etc/modprobe.conf
+
+	options intelfb mode=800x600-32@75 vram=8 accel=1 hwcursor=1
+
+and just do a 
+
+	modprobe intelfb
+
+
+E.  Acknowledgment:
+	
+	1.  Geert Uytterhoeven - his excellent howto and the virtual
+                                 framebuffer driver code made this possible.
+
+	2.  Jeff Hartmann for his agpgart code.  
+
+	3.  David Dawes for his original kernel 2.4 code.  
+
+	4.  The X developers.  Insights were provided just by reading the
+	    XFree86 source code.
+
+	5.  Antonino A. Daplas for his inspiring i810fb driver.
+
+	6.  Andrew Morton for his kernel patches maintenance.
+
+###########################
+Sylvain
_



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
