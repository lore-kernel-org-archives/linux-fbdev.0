From: Antonino Daplas <adaplas@pol.net>
Subject: [Patch 4] Console Rotation
Date: 09 Sep 2002 22:23:23 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1031580924.632.15.camel@daplas>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.167.79.9] (helo=willow.compass.com.ph)
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17oPQx-0003Yn-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 09 Sep 2002 07:22:35 -0700
Received: from AP-202-70-99-9.compass.com.ph (AP-202-70-99-9.compass.com.ph [202.70.99.9])
	by willow.compass.com.ph (8.9.3/8.9.3) with ESMTP id WAA90413
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 9 Sep 2002 22:22:31 +0800 (PHT)
	(envelope-from adaplas@pol.net)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

The patch (fbset_rotate.diff), which is against fbset-2.1, adds 3 new
options to set the rotation: 

fbset -{cw|ccw|ud} {true|false} 

Try this with the modified vesafb. 

Tony 

<<------------------------------------------------------------------>> 
diff -Naur fbset-orig/fb.h fbset-2.1/fb.h
--- fbset-orig/fb.h	Wed Jun 23 22:09:48 1999
+++ fbset-2.1/fb.h	Sat Sep  7 11:28:41 2002
@@ -137,6 +137,11 @@
 #define FB_VMODE_DOUBLE		2	/* double scan */
 #define FB_VMODE_MASK		255
 
+#define FB_VMODE_ROTATE_CW      0x010000
+#define FB_VMODE_ROTATE_CCW     0x020000
+#define FB_VMODE_ROTATE_UD      0x040000
+#define FB_ROTATE_MASK          0xFF0000
+
 #define FB_VMODE_YWRAP		256	/* ywrap instead of panning     */
 #define FB_VMODE_SMOOTH_XPAN	512	/* smooth xpan possible (internally used) */
 #define FB_VMODE_CONUPDATE	512	/* don't update x/yoffset	*/
diff -Naur fbset-orig/fbset.c fbset-2.1/fbset.c
--- fbset-orig/fbset.c	Wed Jun 23 22:11:46 1999
+++ fbset-2.1/fbset.c	Sun Sep  8 09:44:19 2002
@@ -89,6 +89,9 @@
 static const char *Opt_bcast = NULL;
 static const char *Opt_laced = NULL;
 static const char *Opt_double = NULL;
+static const char *Opt_cw = NULL;
+static const char *Opt_ccw = NULL;
+static const char *Opt_ud = NULL;
 static const char *Opt_move = NULL;
 static const char *Opt_step = NULL;
 static const char *Opt_modename = NULL;
@@ -126,6 +129,9 @@
     { "-bcast", &Opt_bcast, 1 },
     { "-laced", &Opt_laced, 1 },
     { "-double", &Opt_double, 1 },
+    { "-cw", &Opt_cw, 1 }, 
+    { "-ccw", &Opt_ccw, 1 }, 
+    { "-ud", &Opt_ud, 1 }, 
     { "-move", &Opt_move, 1 },
     { "-step", &Opt_step, 1 },
     { "-rgba", &Opt_rgba, 1 },
@@ -354,6 +360,15 @@
 	var->vmode = FB_VMODE_DOUBLE;
     else
 	var->vmode = FB_VMODE_NONINTERLACED;
+
+    var->vmode &= ~FB_ROTATE_MASK;
+    if (vmode->cw == TRUE) 
+	var->vmode |= FB_VMODE_ROTATE_CW;
+    else if (vmode->ccw == TRUE)
+	var->vmode |= FB_VMODE_ROTATE_CCW;
+    else if (vmode->ud == TRUE)
+	var->vmode |= FB_VMODE_ROTATE_UD;
+
     var->vmode |= FB_VMODE_CONUPDATE;
     var->red.length = vmode->red.length;
     var->red.offset = vmode->red.offset;
@@ -402,6 +417,21 @@
 	    vmode->dblscan = TRUE;
 	    break;
     }
+
+    vmode->cw = FALSE;
+    vmode->ccw = FALSE;
+    vmode->ud = FALSE;
+    switch (var->vmode & FB_ROTATE_MASK) {
+        case FB_VMODE_ROTATE_CW:
+	    vmode->cw = TRUE;
+	    break;
+        case FB_VMODE_ROTATE_CCW:
+            vmode->ccw = TRUE;
+	    break;
+        case FB_VMODE_ROTATE_UD:
+            vmode->ud = TRUE;
+	    break;
+    }
     vmode->red.length = var->red.length;
     vmode->red.offset = var->red.offset;
     vmode->green.length = var->green.length;
@@ -567,6 +597,12 @@
 	vmode->laced = atoboolean(Opt_laced);
     if (Opt_double)
 	vmode->dblscan = atoboolean(Opt_double);
+    if (Opt_cw)
+	vmode->cw = atoboolean(Opt_cw);
+    if (Opt_ccw)
+	vmode->ccw = atoboolean(Opt_ccw);
+    if (Opt_ud)
+	vmode->ud = atoboolean(Opt_ud);
     if (Opt_grayscale)
 	vmode->grayscale = atoboolean(Opt_grayscale);
     if (Opt_step)
@@ -643,6 +679,12 @@
 	    puts("    laced true");
 	if (vmode->dblscan)
 	    puts("    double true");
+	if (vmode->cw)
+	    puts("    cw true");
+	if (vmode->ccw)
+	    puts("    ccw true");
+	if (vmode->ud)
+	    puts("    ud true");
 	if (vmode->nonstd)
             printf("    nonstd %u\n", vmode->nonstd);
 	if (vmode->accel_flags)
@@ -677,6 +719,12 @@
 	    printf(" \"Interlace\"");
 	if (vmode->dblscan)
 	    printf(" \"DoubleScan\"");
+	if (vmode->cw)
+	    printf(" \"Clockwise Rotation\"");
+	if (vmode->ccw)
+	    printf(" \"CounterClockwise Rotation\"");
+	if (vmode->ud)
+	    printf(" \"180 degree Rotation\"");
 	if (vmode->hsync)
 	    printf(" \"+HSync\"");
 	else
@@ -879,6 +927,9 @@
 	"    -bcast <value>     : broadcast enable (false or true)\n"
 	"    -laced <value>     : interlace enable (false or true)\n"
 	"    -double <value>    : doublescan enable (false or true)\n"
+	"    -cw <value>        : rotate clockwise (false or true)\n"
+	"    -ccw <value>       : rotate counter clockwise (false or true)\n"
+	"    -ud <value>        : rotate 180 degrees (false or true)\n"
 	"    -rgba <r,g,b,a>    : recommended length of color entries\n"
 	"    -grayscale <value> : grayscale enable (false or true)\n"
 	"  Display positioning:\n"
diff -Naur fbset-orig/fbset.h fbset-2.1/fbset.h
--- fbset-orig/fbset.h	Wed Jun 23 22:12:28 1999
+++ fbset-2.1/fbset.h	Sat Sep  7 10:39:28 2002
@@ -62,6 +62,9 @@
     unsigned extsync : 1;
     unsigned bcast : 1;
     unsigned laced : 1;
+    unsigned cw    : 1;
+    unsigned ccw   : 1;
+    unsigned ud    : 1;
     unsigned dblscan : 1;
     unsigned grayscale : 1;
     /* scanrates */
diff -Naur fbset-orig/modes.l fbset-2.1/modes.l
--- fbset-orig/modes.l	Wed Jun 23 22:09:48 1999
+++ fbset-2.1/modes.l	Sat Sep  7 11:37:09 2002
@@ -41,6 +41,9 @@
     { "bcast", BCAST, 0 },
     { "laced", LACED, 0 },
     { "double", DOUBLE, 0 },
+    { "cw", CW, 0 }, 
+    { "ccw", CCW, 0 }, 
+    { "ud", UD, 0 }, 
     { "rgba", RGBA, 0 },
     { "nonstd", NONSTD, 0 },
     { "accel", ACCEL, 0 },
diff -Naur fbset-orig/modes.y fbset-2.1/modes.y
--- fbset-orig/modes.y	Wed Jun 23 22:09:48 1999
+++ fbset-2.1/modes.y	Sat Sep  7 11:34:39 2002
@@ -41,7 +41,7 @@
 %start file
 
 %token MODE GEOMETRY TIMINGS HSYNC VSYNC CSYNC GSYNC EXTSYNC BCAST LACED DOUBLE
-       RGBA NONSTD ACCEL GRAYSCALE
+       CW CCW UD RGBA NONSTD ACCEL GRAYSCALE
        ENDMODE POLARITY BOOLEAN STRING NUMBER 
 
 %%
@@ -94,6 +94,9 @@
 	  | options bcast
 	  | options laced
 	  | options double
+          | options cw
+          | options ccw
+          | options ud
 	  | options rgba
 	  | options nonstd
 	  | options accel
@@ -145,6 +148,24 @@
 double	  : DOUBLE BOOLEAN
 	    {
 		VideoMode.dblscan = $2;
+	    }
+	  ;
+
+cw	  : DOUBLE CW
+	    {
+		VideoMode.cw = $2;
+	    }
+	  ;
+
+ccw	  : DOUBLE CCW
+	    {
+		VideoMode.ccw = $2;
+	    }
+	  ;
+
+ud	  : DOUBLE UD
+	    {
+		VideoMode.ud = $2;
 	    }
 	  ;
 



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
