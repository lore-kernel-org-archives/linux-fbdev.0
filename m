From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: [PATCH 7/7] fbdev: Add Tile Blitting support
Date: Fri, 10 Sep 2004 02:11:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040910001113.GA19132@vana.vc.cvut.cz>
References: <200409100534.56680.adaplas@hotpop.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S267186AbUIJANm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200409100534.56680.adaplas@hotpop.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 05:34:56AM +0800, Antonino A. Daplas wrote:
> 
> In my case at least, the cleanup did produce an unexpected but beneficial
> side effect, a little more speedup.  Not much, < 5%.
> 
> Petr, if you have comments, suggestions, or you think this is a bad idea,
> let me know.

It looks like good idea to me.  Though I still do not see benefits
2.6.x fbcon provides over 2.4.x.

BTW, there is still bad bug with software scrollback and multihead
(it is here since I remember): redraw_screen sets redraw to 0 when 
old_console == new_console, but fbcon uses con_switch() method for 
deciding whether software scrollback should be reinitialized or not.  
As software scrollback is per-system and not per-fbdev thing, this 
has rather nasty consequences - when both fbdevs have different xres, 
console user can crash system (con2fb /dev/fb1 /dev/tty11; set xres 
fb0 != xres fb1; chvt 11; chvt 10; chvt 11; hit alt-shift-pgup 
or force vt11 to scroll; crash, some kernel data structures were
overwritten with 0x0720...).
					Petr Vandrovec
