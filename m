From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [FBDEV UPDATE] Newer patch.
Date: Thu, 23 Oct 2003 12:00:24 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0310231200050.27218-100000@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0310221814290.25125-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0310221814290.25125-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, 22 Oct 2003, James Simmons wrote:
>   I have a new patch against 2.6.0-test8. This patch is a few fixes and I 
> added back in functionality for switching the video mode for fbcon via 
> fbset again. Give it a try and let me know the results.
> 
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

This patch accidentally includes drivers/video/logo/logo_linux_clut224.c.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
