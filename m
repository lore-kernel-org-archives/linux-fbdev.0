From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [RFC] Video Mode Handling
Date: Mon, 9 Aug 2004 10:10:18 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408091009010.14159@waterleaf.sonytel.be>
References: <200408090944.01414.adaplas@hotpop.com> <20040808230412.6dc16bf4.akpm@osdl.org>
 <Pine.GSO.4.58.0408090920511.14159@waterleaf.sonytel.be>
 <20040809010326.305620a7.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bu5Ej-0001wi-FB
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 01:10:29 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bu5Eh-0006tY-AJ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Aug 2004 01:10:27 -0700
In-Reply-To: <20040809010326.305620a7.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>
Cc: Antonino Daplas <adaplas@pol.net>, adaplas@hotpop.com, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 9 Aug 2004, Andrew Morton wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, 8 Aug 2004, Andrew Morton wrote:
> > > "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> > > > Most fbdev developers are proposing to bring back the per-display var
> > > >  structures to ease the difficulty of video mode handling.  This proposal
> > > >  is countered by a few (notably James) in that it severely increases the
> > > >  memory footprint of the kernel.
> > >
> > > Surprised.
> > >
> > > By how much does this increase the kernel's memory footprint?
> >
> > Indeed, you need a full mode database per driver.
>
> Sorry, that's way outside my area of knowledge ;)

Each driver needs a list of supported video modes.

> > > And how much simpler would the code be if we were to bring back the
> > > per-display var structures?
> > >
> > > IOW: what's the tradeoff here?
> >
> >   - per-display var:
> >       - increase memory footprint by
> >         MAX_NR_CONSOLES.*sizeof(struct var_screen_info)
>
> I see no var_screen_info.  sizeof(struct screen_info) is 56 bytes, and
> there are 63 of them.  This is a negligible amount of memory!

Sorry, struct fb_var_screeninfo.

> >       + simpler code
> >       + 100% compatible with 2.4
> >
> >   - private modedb:
> >       - increase memory footprint by full mode database per driver.
> >       - more complex (and larger) code
> >       - subtle differences with 2.4, because not the whole var is saved
> >         (BTW, which fields do you want to save, and which not, so I can
> > 	 evaluate the impact on some drivers?)
>
> Well gee.  If we're talking about 3k, or even 10k or 30k, let's go with the
> simplest code?

I agree!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
