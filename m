From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 5/5] VT binding: Add new doc file
 describing the feature
Date: Mon, 12 Jun 2006 10:31:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0606121029010.7668@pademelon.sonytel.be>
References: <44893407.4020507@gmail.com>
	<9e4733910606092253n7fe4e074xe54eaec0fe4149f3@mail.gmail.com>
	<448AC8BE.7090202@gmail.com>
	<9e4733910606100916r74615af8i34d37f323414034c@mail.gmail.com>
	<448B38F8.2000402@gmail.com>
	<9e4733910606101644j79b3d8a5ud7431564f4f42c7f@mail.gmail.com>
	<448B61F9.4060507@gmail.com>
	<9e4733910606101749r77d72a56mbcf6fb3505eb1de0@mail.gmail.com>
	<9e4733910606101805t3060c0cdgd08ceabe8cfe4e0e@mail.gmail.com>
	<448B7594.6040408@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FphqY-00013c-G9 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 01:32:30 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FphqY-0001k3-7v for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 01:32:30 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FphqW-00016L-Nt
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 01:32:30 -0700
In-Reply-To: <448B7594.6040408@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>, Jon Smirl <jonsmirl@gmail.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Sun, 11 Jun 2006, Antonino A. Daplas wrote:
> Jon Smirl wrote:
> > On 6/10/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> >> On 6/10/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> > > I see now that you can have tty0-7 assigned to a different console
> >> > > driver than tty8-63.
> >> > > Why do I want to do this?
> >> >
> >> > Multi-head.  I can have vgacon on the primary card for tty0-7,
> >> > fbcon on the secondary card for tty8-16.
> >>
> > 
> > When I say dropped, I mean drop the feature of having multiple drivers
> > simultaneously open by the VT layer. You would still be able to switch
> > from vgacon to fbcon by using sysfs. You just wouldn't be able to use
> > VT swap hotkeys between them.
> 
> Quoting you:
> 
> "Googling around the only example I could find was someone with a VGA
> card and a Hercules card. They setup 8 consoles on each card."
> 
> How do you think they accomplished that? They did not rewrite the VT
> layer, all they need to do is change the 'first' and 'last' parameter
> passed to take_over_console() in mdacon.c.  This implies that the VT
> layer already supports multiple active VT console drivers, maybe as
> early as 2.2, and no, we won't remove that.

JFYI, probably 2.1.x. Multi-head dates back to at least 1996.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
