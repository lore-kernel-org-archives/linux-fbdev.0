From: John Zielinski <grim@undead.cc>
Subject: Re: fbutils
Date: Wed, 07 Jan 2004 21:26:05 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3FFCBFBD.1010806@undead.cc>
References: <3FE649BF.30501@undead.cc> <3FE7DCAC.8000204@undead.cc> <Pine.LNX.4.58.0401061420420.1856@callisto>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AePrn-00056b-4x
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jan 2004 18:25:47 -0800
Received: from mail.undead.cc ([216.126.84.18])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AePrm-0003Zq-O7
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 07 Jan 2004 18:25:46 -0800
In-Reply-To: <Pine.LNX.4.58.0401061420420.1856@callisto>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

Geert Uytterhoeven wrote:

>--- fbutils-john-2/etc/modes	2004-01-04 15:38:38.000000000 +0100
>+++ fbutils/etc/modes	2004-01-04 15:33:21.000000000 +0100
>@@ -14,7 +14,7 @@
>     "640x480@75"	# 640x480 @ 75 Hz, 37.50 kHz hsync
> 	{ 640 480 31746 120 16 16 1 64 3 }
>     "800x600@60"	# 800x600 @ 60 Hz, 37.8 kHz hsync
>-	{ 800 600 25000 88 40 23 1 128 4 0 hsync+ vsync+ }
>+	{ 800 600 25000 88 40 23 1 128 4 hsync+ vsync+ }
>     "640x480@85"	# 640x480 @ 85 Hz, 43.27 kHz hsync
> 	{ 640 480 27777 80 56 25 1 56 3 }
>     "1152x864@89"	# 1152x864 @ 89 Hz interlaced, 44 kHz hsync
>  
>

Woops.  I changed that in my /etc/fb/modes file but forgot to update the 
one in the source package.

>--- fbutils-john-2/fbset/fbset.C	2004-01-04 15:38:38.000000000 +0100
>+++ fbutils/fbset/fbset.C	2004-01-04 15:42:02.000000000 +0100
>@@ -259,8 +259,8 @@
>
>     //  Parse the Options
>
>-    while (id = GetNextOption(argc, argv, Options,
>-			       sizeof(Options)/sizeof(*Options))) {
>+    while ((id = GetNextOption(argc, argv, Options,
>+			       sizeof(Options)/sizeof(*Options)))) {
> 	switch (id) {
> 	    case ID_HELP:
> 		Usage();
>
>  
>
Already cought that one.  Don't know why I changed it in the first 
place.  That must have been a late night session or something.  :)

I still have a couple of  command line options that need finishing.  
I'll have another updated patch with those in the next few days.  I've 
been extremely busy lately: holidays, email server dying, Prince of 
Persia....

John




-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
