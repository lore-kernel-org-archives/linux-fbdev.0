From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 5/7] fbcon: Fix setup boot options
 of fbcon
Date: Fri, 10 Sep 2004 09:57:08 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.58.0409100955500.93@waterleaf.sonytel.be>
References: <200409100534.49269.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267285AbUIJIBR@vger.kernel.org>
In-Reply-To: <200409100534.49269.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>

On Fri, 10 Sep 2004, Antonino A. Daplas wrote:
> In the unlikely case of > 10 framebuffers, one can use the characters after
> '9', namely:
>
> ':' = 10
> ';' = 11
> '<' = 12
> '=' = 13
> '>' = 14
> '?' = 15
> '@' = 16
> 'A' = 17
> 'B' = 18
> 'C' = 19
> (and so on until 31, which is the maximum framebuffers allowed)

To avoid problems with the special characters, what about using 0-9 and a-v
instead?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
