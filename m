From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] vesafb and *fb
Date: Sun, 25 Apr 2004 15:13:33 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.58.0404251511320.13613@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0404240031030.5826-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S262602AbUDYNOH@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0404240031030.5826-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, 24 Apr 2004, James Simmons wrote:
> I don't know why it is that way. I would think it should fail at this
> point. Anyone know why this is?

I searched through my mailing list archives of lkml and fbdev in 2001, but
couldn't find who submitted the original patch. I guess it came from Alan.

Anyway, if this really is a problem for some people, we can always add a
`video=vesafb:force' flag for the unhappy few.

> > Yesterday I noticed on a box at work that if you compile in both vesafb and
> > atyfb (the box has an ATI 3D RAGE PRO), you get both fb0 (atyfb) and fb1
> > (vesafb). That's not supposed to happen.
> >
> > Vesafb did print that the frame buffer was already in use, but it just
> > continued, cfr. this code:
> >
> >     if (!request_mem_region(vesafb_fix.smem_start, vesafb_fix.smem_len, "vesafb")) {
> > 	    printk(KERN_WARNING
> > 		   "vesafb: abort, cannot reserve video memory at 0x%lx\n",
> > 		    vesafb_fix.smem_start);
> > 	    /* We cannot make this fatal. Sometimes this comes from magic
> > 	       spaces our resource handlers simply don't know about */
> >     }
> >
> > That was on plain 2.6.5. But to my surprise the latest 2.4 behaves the same.
> > This seems to have been changed in 2.4.15.
> > Does anyone know why this was changed?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
