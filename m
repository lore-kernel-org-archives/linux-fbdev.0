From: Greg KH <greg@kroah.com>
Subject: Re: FBDEV updates.
Date: Fri, 15 Aug 2003 16:54:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20030815235408.GB5697@kroah.com>
References: <20030814231620.GA4632@kroah.com> <Pine.LNX.4.44.0308152337070.30952-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308152337070.30952-100000@phoenix.infradead.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: Otto Solares <solca@guug.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, Aug 15, 2003 at 11:37:21PM +0100, James Simmons wrote:
> 
> > > Is there an API (or lib) to use framebuffers devices without
> > > worring about differents visuals?, to quering, setting or
> > > disabling EDID support? will these drivers export sysfs
> > > entries instead of control via ioctl's?
> > 
> > I have some initial sysfs patches for the fb code that I've been sitting
> > on in my trees.  I was waiting for these patches to hit the mainline
> > before bothering James and the rest of the world with them.
> > 
> > But they don't export any of the ioctl stuff through the sysfs
> > interface, but that would not be very hard to do at all if you want to.
> > They just basically show the major/minor of the fb device, and point
> > back to the proper place in the device tree where the fb device lives,
> > which is all udev really needs right now.
> 
> Could you send me those patches :-)

I'll clean them up, and port all fb drivers to them (I only did the ones
that I had hardware too), and send them to you next week.  Do not let
them hold anything up that you can send to Linus though, they are not
that important at all right now.

thanks,

greg k-h
