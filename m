From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: atyfb in 2.5.51
Date: Fri, 13 Dec 2002 09:49:30 +0100 (MET)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.GSO.4.21.0212130946100.6939-100000@vervain.sonytel.be>
References: <1039596149.24691.2.camel@rth.ninka.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1039596149.24691.2.camel@rth.ninka.net>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: James Simmons <jsimmons@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On 11 Dec 2002, David S. Miller wrote:
> On Tue, 2002-12-10 at 22:18, James Simmons wrote:
> > > AFAIK, the X "mach64" driver in XF 4.* doesn't care about UseFBDev.
> > > Marc Aurele La France (maintainer of this driver) is basically allergic
> > > to kernel fbdev support.
> > 
> > :-(
> 
> I've always stated that the whole fbdev model was flawed, it makes
> basic assumptions about how a video card's memory and registers are
> accessed (ie. the programming model) and many popular cards absolutely
> do not fit into that model.

Could you please elaborate so we have a chance to improve the model? Thanks!

In case you just mean graphics hardware (e.g. Creator) where you don't want to
provide direct access to the frame buffer, but do everything through the
acceleration engine, just set smem_start and smem_len both to 0.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
