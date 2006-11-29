From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [2.6 patch] remove broken video drivers (v3)
Date: Wed, 29 Nov 2006 11:30:58 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0611291130070.6335@pademelon.sonytel.be>
References: <20061129100431.GN11084@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S966979AbWK2KbH@vger.kernel.org>
In-Reply-To: <20061129100431.GN11084@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>, adaplas@pol.net, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>, linux-m68k@vger.kernel.org, Linux/PPC Development <linuxppc-dev@ozlabs.org>, Sam Creasey <sammy@sammy.net>, sun3-list@redhat.com

On Wed, 29 Nov 2006, Adrian Bunk wrote:
> This patch removes some video drivers that:
> - had already been marked as BROKEN in 2.6.0 three years ago and
> - are still marked as BROKEN.
> 
> These are the following drivers:
> - FB_CYBER
> - FB_VIRGE
> - FB_RETINAZ3
> - FB_SUN3
> 
> Drivers that had been marked as BROKEN for such a long time seem to be
> unlikely to be revived in the forseeable future.
> 
> But if anyone wants to ever revive any of these drivers, the code is
> still present in the older kernel releases.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Acked-By: Geert Uytterhoeven <geert@linux-m68k.org>

> This patch obsoletes the following patches in -mm:
> ioremap-balanced-with-iounmap-for-drivers-video-cyberfb.patch
> ioremap-balanced-with-iounmap-for-drivers-video-retz3fb.patch
> ioremap-balanced-with-iounmap-for-drivers-video-virgefb.patch

If possible, can these still be integrated first, to ease a future
resurrection?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
