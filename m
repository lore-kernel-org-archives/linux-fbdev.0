From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Date: 03 Apr 2003 08:44:58 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1049352298.579.23.camel@zion.wanadoo.fr>
References: <Pine.LNX.4.44.0304022245520.2488-100000@phoenix.infradead.org>
	 <1049330578.1029.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <1049330578.1029.38.camel@localhost.localdomain>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Petr Vandrovec <vandrove@vc.cvut.cz>


> 3.  Some architecture specific methods, such as doing it via the BIOS. 
> This is the last choice, our fallback method. as this EDID may be static
> and represents only the display detected at boot time.
> 
> For supplementary functions, we also need some kind of control that
> allows the user to tell fbdev "I've switched monitors, please reread the
> EDID". We want to avoid doing DDC each time fbdev does an fb_set_var(),
> especially for DDC1 which can be very slow. 

That's also what Apple does indeed. It's too complicated/long to
dynamically detect hotplug, but they do have a button you can
click to force a re-detect of the displays in the GUI and this
goes via some kind of ioctl to the video driver to ask for new
connection informations (basically EDID).

> Also, a way to download the EDID from kernel to userland.

Just define an ioctl for that and let each driver that support EDID
return something seem to be the simplest way.

If we really want to make EDID a generic thing, then we can eventually
have the EDID block attached to each fb_info and then a generic
fbmem.c ioctl to read it, but then make sure that EDID block isn"t
mandatory (it has no sense to some specific HW like some embedded
stuffs) and I always prefer when drivers are the real target of
the calls like this ioctl, eventually using fbdev "tools" as helpers
instead of having fbdev do something directly as a "mid-mayer".

Ben.
