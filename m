From: John Zielinski <grim@undead.cc>
Subject: Re: fbutils
Date: Tue, 23 Dec 2003 01:11:56 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FE7DCAC.8000204@undead.cc>
References: <3FE649BF.30501@undead.cc>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080901060607020301020900"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYfmA-0006wc-I2
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Dec 2003 22:12:14 -0800
Received: from ghoul.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AYfm8-00042F-U0
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Dec 2003 22:12:13 -0800
In-Reply-To: <3FE649BF.30501@undead.cc>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080901060607020301020900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I didn't get as much done as I've hoped but there's a few important 
fixes so I'll repost early.  Apply to a fresh CVS copy.

John


--------------080901060607020301020900
Content-Type: text/plain;
 name="patch.fbutils2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="patch.fbutils2"

diff -urNX dontdiff fbutils.old/con2fbmap/con2fbmap.C fbutils/con2fbmap/con2fbmap.C
--- fbutils.old/con2fbmap/con2fbmap.C	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/con2fbmap/con2fbmap.C	2003-12-23 00:32:16.000000000 -0500
@@ -13,6 +13,7 @@
 
 bool Opt_version = false;
 bool Opt_verbose = false;
+bool Opt_quiet = false;
 const char *Opt_debug = NULL;
 const char *Opt_fb = DEFAULT_FRAMEBUFFER;
 const char *Opt_console = NULL;
diff -urNX dontdiff fbutils.old/etc/modes fbutils/etc/modes
--- fbutils.old/etc/modes	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/etc/modes	2003-12-21 22:43:56.000000000 -0500
@@ -7,20 +7,20 @@
 	{ 800 600 27777 128 24 22 1 72 2 }
     "1024x768@87"	# 1024x768 @ 87 Hz interlaced, 35.5 kHz hsync
 	{ 1024 768 22271 56 24 33 8 160 8 interlace }
-#   "640x400@85"	# 640x400 @ 85 Hz, 37.86 kHz hsync
-#	{ 640 400 31746 96 32 41 1 64 3 vsync+ }
+    "640x400@85"	# 640x400 @ 85 Hz, 37.86 kHz hsync
+	{ 640 400 31746 96 32 41 1 64 3 vsync+ }
     "640x480@72"	# 640x480 @ 72 Hz, 36.5 kHz hsync
 	{ 640 480 31746 144 40 30 8 40 3 }
     "640x480@75"	# 640x480 @ 75 Hz, 37.50 kHz hsync
 	{ 640 480 31746 120 16 16 1 64 3 }
-#   "800x600@60"	# 800x600 @ 60 Hz, 37.8 kHz hsync
-#	{ 800 600 25000 88 40 23 1 128 4 0 hsync+ vsync+ }
+    "800x600@60"	# 800x600 @ 60 Hz, 37.8 kHz hsync
+	{ 800 600 25000 88 40 23 1 128 4 0 hsync+ vsync+ }
     "640x480@85"	# 640x480 @ 85 Hz, 43.27 kHz hsync
 	{ 640 480 27777 80 56 25 1 56 3 }
     "1152x864@89"	# 1152x864 @ 89 Hz interlaced, 44 kHz hsync
 	{ 1152 864 15384 96 16 110 1 216 10 interlace }
-#   "800x600@72"	# 800x600 @ 72 Hz, 48.0 kHz hsync
-#	{ 800 600 20000 64 56 23 37 120 6 hsync+ vsync+ }
+    "800x600@72"	# 800x600 @ 72 Hz, 48.0 kHz hsync
+	{ 800 600 20000 64 56 23 37 120 6 hsync+ vsync+ }
     "1024x768@60"	# 1024x768 @ 60 Hz, 48.4 kHz hsync
 	{ 1024 768 15384 168 8 29 3 144 6 }
     "640x480@100"	# 640x480 @ 100 Hz, 53.01 kHz hsync
@@ -47,8 +47,8 @@
 	{ 1152 864 9090 228 88 32 0 84 12 }
     "1280x1024@70"	# 1280x1024 @ 70 Hz, 74.59 kHz hsync
 	{ 1280 1024 7905 224 32 28 8 160 8 }
-#   "1600x1200@60"	# 1600x1200 @ 60Hz, 75.00 kHz hsync
-#	{ 1600 1200 6172 304 64 46 1 192 3 hsync+ vsync+ }
+    "1600x1200@60"	# 1600x1200 @ 60Hz, 75.00 kHz hsync
+	{ 1600 1200 6172 304 64 46 1 192 3 hsync+ vsync+ }
     "1152x864@84"	# 1152x864 @ 84 Hz, 76.0 kHz hsync
 	{ 1152 864 7407 184 312 32 0 128 12 }
     "1280x1024@74"	# 1280x1024 @ 74 Hz, 78.85 kHz hsync
@@ -61,18 +61,18 @@
 	{ 1600 1200 5291 304 64 46 1 192 3 }
     "1152x864@100"	# 1152x864 @ 100 Hz, 89.62 kHz hsync
 	{ 1152 864 7264 224 32 17 2 128 19 }
-#   "1280x1024@85"	# 1280x1024 @ 85 Hz, 91.15 kHz hsync
-#	{ 1280 1024 6349 224 64 44 1 160 3 hsync+ vsync+ }
-#   "1600x1200@75"	# 1600x1200 @ 75 Hz, 93.75 kHz hsync
-#	{ 1600 1200 4938 304 64 46 1 192 3 hsync+ vsync+ }
-#   "1600x1200@85"	# 1600x1200 @ 85 Hz, 105.77 kHz hsync
-#	{ 1600 1200 4545 272 16 37 4 192 3 hsync+ vsync+ }
+    "1280x1024@85"	# 1280x1024 @ 85 Hz, 91.15 kHz hsync
+	{ 1280 1024 6349 224 64 44 1 160 3 hsync+ vsync+ }
+    "1600x1200@75"	# 1600x1200 @ 75 Hz, 93.75 kHz hsync
+	{ 1600 1200 4938 304 64 46 1 192 3 hsync+ vsync+ }
+    "1600x1200@85"	# 1600x1200 @ 85 Hz, 105.77 kHz hsync
+	{ 1600 1200 4545 272 16 37 4 192 3 hsync+ vsync+ }
     "1280x1024@100"	# 1280x1024 @ 100 Hz, 107.16 kHz hsync
 	{ 1280 1024 5502 256 32 26 7 128 15 }
-#   "1800x1440@64"	# 1800x1440 @ 64Hz, 96.15 kHz hsync 
-#	{ 1800 1440 4347 304 96 46 1 192 3 hsync+ vsync+ }
-#   "1800x1440@70"	# 1800x1440 @ 70Hz, 104.52 kHz hsync 
-#	{ 1800 1440 4000 304 96 46 1 192 3 hsync+ vsync+ }
+    "1800x1440@64"	# 1800x1440 @ 64Hz, 96.15 kHz hsync 
+	{ 1800 1440 4347 304 96 46 1 192 3 hsync+ vsync+ }
+    "1800x1440@70"	# 1800x1440 @ 70Hz, 104.52 kHz hsync 
+	{ 1800 1440 4000 304 96 46 1 192 3 hsync+ vsync+ }
     "512x384@78"	# 512x384 @ 78 Hz, 31.50 kHz hsync
 	{ 512 384 49603 48 16 16 1 64 3 }
     "512x384@85"	# 512x384 @ 85 Hz, 34.38 kHz hsync
@@ -100,11 +100,11 @@
 }
 
 format {
-#   "8bpp" { 8 }
-#   "15bpp" { 16 0:5:0 0:5:0 0:5:0 0:0:0 }
-#   "16bpp" { 16 0:5:0 0:6:0 0:5:0 0:0:0 }
-#   "24bpp" { 24 0:8:0 0:8:0 0:8:0 0:0:0 }
-#   "32bpp" { 32 0:8:0 0:8:0 0:8:0 0:0:0 }
+   "8bpp" { 8 }
+   "15bpp" { 16 0:5:0 0:5:0 0:5:0 0:0:0 }
+   "16bpp" { 16 0:5:0 0:6:0 0:5:0 0:0:0 }
+   "24bpp" { 24 0:8:0 0:8:0 0:8:0 0:0:0 }
+   "32bpp" { 32 0:8:0 0:8:0 0:8:0 0:0:0 }
 }
 
 mode {
diff -urNX dontdiff fbutils.old/fbcmap/fbcmap.C fbutils/fbcmap/fbcmap.C
--- fbutils.old/fbcmap/fbcmap.C	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/fbcmap/fbcmap.C	2003-12-23 00:31:07.000000000 -0500
@@ -16,6 +16,7 @@
 
 bool Opt_version = false;
 bool Opt_verbose = false;
+bool Opt_quiet = false;
 const char *Opt_debug = NULL;
 const char *Opt_fb = DEFAULT_FRAMEBUFFER;
 const char *Opt_length = NULL;
diff -urNX dontdiff fbutils.old/fbconvert/fbconvert.C fbutils/fbconvert/fbconvert.C
--- fbutils.old/fbconvert/fbconvert.C	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/fbconvert/fbconvert.C	2003-12-23 00:32:35.000000000 -0500
@@ -27,9 +27,9 @@
 extern int y2parse(void);
 
 
-static bool Opt_version = false;
-static bool Opt_verbose = false;
-static bool Opt_quiet = false;
+bool Opt_version = false;
+bool Opt_verbose = false;
+bool Opt_quiet = false;
 static const char *Opt_debug = NULL;
 const char *Opt_modedb = NULL;
 
@@ -50,18 +50,12 @@
 static void Usage(void)
 {
     puts(VERSION);
-    Die("\nUsage: %s [options] [mode]\n\n"
+    Die("\nUsage: %s [options] modedb\n\n"
 	"Valid options:\n"
 	"  General options:\n"
 	"    -h, --help         : display this usage information\n"
-	"    --test             : don't change, just test whether the mode is "
-				 "valid\n"
-	"    -s, --show         : display video mode settings\n"
-	"    -i, --info         : display all frame buffer information\n"
 	"    -v, --verbose      : verbose mode\n"
 	"    -V, --version      : print version information\n"
-	"    -x, --xfree86      : XFree86 compatibility mode\n"
-	"    -a, --all          : change all virtual consoles on this device\n"
 	"n", ProgramName);
 }
 
diff -urNX dontdiff fbutils.old/fbconvert/modes.y fbutils/fbconvert/modes.y
--- fbutils.old/fbconvert/modes.y	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/fbconvert/modes.y	2003-12-22 00:40:34.000000000 -0500
@@ -108,7 +108,7 @@
     virtual_.xres_virtual = vmode->vxres;
     virtual_.yres_virtual = vmode->vyres;
 
-    Videomode *node = new Videomode(vmode->name, geometry, format, &virtual_);
+    Videomode *node = new Videomode(vmode->name, geometry, format, virtual_);
     node->accel_flags = vmode->accel_flags;
     Videomodes.Add(node);
 }
diff -urNX dontdiff fbutils.old/fbset/fbset.C fbutils/fbset/fbset.C
--- fbutils.old/fbset/fbset.C	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/fbset/fbset.C	2003-12-23 00:49:10.000000000 -0500
@@ -105,7 +105,7 @@
     //  Function Prototypes
 
 static void ReadDatabase(void);
-static bool ModifyVideomode(Videomode &mode);
+static void ModifyVideomode(Videomode &mode);
 
 
     //  Read the Video Mode Database
@@ -118,63 +118,70 @@
     ReadDatabase(Opt_modedb);
 }
 
+    // Convert string to bool
+
+static bool atoboolean( const char *opt )
+{
+    if (strcasecmp(opt, "true") == 0) return true;
+    if (strcasecmp(opt, "yes") == 0) return true;
+    if (strcasecmp(opt, "1") == 0) return true;
+    return false;
+}
 
     //  Modify a Video Mode
 
-static bool ModifyVideomode(Videomode &mode)
+static void ModifyVideomode(Videomode &mode)
 {
-    //
-
-    u_int hstep = 8, vstep = 2;
+//    u_int hstep = 8, vstep = 2;
 
     if (Modify_xres)
-	{} // vmode.xres = strtoul(Modify_xres, NULL, 0);
+	mode.xres = strtoul(Modify_xres, NULL, 0);
     if (Modify_yres)
-	{} // vmode.yres = strtoul(Modify_yres, NULL, 0);
+	mode.yres = strtoul(Modify_yres, NULL, 0);
     if (Modify_vxres)
-	{} // vmode.vxres = strtoul(Modify_vxres, NULL, 0);
+	mode.xres_virtual = strtoul(Modify_vxres, NULL, 0);
     if (Modify_vyres)
-	{} // vmode.vyres = strtoul(Modify_vyres, NULL, 0);
+	mode.yres_virtual = strtoul(Modify_vyres, NULL, 0);
     if (Modify_depth)
-	{} // vmode.depth = strtoul(Modify_depth, NULL, 0);
+	mode.bits_per_pixel = strtoul(Modify_depth, NULL, 0);
     if (Modify_accel)
-	{} // vmode.accel_flags = atoboolean(Modify_accel) ? FB_ACCELF_TEXT : 0;
+	atoboolean(Modify_accel) ? mode.accel_flags |= FB_ACCELF_TEXT : mode.accel_flags &= ~FB_ACCELF_TEXT;
     if (Modify_pixclock)
-	{} // vmode.pixclock = strtoul(Modify_pixclock, NULL, 0);
+	mode.pixclock = strtoul(Modify_pixclock, NULL, 0);
     if (Modify_left)
-	{} // vmode.left = strtoul(Modify_left, NULL, 0);
+	mode.left_margin = strtoul(Modify_left, NULL, 0);
     if (Modify_right)
-	{} // vmode.right = strtoul(Modify_right, NULL, 0);
+	mode.right_margin = strtoul(Modify_right, NULL, 0);
     if (Modify_upper)
-	{} // vmode.upper = strtoul(Modify_upper, NULL, 0);
+	mode.upper_margin = strtoul(Modify_upper, NULL, 0);
     if (Modify_lower)
-	{} // vmode.lower = strtoul(Modify_lower, NULL, 0);
+	mode.lower_margin = strtoul(Modify_lower, NULL, 0);
     if (Modify_hslen)
-	{} // vmode.hslen = strtoul(Modify_hslen, NULL, 0);
+	mode.hsync_len = strtoul(Modify_hslen, NULL, 0);
     if (Modify_vslen)
-	{} // vmode.vslen = strtoul(Modify_vslen, NULL, 0);
+	mode.vsync_len = strtoul(Modify_vslen, NULL, 0);
     if (Modify_hsync)
-	{} // vmode.hsync = atoboolean(Modify_hsync);
+	atoboolean(Modify_hsync) ? mode.sync |= FB_SYNC_HOR_HIGH_ACT : mode.sync &= ~FB_SYNC_HOR_HIGH_ACT;
     if (Modify_vsync)
-	{} // vmode.vsync = atoboolean(Modify_vsync);
+	atoboolean(Modify_vsync) ? mode.sync |= FB_SYNC_VERT_HIGH_ACT : mode.sync &= ~FB_SYNC_VERT_HIGH_ACT; 
     if (Modify_csync)
-	{} // vmode.csync = atoboolean(Modify_csync);
+	atoboolean(Modify_csync) ? mode.sync |= FB_SYNC_COMP_HIGH_ACT : mode.sync &= ~FB_SYNC_COMP_HIGH_ACT;
     if (Modify_gsync)
-	{} // vmode.gsync = atoboolean(Modify_gsync);
+	atoboolean(Modify_gsync) ? mode.sync |= FB_SYNC_ON_GREEN : mode.sync &= ~FB_SYNC_ON_GREEN;
     if (Modify_extsync)
-	{} // vmode.extsync = atoboolean(Modify_extsync);
+	atoboolean(Modify_extsync) ? mode.sync |= FB_SYNC_EXT : mode.sync &= ~FB_SYNC_EXT;
     if (Modify_bcast)
-	{} // vmode.bcast = atoboolean(Modify_bcast);
-    if (Modify_laced)
-	{} // vmode.laced = atoboolean(Modify_laced);
-    if (Modify_double)
-	{} // vmode.dblscan = atoboolean(Modify_double);
-    if (Modify_step)
-	hstep = vstep = strtoul(Modify_step, NULL, 0);
-    if (Modify_move) {
-	{} //
+	atoboolean(Modify_bcast) ? mode.sync |= FB_SYNC_BROADCAST : mode.sync &= ~FB_SYNC_BROADCAST;
+    if (Modify_laced) {
+	mode.vmode &= ~FB_VMODE_MASK;	
+	mode.vmode = atoboolean(Modify_laced) ? FB_VMODE_INTERLACED : 0;
     }
-    return false;
+    else if (Modify_double) {
+	mode.vmode &= ~FB_VMODE_MASK;	
+	mode.vmode = atoboolean(Modify_double) ? FB_VMODE_DOUBLE : 0;
+    }
+//    if (Modify_step) 
+//    if (Modify_move) 
 }
 
 
@@ -186,53 +193,56 @@
     Die("\nUsage: %s [options] [mode]\n\n"
 	"Valid options:\n"
 	"  General options:\n"
-	"    -h, --help         : display this usage information\n"
-	"    --test             : don't change, just test whether the mode is "
-				 "valid\n"
-	"    -s, --show         : display video mode settings\n"
-	"    -i, --info         : display all frame buffer information\n"
-	"    -v, --verbose      : verbose mode\n"
-	"    -V, --version      : print version information\n"
-	"    -x, --xfree86      : XFree86 compatibility mode\n"
-	"    -a, --all          : change all virtual consoles on this device\n"
+	"    -h, --help           : display this usage information\n"
+//	"    --test               : don't change, just test whether the mode is "
+//				    "valid\n"
+	"    -s, --show           : display video mode settings\n"
+	"    -n, --just-print     : don't do anything, just print results\n"
+	"    -i, --info           : display all frame buffer information\n"
+	"    -v, --verbose        : verbose mode\n"
+	"    -q, --quiet          : quiet mode\n"
+	"    -V, --version        : print version information\n"
+//	"    --xfree86            : XFree86 compatibility mode\n"
+//	"    -a, --all            : change all virtual consoles on this device\n"
 	"  Frame buffer special device nodes:\n"
-	"    -fb <device>       : processed frame buffer device\n"
-	"                         (default is %s)\n"
+	"    -f, --frame-buffer   : processed frame buffer device\n"
+	"               <device>  : (default is %s)\n"
 	"  Video mode database:\n"
-	"    -db <file>         : video mode database file\n"
-	"                         (default is %s)\n"
+	"    -m, --mode-db <file> : video mode database file\n"
+	"                           (default is %s)\n"
+	"    -d, --dump           : dump database\n"
 	"  Display geometry:\n"
-	"    -xres <value>      : horizontal resolution (in pixels)\n"
-	"    -yres <value>      : vertical resolution (in pixels)\n"
-	"    -vxres <value>     : virtual horizontal resolution (in pixels)\n"
-	"    -vyres <value>     : virtual vertical resolution (in pixels)\n"
-	"    -depth <value>     : display depth (in bits per pixel)\n"
-	"    -g, --geometry ... : set all geometry parameters at once\n"
+	"    -x, --xres <value>   : horizontal resolution (in pixels)\n"
+	"    -y, --yres <value>   : vertical resolution (in pixels)\n"
+	"    --vxres <value>      : virtual horizontal resolution (in pixels)\n"
+	"    --vyres <value>      : virtual vertical resolution (in pixels)\n"
+	"    -b, --bpp <value>    : display depth (in bits per pixel)\n"
+//	"    -g, --geometry ...   : set all geometry parameters at once\n"
 	"  Display timings:\n"
-	"    -pixclock <value>  : pixel clock (in picoseconds)\n"
-	"    -left <value>      : left margin (in pixels)\n"
-	"    -right <value>     : right margin (in pixels)\n"
-	"    -upper <value>     : upper margin (in pixel lines)\n"
-	"    -lower <value>     : lower margin (in pixel lines)\n"
-	"    -hslen <value>     : horizontal sync length (in pixels)\n"
-	"    -vslen <value>     : vertical sync length (in pixel lines)\n"
-	"    -t, --timings ...  : set all timing parameters at once\n"
+	"    --pixclock <value>   : pixel clock (in picoseconds)\n"
+	"    --left <value>       : left margin (in pixels)\n"
+	"    --right <value>      : right margin (in pixels)\n"
+	"    --upper <value>      : upper margin (in pixel lines)\n"
+	"    --lower <value>      : lower margin (in pixel lines)\n"
+	"    --hslen <value>      : horizontal sync length (in pixels)\n"
+	"    --vslen <value>      : vertical sync length (in pixel lines)\n"
+//	"    -t, --timings ...    : set all timing parameters at once\n"
 	"  Display flags:\n"
-	"    -accel <value>     : hardware text acceleration enable (false or "
-				 "true)\n"
-	"    -hsync <value>     : horizontal sync polarity (low or high)\n"
-	"    -vsync <value>     : vertical sync polarity (low or high)\n"
-	"    -csync <value>     : composite sync polarity (low or high)\n"
-	"    -gsync <value>     : synch on green (false or true)\n"
-	"    -extsync <value>   : external sync enable (false or true)\n"
-	"    -bcast <value>     : broadcast enable (false or true)\n"
-	"    -laced <value>     : interlace enable (false or true)\n"
-	"    -double <value>    : doublescan enable (false or true)\n"
-	"  Display positioning:\n"
-	"    -move <direction>  : move the visible part (left, right, up or "
-				 "down)\n"
-	"    -step <value>      : step increment (in pixels or pixel lines)\n"
-	"                         (default is 8 horizontal, 2 vertical)\n",
+	"    -a, --accel <value>  : hardware text acceleration enable (false or "
+				    "true)\n"
+	"    --hsync <value>      : horizontal sync polarity (low or high)\n"
+	"    --vsync <value>      : vertical sync polarity (low or high)\n"
+	"    --csync <value>      : composite sync polarity (low or high)\n"
+	"    --gsync <value>      : synch on green (false or true)\n"
+	"    --extsync <value>    : external sync enable (false or true)\n"
+	"    --bcast <value>      : broadcast enable (false or true)\n"
+	"    --laced <value>      : interlace enable (false or true)\n"
+	"    --double <value>     : doublescan enable (false or true)\n"
+//	"  Display positioning:\n"
+//	"    --move <direction>   : move the visible part (left, right, up or "
+//				    "down)\n"
+//	"    --step <value>       : step increment (in pixels or pixel lines)\n"
+,//	"                           (default is 8 horizontal, 2 vertical)\n",
 	ProgramName, Opt_fb, Opt_modedb);
 }
 
@@ -243,11 +253,14 @@
 {
     int id;
     bool changed;
+    bool setmode;
+    Videomode const *mode;
+    Videomode *newmode;
 
     //  Parse the Options
 
-    while ((id = GetNextOption(argc, argv, Options,
-			       sizeof(Options)/sizeof(*Options))))
+    while (id = GetNextOption(argc, argv, Options,
+			       sizeof(Options)/sizeof(*Options))) {
 	switch (id) {
 	    case ID_HELP:
 		Usage();
@@ -259,6 +272,7 @@
 		argc--;
 		argv++;
 	}
+    }
     if (Opt_debug)
 	DebugMask = strtoul(Opt_debug, NULL, 0);
 
@@ -267,30 +281,42 @@
 
     FrameBuffer fb(Opt_fb);
 
+    ReadDatabase();
+
+    if (Opt_dump) {
+        DumpDatabase();
+	return 0;
+    } 
+
     if (Opt_info) {
-	FixScreenInfo fix;
-	fix.Get(fb);
-	fix.Print();
+        FixScreenInfo fix;
+        fix.Get(fb);
+        fix.Print();
     }
-    Videomode *mode;
+	
     if (Opt_modename) {
-	ReadDatabase();
-	if (Opt_dump)
-	    DumpDatabase();
-	mode = Videomodes.Find(Opt_modename);
+        mode = Videomodes.Find(Opt_modename);
+        if (!mode) 
+	    Die( "\nMode %s not found.\n\n", Opt_modename );
+	setmode = true;
     } else {
 	VarScreenInfo var;
 	var.Get(fb);
 	mode = new Videomode(var);
-	mode->Dump();
+	setmode = false;
     }
 
-    changed = ModifyVideomode(*mode);
-
-    if (changed && !Opt_just_print) {
-	VarScreenInfo var(*mode);
-	var.Set(fb);
+    newmode = new Videomode(*mode);
+    ModifyVideomode(*newmode);
+    changed = (*newmode != *mode);
+
+    if ((setmode || changed) && !Opt_just_print) {
+        VarScreenInfo var(*newmode);
+        var.Set(fb);
     }
-
-    exit(0);
+    
+    if (Opt_show) 
+        Videomodes.TryToFind(changed ? newmode : mode)->Dump();
+    
+    return 0;
 }
diff -urNX dontdiff fbutils.old/include/database.h fbutils/include/database.h
--- fbutils.old/include/database.h	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/include/database.h	2003-12-23 00:04:18.000000000 -0500
@@ -17,8 +17,16 @@
 	void Print(const char *indent = "") const;
 	void XFree86(const char *indent = "") const;
 	virtual void Dump(bool in_list = false) const;
+	bool operator==(const Geometry &geometry) const;
+	bool operator!=(const Geometry &geometry) const;
 	bool IsInterlaced(void) const;
 	bool IsDoubleScan(void) const;
+	bool IsSyncHorPos(void) const;
+	bool IsSyncVertPos(void) const;
+	bool IsSyncCompPos(void) const;
+	bool IsSyncOnGreen(void) const;
+	bool IsSyncExt(void) const;
+	bool IsSyncBcast(void) const;
 
 	__u32 xres;
 	__u32 yres;
@@ -57,6 +65,11 @@
 	void Clear(void);
 	void Print(const char *indent = "") const;
 	virtual void Dump(bool in_list = false) const;
+	bool operator==(const Format &format) const;
+	bool operator!=(const Format &format) const;
+	bool BitfieldsAreNZ(void) const;
+	bool IsGrayscale(void) const;
+	bool IsNonStd(void) const;
 
 	__u32 bits_per_pixel;
 	__u32 grayscale;
@@ -90,6 +103,8 @@
 	void Clear(void);
 	void Print(const char *indent = "") const;
 	void Dump(void) const;
+	bool operator==(const Virtual &v) const;
+	bool operator!=(const Virtual &v) const;
 
 	__u32 xres_virtual;
 	__u32 yres_virtual;
@@ -104,10 +119,17 @@
 		  public Virtual {
     public:
 	Videomode(const char *name, const Geometry &geometry,
-		  const Format &format, const Virtual *_virtual = NULL);
+		  const Format &format, const Virtual &_virtual);
 	Videomode(const VarScreenInfo &var);
+	Videomode(const Videomode &mode);
+	void SetAccel(__u32 _accel_flags);
+	void SetNames(const Node *geometry, const Node *format);
 	void Print(const char *indent = "") const;
 	void Dump(bool in_list = false) const;
+	int operator==(const Videomode &mode) const;
+	int operator!=(const Videomode &mode) const;
+	bool IsVirtual() const;
+	bool IsAccel() const;
 
     private:
 	void FillScanRates(void);
@@ -119,12 +141,16 @@
 	double PixelRate;
 	double HorizSync;
 	double VertSync;
+	
+	const char *geometry_name;
+	const char *format_name;
 };
 
 class VideomodeList : public List {
     public:
 	VideomodeList();
-	Videomode *Find(const char *name) const;
+	const Videomode *Find(const char *name) const;
+	const Videomode *TryToFind(const Videomode *mode) const;
 };
 
 
@@ -140,6 +166,11 @@
     memset(this, 0, sizeof(*this));
 }
 
+inline bool Geometry::operator!=(const Geometry &geometry) const
+{
+    return !operator==(geometry);
+}
+	
 inline bool Geometry::IsInterlaced(void) const
 {
     return (vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED;
@@ -150,6 +181,36 @@
     return (vmode & FB_VMODE_MASK) == FB_VMODE_DOUBLE;
 }
 
+inline bool Geometry::IsSyncHorPos(void) const
+{
+    return (sync & FB_SYNC_HOR_HIGH_ACT) == FB_SYNC_HOR_HIGH_ACT;
+}
+
+inline bool Geometry::IsSyncVertPos(void) const
+{
+    return (sync & FB_SYNC_VERT_HIGH_ACT) == FB_SYNC_VERT_HIGH_ACT;
+}
+
+inline bool Geometry::IsSyncCompPos(void) const
+{
+    return (sync & FB_SYNC_COMP_HIGH_ACT) == FB_SYNC_COMP_HIGH_ACT;
+}
+
+inline bool Geometry::IsSyncOnGreen(void) const
+{
+    return (sync & FB_SYNC_ON_GREEN) == FB_SYNC_ON_GREEN;
+}
+
+inline bool Geometry::IsSyncExt(void) const
+{
+    return (sync & FB_SYNC_EXT) == FB_SYNC_EXT;
+}
+
+inline bool Geometry::IsSyncBcast(void) const
+{
+    return (sync & FB_SYNC_BROADCAST) == FB_SYNC_BROADCAST;
+}
+
 inline GeometryNode::GeometryNode(const char *name,
 				  const Geometry &geometry)
     : Node(name), Geometry(geometry)
@@ -170,6 +231,29 @@
     memset(this, 0, sizeof(*this));
 }
 
+inline bool Format::operator!=(const Format &format) const
+{
+    return !operator==(format);
+}
+	
+inline bool Format::BitfieldsAreNZ(void) const
+{
+    return (red.offset | red.length | red.msb_right |
+	    green.offset | green.length | green.msb_right |
+	    blue.offset | blue.length | blue.msb_right |
+	    transp.offset | transp.length | transp.msb_right ) != 0;
+}
+
+inline bool Format::IsGrayscale(void) const
+{
+    return grayscale != 0;
+}
+
+inline bool Format::IsNonStd(void) const
+{
+    return nonstd != 0;
+}
+
 inline FormatNode::FormatNode(const char *name, const Format &format)
     : Node(name), Format(format)
 {}
@@ -189,7 +273,32 @@
     memset(this, 0, sizeof(*this));
 }
 
-inline Videomode *VideomodeList::Find(const char *name) const
+inline bool Virtual::operator!=(const Virtual &v) const
+{
+    return !operator==(v);
+}
+
+inline int Videomode::operator!=(const Videomode &mode) const
+{
+    return !operator==(mode);
+}
+	
+inline void Videomode::SetAccel(__u32 _accel_flags)
+{
+    accel_flags = _accel_flags;
+}
+	
+inline bool Videomode::IsVirtual(void) const
+{
+    return xres != xres_virtual || yres != yres_virtual;
+}
+
+inline bool Videomode::IsAccel(void) const
+{
+    return accel_flags & FB_ACCELF_TEXT;
+}
+
+inline const Videomode *VideomodeList::Find(const char *name) const
 {
     return (Videomode *)List::Find(name);
 }
diff -urNX dontdiff fbutils.old/include/list.h fbutils/include/list.h
--- fbutils.old/include/list.h	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/include/list.h	2003-12-22 00:05:44.000000000 -0500
@@ -48,6 +48,10 @@
     return Pred->Pred ? Pred : (Node *)NULL;
 }
 
+inline const char *Node::GetName(void) const
+{
+    return Name;
+}
 
     //	List Header
 
diff -urNX dontdiff fbutils.old/include/util.h fbutils/include/util.h
--- fbutils.old/include/util.h	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/include/util.h	2003-12-23 00:28:34.000000000 -0500
@@ -14,13 +14,14 @@
 
 
 extern const char *ProgramName;
+extern bool Opt_quiet;
 
 
     //  Function Prototypes
 
 extern void Die(const char *fmt,...) __attribute__((noreturn));
 extern void Warn(const char *fmt,...);
-extern int GetNextOption(int &argc, const char **&argv,
+extern int GetNextOption(int &argc, char **&argv,
 			 const struct option options[],
 			 const u_int num_options);
 
diff -urNX dontdiff fbutils.old/lib/config.l fbutils/lib/config.l
--- fbutils.old/lib/config.l	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/lib/config.l	2003-12-22 00:56:27.000000000 -0500
@@ -34,18 +34,16 @@
     { "geometry", GEOMETRY, 0 },
     { "format", FORMAT, 0 },
     { "mode", MODE, 0 },
-    { "hsync", HSYNC, 0 },
-    { "vsync", VSYNC, 0 },
-    { "csync", CSYNC, 0 },
+    { "hsync+", HSYNCP, 0 },
+    { "vsync+", VSYNCP, 0 },
+    { "csync+", CSYNCP, 0 },
     { "gsync", GSYNC, 0 },
     { "extsync", EXTSYNC, 0 },
     { "broadcast", BCAST, 0 },
     { "interlace", LACED, 0 },
     { "doublescan", DOUBLE, 0 },
-    { "low", POLARITY, 0 },
-    { "high", POLARITY, 1 },
-    { "false", BOOL, 0 },
-    { "true", BOOL, 1 },
+    { "virtual", VIRTUAL, 0 },
+    { "accel", ACCEL, 0 },
     { "", -1, 0 }
 };
 
@@ -110,7 +108,7 @@
 
 %}
 
-keyword	[a-zA-Z][a-zA-Z0-9]*
+keyword	[a-zA-Z][a-zA-Z0-9\+]*
 int	[0-9]*
 string	\"[^\"\n]*\"
 comment	\#([^\n]*)
@@ -149,6 +147,10 @@
 \}		{
 		    return CLOSEB;
 		}
+		
+\:		{
+		    return COLON;
+		}
 
 {junk}		{
 		    yyerror("Invalid token `%s'\n", yytext);
diff -urNX dontdiff fbutils.old/lib/config.y fbutils/lib/config.y
--- fbutils.old/lib/config.y	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/lib/config.y	2003-12-22 01:00:27.000000000 -0500
@@ -1,4 +1,3 @@
-
 //  Linux Frame Buffer Device Configuration
 //
 //  ��� Copyright 1995-1999 by Geert Uytterhoeven <geert@linux-m68k.org>
@@ -13,6 +12,7 @@
 %{
 
 #define YYSTYPE		long
+#define YY_NO_UNPUT
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -25,21 +25,21 @@
 extern void yyerror(const char *fmt, ...)
     __attribute__((noreturn, format (printf, 1, 2)));
 
-
 static GeometryNode *_GeometryNode = NULL;
 static FormatNode *_FormatNode = NULL;
 
 static Geometry _Geometry;
 static Format _Format;
 static Virtual _Virtual;
+static __u32 _Accel_Flags = 0;
 
 %}
 
 %start file
 
-%token OPENB CLOSEB GEOMETRY FORMAT MODE ALIAS
-    HSYNC VSYNC CSYNC GSYNC EXTSYNC BCAST
-    LACED DOUBLE GRAYSCALE NONSTD ACCEL VIRTUAL POLARITY BOOL STRING INT
+%token OPENB CLOSEB COLON GEOMETRY FORMAT MODE ALIAS
+    HSYNCP VSYNCP CSYNCP GSYNC EXTSYNC BCAST
+    LACED DOUBLE GRAYSCALE NONSTD ACCEL VIRTUAL STRING INT
 
 %%
 
@@ -65,8 +65,7 @@
     //  Screen Geometries
 
 geometry_section
-    : // empty
-    | GEOMETRY named_geometry
+    : GEOMETRY named_geometry
     | GEOMETRY OPENB geometries CLOSEB
     ;
 
@@ -107,16 +106,46 @@
 
 geometry_option
     : LACED
+	{
+	    _Geometry.vmode |= FB_VMODE_INTERLACED;
+	}
     | DOUBLE
+	{
+	    _Geometry.vmode |= FB_VMODE_DOUBLE;
+	}
+    | HSYNCP
+	{
+	    _Geometry.sync |= FB_SYNC_HOR_HIGH_ACT;
+	}
+    | VSYNCP
+	{
+	    _Geometry.sync |= FB_SYNC_VERT_HIGH_ACT;
+	}
+    | CSYNCP
+	{
+	    _Geometry.sync |= FB_SYNC_COMP_HIGH_ACT;
+	}
+    | GSYNC
+	{
+	    _Geometry.sync |= FB_SYNC_ON_GREEN;
+	}
+    | EXTSYNC
+	{
+	    _Geometry.sync |= FB_SYNC_EXT;
+	}
+    | BCAST
+	{
+	    _Geometry.sync |= FB_SYNC_BROADCAST;
+	}
     ;
 
 geometry_ref
     : geometry_name
     | geometry
+    ;
 
 geometry_name
     : STRING
-    | geometry
 	{
 	    const char *s = (const char *)$1;
 	    _GeometryNode = Geometries.Find(s);
@@ -129,8 +158,7 @@
     //  Pixel Formats
 
 format_section
-    : // empty
-    | FORMAT named_format
+    : FORMAT named_format
     | FORMAT OPENB formats CLOSEB
     ;
 
@@ -150,12 +178,53 @@
     ;
 
 format
-    : OPENB INT format_options OPENB
+    : OPENB INT format_bitfields format_options CLOSEB
 	{
 	    _Format.bits_per_pixel = $2;
 	}
     ;
 
+format_bitfields
+    : // empty
+    | format_red_bitfield format_green_bitfield format_blue_bitfield format_transp_bitfield
+    ;
+    
+format_red_bitfield
+    : INT COLON INT COLON INT
+	{
+	    _Format.red.offset = $1;
+	    _Format.red.length = $3;
+	    _Format.red.msb_right = $5;
+	}
+    ;
+
+format_green_bitfield
+    : INT COLON INT COLON INT
+	{
+	    _Format.green.offset = $1;
+	    _Format.green.length = $3;
+	    _Format.green.msb_right = $5;
+	}
+    ;
+
+format_blue_bitfield
+    : INT COLON INT COLON INT
+	{
+	    _Format.blue.offset = $1;
+	    _Format.blue.length = $3;
+	    _Format.blue.msb_right = $5;
+	}
+    ;
+
+format_transp_bitfield
+    : INT COLON INT COLON INT
+	{
+	    _Format.transp.offset = $1;
+	    _Format.transp.length = $3;
+	    _Format.transp.msb_right = $5;
+	}
+    ;
+
 format_options
     : // empty
     | format_options format_option
@@ -169,10 +238,10 @@
 format_ref
     : format_name
     | format
+    ;
 
 format_name
     : STRING
-    | format
 	{
 	    const char *s = (const char *)$1;
 	    _FormatNode = Formats.Find(s);
@@ -185,10 +254,11 @@
     //  Virtual Screen Dimensions
 
 virtual
-    : VIRTUAL INT INT
+    : // empty
+    | VIRTUAL INT INT
 	{
-	    _Virtual.xres_virtual = $1;
-	    _Virtual.yres_virtual = $2;
+	    _Virtual.xres_virtual = $2;
+	    _Virtual.yres_virtual = $3;
 	}
     ;
 
@@ -196,8 +266,7 @@
     //  Video Modes
 
 mode_section
-    : // empty
-    | MODE named_mode
+    : MODE named_mode
     | MODE OPENB modes CLOSEB
     ;
 
@@ -207,30 +276,22 @@
     ;
 
 named_mode
-    : STRING OPENB geometry_ref format_ref mode_options CLOSEB
-	{
-	    const char *s = (const char *)$1;
-	    Videomode *node = new Videomode(s,
-				_GeometryNode ? *_GeometryNode : _Geometry,
-				_FormatNode ? *_FormatNode : _Format);
-	    Videomodes.Add(node);
-	    _GeometryNode = NULL;
-	    _Geometry.Clear();
-	    _FormatNode = NULL;
-	    _Format.Clear();
-	}
-    | STRING OPENB geometry_ref format_ref virtual mode_options CLOSEB
+    : STRING OPENB geometry_ref format_ref virtual mode_options CLOSEB
 	{
 	    const char *s = (const char *)$1;
 	    Videomode *node = new Videomode(s,
 				_GeometryNode ? *_GeometryNode : _Geometry,
 				_FormatNode ? *_FormatNode : _Format,
-				&_Virtual);
+				_Virtual);
+	    node->SetAccel(_Accel_Flags);
+	    node->SetNames(_GeometryNode, _FormatNode);
 	    Videomodes.Add(node);
 	    _GeometryNode = NULL;
 	    _Geometry.Clear();
 	    _FormatNode = NULL;
 	    _Format.Clear();
+	    _Virtual.Clear();
+	    _Accel_Flags = 0;
 	}
     ;
 
@@ -241,14 +302,16 @@
 
 mode_option
     : ACCEL
+	{
+	    _Accel_Flags |= FB_ACCELF_TEXT;
+	}
     ;
 
 
     //  Aliases
 
 alias_section
-    : // empty
-    | ALIAS named_alias
+    : ALIAS named_alias
     | ALIAS OPENB aliases CLOSEB
     ;
 
diff -urNX dontdiff fbutils.old/lib/database.C fbutils/lib/database.C
--- fbutils.old/lib/database.C	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/lib/database.C	2003-12-23 01:03:30.000000000 -0500
@@ -46,9 +46,30 @@
     if (IsDoubleScan())
 	printf("doublescan ");
     // if (sync) ...
+    if (IsSyncHorPos())
+	printf("hsync+ ");
+    if (IsSyncVertPos())
+	printf("vsync+ ");
+    if (IsSyncCompPos())
+	printf("csync+ ");
+    if (IsSyncOnGreen())
+	printf("gsync ");
+    if (IsSyncExt())
+	printf("extsync ");
+    if (IsSyncBcast())
+	printf("broadcast ");
     puts("}");
 }
 
+bool Geometry::operator==(const Geometry &g) const
+{
+    return xres == g.xres && yres == g.yres && pixclock == g.pixclock &&
+	   left_margin == g.left_margin && right_margin == g.right_margin &&
+	   upper_margin == g.upper_margin && lower_margin == g.lower_margin &&
+	   hsync_len == g.hsync_len && vsync_len == g.vsync_len &&
+	   vmode == g.vmode && sync == g.sync;
+}	
+
 void GeometryNode::Dump(bool in_list) const
 {
     printf("%s\"%s\" ", in_list ? "    " : "geometry ",
@@ -88,11 +109,40 @@
 
 void Format::Dump(bool in_list) const
 {
-    printf("{ %d %d:%d:%d %d:%d:%d %d:%d:%d %d:%d:%d %d %d }\n",
-           bits_per_pixel, red.offset, red.length, red.msb_right, green.offset,
-	   green.length, green.msb_right, blue.offset, blue.length,
-	   blue.msb_right, transp.offset, transp.length, transp.msb_right,
-	   grayscale, nonstd);
+    printf("{ %d ", bits_per_pixel );
+
+    if (BitfieldsAreNZ()) 
+        printf("%d:%d:%d %d:%d:%d %d:%d:%d %d:%d:%d ",
+               red.offset, red.length, red.msb_right, green.offset,
+	       green.length, green.msb_right, blue.offset, blue.length,
+	       blue.msb_right, transp.offset, transp.length, transp.msb_right );
+    
+    if (IsGrayscale())
+	printf( "grayscale " );
+	
+    if (IsNonStd()) 
+	printf( "nonstd %d ", nonstd );
+	
+    printf( "}\n" );
+}
+
+bool Format::operator==(const Format& format) const
+{
+    return bits_per_pixel == format.bits_per_pixel &&
+	   grayscale == format.grayscale &&
+	   nonstd == nonstd; /* &&
+	   red.length == format.red.length &&
+	   red.offset == format.red.offset && 
+	   red.msb_right == format.red.msb_right &&    
+	   green.length == format.green.length &&
+	   green.offset == format.green.offset &&
+	   green.msb_right == format.green.msb_right &&    
+	   blue.length == format.blue.length &&
+	   blue.offset == format.blue.offset && 
+	   blue.msb_right == format.blue.msb_right &&    
+	   transp.length == format.transp.length &&
+	   transp.offset == format.transp.offset &&
+	   transp.msb_right == format.transp.msb_right;*/
 }
 
 void FormatNode::Dump(bool in_list) const
@@ -125,21 +175,27 @@
     printf("virtual %d %d\n", xres_virtual, yres_virtual);
 }
 
+bool Virtual::operator==(const Virtual &v) const
+{
+    return xres_virtual == v.xres_virtual &&
+	   yres_virtual == v.yres_virtual;
+}
 
     //  List of Video Modes
 
 Videomode::Videomode(const char *name, const Geometry &geometry,
-		     const Format &format, const Virtual *virtual_)
-    : Node(name), Geometry(geometry), Format(format), PixelRate(0.0),
-      HorizSync(0), VertSync(0)
-{
-    if (virtual_)
-	*((Virtual *)this) = *virtual_;
-    else {
+		     const Format &format, const Virtual &virtual_)
+    : Node(name), Geometry(geometry), Format(format), Virtual(virtual_),
+      PixelRate(0.0), HorizSync(0), VertSync(0)
+{
+    if ( xres_virtual == 0 || yres_virtual == 0 ) {
 	xres_virtual = xres;
 	yres_virtual = yres;
     }
+    accel_flags = 0;
     FillScanRates();
+    geometry_name = NULL;
+    format_name = NULL;
 }
 
 Videomode::Videomode(const VarScreenInfo &var)
@@ -148,6 +204,28 @@
 {
     accel_flags = var.accel_flags;
     FillScanRates();
+    geometry_name = NULL;
+    format_name = NULL;
+}
+
+Videomode::Videomode(const Videomode &mode)
+    : Geometry(mode), Format(mode), Virtual(mode), PixelRate(0.0), HorizSync(0),
+      VertSync(0)
+{
+    accel_flags = mode.accel_flags;
+    PixelRate = mode.PixelRate;
+    HorizSync = mode.HorizSync;
+    VertSync = mode.VertSync;
+    geometry_name = mode.geometry_name;
+    format_name = mode.format_name;
+}
+
+void Videomode::SetNames(const Node *geometry, const Node *format)
+{
+    if (geometry)
+        geometry_name = geometry->GetName();
+    if (format)
+        format_name = format->GetName();
 }
 
 void Videomode::FillScanRates(void)
@@ -185,6 +263,7 @@
     ((Format *)this)->Print(indent2);
     printf("%sVirtual screen dimensions:\n", indent);
     ((Virtual *)this)->Print(indent2);
+    printf("%saccel_flags = %d\n", indent, accel_flags);
 }
 
 void Videomode::Dump(bool in_list) const
@@ -192,18 +271,46 @@
     printf("%s\"%s\" {\n", in_list ? "    " : "mode ",
 	   Name ? Name : "UNNAMED");
     printf(in_list ? "\t" : "    ");
-    Geometry::Dump();
-    printf(in_list ? "\t" : "    ");
-    Format::Dump();
+    if (geometry_name)
+	printf("\"%s\"\n", geometry_name);
+    else
+        Geometry::Dump();
     printf(in_list ? "\t" : "    ");
-    Virtual::Dump();
+    if (format_name)
+	printf("\"%s\"\n", format_name);
+    else
+        Format::Dump();
+    if (IsVirtual()) {
+        printf(in_list ? "\t" : "    ");
+	Virtual::Dump();
+    }
+    if (IsAccel()) 
+        printf( "%saccel\n", in_list ? "\t" : "    ");
     printf("%s}\n", in_list ? "    " : "");
 }
 
+int Videomode::operator==(const Videomode &mode) const
+{
+   return Geometry::operator==(mode) && Format::operator==(mode) && 
+	  Virtual::operator==(mode) && accel_flags == mode.accel_flags;
+}
+
 VideomodeList::VideomodeList()
     : List("mode")
 {}
 
+const Videomode *VideomodeList::TryToFind(const Videomode *mode) const
+{
+    const Videomode *dbmode;
+
+    for (dbmode = (Videomode *)GetHead(); dbmode; dbmode = (Videomode *)dbmode->GetNext()) {
+	if( *dbmode == *mode ) {
+	    return dbmode;
+	}
+    }
+    return mode;
+}
+
 VideomodeList Videomodes;
 
 
diff -urNX dontdiff fbutils.old/lib/framebuffer.C fbutils/lib/framebuffer.C
--- fbutils.old/lib/framebuffer.C	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/lib/framebuffer.C	2003-11-27 01:31:01.000000000 -0500
@@ -164,7 +164,7 @@
     }
 }
 
-void ColorMap::Print(const char *indent = "") const
+void ColorMap::Print(const char *indent) const
 {
     printf("start = %d\n", start);
     printf("len = %d\n", len);
@@ -191,7 +191,7 @@
 	Die("ioctl FBIOPUT_CON2FBMAP: %s\n", strerror(errno));
 }
 
-void Con2FBMap::Print(const char *indent = "") const
+void Con2FBMap::Print(const char *indent) const
 {
     printf("%sconsole %d -> fb %d\n", indent, console, framebuffer);
 }
diff -urNX dontdiff fbutils.old/lib/list.C fbutils/lib/list.C
--- fbutils.old/lib/list.C	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/lib/list.C	2003-11-27 01:28:40.000000000 -0500
@@ -1,4 +1,6 @@
 
+#include <string.h>
+
 #include "list.h"
 #include "util.h"
 
diff -urNX dontdiff fbutils.old/lib/util.C fbutils/lib/util.C
--- fbutils.old/lib/util.C	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/lib/util.C	2003-12-23 00:28:01.000000000 -0500
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <sys/ioctl.h>
 
 #include "util.h"
@@ -19,11 +20,12 @@
 {
     va_list ap;
 
-    fflush(stdout);
-    va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
-    va_end(ap);
-
+    if (!Opt_quiet) {
+	fflush(stdout);
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+    }
     exit(1);
 }
 
@@ -34,16 +36,18 @@
 {
     va_list ap;
 
-    fflush(stdout);
-    va_start(ap, fmt);
-    vfprintf(stderr, fmt, ap);
+    if (!Opt_quiet) {
+	fflush(stdout);
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+    }
     va_end(ap);
 }
 
 
     //  Command Line Parameter Processing
 
-int GetNextOption(int &argc, const char **&argv,
+int GetNextOption(int &argc, char **&argv,
 		  const struct option options[], const u_int num_options)
 {
     static bool first = true;

--------------080901060607020301020900--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
