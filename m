From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: patch fixing background next to penguin logo
 in monochrome
Date: Thu, 12 Aug 2004 22:01:26 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408122158550.18214@waterleaf.sonytel.be>
References: <1092254183.4209.16.camel@joy.home> <200409120616.43518.adaplas@hotpop.com>
 <1092312171.27772.73.camel@joy.sophics>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BvLlX-0001ix-Ii
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Aug 2004 13:01:35 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BvLlW-0000rv-UR
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Aug 2004 13:01:35 -0700
In-Reply-To: <1092312171.27772.73.camel@joy.sophics>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Petr Stehlik <pstehlik@sophics.cz>
Cc: Antonino Daplas <adaplas@pol.net>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, "Christian T. Steigies" <cts@debian.org>

On Thu, 12 Aug 2004, Petr Stehlik wrote:
> V Ne, 12. 09. 2004 v 00:16, Antonino A. Daplas p=ED=A8e:
> > On Thursday 12 August 2004 03:56, Petr Stehlik wrote:
> > > I have developed a simple workaround for a problem existing in
> > > framebuffer when it interprets VGA attribute bits in monochrome mod=
e.
> > > Instead of empty chars we get underlines
>
> > Anyway, the simplest solution is to use a vc->vc_video_erase_char wit=
h the
> > underline attribute removed.  Check drivers/video/fbcon.c and look at=
 the
> > function fbcon_setup. Note, the logo space is erased using the scr_me=
msetw
> > function with conp->vc_video_erase_char. Just replace them with
> > (conp->vc_video_erase_char & ~0x400) if conp->can_do_color is false. =
(0x400
> > is the underline attribute).
>
> Good idea. Tested, works. Included below.

Thanks a lot! Works fine on Amiga as well!

BTW, I checked in a slightly modified version in Linux/m68k CVS
(http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.4.x-merging/162-logo.di=
ff).

Gr{oetje,eeting}s,

						Geert

P.S. There are still problems when switching from color to monochrome
     (underlines appear everywhere) or vice versa (text becomes blue), bu=
t I
     cannot expect you to fix all old bugs in one week ;-)
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
