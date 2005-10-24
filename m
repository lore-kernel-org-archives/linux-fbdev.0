From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: color map vs. pseudo-palette vs. RAMDAC
 registers
Date: Mon, 24 Oct 2005 09:57:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0510240954290.16285@numbat.sonytel.be>
References: <200510240948.50185.rolf.offermanns@gmx.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ETxCx-0001QQ-5t
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 00:57:27 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ETxCu-00010v-R6
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 24 Oct 2005 00:57:27 -0700
Received: from numbat.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id j9O7vKva003210
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Oct 2005 09:57:21 +0200 (MEST)
In-Reply-To: <200510240948.50185.rolf.offermanns@gmx.net>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 24 Oct 2005, Rolf Offermanns wrote:
> I tried to understand the skeletonfb driver code, and I am confused by some 
> comments in it:
> 
> I do not understand what the color map and pseudo palette stuff is used for.
> 
> >From the c file:
> --------------------------------------------------------------------
> Pseudocolor:
> * cmap is not used

That should be `pseudo palette is not used'.

> * DAC[X] is programmed to (red, green, blue)
> --------------------------------------------------------------------
> Does that mean, I do not need to allocate a color map, if my driver would only 
It means you don't have to fill in the pseudo palette in this mode.

> support pseudocolor visual? Is pseudocolor always used for 8bpp or are there 
> situations where 16bpp pseudocolor makes sense?

Pseudocolor is not always 8 bpp (1, 2, 4 are common values as well), but large
values are very uncommon, since 16 bpp pseudocolor would mean a 65536-entries
colormap.

> -----------------------------------------------------------------------------
> Truecolor:
>      *    does not use RAMDAC (usually has 3 of them).
>      *    var->{color}.offset contains start of bitfield
>      *    var->{color}.length contains length of bitfield
>      *    cmap is programmed to (red << red.offset) | 
> 				(green << green.offset) |
>     				(blue << blue.offset) | 
> 				(transp << transp.offset)
>      *    RAMDAC does not exist
> -----------------------------------------------------------------------------
> Now I am lost:
> -> does not use RAMDAC. 
> I understand this. It states the same in my chip reference. But what means 
> "usually has 3 of them" in this context?

Red, green, and blue.

> -> cmap is programmed to...
> In the code that follows this comment, not the cmap is programmed, but the 
> pseudo palette.

That should be `pseudo palette' again.

> 1. Why do I need a pseudo palette and where does its size 16 comes from?

It's used to translate from the 16 text console colors to actual pixel values.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
