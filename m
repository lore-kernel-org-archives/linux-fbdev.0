From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: S3triofb, pm3fb, retz3fb: abandoned?
Date: Thu, 13 May 2004 16:17:55 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0405131607090.24805@rosencrantz.theboonies.us>
References: <Pine.GSO.4.58.0405031952180.27296@waterleaf.sonytel.be>
Reply-To: David Eger <eger-dated-1085062396.5ba703@theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOGxb-0000b8-HN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 07:13:19 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BOGxb-0000Ws-13
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 07:13:19 -0700
In-Reply-To: <Pine.GSO.4.58.0405031952180.27296@waterleaf.sonytel.be>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


I ran across some interesting things grepping for "scrollmode" in the
fb sources.  The framebuffer drivers shouldn't know about the console
(at least any more), so references to "scrollmode" says something's up.
I found the following:

drivers/video/sis/sis_main.c:          /* display->scrollmode = 0;  */
drivers/video/sis/sis_main.c:          display->scrollmode = SCROLL_YREDRAW;
drivers/video/S3triofb.c:    disp.scrollmode = fb_var.accel_flags & FB_ACCELF_TEXT ? 0 : SCROLL_YREDRAW;
drivers/video/pm3fb.c:     disp[l_fb_info->board_num].scrollmode = 0;      /* SCROLL_YNOMOVE; *//* 0 means "let fbcon choose" */
drivers/video/retz3fb.c:   display->scrollmode = SCROLL_YREDRAW;

Now sis_main tries to be both the 2.4 and 2.6 driver in one file, and
messing with scrollmode happens in the Linux 2.4 portion.  But for
the other three drivers here -- S3triofb, pm3fb, and retz3fb, they
just haven't been updated in recent memory.  Their code is still the
old interface where all the console cruft is intermingled with video
card settings.  Does anyone still care about these drivers?

-dte

---
getting bounce messages from me? let me know and you'll go on my whitelist


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
