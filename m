From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video
 card BOOT?
Date: Fri, 15 Oct 2004 14:38:01 +0200 (MEST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267746AbUJOMlQ@vger.kernel.org>
In-Reply-To: <87d5zkqj8h.fsf@bytesex.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, penguinppc-team@lists.penguinppc.org

On Fri, 15 Oct 2004, Gerd Knorr wrote:
> Have you talked to the powermanagement guys btw.?  One of the major
> issues with suspend-to-ram is to get the graphics card back online,
> and SNAPBoot might help to fix this too.  I'm not sure a userspace
> solution would work for *that* through.

Why not? Of course you won't get any output before the graphics card has been
re-initialized to a sane and usable state...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
