From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: patch fixing background next to penguin logo
 in monochrome
Date: Tue, 17 Aug 2004 09:45:34 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408170945120.8552@waterleaf.sonytel.be>
References: <1092254183.4209.16.camel@joy.home> <200409130625.07250.adaplas@hotpop.com>
 <Pine.GSO.4.58.0408151425000.3409@waterleaf.sonytel.be>
 <200409161110.12046.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bwykg-0004ts-Ib
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 17 Aug 2004 00:51:26 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1Bwyfd-0006tS-FI
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 17 Aug 2004 00:51:26 -0700
In-Reply-To: <200409161110.12046.adaplas@hotpop.com>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: Petr Stehlik <pstehlik@sophics.cz>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Christian T. Steigies" <cts@debian.org>

On Thu, 16 Sep 2004, Antonino A. Daplas wrote:
> On Sunday 15 August 2004 20:25, Geert Uytterhoeven wrote:
> > > This one is a little difficult since there is currently no method to
> > > convert monochrome attributes to color and vice versa.  The best one can
> > > do is to clear all attributes when switching from mono<->color.
> > >
> > > When switching, one will get plain text only.  This is  probably better
> > > than having text with incorrect attributes.
> > >
> > > Attached patch is completely untested, but it's the same one in 2.6.
> >
> > Doesn't help, still the same behavior :-(
>
> I looked at the code, and the flow seems to be like this:
>
> fbcon_switch->fb_set_var->changevar->fbcon_setup->update_screen/redraw_screen
>
> However, fbcon_setup() updates conp->vc_can_do_color, so by the time
> the redraw_screen function in console.c checks for the vc_can_do_color field,
> it always returns equal.
>
> So instead of clearing the buffer attributes in redraw_screen(), we do it
> instead in fbcon_setup().
>
> Try the patch below.  You might have to apply them manually as I'm using
> Suse-9.0 linux kernel, which has the bootsplash code.  Also, all the previous
> patches need to be reversed.

Applied fine, but still the same result.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
