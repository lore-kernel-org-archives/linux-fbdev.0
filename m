From: James Simmons <jsimmons@infradead.org>
Subject: Re: FBDEV updates.
Date: Fri, 15 Aug 2003 23:37:21 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.44.0308152337070.30952-100000@phoenix.infradead.org>
References: <20030814231620.GA4632@kroah.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20030814231620.GA4632@kroah.com>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Otto Solares <solca@guug.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> > Is there an API (or lib) to use framebuffers devices without
> > worring about differents visuals?, to quering, setting or
> > disabling EDID support? will these drivers export sysfs
> > entries instead of control via ioctl's?
> 
> I have some initial sysfs patches for the fb code that I've been sitting
> on in my trees.  I was waiting for these patches to hit the mainline
> before bothering James and the rest of the world with them.
> 
> But they don't export any of the ioctl stuff through the sysfs
> interface, but that would not be very hard to do at all if you want to.
> They just basically show the major/minor of the fb device, and point
> back to the proper place in the device tree where the fb device lives,
> which is all udev really needs right now.

Could you send me those patches :-)
