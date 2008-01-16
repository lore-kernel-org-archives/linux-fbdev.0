From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 9762] New: radeonfb and
	Xpress 200m 5955
Date: Wed, 16 Jan 2008 23:37:54 +0100
Message-ID: <200801162337.55226.rjw@sisk.pl>
References: <bug-9762-10286@http.bugzilla.kernel.org/>
	<Pine.LNX.4.64.0801161622060.7015@anakin>
	<20080116111233.04c6df3a.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFGrY-0007D1-W7 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jan 2008 14:36:06 -0800
Received: from ogre.sisk.pl ([217.79.144.158])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JFGrW-0001Wh-UD
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 16 Jan 2008 14:36:00 -0800
In-Reply-To: <20080116111233.04c6df3a.akpm@linux-foundation.org>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sellout Bessie <sellout@beautyisfleeting.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>, alevkovich@tut.by, "Antonino A. Daplas" <adaplas@pol.net>

This patch from Alex, attached as
http://bugzilla.kernel.org/attachment.cgi?id=14481&action=view,
is reported to fix the problem.

--- linux-2.6.23/drivers/video/modedb.c	2008-01-16 18:23:48.183178912 +0200
+++ linux-2.6.23/drivers/video/modedb.c	2008-01-16 18:17:04.000000000 +0200
@@ -259,6 +259,10 @@
 	/* 1366x768, 60 Hz, 47.403 kHz hsync, WXGA 16:9 aspect ratio */
 	NULL, 60, 1366, 768, 13806, 120, 10, 14, 3, 32, 5,
 	0, FB_VMODE_NONINTERLACED
+   }, {
+	/* 1280x800, 60 Hz, 47.403 kHz hsync, WXGA 16:10 aspect ratio */
+	NULL, 60, 1280, 800, 12048, 200, 64, 24, 1, 136, 3,
+	0, FB_VMODE_NONINTERLACED
     },
 };
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
