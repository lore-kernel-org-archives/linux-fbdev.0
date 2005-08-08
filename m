From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: CRTC scanout buffer types
Date: Mon, 8 Aug 2005 10:39:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0508081038500.3826@numbat.sonytel.be>
References: <9e47339105080513195dee0804@mail.gmail.com> 
 <Pine.LNX.4.62.0508071135450.31010@gorilla.sonytel.be> 
 <9e47339105080706414faf1e40@mail.gmail.com>  <42F67719.9050805@us.ibm.com>
 <42F68105.1080207@pol.net>  <Pine.LNX.4.62.0508071830270.11306@node2.an-vo.com>
  <42F6B21E.1070405@gmail.com> <9e47339105080719338b78aa@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <9e47339105080719338b78aa@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Vladimir Dergachev <volodya@mindspring.com>, Ian Romanick <idr@us.ibm.com>, DRI developer's list <dri-devel@lists.sourceforge.net>

On Sun, 7 Aug 2005, Jon Smirl wrote:
> On 8/7/05, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > Vladimir Dergachev wrote:
> > >> I agree that something like the above is acceptable, exept that we need
> > >> an extra field for offset and another if indexed color or not. So
> > >> something like:
> > >>
> > >> A:2/0/R:10/2/G:10/12/B:10/22//I
> 
> The offsets are not needed as part of the input, they should be part
> of the output display. It is the chip driver that will determine the
> offsets, not the user.

So you cannot select between RGB and BGR on hardware that allows to select
that?

> The only exception I can think of is that the radeon hardware can
> control which nibble is used in 4bpp. I'd say if you need that kind of

This is something completely different, since each nibble is a different pixel.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
