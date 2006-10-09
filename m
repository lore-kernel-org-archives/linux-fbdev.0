From: Guillem Jover <guillem@debian.org>
Subject: [PATCH 3/7] fbset: send usage to stdout and fix
	its exit code
Date: Mon, 9 Oct 2006 05:40:59 +0300
Message-ID: <20061009024059.GC9011@zulo.hadrons.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mvpLiMfbWzRoNl4x"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GWmgD-0004mL-Eu for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 21:23:53 -0700
Received: from 159.red-81-184-118.user.auna.net ([81.184.118.159]
	helo=pulsar.hadrons.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GWmgC-0003XJ-I4
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 08 Oct 2006 21:23:53 -0700
Received: from guillem by pulsar.hadrons.org with local (Exim 4.50)
	id 1GWl7C-00069N-6T for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 09 Oct 2006 04:43:38 +0200
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

This one makes Usage output to stdout instead of stderr, it also sends
a proper exit code, depending if it has been called due to an error or
the user asking for it via --help.

regards,
guillem

--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fbset_03_usage.patch"

Index: fbset.c
===================================================================
--- fbset.c.orig	2006-10-09 05:29:45.000000000 +0300
+++ fbset.c	2006-10-09 05:33:33.000000000 +0300
@@ -229,7 +229,7 @@ static void ModifyVideoMode(struct Video
 static void DisplayVModeInfo(struct VideoMode *vmode);
 static void DisplayFBInfo(struct fb_fix_screeninfo *fix);
 static int FillScanRates(struct VideoMode *vmode);
-static void Usage(void) __attribute__ ((noreturn));
+static void Usage(int status) __attribute__ ((noreturn));
 int main(int argc, char *argv[]);
 
 
@@ -829,10 +829,12 @@ static int FillScanRates(struct VideoMod
      *  Print the Usage Template and Exit
      */
 
-static void Usage(void)
+static void Usage(int status)
 {
     puts(VERSION);
-    Die("\nUsage: %s [options] [mode]\n\n"
+    printf(
+	"Usage: %s [options] [mode]\n"
+	"\n"
 	"Valid options:\n"
 	"  General options:\n"
 	"    -h, --help         : display this usage information\n"
@@ -887,6 +889,7 @@ static void Usage(void)
 	"    -step <value>      : step increment (in pixels or pixel lines)\n"
 	"                         (default is 8 horizontal, 2 vertical)\n",
 	ProgramName);
+	exit(status);
 }
 
 
@@ -910,7 +913,7 @@ int main(int argc, char *argv[])
     while (--argc > 0) {
 	argv++;
 	if (!strcmp(argv[0], "-h") || !strcmp(argv[0], "--help"))
-	    Usage();
+	    Usage(0);
 	else if (!strcmp(argv[0], "-v") || !strcmp(argv[0], "--verbose"))
 	    Opt_verbose = 1;
 	else if (!strcmp(argv[0], "-V") || !strcmp(argv[0], "--version"))
@@ -937,7 +940,7 @@ int main(int argc, char *argv[])
 		argc -= 5;
 		argv += 5;
 	    } else
-		Usage();
+		Usage(1);
 	} else if (!strcmp(argv[0], "-t") || !strcmp(argv[0], "--timings")) {
 	    if (argc > 7) {
 		Opt_pixclock = argv[1];
@@ -951,7 +954,7 @@ int main(int argc, char *argv[])
 		argc -= 7;
 		argv += 7;
 	    } else
-		Usage();
+		Usage(1);
 	} else if (!strcmp(argv[0], "-match")) {
 	    Opt_matchyres = argv[0];
 	    Opt_change = 1;
@@ -965,12 +968,12 @@ int main(int argc, char *argv[])
 		    Opt_change |= Options[i].change;
 		    argv++;
 		} else
-		    Usage();
+		    Usage(1);
 	    } else if (!Opt_modename) {
 		Opt_modename = argv[0];
 		Opt_change = 1;
 	    } else
-		Usage();
+		Usage(1);
 	}
     }
 

--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--mvpLiMfbWzRoNl4x--
