From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] radeonfb(): memmove() fix -- this
 one works ;-)
Date: Wed, 28 Apr 2004 19:56:58 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0404281948260.11982@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404281709260.1187-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BItIx-0003g9-3m
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 10:57:07 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BItIw-0008CL-MP
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 28 Apr 2004 10:57:06 -0700
In-Reply-To: <Pine.LNX.4.44.0404281709260.1187-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, John Zielinski <grim@undead.cc>, David Eger <eger-dated-1083663529.7e8c27@theboonies.us>, "Antonino A. Daplas" <adaplas@hotpop.com>, eger-dated-1082943669.d79d33@theboonies.us, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 28 Apr 2004, James Simmons wrote:
> > > No. Look the logic should go from the upper VT layer to the lower driver
> > > to accomplish something. Not the reverse.
> > >
> > > struct vc_data -> native console driver structure --> fbdev
> >
> > But the upper VT layer has no clue about what a graphic mode can be and
> > we know well enough that we _need_ to be able to enforce graphics mode
> > or want to play with them by manipulating var structures, without losing
> > the console.
> >
> > Your logic is only ever valid once every single fbdev is capable of
> > doing proper mode management & validation. And even then, there isn't
> > a 1:1 relationchip between a mode and an fbcon size.
>
>   But we do have the proper data already. Its called modedb. I have two

So I cannot have a mode that's not in modedb, since it won't survive switching
VTs.

> reasons for why I hate to have a var in struct display. One is that it
> makes fbcon heavier. You now have a extra var in every struct display.

... vs. a (non __init) modedb that stays in RAM after bootup.

Besides the initial mode (modedb, EDID, kernel arg, ...), I'd like to keep mode
databases in userspace where possible.

> Usually the user has several if not all VCs at the same resolution. That
> means there is alot of duplication of the same data for now reason. If we

Alternatively, make the vars in struct display pointers to reference counted
data, so initially they all point to the same var. But I don't know if it's
worth the extra effort.

> use modedb to fill in the extra data then we don't need the extra data in
> each struct display. The bonus there is permentally stored data to represent
> that one mode to everybody!! Much lighter.

But I'm still limited to the modes in modedb.

>   Second I have seen the fbset method to set the VC fail miserably. Whereas I
> have never seen using modedb at boot time fail unless the mode is not supported.
> There have been many times where using fbset has left my screen blank :-(

I consider it a bug in the fbdev driver if you manage to end up with a blank
screen (not taking into account modes beyond your monitor's limitations if
monspecs are not implemented/working).

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
