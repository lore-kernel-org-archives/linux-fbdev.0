From: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.5.69
Date: Wed, 7 May 2003 15:07:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0305071504470.3543-100000@home.transmeta.com>
References: <Pine.GSO.4.21.0305072138510.12013-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0305072138510.12013-100000@vervain.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: Ben Collins <bcollins@debian.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>


On Wed, 7 May 2003, Geert Uytterhoeven wrote:
> On Sun, 4 May 2003, Linus Torvalds wrote:
> > Summary of changes from v2.5.68 to v2.5.69
> > ============================================
> > 
> > Ben Collins:
> >   o [VIDEO]: Revert cfbimgblt.c back to a working state on 64-bit
> >   o [VIDEO]: Revert atyfb back to known working clean base
> 
> For future changes, could you please run these `reversals' through 
> linux-fbdev-devel, instead of silently passing them behind our backs? Thanks!

As mentioned already, this was done by several people, including the 
maintainer.

But even if it wasn't, the fact is that new additions that break major 
architectures _will_ be reverted. No ifs, buts or maybes about it. If new 
code shows itself to be broken, it's going to get reverted, and the sooner 
the better. And in this case, the code was not just slightly broken, it 
was totally non-working, in ways that made it clear that it had NEVER 
worked as intended.

			Linus
