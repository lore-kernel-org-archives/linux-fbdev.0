From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Wed, 28 Apr 2004 10:41:05 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404281036030.3644@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404280039460.23153-100000@phoenix.infradead.org>
 <1083110007.20091.5.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BIkcx-0005gN-DX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 01:41:11 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BIkcw-0002X6-PX
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 01:41:10 -0700
In-Reply-To: <1083110007.20091.5.camel@gaston>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, John Zielinski <grim@undead.cc>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 28 Apr 2004, Benjamin Herrenschmidt wrote:
> > No. Look the logic should go from the upper VT layer to the lower driver
> > to accomplish something. Not the reverse.
> >
> > struct vc_data -> native console driver structure --> fbdev
>
> But the upper VT layer has no clue about what a graphic mode can be and
> we know well enough that we _need_ to be able to enforce graphics mode
> or want to play with them by manipulating var structures, without losing
> the console.
>
> Your logic is only ever valid once every single fbdev is capable of
> doing proper mode management & validation. And even then, there isn't
> a 1:1 relationchip between a mode and an fbcon size.
>
> > Not.
> >
> > fbdev --> native console driver --> struct vc_data.
> >
> > This was the way it uses to be. If this is the case then I suggest we
> > write our own vt.c and vt_ioctl.c for the fbcon layer. We shouldn't even
> > use struct vc_data then. In fact each fbdev driver should be independent
> > console drivers. That is how 2.4.X was. Each driver was nearly its own
> > console driver. We need to go one way or the other.
>
> I agree we need to go away and I'm not proposing adding anything to
> fb_info nor whatever in this regard. It has to be all self-contained
> in the console subsystem, that is fbcon. And we already have a data
> structure holding per-console fbcon-specific data, it's called
> struct display.

Agreed. We need a per-VT var.

The way I see it (and have always seen it), fbcon implements a text console _on
top of_ fbdev, just like vgacon implements a text console on top of the VGA
hardware. Not the other way around!

You give fbcon the number of columns and rows, and a font, and it will build a
text console using the current var (of the VT).

<sidenote>
In extremis, this means I wouldn't have a problem if you use stty to set a
80x25 console with a 8x16 font on a 1280x1024 screen, and get text in the
upper left 640x400 corner only. Or try a 160x100 console on a 640x480 screen,
of which only 80x32 characters are visible.

This would IMHO be much more logical than the way it is now.
</sidenote>

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
