From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: [PATCH] Sysfs for framebuffer
Date: Tue, 23 Mar 2004 17:13:17 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.58.0403231712560.8977@waterleaf.sonytel.be>
References: <20040320174956.GA3177@dreamland.darkstar.lan>
 <200403231211.09334.lkml@kcore.org> <20040323122627.GA22830@lambda>
 <200403231701.19786.lkml@kcore.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200403231701.19786.lkml@kcore.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan De Luyck <lkml@kcore.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kronos <kronos@kronoz.cjb.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>

On Tue, 23 Mar 2004, Jan De Luyck wrote:
> On Tuesday 23 March 2004 13:26, Sven Luther wrote:
> > > - From a users point of view: if there are only to be framebuffer devices
> > > listed in this class, why not call it just what it is: "Framebuffer" ?
> > > Naming it after something it is only in a broad sense makes no sense to
> > > me. I'd be looking in /sys/.../framebuffer instead of /sys/.../graphics
> > > or /display.
> >
> > Notice that /display is what is used by most OF implementations, so this
> > kinda makes sense. I would vote like BenH on this if i was consulted.
>
> OF implementations?

Open Firmware

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
