From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH]: vesafb - vram option
Date: 28 Mar 2003 04:20:12 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1048796361.977.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18ye9G-0003zY-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 12:38:54 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Attached is a diff against linux-2.5.66.

- Added vesafb option to specify amount of video RAM to remap.  This is
perhaps useful for people with machines with large amounts of system and
graphics RAM and vesafb fails to load due to failure to ioremap.

To use:  to remap only 1MiB of ram, add the ff. in your boot option:

video=vesafb:vram:1,<your other options>

Tony

diff -Naur linux-2.5.66-orig/Documentation/fb/vesafb.txt linux-2.5.66/Documentation/fb/vesafb.txt
--- linux-2.5.66-orig/Documentation/fb/vesafb.txt	2003-03-26 02:24:54.000000000 +0000
+++ linux-2.5.66/Documentation/fb/vesafb.txt	2003-03-27 20:10:01.000000000 +0000
@@ -146,7 +146,9 @@
 
 mtrr	setup memory type range registers for the vesafb framebuffer.
 
-
+vram:n  remap 'n' MiB of video RAM. If 0 or not specified, remap all
+	available video RAM. 
+  
 Have fun!
 
   Gerd
diff -Naur linux-2.5.66-orig/drivers/video/vesafb.c linux-2.5.66/drivers/video/vesafb.c
--- linux-2.5.66-orig/drivers/video/vesafb.c	2003-02-16 00:49:23.000000000 +0000
+++ linux-2.5.66/drivers/video/vesafb.c	2003-03-27 20:01:11.000000000 +0000
@@ -50,7 +50,7 @@
 
 static int             inverse   = 0;
 static int             mtrr      = 0;
-
+static int        vram __initdata = 0;
 static int             pmi_setpal = 0;	/* pmi for palette changes ??? */
 static int             ypan       = 0;  /* 0..nothing, 1..ypan, 2..ywrap */
 static unsigned short  *pmi_base  = 0;
@@ -206,6 +206,8 @@
 			pmi_setpal=1;
 		else if (! strcmp(this_opt, "mtrr"))
 			mtrr=1;
+		else if (! strncmp(this_opt, "vram:", 5))
+			vram = simple_strtoul(this_opt+5, NULL, 0);
 	}
 	return 0;
 }
@@ -226,6 +228,8 @@
 	vesafb_defined.yres = screen_info.lfb_height;
 	vesafb_fix.line_length = screen_info.lfb_linelength;
 	vesafb_fix.smem_len = screen_info.lfb_size * 65536;
+	if (vram && vram * 1024 * 1024 < vesafb_fix.smem_len)
+		vesafb_fix.smem_len = vram * 1024 * 1024;
 	vesafb_fix.visual   = (vesafb_defined.bits_per_pixel == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
