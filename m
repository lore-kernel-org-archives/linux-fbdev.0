From: "Tony" <adaplas@hotpop.com>
Subject: RE: Re: New radeonfb, mostly untested
Date: Mon, 15 Sep 2003 07:59:37 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <000301c37b1c$40b7e480$ba17b1cb@bom>
References: <20030910212700.GA12271@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ygca-000756-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 16:49:36 -0700
Received: from babyruth.hotpop.com ([204.57.55.14])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ygca-0002uP-B4
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 14 Sep 2003 16:49:36 -0700
Received: from hotpop.com (kubrick.hotpop.com [204.57.55.16])
	by babyruth.hotpop.com (Postfix) with SMTP id 1A6832171CC
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 23:49:00 +0000 (UTC)
In-Reply-To: <20030910212700.GA12271@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: kronos@kronoz.cjb.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

> Il Wed, Sep 10, 2003 at 07:50:10PM +0200, Benjamin
> Herrenschmidt ha scritto:
> > Anyway, if your EDID returns incorrect infos, then we are
> screwed, or
> > maybe we aren't calculating the horizontal margin properly
> when building
> > the mode.
>
> This is the modedb created from my edid:
> [cut]
> mode 18
> mode->xres = 1280, mode->right_margin = 79
> mode->hsync_len = 137, mode->left_margin = 217
> mode->vres = 1024, mode->lower_margin = 1
> mode->vsync_len = 3, mode->upper_margin = 32
> mode->refresh = 60
> mode 19
> mode->xres = 1280, mode->right_margin = 48
> mode->hsync_len = 112, mode->left_margin = 248
> mode->vres = 1024, mode->lower_margin = 1
> mode->vsync_len = 3, mode->upper_margin = 38
> mode->refresh = 60
>
> mode 19 comes from get_detailed_timing, while 18 comes from
> get_std_timing and timings are calculated by
> calc_mode_timings (which in
> turn calls fb_get_mode). Any chance that there is some error in
> fb_get_mode?

fb_get_mode() uses GTF calculations to estimate the timings.  It will
surely be different from VESA standard timings and manufacturer's
timings (detailed).  Most, if not all, modern CRT , monitors should be
able to handle GTF calculated timings -- at least it will display, but
the frame may be wide/narrow, tall/short, or shifted left/right/up/down.
This is when you need to use fbset to fine tune the timings.  However
GTF calculations should be treated as last resort (manufacturer's
detailed timings, VESA discrete timings, GTF -- decreasing priority).

One thing I forgot to comment in fbmon.c is that the GTF horizontal
timing results are not rounded off.  It may be necessary to round it off
to the nearest character clock (usually 8 pixels) such as by doing a

	left_margin = (left_margin + 4) & ~7 .

I agree with Ben that modedb should have extra flags to determine which
of the modes came from where.  One can then check an extra flag in EDID
(First detailed timing is preferred) to find what is the best mode for
the display.   (The print out of show_edid() should tell you this
information).

I was also planning to extend info->monspecs to include most of the
information from EDID, but I still have no time.

Regarding your problem about re-centering the screen, why not check the
modeline used by XFree86 and by radeonfb?  In order to prevent
re-centering when switching to/from X, the timings should be the same
and if not, either create a custom Xfree86 modeline from fb or a custom
timing in /etc/fb.modes taken from your current Xfree86 timings.

BTW, i810fb largely uses timings generated from fb_get_modes() and I
haven't heard anyone report a display problem yet.  The EDID parser
though is largely untested, and I've already seen a few bugs.

Tony




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
