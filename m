From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [Linux-fbdev-devel] FBDEV 2.6.0-test7 updates.
Date: Thu, 16 Oct 2003 22:40:12 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20031016204012.GA2420@mars.ravnborg.org>
References: <Pine.LNX.4.44.0310152345210.13660-100000@phoenix.infradead.org> <Pine.GSO.4.21.0310162156240.22417-100000@waterleaf.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0310162156240.22417-100000@waterleaf.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Oct 16, 2003 at 09:58:44PM +0200, Geert Uytterhoeven wrote:
> 
> > --- linux-2.6.0-test7/drivers/video/logo/Makefile	Wed Oct 15 19:12:21 2003
> > +++ fbdev-2.6/drivers/video/logo/Makefile	Wed Oct 15 19:20:50 2003
> > @@ -13,30 +13,36 @@
> >  obj-$(CONFIG_LOGO_SUPERH_VGA16)		+= logo_superh_vga16.o
> >  obj-$(CONFIG_LOGO_SUPERH_CLUT224)	+= logo_superh_clut224.o
> >  
> > -# Dependencies on generated files need to be listed explicitly
> > -
> > -$(obj)/%_mono.o: $(src)/%_mono.c
> > -
> > -$(obj)/%_vga16.o: $(src)/%_vga16.c
> > -
> > -$(obj)/%_clut224.o: $(src)/%_clut224.c
> > -
> > -$(obj)/%_gray256.o: $(src)/%_gray256.c
> > -
> > -# How to generate them
> > +# mono logo's
> > +$(obj)/logo_linux_mono.o:	$(obj)/logo_linux_mono.c
> > +$(obj)/logo_superh_mono.o:	$(obj)/logo_superh_mono.c
> > +
> > +# vga16 logo's
> > +$(obj)/logo_linux_vga16.o:	$(obj)/logo_linux_vga16.c
> > +$(obj)/logo_superh_vga16.o:	$(obj)/logo_superh_vga16.c
> > +
> > +# clut224 logo's
> > +$(obj)/logo_linux_clut224.o:	$(obj)/logo_linux_clut224.c
> > +$(obj)/logo_dec_clut224.o:	$(obj)/logo_dec_clut224.c
> > +$(obj)/logo_mac_clut224.o:	$(obj)/logo_mac_clut224.c
> > +$(obj)/logo_sgi_clut224.o:	$(obj)/logo_sgi_clut224.c
> > +$(obj)/logo_sun_clut224.o:	$(obj)/logo_sun_clut224.c
> > +$(obj)/logo_superh_clut224.o:	$(obj)/logo_superh_clut224.c
> 
> Why did you replace the generic rules?

I made that a few months ago - I do not remember the details.
But in order to use a common rule for all logos I had to list them
explicit one by one.
I also recall that the old makefile used some built-in rules to create
the logo files - and the above may have been required to avoid that
as well.

	Sam
