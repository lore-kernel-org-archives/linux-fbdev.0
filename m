From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] visws: fix 16 bit framebuffer mode
Date: Tue, 7 Oct 2003 11:25:38 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0310071123200.2345-100000@waterleaf.sonytel.be>
References: <20031003080245.GB12930@pazke>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20031003080245.GB12930@pazke>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pazke@donpac.ru
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 3 Oct 2003 pazke@donpac.ru wrote:
> attached patch (from Florian Boor) allows X to work on visws 
> in 16 bit framebuffer mode.

Please also change the comment from `RGBA5551' to `ARGB1555' to match the code.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
