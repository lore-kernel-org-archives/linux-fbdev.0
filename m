From: John Zielinski <grim@undead.cc>
Subject: fbutils
Date: Sun, 21 Dec 2003 20:32:47 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FE649BF.30501@undead.cc>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070000020603050901060409"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYEwV-0006Op-AF
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Dec 2003 17:33:07 -0800
Received: from ns2.undead.cc ([216.126.84.18] helo=mail.undead.cc)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AYEwU-0001FS-0e
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Dec 2003 17:33:06 -0800
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
--------------070000020603050901060409
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here's a patch to get fbutils from the CVS working if anyone else wants 
to play around with them.

John


--------------070000020603050901060409
Content-Type: text/plain;
 name="patch.fbutils"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="patch.fbutils"

diff -urNX dontdiff fbutils.old/etc/modes fbutils/etc/modes
--- fbutils.old/etc/modes	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/etc/modes	2003-12-09 14:45:37.000000000 -0500
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
diff -urNX dontdiff fbutils.old/fbconvert/fbconvert.C fbutils/fbconvert/fbconvert.C
--- fbutils.old/fbconvert/fbconvert.C	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/fbconvert/fbconvert.C	2003-12-21 20:20:29.000000000 -0500
@@ -29,7 +29,6 @@
 
 static bool Opt_version = false;
 static bool Opt_verbose = false;
-static bool Opt_quiet = false;
 static const char *Opt_debug = NULL;
 const char *Opt_modedb = NULL;
 
@@ -39,7 +38,6 @@
     { ID_HELP, 'h', "help", NULL, 0 },
     { 0, 'V', "version", &Opt_version, 0 },
     { 0, 'v', "verbose", &Opt_verbose, 0 },
-    { 0, 'q', "quiet", &Opt_quiet, 0 },
 };
 
 u_int DebugMask = 0;
@@ -50,18 +48,12 @@
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
 
diff -urNX dontdiff fbutils.old/fbset/fbset.C fbutils/fbset/fbset.C
--- fbutils.old/fbset/fbset.C	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/fbset/fbset.C	2003-12-13 20:25:28.000000000 -0500
@@ -118,63 +118,117 @@
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
 
 static bool ModifyVideomode(Videomode &mode)
 {
-    //
-
-    u_int hstep = 8, vstep = 2;
+    bool changed = false;
+//    u_int hstep = 8, vstep = 2;
 
-    if (Modify_xres)
-	{} // vmode.xres = strtoul(Modify_xres, NULL, 0);
-    if (Modify_yres)
-	{} // vmode.yres = strtoul(Modify_yres, NULL, 0);
-    if (Modify_vxres)
-	{} // vmode.vxres = strtoul(Modify_vxres, NULL, 0);
-    if (Modify_vyres)
-	{} // vmode.vyres = strtoul(Modify_vyres, NULL, 0);
-    if (Modify_depth)
-	{} // vmode.depth = strtoul(Modify_depth, NULL, 0);
-    if (Modify_accel)
-	{} // vmode.accel_flags = atoboolean(Modify_accel) ? FB_ACCELF_TEXT : 0;
-    if (Modify_pixclock)
-	{} // vmode.pixclock = strtoul(Modify_pixclock, NULL, 0);
-    if (Modify_left)
-	{} // vmode.left = strtoul(Modify_left, NULL, 0);
-    if (Modify_right)
-	{} // vmode.right = strtoul(Modify_right, NULL, 0);
-    if (Modify_upper)
-	{} // vmode.upper = strtoul(Modify_upper, NULL, 0);
-    if (Modify_lower)
-	{} // vmode.lower = strtoul(Modify_lower, NULL, 0);
-    if (Modify_hslen)
-	{} // vmode.hslen = strtoul(Modify_hslen, NULL, 0);
-    if (Modify_vslen)
-	{} // vmode.vslen = strtoul(Modify_vslen, NULL, 0);
-    if (Modify_hsync)
-	{} // vmode.hsync = atoboolean(Modify_hsync);
-    if (Modify_vsync)
-	{} // vmode.vsync = atoboolean(Modify_vsync);
-    if (Modify_csync)
-	{} // vmode.csync = atoboolean(Modify_csync);
-    if (Modify_gsync)
-	{} // vmode.gsync = atoboolean(Modify_gsync);
-    if (Modify_extsync)
-	{} // vmode.extsync = atoboolean(Modify_extsync);
-    if (Modify_bcast)
-	{} // vmode.bcast = atoboolean(Modify_bcast);
-    if (Modify_laced)
-	{} // vmode.laced = atoboolean(Modify_laced);
-    if (Modify_double)
-	{} // vmode.dblscan = atoboolean(Modify_double);
-    if (Modify_step)
-	hstep = vstep = strtoul(Modify_step, NULL, 0);
+    if (Modify_xres) {
+	mode.xres = strtoul(Modify_xres, NULL, 0);
+	changed = true;
+    }
+    if (Modify_yres) {
+	mode.yres = strtoul(Modify_yres, NULL, 0);
+	changed = true;
+    }
+    if (Modify_vxres) {
+	mode.xres_virtual = strtoul(Modify_vxres, NULL, 0);
+	changed = true;
+    }
+    if (Modify_vyres) {
+	mode.yres_virtual = strtoul(Modify_vyres, NULL, 0);
+	changed = true;
+    }
+    if (Modify_depth) {
+	mode.bits_per_pixel = strtoul(Modify_depth, NULL, 0);
+	changed = true;
+    }
+    if (Modify_accel) {
+	atoboolean(Modify_accel) ? mode.accel_flags |= FB_ACCELF_TEXT : mode.accel_flags &= ~FB_ACCELF_TEXT;
+	changed = true;
+    }
+    if (Modify_pixclock) {
+	mode.pixclock = strtoul(Modify_pixclock, NULL, 0);
+	changed = true;
+    }
+    if (Modify_left) {
+	mode.left_margin = strtoul(Modify_left, NULL, 0);
+	changed = true;
+    }
+    if (Modify_right) {
+	mode.right_margin = strtoul(Modify_right, NULL, 0);
+	changed = true;
+    }
+    if (Modify_upper) {
+	mode.upper_margin = strtoul(Modify_upper, NULL, 0);
+	changed = true;
+    }
+    if (Modify_lower) {
+	mode.lower_margin = strtoul(Modify_lower, NULL, 0);
+	changed = true;
+    }
+    if (Modify_hslen) {
+	mode.hsync_len = strtoul(Modify_hslen, NULL, 0);
+	changed = true;
+    }
+    if (Modify_vslen) {
+	mode.vsync_len = strtoul(Modify_vslen, NULL, 0);
+	changed = true;
+    }
+    if (Modify_hsync) {
+	atoboolean(Modify_hsync) ? mode.sync |= FB_SYNC_HOR_HIGH_ACT : mode.sync &= ~FB_SYNC_HOR_HIGH_ACT;
+	changed = true;
+    }
+    if (Modify_vsync) {
+	atoboolean(Modify_vsync) ? mode.sync |= FB_SYNC_VERT_HIGH_ACT : mode.sync &= ~FB_SYNC_VERT_HIGH_ACT; 
+	changed = true;
+    }
+    if (Modify_csync) {
+	atoboolean(Modify_csync) ? mode.sync |= FB_SYNC_COMP_HIGH_ACT : mode.sync &= ~FB_SYNC_COMP_HIGH_ACT;
+	changed = true;
+    }
+    if (Modify_gsync) {
+	atoboolean(Modify_gsync) ? mode.sync |= FB_SYNC_ON_GREEN : mode.sync &= ~FB_SYNC_ON_GREEN;
+	changed = true;
+    }
+    if (Modify_extsync) {
+	atoboolean(Modify_extsync) ? mode.sync |= FB_SYNC_EXT : mode.sync &= ~FB_SYNC_EXT;
+	changed = true;
+    }
+    if (Modify_bcast) {
+	atoboolean(Modify_bcast) ? mode.sync |= FB_SYNC_BROADCAST : mode.sync &= ~FB_SYNC_BROADCAST;
+	changed = true;
+    }
+    if (Modify_laced) {
+	mode.vmode &= ~FB_VMODE_MASK;	
+	mode.vmode = atoboolean(Modify_laced) ? FB_VMODE_INTERLACED : 0;
+	changed = true;
+    }
+    else if (Modify_double) {
+	mode.vmode &= ~FB_VMODE_MASK;	
+	mode.vmode = atoboolean(Modify_double) ? FB_VMODE_DOUBLE : 0;
+	changed = true;
+    }
+    if (Modify_step) {
+	//hstep = vstep = strtoul(Modify_step, NULL, 0);
+	//changed = true;
+    }
     if (Modify_move) {
-	{} //
+	//changed = true;
     }
-    return false;
+    return changed;
 }
 
 
@@ -243,6 +297,8 @@
 {
     int id;
     bool changed;
+    bool setmode;
+    Videomode *mode;
 
     //  Parse the Options
 
@@ -267,30 +323,38 @@
 
     FrameBuffer fb(Opt_fb);
 
-    if (Opt_info) {
-	FixScreenInfo fix;
-	fix.Get(fb);
-	fix.Print();
-    }
-    Videomode *mode;
-    if (Opt_modename) {
-	ReadDatabase();
-	if (Opt_dump)
-	    DumpDatabase();
-	mode = Videomodes.Find(Opt_modename);
-    } else {
-	VarScreenInfo var;
-	var.Get(fb);
-	mode = new Videomode(var);
-	mode->Dump();
-    }
-
-    changed = ModifyVideomode(*mode);
-
-    if (changed && !Opt_just_print) {
-	VarScreenInfo var(*mode);
-	var.Set(fb);
-    }
+    ReadDatabase();
 
-    exit(0);
+    if (Opt_dump) {
+        DumpDatabase();
+    } else {	    
+	if (Opt_info) {
+	    FixScreenInfo fix;
+	    fix.Get(fb);
+	    fix.Print();
+	}
+	
+	if (Opt_modename) {
+	    mode = Videomodes.Find(Opt_modename);
+	    if( mode == NULL ) {
+		printf( "\nMode %s not found.\n\n", Opt_modename );
+		return 1;
+	    }
+	    setmode = true;
+        } else {
+    	    VarScreenInfo var;
+	    var.Get(fb);
+	    mode = new Videomode(var);
+	    setmode = false;
+	}
+
+	changed = ModifyVideomode(*mode);
+        mode->Dump();
+
+	if ((setmode || changed) && !Opt_just_print) {
+	    VarScreenInfo var(*mode);
+	    var.Set(fb);
+        }
+    }
+    return 0;
 }
diff -urNX dontdiff fbutils.old/include/database.h fbutils/include/database.h
--- fbutils.old/include/database.h	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/include/database.h	2003-12-21 20:22:20.000000000 -0500
@@ -19,6 +19,12 @@
 	virtual void Dump(bool in_list = false) const;
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
@@ -57,6 +63,9 @@
 	void Clear(void);
 	void Print(const char *indent = "") const;
 	virtual void Dump(bool in_list = false) const;
+	bool BitfieldsAreNZ(void) const;
+	bool IsGrayscale(void) const;
+	bool IsNonStd(void) const;
 
 	__u32 bits_per_pixel;
 	__u32 grayscale;
@@ -150,6 +159,36 @@
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
@@ -170,6 +209,24 @@
     memset(this, 0, sizeof(*this));
 }
 
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
diff -urNX dontdiff fbutils.old/include/util.h fbutils/include/util.h
--- fbutils.old/include/util.h	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/include/util.h	2003-11-27 01:33:58.000000000 -0500
@@ -20,7 +20,7 @@
 
 extern void Die(const char *fmt,...) __attribute__((noreturn));
 extern void Warn(const char *fmt,...);
-extern int GetNextOption(int &argc, const char **&argv,
+extern int GetNextOption(int &argc, char **&argv,
 			 const struct option options[],
 			 const u_int num_options);
 
diff -urNX dontdiff fbutils.old/lib/config.l fbutils/lib/config.l
--- fbutils.old/lib/config.l	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/lib/config.l	2003-12-09 16:56:06.000000000 -0500
@@ -34,18 +34,14 @@
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
     { "", -1, 0 }
 };
 
@@ -110,7 +106,7 @@
 
 %}
 
-keyword	[a-zA-Z][a-zA-Z0-9]*
+keyword	[a-zA-Z][a-zA-Z0-9\+]*
 int	[0-9]*
 string	\"[^\"\n]*\"
 comment	\#([^\n]*)
@@ -149,6 +145,10 @@
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
+++ fbutils/lib/config.y	2003-12-09 16:56:57.000000000 -0500
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
@@ -25,7 +25,6 @@
 extern void yyerror(const char *fmt, ...)
     __attribute__((noreturn, format (printf, 1, 2)));
 
-
 static GeometryNode *_GeometryNode = NULL;
 static FormatNode *_FormatNode = NULL;
 
@@ -37,9 +36,9 @@
 
 %start file
 
-%token OPENB CLOSEB GEOMETRY FORMAT MODE ALIAS
-    HSYNC VSYNC CSYNC GSYNC EXTSYNC BCAST
-    LACED DOUBLE GRAYSCALE NONSTD ACCEL VIRTUAL POLARITY BOOL STRING INT
+%token OPENB CLOSEB COLON GEOMETRY FORMAT MODE ALIAS
+    HSYNCP VSYNCP CSYNCP GSYNC EXTSYNC BCAST
+    LACED DOUBLE GRAYSCALE NONSTD ACCEL VIRTUAL STRING INT
 
 %%
 
@@ -65,8 +64,7 @@
     //  Screen Geometries
 
 geometry_section
-    : // empty
-    | GEOMETRY named_geometry
+    : GEOMETRY named_geometry
     | GEOMETRY OPENB geometries CLOSEB
     ;
 
@@ -107,16 +105,46 @@
 
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
@@ -129,8 +157,7 @@
     //  Pixel Formats
 
 format_section
-    : // empty
-    | FORMAT named_format
+    : FORMAT named_format
     | FORMAT OPENB formats CLOSEB
     ;
 
@@ -150,12 +177,53 @@
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
@@ -169,10 +237,10 @@
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
@@ -196,8 +264,7 @@
     //  Video Modes
 
 mode_section
-    : // empty
-    | MODE named_mode
+    : MODE named_mode
     | MODE OPENB modes CLOSEB
     ;
 
@@ -247,8 +314,7 @@
     //  Aliases
 
 alias_section
-    : // empty
-    | ALIAS named_alias
+    : ALIAS named_alias
     | ALIAS OPENB aliases CLOSEB
     ;
 
diff -urNX dontdiff fbutils.old/lib/database.C fbutils/lib/database.C
--- fbutils.old/lib/database.C	2001-08-06 13:28:23.000000000 -0400
+++ fbutils/lib/database.C	2003-12-09 17:18:38.000000000 -0500
@@ -46,6 +46,18 @@
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
 
@@ -88,11 +100,21 @@
 
 void Format::Dump(bool in_list) const
 {
-    printf("{ %d %d:%d:%d %d:%d:%d %d:%d:%d %d:%d:%d %d %d }\n",
-           bits_per_pixel, red.offset, red.length, red.msb_right, green.offset,
-	   green.length, green.msb_right, blue.offset, blue.length,
-	   blue.msb_right, transp.offset, transp.length, transp.msb_right,
-	   grayscale, nonstd);
+    printf("{ %d ", bits_per_pixel );
+
+    if( BitfieldsAreNZ() ) 
+        printf("%d:%d:%d %d:%d:%d %d:%d:%d %d:%d:%d ",
+               red.offset, red.length, red.msb_right, green.offset,
+	       green.length, green.msb_right, blue.offset, blue.length,
+	       blue.msb_right, transp.offset, transp.length, transp.msb_right );
+    
+    if( IsGrayscale() )
+	printf( "grayscale " );
+	
+    if( IsNonStd() ) 
+	printf( "nonstd %d ", nonstd );
+	
+    printf( "}\n" );
 }
 
 void FormatNode::Dump(bool in_list) const
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
+++ fbutils/lib/util.C	2003-11-27 01:33:46.000000000 -0500
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <sys/ioctl.h>
 
 #include "util.h"
@@ -43,7 +44,7 @@
 
     //  Command Line Parameter Processing
 
-int GetNextOption(int &argc, const char **&argv,
+int GetNextOption(int &argc, char **&argv,
 		  const struct option options[], const u_int num_options)
 {
     static bool first = true;

--------------070000020603050901060409--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
