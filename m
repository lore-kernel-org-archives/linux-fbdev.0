From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: fbutils
Date: Tue, 6 Jan 2004 14:22:45 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401061420420.1856@callisto>
References: <3FE649BF.30501@undead.cc> <3FE7DCAC.8000204@undead.cc>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AdrAf-0006fG-3d
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 05:22:57 -0800
Received: from amsfep12-int.chello.nl ([213.46.243.18])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AdrAe-0005UW-Hb
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 05:22:56 -0800
In-Reply-To: <3FE7DCAC.8000204@undead.cc>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Zielinski <grim@undead.cc>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 23 Dec 2003, John Zielinski wrote:
> I didn't get as much done as I've hoped but there's a few important
> fixes so I'll repost early.  Apply to a fresh CVS copy.

Thanks!

I need these patches to:
  - accept the included etc/modes as a valid config file
  - kill a warning

If these are OK, I'll check everything in (someday :-)

--- fbutils-john-2/etc/modes	2004-01-04 15:38:38.000000000 +0100
+++ fbutils/etc/modes	2004-01-04 15:33:21.000000000 +0100
@@ -14,7 +14,7 @@
     "640x480@75"	# 640x480 @ 75 Hz, 37.50 kHz hsync
 	{ 640 480 31746 120 16 16 1 64 3 }
     "800x600@60"	# 800x600 @ 60 Hz, 37.8 kHz hsync
-	{ 800 600 25000 88 40 23 1 128 4 0 hsync+ vsync+ }
+	{ 800 600 25000 88 40 23 1 128 4 hsync+ vsync+ }
     "640x480@85"	# 640x480 @ 85 Hz, 43.27 kHz hsync
 	{ 640 480 27777 80 56 25 1 56 3 }
     "1152x864@89"	# 1152x864 @ 89 Hz interlaced, 44 kHz hsync
--- fbutils-john-2/fbset/fbset.C	2004-01-04 15:38:38.000000000 +0100
+++ fbutils/fbset/fbset.C	2004-01-04 15:42:02.000000000 +0100
@@ -259,8 +259,8 @@

     //  Parse the Options

-    while (id = GetNextOption(argc, argv, Options,
-			       sizeof(Options)/sizeof(*Options))) {
+    while ((id = GetNextOption(argc, argv, Options,
+			       sizeof(Options)/sizeof(*Options)))) {
 	switch (id) {
 	    case ID_HELP:
 		Usage();

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
