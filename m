From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: PPC64 prom logo
Date: Mon, 24 Mar 2003 20:21:29 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303242020520.20509-100000@vervain.sonytel.be>
References: <Pine.LNX.4.44.0303241856480.22808-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xXWa-0007n7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Mar 2003 11:22:24 -0800
In-Reply-To: <Pine.LNX.4.44.0303241856480.22808-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC64 Development <linuxppc64-dev@lists.linuxppc.org>

On Mon, 24 Mar 2003, James Simmons wrote:
> > --- linux-2.5.x/arch/ppc64/kernel/prom.c.orig	Sun Mar 23 11:37:52 2003
> > +++ linux-2.5.x/arch/ppc64/kernel/prom.c	Sun Mar 23 11:39:35 2003
> > @@ -1271,7 +1271,8 @@
> >  
> >  #ifdef CONFIG_FB_LOGO_LINUX_CLUT224
> >  		clut = RELOC(RELOC(&logo_linux_clut224)->clut);
> > -		for (i = 0; i < logo_linux_clut224.clutsize; i++, clut += 3)
> > +		for (i = 0; i < RELOC(&logo_linux_clut224)->clutsize;
> > +		     i++, clut += 3)
> >  			if (prom_set_color(ih, i + 32, clut[0], clut[1],
> >  					   clut[2]) != 0)
> >  				break;
> > 
> 
> Shoudln't that be clut = RELOC(&logo_linux_clut2 instead?

I don't think so. First the logo_linux_clut224 symbol has to be relocated,
followed by the pointer to the CLUT.

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
