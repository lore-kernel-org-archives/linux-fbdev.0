From: Paul Mackerras <paulus@samba.org>
Subject: Re: PPC64 prom logo
Date: Tue, 25 Mar 2003 07:28:26 +1100 (EST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <15999.27242.738276.356568@nanango.paulus.ozlabs.org>
References: <Pine.LNX.4.44.0303241856480.22808-100000@phoenix.infradead.org>
	<Pine.GSO.4.21.0303242020520.20509-100000@vervain.sonytel.be>
Reply-To: paulus@samba.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dp.samba.org ([66.70.73.150] helo=lists.samba.org)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xYgv-00087a-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Mar 2003 12:37:09 -0800
In-Reply-To: <Pine.GSO.4.21.0303242020520.20509-100000@vervain.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC64 Development <linuxppc64-dev@lists.linuxppc.org>

Geert Uytterhoeven writes:

> On Mon, 24 Mar 2003, James Simmons wrote:
> > > --- linux-2.5.x/arch/ppc64/kernel/prom.c.orig	Sun Mar 23 11:37:52 2003
> > > +++ linux-2.5.x/arch/ppc64/kernel/prom.c	Sun Mar 23 11:39:35 2003
> > > @@ -1271,7 +1271,8 @@
> > >
> > >  #ifdef CONFIG_FB_LOGO_LINUX_CLUT224
> > >  		clut = RELOC(RELOC(&logo_linux_clut224)->clut);
> > > -		for (i = 0; i < logo_linux_clut224.clutsize; i++, clut += 3)
> > > +		for (i = 0; i < RELOC(&logo_linux_clut224)->clutsize;
> > > +		     i++, clut += 3)
> > >  			if (prom_set_color(ih, i + 32, clut[0], clut[1],
> > >  					   clut[2]) != 0)
> > >  				break;
> > >
> >
> > Shoudln't that be clut = RELOC(&logo_linux_clut2 instead?
> 
> I don't think so. First the logo_linux_clut224 symbol has to be relocated,
> followed by the pointer to the CLUT.

Actually, you should use RELOC on a variable (an L-value) or PTRRELOC
on a value (an R-value), so it should look like this:

	clut = PTRRELOC(RELOC(logo_linux_clut224.clut));
	for (i = 0; i < RELOC(logo_linux_clut224.clutsize); i++, clut += 3)

etc.  I'll test on an actual ppc64 box and send a tested patch.

Paul.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
