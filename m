From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/5] Video Mode Handling - Patch for fbset
Date: Mon, 9 Aug 2004 09:47:11 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408090947.11731.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BtzIN-0001Vt-Ho
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:51 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BtzIN-0005dc-0q
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 08 Aug 2004 18:49:51 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 8F0D21054D6D
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon,  9 Aug 2004 01:23:19 +0000 (UTC)
Content-Disposition: inline
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>

Hi,

The patch is against fbset-2.1.  It adds the following:

1. Ask for user confirmation before applying the new mode. If 
rejected by the user, fbset will set the previous mode and
invalidate the last timings.

2. Add support for invalidating modelines.  Usage:

fbset -r pixclock xres yres left right upper lower hslen vslen <-hsync bool> <-vsync bool> <-laced bool> <-double bool>

Options in "<>" are optional.

First 3 patches must be applied. The patch is for
demonstration only, no attempts to beautify the code were done.

Tony

diff -uprN fbset-2.1-orig/fb.h fbset-2.1/fb.h
--- fbset-2.1-orig/fb.h	1999-06-23 22:09:48.000000000 +0800
+++ fbset-2.1/fb.h	2004-08-09 09:13:32.470502928 +0800
@@ -120,6 +120,7 @@ struct fb_bitfield {
 #define FB_ACTIVATE_VBL	       16	/* activate values on next vbl  */
 #define FB_CHANGE_CMAP_VBL     32	/* change colormap on vbl	*/
 #define FB_ACTIVATE_ALL	       64	/* change all VCs on this fb	*/
+#define FB_ACTIVATE_INV_MODE   256      /* remove videomode from list   */
 
 #define FB_ACCELF_TEXT		1	/* text mode acceleration */
 
diff -uprN fbset-2.1-orig/fbset.c fbset-2.1/fbset.c
--- fbset-2.1-orig/fbset.c	1999-06-23 22:11:46.000000000 +0800
+++ fbset-2.1/fbset.c	2004-08-09 09:16:49.747512264 +0800
@@ -65,6 +65,7 @@ static int Opt_verbose = 0;
 static int Opt_xfree86 = 0;
 static int Opt_change = 0;
 static int Opt_all = 0;
+static int Opt_remove = 0;
 
 static const char *Opt_fb = NULL;
 const char *Opt_modedb = DEFAULT_MODEDBFILE;
@@ -324,10 +325,12 @@ static void ConvertFromVideoMode(const s
     var->nonstd = vmode->nonstd;
     if (Opt_test)
 	var->activate = FB_ACTIVATE_TEST;
-    else
+    else 
 	var->activate = FB_ACTIVATE_NOW;
     if (Opt_all)
 	var->activate = FB_ACTIVATE_ALL;
+    if (Opt_remove)
+	var->activate = FB_ACTIVATE_INV_MODE;
     var->accel_flags = vmode->accel_flags;
     var->pixclock = vmode->pixclock;
     var->left_margin = vmode->left;
@@ -868,6 +871,10 @@ static void Usage(void)
 	"    -hslen <value>     : horizontal sync length (in pixels)\n"
 	"    -vslen <value>     : vertical sync length (in pixel lines)\n"
 	"    -t, --timings ...  : set all timing parameters at once\n"
+	"    -r, --remove ...   : invalidate mode timings\n"
+	"                         pixclock xres yres left right\n"
+	"                         upper lower hslen vslen\n"
+	"                         <-laced> <-double> <-hsync> <-vsync>\n" 
 	"  Display flags:\n"
 	"    -accel <value>     : hardware text acceleration enable (false or "
 				 "true)\n"
@@ -926,7 +933,24 @@ int main(int argc, char *argv[])
 	    Opt_xfree86 = 1;
 	else if (!strcmp(argv[0], "-a") || !strcmp(argv[0], "--all"))
 	    Opt_all = 1;
-	else if (!strcmp(argv[0], "-g") || !strcmp(argv[0], "--geometry")) {
+	else if (!strcmp(argv[0], "-r") || !strcmp(argv[0], "-remove")) {
+	    if (argc > 9) {
+		Opt_pixclock = argv[1];
+		Opt_xres = argv[2];
+		Opt_yres = argv[3];
+		Opt_left = argv[4];
+		Opt_right = argv[5];
+		Opt_upper = argv[6];
+		Opt_lower = argv[7];
+		Opt_hslen = argv[8];
+		Opt_vslen = argv[9];
+		Opt_change = 1;
+		Opt_remove = 1;
+		argc -= 9;
+		argv += 9;
+	    } else
+		Usage();
+	} else if (!strcmp(argv[0], "-g") || !strcmp(argv[0], "--geometry")) {
 	    if (argc > 5) {
 		Opt_xres = argv[1];
 		Opt_yres = argv[2];
@@ -1012,8 +1036,14 @@ int main(int argc, char *argv[])
     }
 
     if (Opt_change) {
+	struct fb_var_screeninfo cur;
+	int done = 0, c;
 
 	/*
+	 * Get Current Var
+	 */
+	GetVarScreenInfo(fh, &cur);
+	/*
 	 *  Optionally Modify the Video Mode
 	 */
 
@@ -1024,12 +1054,29 @@ int main(int argc, char *argv[])
 	 */
 
 	ConvertFromVideoMode(&Current, &var);
-	if (Opt_verbose)
-	    printf("Setting video mode to `%s'\n", Opt_fb);
+	if (Opt_verbose) {
+	    if (Opt_remove) 
+		printf("Removing video mode to '%s'\n", Opt_fb);
+	    else
+		printf("Setting video mode to `%s'\n", Opt_fb);
+	}
 	SetVarScreenInfo(fh, &var);
 	ConvertToVideoMode(&var, &Current);
+	if (!Opt_remove) {
+	    while (!done) {
+		printf("Accept Video Mode Settings? (Y/N) ");
+		c = getchar();
+		if (c == 'Y' || c == 'y') 
+		    done = 1;
+		else if (c == 'N' || c == 'n') {
+		    SetVarScreenInfo(fh, &cur);
+		    var.activate = FB_ACTIVATE_INV_MODE;
+		    SetVarScreenInfo(fh, &var);
+		    done = 1;
+		}
+	    }
+	}
     }
-
     /*
      *  Display some Video Mode Information
      */




-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
