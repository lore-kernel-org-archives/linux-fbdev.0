From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] Re: xxx_check_var
Date: Sun, 22 Dec 2002 13:17:47 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0212221315451.11715-100000@vervain.sonytel.be>
References: <Pine.LNX.4.33.0212102219010.2617-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0212102219010.2617-100000@maxwell.earthlink.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 10 Dec 2002, James Simmons wrote:
> > > When I look at atyfb_check_var or aty128fb_check_var, I see that they
> > > will alter the contents of *info->par.  Isn't this a bad thing?  My
> >
> > Yes, this wrong, and afaik, it's your original port to 2.5 that did that
> > ;)
> 
> Yeap. The idea of check_var is to validate a mode. Note modedb uses just
> check_var. It is okay to READ the values in your par. You shouldn't alter
> the values in par.

Perhaps it makes sense to make the info parameter of fb_check_var() const to
prevent this from happening?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
