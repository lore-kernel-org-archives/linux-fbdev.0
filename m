From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 0/3] fb accel capabilities (aka fast
 radeon fb, the right way)
Date: Thu, 13 May 2004 13:15:08 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0405131309030.9790@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0405130131460.2282@rosencrantz.theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOEBM-0006CR-9g
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 04:15:20 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BOEBL-0007nh-En
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 May 2004 04:15:19 -0700
In-Reply-To: <Pine.LNX.4.58.0405130131460.2282@rosencrantz.theboonies.us>
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
To: David Eger <eger-dated-1085010079.06feaf@theboonies.us>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Thu, 13 May 2004, David Eger wrote:
> I fleshed out Geert's idea from the last radeonfb thread on bringing
> fbcon's interaction with the underlying framebuffer drivers up-to-date.
> Now fbcon should be smart and actually *use* fb-driver provided accel
> functions ;-)

Nice!

> Specifically, I've added a .hwaccel field to fb_fix_screeninfo, which
> should serve as the way framebuffers pass hints to higher layers.

I think we agreed to put it in fb_info instead, since it doesn't really matter
for user space.

> This should totally obsolete the accel_flags in var (which till now has
> had one half-heartedly used value FB_ACCELF_TEXT).

Well, we still need a way to know when the fbdev has to reinitialize its accel
engine, when switching the console from graphics mode (user space does accel)
to text mode (kernel uses accel). Currently this is done when FB_ACCELF_TEXT is
set.

BTW, we've been talking about allowing kernel messages (mainly oops and panic)
to show up under X. Since we cannot use the accel engine for that, perhaps we
need different routines for fb_{fillrect,copyarea,imageblit}() for the
accelerated vs. non-accelerated cases? And fbcon could compare the function
pointers, instead of looking at .hwaccel.

(Yes, I know it's still possible to lock up your card when using unaccelerated
 drawing while an accelerated operation is in progress on some cards).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
