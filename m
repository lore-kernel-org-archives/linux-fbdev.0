From: James Simmons <jsimmons@infradead.org>
Subject: Re: fbdev tree pulled into Linus tree
Date: Thu, 22 Aug 2002 12:16:16 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208221213260.9077-100000@maxwell.earthlink.net>
References: <20020814015542.GA14680@ppc.vc.cvut.cz>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020814015542.GA14680@ppc.vc.cvut.cz>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: jsimmons@users.sourceforge.net, linux-fbdev-devel@lists.sourceforge.net


> Hello James,
>   besides that the beast does not compile because of
> the use of p->type instead of info->fix.type in the logo code,
> what's the reason for having next_line, next_plane

I believe that is for ilbm support. I plan to have those go away soon.

> (and maybe other too - can_soft_blank, inverse, yscroll)
> in the display struct, if you moved rest of the values
> into fix.

That stuff will be cleaned up soon. My next set of changes will be big.

> So now I maintain half of state in per-display
> structs, and half in the per-fbdev structure? Nigthmare.
> Can you create some ('tmp' or 'par' or whatever) structure
> and hold them in fb_info too?

This is for the next set of changes. I'm working on them right now.

>   Also because of you moved these type/line_length and
> other into the fix, there is no point in having dispsw
> in the display struct: these functions must not be invoked
> on the fbdev with con != fbcon.currcon now because of
> part of state exists only for foreground console now. So
> move them into per-fb_info structure too, and handle
> con != fbcon.currcon in generic code (if not done already).

Working on it.

>   Then it will be clear what is really per-VT structure
> which should be maintained by upper layer, and what is
> fbdev bussiness. And while you'll move dispsw pointer, change
> it to the embeded structure. It will make life easier to
> atafb and matroxfb at least, as they like to modify fb_ops
> according to the hardware they find, and currently they
> modify structure global to the driver.

As the new cfb* functions mature I can get ride of dispsw and use the
accel pointer directly.

> P.S.: I do not have your new email address here at home,
> and you are neither in MAINTAINERS nor in the CREDITS,
> I hope that the address I randomly choosed from the credits
> in fbdev files will work.

I'm in MAINTAINERS and CREDITS in BK now.



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
