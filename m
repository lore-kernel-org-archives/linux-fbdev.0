From: David Eger <eger-sender-da68b9@theboonies.us>
Subject: Re: [PATCH 0/3] fb accel capabilities (aka fast
	radeon fb, the right way)
Date: Thu, 13 May 2004 08:26:44 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1084451204.40a369846f626@mail.theboonies.us>
References: <Pine.LNX.4.58.0405130131460.2282@rosencrantz.theboonies.us>
	<Pine.GSO.4.58.0405131309030.9790@waterleaf.sonytel.be>
Reply-To: David Eger <eger-dated-1085056009.2e1759@theboonies.us>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOFIY-0000Nl-TN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 05:26:50 -0700
Received: from not.theboonies.us ([66.139.79.224])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BOFIY-0002h7-GN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 05:26:50 -0700
In-Reply-To: <Pine.GSO.4.58.0405131309030.9790@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Quoting Geert Uytterhoeven <geert@linux-m68k.org>:

> > Specifically, I've added a .hwaccel field to fb_fix_screeninfo, which
> > should serve as the way framebuffers pass hints to higher layers.
>
> I think we agreed to put it in fb_info instead, since it doesn't really
> matter for user space.

It doesn't so much matter to me.  I just saw some built-in padding in
fb_fix_screeninfo I could steal..

> > This should totally obsolete the accel_flags in var (which till now has
> > had one half-heartedly used value FB_ACCELF_TEXT).
>
> Well, we still need a way to know when the fbdev has to reinitialize its
> accel engine, when switching the console from graphics mode (user space
> does accel) to text mode (kernel uses accel). Currently this is done when
> FB_ACCELF_TEXT is set.

thought this was changed to KD_GRAPHICS and KD_TEXT...

> BTW, we've been talking about allowing kernel messages (mainly oops and
> panic) to show up under X. Since we cannot use the accel engine for that,
> perhaps we need different routines for fb_{fillrect,copyarea,imageblit}()
> for the accelerated vs. non-accelerated cases? And fbcon could compare
> the function pointers, instead of looking at .hwaccel.

If we want the console to display an oops under X then the drawing functions
need to be smart enough to grok the current mode/state of the accel engine and
not rely on var.  Is that what we want?

Comparing pointers just won't work, though.  For example, the radeon driver
decides whether to call the cfb_fillrect() functions or do real hw accel from
within radeonfb_fillrect().

-dte


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
