From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Some questions
Date: Wed, 5 Mar 2003 15:12:08 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303051511200.23176-100000@vervain.sonytel.be>
References: <1046870342.1291.86.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18qZeI-0005oy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 05 Mar 2003 06:13:35 -0800
In-Reply-To: <1046870342.1291.86.camel@localhost.localdomain>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Antonino Daplas <adaplas@pol.net>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 5 Mar 2003, Antonino Daplas wrote:
> > 3) The resizing using stty is - how do I put this - slightly imperfect.
> > I don't know how you fbdev folks do it, but I am not used to think in
> > row/col categories, but *resolutions* instead. Apart from this - IMHO a
> > bit annoying - inconvenience, this method has further issues:
> > 
> > a) Calculating the desired mode resolution my simply multiplying the
> > rows/cols by the font size very often results in odd modes like 800x592.
> > This even when using a standard 8x16 font, not thinking of situations
> > where for instance 12x22 fonts are used. How is the low level driver
> > supposed to handle this?
> 
> Ideally, the driver should round up to the nearest mode it's capable
> of.  The "fraction of a character dimensions" will be automatically
> cleared by the "clear_margins" hook.

But if I say e.g. `fbset 800x600-90', I do want a 90 Hz 800x600 mode, whatever
the font may be.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
