From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH 7/7] fbdev: Add Tile Blitting support
Date: Fri, 10 Sep 2004 08:47:55 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <200409100847.56034.adaplas@hotpop.com>
References: <200409100534.56680.adaplas@hotpop.com> <20040910001113.GA19132@vana.vc.cvut.cz>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S265795AbUIJAqr@vger.kernel.org>
In-Reply-To: <20040910001113.GA19132@vana.vc.cvut.cz>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Petr Vandrovec <vandrove@vc.cvut.cz>, adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

On Friday 10 September 2004 08:11, Petr Vandrovec wrote:
> On Fri, Sep 10, 2004 at 05:34:56AM +0800, Antonino A. Daplas wrote:
> > In my case at least, the cleanup did produce an unexpected but beneficial
> > side effect, a little more speedup.  Not much, < 5%.
> >
> > Petr, if you have comments, suggestions, or you think this is a bad idea,
> > let me know.
>
> It looks like good idea to me.  Though I still do not see benefits
> 2.6.x fbcon provides over 2.4.x.

Too late for that :-).  Personally, minus the stability and bugs, I
prefer 2.6 over 2.4.

>
> BTW, there is still bad bug with software scrollback and multihead
> (it is here since I remember): redraw_screen sets redraw to 0 when
> old_console == new_console, but fbcon uses con_switch() method for
> deciding whether software scrollback should be reinitialized or not.
> As software scrollback is per-system and not per-fbdev thing, this
> has rather nasty consequences - when both fbdevs have different xres,
> console user can crash system (con2fb /dev/fb1 /dev/tty11; set xres
> fb0 != xres fb1; chvt 11; chvt 10; chvt 11; hit alt-shift-pgup
> or force vt11 to scroll; crash, some kernel data structures were
> overwritten with 0x0720...).

I just tried it now, but can't elicit a crash (2.6.9-rc1-mm4 + my patches).
I'll try to examine this in more detail this weekend.

Tony
