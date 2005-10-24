From: Rolf Offermanns <rolf@offermanns.de>
Subject: Re: color map vs. pseudo-palette vs. RAMDAC registers
Date: Mon, 24 Oct 2005 13:01:16 +0200
Message-ID: <200510241301.17275.rolf@offermanns.de>
References: <200510240948.50185.rolf.offermanns@gmx.net> <Pine.LNX.4.62.0510240954290.16285@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EU05B-0003nK-CA
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 04:01:37 -0700
Received: from mail.sysgo.com ([62.8.134.5])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EU05A-00039P-U8
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 04:01:37 -0700
In-Reply-To: <Pine.LNX.4.62.0510240954290.16285@numbat.sonytel.be>
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

On Monday 24 October 2005 09:57, Geert Uytterhoeven wrote:
> > --------------------------------------------------------------------
> > Pseudocolor:
> > * cmap is not used
>
> That should be `pseudo palette is not used'.
>
> > * DAC[X] is programmed to (red, green, blue)
> > --------------------------------------------------------------------
> > Does that mean, I do not need to allocate a color map, if my driver would
> > only
>
> It means you don't have to fill in the pseudo palette in this mode.
OK.

> > support pseudocolor visual? Is pseudocolor always used for 8bpp or are
> > there situations where 16bpp pseudocolor makes sense?
>
> Pseudocolor is not always 8 bpp (1, 2, 4 are common values as well), but
> large values are very uncommon, since 16 bpp pseudocolor would mean a
> 65536-entries colormap.
OK.

> > -------------------------------------------------------------------------
> >---- Truecolor:
> >      *    does not use RAMDAC (usually has 3 of them).
> >      *    var->{color}.offset contains start of bitfield
> >      *    var->{color}.length contains length of bitfield
> >      *    cmap is programmed to (red << red.offset) |
> > 				(green << green.offset) |
> >     				(blue << blue.offset) |
> > 				(transp << transp.offset)
> >      *    RAMDAC does not exist
> > -------------------------------------------------------------------------
> >---- Now I am lost:
> > -> does not use RAMDAC.
> > I understand this. It states the same in my chip reference. But what
> > means "usually has 3 of them" in this context?
>
> Red, green, and blue.
OK. But this is for H/W with DirectColor support where each color has its own 
CLUT, right?

> > -> cmap is programmed to...
> > In the code that follows this comment, not the cmap is programmed, but
> > the pseudo palette.
>
> That should be `pseudo palette' again.
OK.
>
> > 1. Why do I need a pseudo palette and where does its size 16 comes from?
>
> It's used to translate from the 16 text console colors to actual pixel
> values.
OK, and these 16 color can be set/defined by text mode apps, right?


Thanks for these explanations Gerd. Shall I provide a patch for the skeletonfb 
driver comments?

The one thing, I still do not understand is:
What are color maps used for in the different visuals? In pseudo mode they are 
not used at all. In TrueColor mode there should be no need to map anything?
I checked the documentation again, but there must be something I have 
overread.

Could you please explain this?

Thanks,
Rolf



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
