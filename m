From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Framebuffer fixes.
Date: Thu, 27 Mar 2003 21:49:23 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0303272148280.7286-100000@vervain.sonytel.be>
References: <1048792155.1109.29.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yeKP-0001Z0-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 12:50:26 -0800
In-Reply-To: <1048792155.1109.29.camel@localhost.localdomain>
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
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 28 Mar 2003, Antonino Daplas wrote:
> On Thu, 2003-03-27 at 17:09, Geert Uytterhoeven wrote:
> > On 27 Mar 2003, Antonino Daplas wrote:
> > >        - image->depth should be representative of the data depth
> > > (currently, either 8 or 1).  If image->depth == 1, color expansion can
> > > now be used to draw the logo, thus there's no need to differentiate
> > > between mono logo drawing and monochrome expansion.
> > 
> > > +	/*
> > > +	 * Monochrome expansion and logo drawing functions are the same if
> > > +	 * fb_logo.needs_logo == 1.
> > > +	 */
> > > +	switch (info->fix.visual) {
> > > +	case FB_VISUAL_MONO10:
> > > +		image.fg_color = (u32) (~(~0UL << fb_logo.depth));
> >                                                   ^^^^^^^^^^^^^
> > > +		image.bg_color = 0;
> > > +		image.depth = 1;
> > > +		break;
> > > +	case FB_VISUAL_MONO01:
> > > +		image.bg_color = (u32) (~(~0UL << fb_logo.depth));
> >                                                   ^^^^^^^^^^^^^
> > > +		image.fg_color = 0;
> > > +		image.depth = 1;
> > > +		break;
> > 
> > Shouldn't these be info->var.bits_per_pixel instead of fb_logo.depth?
> 
> Yes, fb_logo.depth == info->var.bits_per_pixel.

Euh, now I get confused... Do you mean
`Yes, it should be replaced by info->var.bits_per_pixel' or
`No, logo.depth is always equal to info->var.bits_per_pixel'?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
