From: Otto Solares <solca@guug.org>
Subject: Re: FBDEV updates.
Date: Fri, 15 Aug 2003 20:40:00 -0600
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030816024000.GA11710@guug.org>
References: <Pine.LNX.4.44.0308152319570.30952-100000@phoenix.infradead.org> <1060990952.881.89.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1060990952.881.89.camel@gaston>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: James Simmons <jsimmons@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sat, Aug 16, 2003 at 01:42:32AM +0200, Benjamin Herrenschmidt wrote:
> 
> > 
> > Will do. I like to also handle Video mode change. Even userland will like 
> > to know when a mode change happened. For userland a signal can be sent. 
> > This would be useful for someone in X that runs fbset in a Xterm. This 
> > hoses the X server. It would be nice if the X server would see the signal 
> > change and adapt to it. Fbset could in theory be used again to change a VC 
> > size. Yuck!!!! But it is what people want.
> 
> And for good reasons as we still have to deal with cases
> where neither the driver nor modedb knows what the monitor supports...

It could be really cool if in sysfs be a file with
video modes, something like this:

1024x768x24@80
1024x768x24@60
800x600x24@60
600x400x16@75

and other file named current_mode (or something) with the
current setting, you just echo a value there and bingo,
a video mode change with the desired refresh rate, is that
hard? EDID and modedb can help us here.

Don't you think?

-solca
