From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Fw: Re: 2.6.8.1-mm2
Date: Fri, 20 Aug 2004 11:16:09 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0408201115170.6741@waterleaf.sonytel.be>
References: <20040820012902.55fb2aa6.akpm@osdl.org> <200408201711.07677.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By5Vf-0007ae-EO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 02:16:31 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1By5Vc-0007T4-Uv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 20 Aug 2004 02:16:30 -0700
In-Reply-To: <200408201711.07677.adaplas@hotpop.com>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, ismail =?iso-8859-1?q?d=F6nmez?= <ismail.donmez@gmail.com>

On Fri, 20 Aug 2004, Antonino A. Daplas wrote:
> On Friday 20 August 2004 16:29, Andrew Morton wrote:
> > From: ismail d=F6nmez <ismail.donmez@gmail.com>
> > On Thu, 19 Aug 2004 01:42:04 -0700, Andrew Morton <akpm@osdl.org> wro=
te:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8=
.1/2.6
> > >.8.1-mm2/
> >
> > Minor issue but still no penguin logo on framebuffer. Config attached=
 in
> > case.
>
> The latest fbdev changes in the mm tree differentiates between bpp and =
color depth.
> The vesafb driver at 8 bpp has a color depth of 6 only (try fbset -i) a=
llowing only for
> 64 colors.  So fbdev assumes that vesafb at this depth cannot draw a 22=
4-color
> logo.
>
> Try using the 16-color logo instead.  The correct fix is for vesafb to =
correctly determine
> the true capability of the hardware instead of arbitrarily setting the =
color depth at 6.

It's not arbitrarily: it's the old convention of setting the color bitfie=
ld
lengths to the number of significant bits of that color component. VGA ha=
s 2^18
colors.

Gr{oetje,eeting}s,

						Geert

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
